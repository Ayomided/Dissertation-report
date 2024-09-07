#import "@preview/pintorita:0.1.1"

#set page(
  paper: "us-letter", 
  margin: (top:2.5cm, right:2cm, bottom:2cm, left:2.5cm)
  )

// Heading Styling
#show heading.where(level: 1): set text(22pt)
#show heading.where(level: 2): set text(18pt)
#show heading.where(level: 3): set text(16pt)
#show heading.where(level: 4): set text(14pt)
#show heading.where(level: 5): set text(12pt)
#show heading.where(level: 6): set text(11pt)
#show heading.where(level: 7): set text(11pt)
#show heading.where(level: 8): set text(10pt)
#show heading.where(level: 9): set text(10pt, style: "italic")


#set text(font:"Avenir", 11pt)
#set bibliography(style: "harvard-cite-them-right")

// Thesis title
#let Title = "This is the title, or not"
// Subject Degree
#let Subject = "Advanced Computing"
// Supervisor Name
#let Manager = "Stelios [NEED TO CONFIRM]"

// Birbeck Logo
#let Logo = image("Birbeck.svg", width: 35%)
#Logo

#v(12em)

#grid(
  align: (center, center),
  inset: 20pt,
  columns: auto,
  rows: (auto,40pt), 

  row-gutter: 10pt,
  rect(width: 100%, stroke: none, text([#Title], fill: rgb(0, 0, 0, 100),28pt, weight: "extrabold")),
  [[Comments]],
  [*David Adediji*],
  [*School of Computing and Mathematical Sciences\
Birkbeck, University of London*
],
  [*XXX 000*],
  [Draft],
)

#v(10em)
= Declaration
I, David Adediji, declare that the work carried out and reported on by this document and the contents of this document, titled *#Title*, and accompanying artefacts, except for where attributed to other sources by way of citations within the body of this document and listed under the References section of this document, is formed of my own original work, which has never before been produced for any other purpose, and has been created solely as part of delivery of *#Subject* for or under supervision of *#Manager*.

All information in this document and accompanying artefacts has been obtained and presented in accordance with the relevant ethical conduct and academic rules.

====== Signature:

// Insert Signature here

====== Date:
#datetime(
  day: 28,
  month: 08, 
  year: 2024
  ).display("[day]/[month]/[year]")


#set page(
  numbering: "I",
  header: [
    #set text(11pt, fill: rgb(0, 0, 0, 90))
    #set align(center)
    #Title
  ],
  footer: [
    #set align(center)
    #set text(11pt)
    #counter(page).display(
      "I",
    )
  ]
)

= Abstract
This study explores the application of computational modeling techniques to optimize the performance of GitHub Actions within DevOps environments. As DevOps practices continue to grow, with up to 83% developer participation (Linux Foundation, 2024), enhancing efficiency in Continuous Integration/Continuous Deployment (CI/CD) processes becomes critical. This research develops models for resource usage analysis, execution time prediction, failure analysis, and security monitoring in GitHub Actions, which has become a dominant CI/CD tool since its release in 2019. The study leverages the frequent reuse of workflows in GitHub Actions, despite many workflows being outdated, to provide data-driven insights aimed at improving cross-team collaboration, resource allocation, and overall development efficiency. 

The study aims to provide data-driven insights to improve cross-team collaboration, resource allocation, and overall development efficiency.
#v(56em)
#outline(
  depth: 2,
  indent: auto
)

#set heading(numbering: "1.")
#v(56em)
= Introduction
\
The software development landscape has undergone a significant transformation with the widespread adoption of DevOps practices. A 2024 report by the Linux Foundation indicates that up to 83% of developers are now involved in DevOps processes. This trend reflects the industry’s broader shift towards cloud-native architectures, with cloud providers like AWS leading the market. CI/CD tools like Jenkins and GitLab CI have been instrumental in this shift, but GitHub Actions has emerged as a key player due to its seamless integration with GitHub repositories and its ability to automate diverse workflows .

GitHub Actions, introduced in 2019, quickly became a dominant CI/CD tool, with over 43.9% of GitHub repositories utilizing it within 18 months of its release @Decan2022. This tool allows developers to automate tasks triggered by events such as code pushes, pull requests and regular schedules, integrating tightly with the GitHub ecosystem. Despite its advantages, GitHub Actions also introduces challenges related to resource usage, execution time predictability, failure rates, security, and cross-team collaboration, which this research seeks to address.

== Problem Statement
\
Despite the widespread adoption of GitHub actions since its introduction in 2018. There is still significant challenge in optimization that promotes performance and reduces costs. These challenges include:
- Resource Utilisation: Inefficient use of computational resources in CI/CD pipelines can lead to increased costs and reduced performance @Decan2022
- Execution Time Unpredictability: Unpredictable job execution times, often due to the reuse of outdated workflows without necessary updates, disrupt development schedules 
- High Failure Rates: CI/CD pipelines frequently experience failures, with studies indicating that testing and integration issues are the most common causes at 10.0% - 17.4% failed workflow runs. @Bouzenia2024

== Research Objectives
\
This study aims to address these challenges by:
+ Developing computational models to analyse and predict resource usage in GitHub Actions.
+ Creating machine learning models for execution time forecasting.
+ Implementing pattern recognition algorithms for failure analysis and prevention.

== Structure
In @chapter2 we will go over the DevOps landscape along with its ...

#v(56em)
= Background <chapter2>
GitHub Actions (GHA), introduced in 2018, has rapidly emerged as a leading platform for automating CI/CD pipelines among developers. Its launch coincided with a shift in the CI/CD landscape, leading to a remarkable 43.9% adoption rate within just 18 months of its release @golzadeh_rise_2022. This swift adoption can be attributed to GHA's seamless integration with GitHub repositories and its flexible pricing model.

GitHub offers both free and paid tiers for Actions @GitHub. The free tier provides developers with 2,000 minutes per month and 500 MB of storage, making it accessible for small projects and individual developers. For larger teams and more demanding workflows, paid plans offer increased minutes and storage capacity. The pricing structure is based on usage, with costs calculated per minute of execution time and per GB of storage used.

#figure(
  table(
  align: center,
  columns: (1fr, 1fr, 1fr), 
  inset: 5pt,
  rows: auto,
  table.header(
    [*Plan*],[*Storage*],[*Minutes (Per month)*],
  ),
  [GitHub Free],[500MB],[2,000],
  [GitHub Pro],[1GB],[3,000],
  [GitHub Team],[2GB],[3,000],
  [GitHub Enterprise Cloud],[50GB],[50,000],
), caption: "GitHub Action Pricing 2024"
) <table-gh-pricing>

This table outlines the storage and minutes included in various GitHub plans. For usage beyond these limits, GitHub charges \$0.008 USD per GB of storage per day and applies per-minute rates based on the operating system used by the GitHub-hosted runner.
The pricing model also includes minute multipliers for different operating systems:

Linux: 1x (base rate)
Windows: 2x
macOS: 10x

These multipliers affect the consumption of included minutes but do not apply to the per-minute rates for additional usage.

GitHub Actions' flexibility and integration capabilities have made it a popular choice for automating various aspects of the software development lifecycle, including continuous integration, continuous deployment, and automated testing. Its ecosystem has grown to include a marketplace of pre-built actions, allowing developers to quickly implement complex workflows without starting from scratch.
As organizations increasingly rely on GitHub Actions for their development processes, understanding its pricing structure and optimizing workflows for both performance and cost-efficiency has become an important consideration in the software development landscape.

Even with the adoption of GitHub Actions (GHA), the need for optimization remains apparent. GitHub offers some built-in optimization options, such as caching and fail-fast strategies @Bouzenia2024. However, these methods provide only limited benefits. Additionally, due to insufficient documentation, many developers are unfamiliar with how to properly implement these features, which can lead to inefficient performance.

The lack of comprehensive guidance on these optimization techniques presents a challenge for developers trying to maximize the efficiency of their GitHub Actions workflows. This situation highlights a gap between the potential for optimization that GitHub Actions offers and the practical ability of many developers to implement these optimizations effectively.

#v(56em)
= Analysis

== Introduction

This chapter presents a comprehensive analysis of the proposed GitHub Actions monitoring system, addressing the key challenges identified in the problem statement: resource utilization, execution time unpredictability, and high failure rates. The analysis draws from empirical studies and industry data to provide a thorough examination of these issues and their potential solutions.

== Problem Analysis

=== Resource Utilization Challenges

According to the study by @Bouzenia2024, GitHub Actions, while powerful and widely adopted, often leads to inefficient use of computational resources. Their research found that CI/CD processes can be expensive, costing around \$504 per year for an average paid-tier repository. The study identified that the majority of resources are consumed by:

- Testing *(percentage not specified)*
- Building *(percentage not specified)*

These processes are primarily triggered by:
- Pull requests (50.7%)
- Pushes (30.9%)
- Regular scheduled workflows (15.5%)

The inefficient resource utilization results in:
1. Increased operational costs for organizations
2. Reduced overall performance of CI/CD pipelines
3. Environmental impact due to unnecessary resource consumption

=== Execution Time Unpredictability

The study by @Decan2022 observed that the reuse of outdated workflows without necessary updates has led to significant unpredictability in job execution times. Their research found that:

- Most workflows run on virtual machines (Action runners)
- The study analyzed 1.3 million runs over 30 months across 952 repositories
- Paid-tier workflows take 7-100x longer than free-tier workflows, depending on the triggering event

This unpredictability manifests as:
1. Disruptions to development schedules
2. Difficulty in planning and allocating resources effectively
3. Reduced developer productivity due to unexpected delays

@Bouzenia2024 further noted that pull requests in paid-tier repositories cost an average of 36 cents, compared to only 4 cents in free-tier repositories. This significant difference highlights the need for optimization, especially for paid-tier repositories.

=== High Failure Rates

The @Bouzenia2024 study reported failure rates of 10.0% - 17.4% in workflow runs, primarily due to testing and building issues. These high failure rates necessitate:

1. Robust failure analysis mechanisms
2. Predictive models for potential failures
3. Automated strategies for failure prevention and quick resolution

A specific example highlighted in the research shows a repository with a scheduled workflow set to execute every 5 minutes, which experienced 12,000 consecutive failures over several months. This case underscores the critical need for optimization techniques tailored to address failing jobs, timed-out workflows, and other types of failures.

== Current Optimization Techniques

=== Caching

@Bouzenia2024 identified caching as a mechanism provided by GitHub Actions to reuse files across multiple runners, reducing network utilization and runtime.

Prevalence and Impact:
- 32.9% of paid-tier repositories use caching
- 17.8% of free-tier repositories use caching
- Reduces execution time by an average of 3.4% for paid-tier and 6.0% for free-tier repositories
- Leads to an annual cost reduction of \$21.48 for paid-tier repositories

Despite its ease of use (requiring only one line addition to the workflow file) and impact on VM time, caching is underutilized, especially in paid-tier repositories.

=== Fail-Fast Strategy

The @Bouzenia2024 study also examined the fail-fast strategy, which applies to workflows that define a matrix of jobs, canceling all in-progress and queued jobs in the matrix as soon as any job fails.

Prevalence and Impact:
- Adopted by 83.5% of free-tier repositories
- Adopted by 75.9% of paid-tier repositories

The high adoption rate is likely due to its default enabling in matrix jobs. However, the specific time and cost savings were not quantified in the provided research.

== System Architecture Analysis

The proposed monitoring system architecture consists of several interconnected components:

1. Self-hosted Runner: Executes jobs and workflows, providing the primary source of data.
   - Advantage: Offers full control over the execution environment.
   - Challenge: Requires careful resource management to avoid impacting job performance.

2. cAdvisor: Collects hardware-level metrics from the runner.
   - Advantage: Provides detailed resource utilization data with minimal overhead.
   - Challenge: Requires secure deployment and maintenance on each runner.

3. Custom Log Exporter: Captures detailed job and step-level metrics.
   - Advantage: Offers granular insights into workflow performance.
   - Challenge: Needs to balance between data detail and collection overhead.

4. Prometheus: Serves as the central metrics collection and storage system.
   - Advantage: Scalable and widely-supported time-series database.
   - Challenge: Requires careful query optimization for large-scale deployments.

5. Central Aggregation Service: Processes and analyzes collected data.
   - Advantage: Enables complex data processing and integration with machine learning models.
   - Challenge: Must be designed for scalability and fault tolerance.

6. Machine Learning Models: Processes data for predictive analytics.
   - Advantage: Provides insights for optimization and failure prediction.
   - Challenge: Requires continuous training and validation to maintain accuracy.

7. User Dashboard: Visualizes data and insights for end-users.
   - Advantage: Offers intuitive interface for monitoring and decision-making.
   - Challenge: Must balance between comprehensive data display and user-friendliness.

This architecture addresses the identified challenges by providing a comprehensive monitoring and analysis solution for GitHub Actions workflows.

== Conclusion

The analysis, drawing from studies like "Resource Usage and Optimization Opportunities in Workflows of GitHub Actions" and "On the Use of GitHub Actions in Software Development Repositories," reveals significant opportunities for optimization in GitHub Actions workflows. The high costs associated with CI/CD processes, particularly for paid-tier repositories, underscore the importance of efficient resource utilization. Current optimization techniques like caching and fail-fast strategies show promise but are underutilized or not fully leveraged.

The proposed monitoring system architecture offers a comprehensive approach to addressing these challenges, providing detailed insights into resource usage, execution times, and failure patterns. By leveraging this system, organizations can potentially reduce costs, improve workflow efficiency, and enhance overall development productivity.

#v(10em)
= Implementation

== Data Pipeline setup
GitHub offers the ability to self host action runners which run on own hardware, by offering this both paid and free repositories, can set the resources they use for running their actions and CI/CD processes. 

Since GitHub action runners typically run on virtual machines, option to run self hosted also provides the option to perform monitoring on the hardware and hence the the GitHub actions runner. In this implementation we will be using Prometheus, an open source systems monitoring and alerting toolkit. 

Prometheus collects metrics and stores it as time series data which is the data shape which we want for our modeling. What this means is metrics are stored with time stamps alongside optional key-value pairs called labels.

Prometheus metrics typically look like.///
```Go
HELP go_threads Number of OS threads created
TYPE go_threads gauge
go_threads 7
```



#v(56em)
#bibliography("project_ref.bib",style: "harvard-cite-them-right")