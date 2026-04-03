import "list"

#hdci_file

#hdci_file: {
  use_templates?: [...string]
  cache?: [string] : string
  "triggers"?: list.MinItems(1) & [...#trigger]
  "triggers+"?: list.MinItems(1) & [...#trigger]
  "triggers*"?: list.MinItems(1) & [...#trigger]
  stages?: [string]: #stage
  jobs?: [string]: #job_def
  scripts?: [string]: #predefined_script_step_def
  executors?: [string]: #script_executor
  settings?: {
    ...
  }

  default_executors?: string | [...string]
  "default_executors+"?: string | [...string]
  default_script_steps?: string | [...string]
  "default_script_steps+"?: string | [...string]

  #trigger: {
    conditions: {
      gh_event!: "push" | "status" | "release" | "pull_request" | "issue_comment"
      gh_action?: string
      git_ref?: [...string]
    }
    stages: list.MinItems(1) & [...string]
  }
  
  #stage: {
    settings?: {
      ...
    }
    jobs?: list.MinItems(1) & [...#job_ref]
    "jobs+"?: list.MinItems(1) & [...#job_ref]
    gh_status_message?: {
      pending?: string
      success?: string
      error?: string
    }
    requires?: string | [...string]
  }
  
  #job_ref: string | #named_job_def
  
  #job_def: #workflow_def | #script_ref
  
  #named_job_def: {
    #job_def

    job_name!: string
  }
  
  #workflow_def: {
    workflow!: string
  }
  
  #script_ref: {
    steps: string | [...(string | #script_step_def)]
    "steps+"?: string | [...(string | #script_step_def)]
    "steps++"?: string | [...(string | #script_step_def)]
    cache?: string | [...string]
    "cache+"?: string | [...string]
    "cache++"?: string | [...string]
    env?: {...}
    skip_steps?: string | [...string]
    "skip_steps+"?: string | [...string]
    "skip_steps++"?: string | [...string]
  }

  #with_run: {
    run?: string
    "run+"?: string
    "run++"?: string
  }

  #with_script_file: {
    script_file?: string
  }

  #predefined_script_step_def: {
    #with_run | #with_script_file

    executor?: string

    container_name?: string
    image?: string
    entrypoint?: string | [...string]
    "entrypoint+"?: string | [...string]
    "entrypoint++"?: string | [...string]
    entrypoint_?: string | [...string]
    "entrypoint_+"?: string | [...string]
    "entrypoint_++"?: string | [...string]
    command?: string | [...string]
    "command+"?: string | [...string]
    "command++"?: string | [...string]
    command_?: string | [...string]
    "command_+"?: string | [...string]
    "command_++"?: string | [...string]
    run_?: string
    "run_+"?: string
    "run_++"?: string
    env?: string | {...}
    cache?: string | [...string]
    "cache+"?: string | [...string]
    "cache++"?: string | [...string]
    work_dir?: string
    skip_executors?: string | [...string]
    "skip_executors+"?: string | [...string]
    "skip_executors++"?: string | [...string]
  }

  #script_step_def: {
    #with_run | #with_script_file

    script_name?: string

    container_name?: string
    executor?: string | [...string]
    entrypoint?: string | [...string]
    command?: string | [...string]
    run_?: string
    "run_+"?: string
    "run_++"?: string
    image?: string
    cache?: string | [...string]
    env?: string | {...}
    skip_executors?: string | [...string]
  }

  #script_executor: {
    image?: string
    entrypoint?: string | [...string]
    "entrypoint+"?: string | [...string]
    "entrypoint++"?: string | [...string]
    entrypoint_?: string | [...string]
    "entrypoint_+"?: string | [...string]
    "entrypoint_++"?: string | [...string]
    command?: string | [...string]
    "command+"?: string | [...string]
    "command++"?: string | [...string]
    command_?: string | [...string]
    "command_+"?: string | [...string]
    "command_++"?: string | [...string]
    run?: string
    "run+"?: string
    "run++"?: string
    run_?: string
    "run_+"?: string
    "run_++"?: string
    env?: string | {...}
    cache?: string | [...string]
    "cache+"?: string | [...string]
    "cache++"?: string | [...string]
    work_dir?: string
  }
}
