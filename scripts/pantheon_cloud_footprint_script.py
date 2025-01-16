import argparse
import re
import subprocess
import json

parser = argparse.ArgumentParser(description='GCP Footprint Scanner')
parser.add_argument('-c', '--cloud', action='append', dest='clouds',
                    help='Specify which clouds to scan. Can be GCP, Github or AWS', required=False, default=[])

parser.add_argument('-a', '--aws-account', action='append', dest='aws_accounts', help='Specify AWS account', required=False)
parser.add_argument('-p', '--gcp-project', action='append', dest='gcp_projects', help='Specify GCP project', required=False)
parser.add_argument('-o', '--github-org', action='append', dest='github_orgs', help='Specify GitHub organizations', required=False)

parser.add_argument('-d', '--debug', action="store_true", dest='debug_logging', help='Enable debug logging', required=False)
parser.add_argument('-v', '--verbose', action="store_true", dest='verbose_logging', help='Enable verbose logging', required=False)
args = parser.parse_args()

gcp_totals = {
    "AlloyDB Instances": 0,
    "App Engine Services": 0,
    "BigQuery Datasets": 0,
    "BigTable Tables": 0,
    "BigTable Instances": 0,
    "Cloud Functions": 0,
    "Project": 0,
    "Compute Instances": 0,
    "GKE Clusters": 0,
    "Dataflow Jobs": 0,
    "Notebook Instances": 0,
    "Redis Instances": 0,
    "Cloud Run Services": 0,
    "CloudSQL Instances": 0,
    "GCS Buckets": 0
}

aws_totals = {
    "EC2 Instances": 0,
    "Lightsail Instances": 0,
    "EKS Instances": 0,
    "ECS Container Instances": 0,
    "Lambda Functions": 0,
    "ECS Resources": 0,
    "ECR Images": 0,
    "DynamoDB Tables": 0,
    "RDS Instances": 0,
    "S3 Buckets": 0,
}

github_totals = {
    "Repositories": 0,
}

def filter_line(line):
    to_filter = ["DeprecationWarning:", "import pipes", "datasetId", "------------"]
    if any(substring in line for substring in to_filter):
        return True
    return False

def ignore_error(error_msg):
    if ("SERVICE_DISABLED" in error_msg or
            "PERMISSION_DENIED" in error_msg or
            "API is not enabled on project" in error_msg or
            "The project is not activated." in error_msg or
            "API has not been used in project" in error_msg or
            "AWS was not able to validate the provided access credentials" in error_msg or
            "The security token included in the request is invalid" in error_msg or
            "Could not connect to the endpoint URL:" in error_msg or
            "(AccessDeniedException) when calling" in error_msg or
            re.search(r"Apps instance \[(.*?)\] not found: Resource 'applications/(.+?)' was not found", error_msg)):
        return True
    return False


def count_lines(output):
    splitlines = output.splitlines()
    return len([l for l in splitlines if not filter_line(l)])

def safe_call_to_json(command):
    """Runs a CLI command and returns the JSON output as a Python dictionary."""
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True, shell=True)
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        process_output = e.output+e.stderr+e.stdout
        if ignore_error(process_output):
            return ''
        else:
            print("Got unrecoverable error. This is most probably a bug. Please report this to the Pantheon developers:\n",e.output)
            raise
    except json.JSONDecodeError as e:
            print("Got unrecoverable error. This is most probably a bug. Please report this to the Pantheon developers:\n", e.output+e.stderr+e.stdout)
            raise


def safe_call_text(command):
    """ Function to safely execute commands and ignore some errors. """
    try:
        output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT, text=True)
        return output.strip()
    except subprocess.CalledProcessError as e:
        if ignore_error(e.output):
            return ''
        else:
            print("Got unrecoverable error. This is most probably a bug. Please report this to the Pantheon developers:\n",e.output)
            raise


def count_call(command):
   """ Function to safely execute gcloud commands and ignore SERVICE_DISABLED errors """
   if args.debug_logging:
       print(f"Executing command: {command}")
   result = safe_call_text(command)
   lines = count_lines(result)
   if args.verbose_logging:
       print(f"Got result: {result} with count {lines}")
   return lines


def count_gcp_regional_resources(regions, project):
   notebook_instances = 0
   redis_instances = 0
   dataflow_jobs = 0

   for region in regions:
       notebook_instances += count_call(
           f"gcloud --quiet notebooks instances list --project={project} --location={region} --format=\"value(name)\"")
       redis_instances += count_call(
           f"gcloud --quiet redis instances list --project={project} --region={region} --format=\"value(name)\"")
       dataflow_jobs += count_call(
           f"gcloud --quiet dataflow jobs list --project={project} --region={region} --format=\"value(id)\"")

   return {
       "Notebook Instances": notebook_instances,
       "Redis Instances": redis_instances,
       "Dataflow Jobs": dataflow_jobs,
   }

def report_counts(aca, counts):
    print(f"Scanned resources for: {aca}")
    for resource, count in counts.items():
        print(f"{resource}: {count}")
    print("-----------------------------------")

def count_gcp_resources(regions, project):
    # Count resources
    cloud_functions = count_call(f"gcloud --quiet functions list --project={project} --format=\"value(name)\" --filter=\"environment!=GEN_2\"")
    cloud_run_services = count_call(
        f"gcloud --quiet run services list --project={project} --platform managed --format=\"value(metadata.name)\"")
    app_engine_services = count_call(f"gcloud --quiet app services list --project={project} --format=\"value(id)\"")
    compute_instances = count_call(
        f"gcloud --quiet compute instances list --project={project} --format=\"value(name)\"")
    gke_clusters = count_call(f"gcloud --quiet container clusters list --project={project} --format=\"value(name)\"")

    # regional resources
    regional_counts = count_gcp_regional_resources(regions, project)
    notebook_instances = regional_counts["Notebook Instances"]
    redis_instances = regional_counts["Redis Instances"]
    dataflow_jobs = regional_counts["Dataflow Jobs"]

    alloydb_instances = count_call(
        f"gcloud --quiet alloydb instances list --project={project} --format=\"value(name)\"")
    cloudsql_instances = count_call(f"gcloud --quiet sql instances list --project={project} --format=\"value(name)\"")
    bigquery_datasets = count_call(f"bq ls -q --project_id={project}")
    gcs_buckets = count_call(f"gsutil -q ls -p {project}")

    bigtable_tables_output = safe_call_text(f"gcloud --quiet bigtable instances list --project={project} --format=\"value(name)\"")
    bigtable_instances = count_lines(bigtable_tables_output)
    bigtable_tables = 0
    for instance in bigtable_tables_output.splitlines():
        bigtable_tables += count_call(f"gcloud --quiet bigtable tables list --project={project} --instances={instance} --format=\"value(name)\"")

    counts = {
        "AlloyDB Instances": alloydb_instances,
        "App Engine Services": app_engine_services,
        "BigQuery Datasets": bigquery_datasets,
        "BigTable Tables": bigtable_tables,
        "BigTable Instances": bigtable_instances,
        "Cloud Functions": cloud_functions,
        "Project": 1,
        "Compute Instances": compute_instances,
        "GKE Clusters": gke_clusters,
        "Dataflow Jobs": dataflow_jobs,
        "Notebook Instances": notebook_instances,
        "Redis Instances": redis_instances,
        "Cloud Run Services": cloud_run_services,
        "CloudSQL Instances": cloudsql_instances,
        "GCS Buckets": gcs_buckets
    }

    report_counts(project, counts)
    return counts

def count_aws_resources(regions):
    """Counts the specified AWS resources across all regions."""
    resource_counts = {
        "EC2 Instances": 0,
        "Lightsail Instances": 0,
        "EKS Instances": 0,
        "ECS Container Instances": 0,
        "Lambda Functions": 0,
        "ECS Resources": 0,
        "ECR Images": 0,
        "DynamoDB Tables": 0,
        "RDS Instances": 0,
        "S3 Buckets": 0,
    }

    # S3 Buckets (global resource, so just run only once)
    s3_buckets = safe_call_to_json(f'aws s3api list-buckets --output json')
    if s3_buckets and 'Buckets' in s3_buckets:
        resource_counts["S3 Buckets"] += len(s3_buckets['Buckets'])
        
    for region in regions:
        # EC2 Instances
        ec2_instances = safe_call_to_json(f'aws ec2 describe-instances --region {region} --output json')
        if ec2_instances and 'Reservations' in ec2_instances:
            for reservation in ec2_instances['Reservations']:
                for instance in reservation['Instances']:
                    if instance['State']['Name'] != 'terminated':
                        resource_counts["EC2 Instances"] += 1        
        
        # Lightsail Instances
        lightsail_instances = safe_call_to_json(f'aws lightsail get-instances --region {region} --output json')
        if lightsail_instances and 'instances' in lightsail_instances:
            resource_counts["Lightsail Instances"] += len(lightsail_instances["instances"])


        # EKS Instances (clusters)
        eks_clusters = safe_call_to_json(f'aws eks list-clusters --region {region} --output json')
        if eks_clusters and 'clusters' in eks_clusters:
            resource_counts["EKS Instances"] += len(eks_clusters['clusters'])


        # ECS Container Instances
        ecs_clusters = safe_call_to_json(f'aws ecs list-clusters --region {region} --output json')
        if ecs_clusters and 'clusterArns' in ecs_clusters:
            for cluster_arn in ecs_clusters['clusterArns']:
                ecs_instances = safe_call_to_json(f'aws ecs list-container-instances --cluster {cluster_arn} --region {region} --output json')
                if ecs_instances and 'containerInstanceArns' in ecs_instances:
                    resource_counts["ECS Container Instances"] += len(ecs_instances['containerInstanceArns'])


        # Lambda Functions
        lambda_functions = safe_call_to_json(f'aws lambda list-functions --region {region} --output json')
        if lambda_functions and 'Functions' in lambda_functions:
            resource_counts["Lambda Functions"] += len(lambda_functions['Functions'])


        # ECS Resources tasks
        if ecs_clusters and 'clusterArns' in ecs_clusters:
            for cluster_arn in ecs_clusters['clusterArns']:
                ecs_tasks = safe_call_to_json(f'aws ecs list-tasks --cluster {cluster_arn} --region {region} --output json')
                if ecs_tasks and 'taskArns' in ecs_tasks:
                    resource_counts["ECS Resources"] += len(ecs_tasks['taskArns'])


        # ECR Images
        ecr_repos = safe_call_to_json(f'aws ecr describe-repositories --region {region} --output json')
        if ecr_repos and 'repositories' in ecr_repos:
            for repo in ecr_repos['repositories']:
                ecr_images = safe_call_to_json(f'aws ecr describe-images --repository-name {repo["repositoryName"]} --region {region} --output json')
                if ecr_images and 'imageDetails' in ecr_images:
                    resource_counts["ECR Images"] += len(ecr_images['imageDetails'])


        # DynamoDB Tables (tables)
        dynamodb_tables = safe_call_to_json(f'aws dynamodb list-tables --region {region} --output json')
        if dynamodb_tables and 'TableNames' in dynamodb_tables:
            resource_counts["DynamoDB Tables"] += len(dynamodb_tables['TableNames'])


        # RDS Instances
        rds_instances = safe_call_to_json(f'aws rds describe-db-instances --region {region} --output json')
        if rds_instances and 'DBInstances' in rds_instances:
            resource_counts["RDS Instances"] += len(rds_instances['DBInstances'])

    return resource_counts

def count_github_resources(org):
    repos = count_call(f"gh repo list {org} -L 10000 --no-archived")

    counts = {
        "Repositories": repos,
    }
    report_counts(org, counts)
    return counts


def scan_gcp():
    projects = args.gcp_projects
    if not args.gcp_projects or len(projects) == 0:
        projects_output = safe_call_text("gcloud --quiet projects list --format=\"value(projectId)\"")
        projects = projects_output.splitlines()

    if len(projects) == 0:
        print("No projects found.")
        exit()

    regions_output = safe_call_text(
        f"gcloud --quiet compute regions list --format=\"value(name)\" --project={projects[0]}")
    regions = regions_output.splitlines()

    print(f"Starting GCP resource scanning for {len(projects)} project/s")
    print("-----------------------------------")
    # Aggregate resources for each project
    for project in projects:
        counts = count_gcp_resources(regions, project)
        for resource, count in counts.items():
            gcp_totals[resource] += count

    # Print totals
    print(f"Total GCP resource count in {len(projects)} project/s")
    print("============")
    for resource, total in gcp_totals.items():
        print(f"Total {resource}: {total}")


def scan_aws():
    regions_output = safe_call_text("aws ec2 describe-regions --all-regions --output text --region eu-central-1 --query \"Regions[].{Name:RegionName}\"")
    regions = regions_output.splitlines()

    print(f"Starting AWS resource scanning")
    print("-----------------------------------")
   
    counts = count_aws_resources(regions)
    for resource, count in counts.items():
        aws_totals[resource] += count

    # Print totals
    print(f"Total AWS resource count")
    print("============")
    for resource, total in aws_totals.items():
        print(f"Total {resource}: {total}")

def scan_github():
    orgs = args.github_orgs
    if not args.github_orgs or len(orgs) == 0:
        orgs_output = safe_call_text("gh org list")
        orgs = orgs_output.splitlines()

    if len(orgs) == 0:
        print("No organizations found.")
        exit()

    print(f"Starting GitHub resource scanning for {len(orgs)} organization/s")
    print("-----------------------------------")
    # Aggregate resources for each project
    for org in orgs:
        counts = count_github_resources(org)
        for resource, count in counts.items():
            github_totals[resource] += count

    # Print totals
    print(f"Total Github resource count in {len(orgs)} organization/s")
    print("============")
    for resource, total in github_totals.items():
        print(f"Total {resource}: {total}")


def run_cloud_module(cloud):
    return any(cloud.lower() == cm.lower() for cm in args.clouds)

if len(args.clouds) == 0:
    print("No clouds selected.")
    exit()

if run_cloud_module("GCP"):
    scan_gcp()
if run_cloud_module("AWS"):
    scan_aws()
if run_cloud_module("GitHub"):
    scan_github()
