import "list"

#hdci

#hdci: {
  use_templates?: [...string]
  cache?: [string]: string
  triggers?: list.MinItems(1) & [...#trigger]
  stages?: [string]: #stage
  jobs?: [string]: #job_def
  scripts?: [string]: #predefined_script_step_def
  executors?: [string]: #script_executor
  settings?: {
    ...
  }

  #predefinedJobs: string & or([for k, _ in jobs {k}])
  #predefinedScripts: string & or([for k, _ in scripts {k}])
  #predefinedStages: string & or([for k, _ in stages {k}])
  #predefinedExecutors: string & or([for k, _ in executors {k}])
  #predefinedCaches: string & or([for k, _ in cache {k}])

  default_executors?: [...#predefinedExecutors]
  default_script_steps?: [...#predefinedScripts]

  #trigger: {
    conditions: {
      gh_event!: "push" | "status" | "release" | "pull_request" | "issue_comment"
      gh_action?: string
      git_ref?: [...string]
    }
    stages: list.MinItems(1) & [...#predefinedStages]
  }
  
  #stage: {
    settings?: {
      ...
    }
    jobs: list.MinItems(1) & [...#job_ref]
    gh_status_message?: {
      pending?: string
      success?: string
      error?: string
    }
    requires?: [...#predefinedStages]
  }
  
  #job_ref: #predefinedJobs | #named_job_def
  
  #job_def: #workflow_def | #script_ref

  #named_job_def: {
    #job_def

    job_name!: string
  }
  
  #workflow_def: {
    workflow!: string
  }

  #script_ref: {
    steps: list.MinItems(1) & [...(#predefinedScripts | #script_step_def)]
    "steps+": list.MinItems(1) & [...(#predefinedScripts | #script_step_def)]
    volumes?: [...]
    "volumes+"?: [...]
    image?: string
    env?: {...}
    cache?: [...#predefinedCaches]
    skip_steps?: "*" | [...#predefinedScripts]
    "skip_steps+"?: "*" | [...#predefinedScripts]
}

  #with_run: {
    run: string
    "run+"?: string
  }

  #with_script_file: {
    script_file?: string
  }

  #predefined_script_step_def: {
    #with_run | #with_script_file

    container_name?: string
    executor?: #predefinedExecutors | [...#predefinedExecutors]
    entrypoint?: [...string]
    "entrypoint+"?: [...string]
    entrypoint_?: [...string]
    "entrypoint_+"?: [...string]
    command?: [...string]
    "command+"?: [...string]
    command_?: [...string]
    "command_+"?: [...string]
    volumes?: [...]
    "volumes+"?: [...]
    volumes_?: [...]
    "volumes_+"?: [...]
    run_?: string
    "run_+"?: string
    image?: string
    env?: {...}
    cache?: [...#predefinedCaches]
    "cache+"?: [...#predefinedCaches]
    skip_executors?: "*" | [...#predefinedExecutors]
    "skip_executors+"?: "*" | [...#predefinedExecutors]
  }

  #script_step_def: {
    #with_run | #with_script_file

    script_name?: #predefinedScripts

    container_name?: string
    executor?: #predefinedExecutors | [...#predefinedExecutors]
    entrypoint?: [...string]
    command?: [...string]
    volumes?: [...]
    image?: string
    env?: {...}
    cache?: [...#predefinedCaches]
    skip_executors?: "*" | [...#predefinedExecutors]
  }

  #script_executor: {
    image?: string
    entrypoint?: [...string]
    "entrypoint+"?: [...string]
    entrypoint_?: [...string]
    "entrypoint_+"?: [...string]
    command?: [...string]
    "command+"?: [...string]
    command_?: [...string]
    "command_+"?: [...string]
    volumes?: [...]
    "volumes+"?: [...]
    volumes_?: [...]
    "volumes_+"?: [...]
    run?: string
    "run+"?: string
    run_?: string
    "run_+"?: string
    env?: {...}
    cache?: [...#predefinedCaches]
    "cache+"?: [...#predefinedCaches]
    work_dir?: string
  }
}
