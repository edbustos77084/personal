# SAFe DevOps Health Radar

### Continuous Exploration: 
#### Why? Alignment; How? Continuous Exploration
- Hypothesize
- Collaborate & Research 
- Architect
- Synthesize
### Continuous Integration:
#### Why? Quality; How? Continuous Integration
- Develop
- Build
- Test End-to-End
- Stage
### Continuous Deployment:
#### Why? Time to Market; How? Continuous Deployment 
- Deploy
- Verify
- Monitor
- Respond
### Release on Demand:
#### Why? Business Value; How? Release on Demand
- Release
- Stabilize
- Measure
- Learn
#### Repeat.....every Sprint

Lesson 1- Introducing DevOps
- 1.1. Recognize the problem to be solved. 
  * Every enterprise must be able to quickly validate the wants and needs of customers. 
  * Every enterprise must be able to release Features when customers need them the most. 
- 1.2 DevOps 
  * DevOps is a set of software development practices that combines software development (Dev) and information technology operations (ops) to shorten the systems development life cycle while delivering features, fixes, and updates frequently in close alignment with business objectives. 
  * Lack of alignment impedes progress
    * Different groups in the organization have different goals and directions
    * The lack of alignment means their different efforts cancel each other out. 
    * This creates a feeling of constant work with little or no progress
    * The Continuous Delivery Pipeline enables the flow of value
    * The DevOps Health Radar helps synchronize the pipeline
- 1.3 Describe continuous security and testing
  * The role of continuous security
    * Information security is a key concept in SAFe DevOps
    * DevSecOps concepts present key principles for value delivery 
    * Security affects every dimension of the continuous delivery cycle 
    * Information security should be part of every DevOps transformation
  * The Role of continuous testing
    * Testing is an ongoing activity
    * We build quality in by addressing testing and quality throughout the continuous delivery cycle
    * Automated testing and quality assurance should be part of every Devops transformation
- 1.4 - Describe core DevOps principles
  * A CALMR approach to DevOps
    * Culture - Establish a culture of shared responsibility for development, deployment and operations. 
    * Automation - Automate the Continuous Delivery Pipeline
    * Lean flow - Keep batch sizes small, limit WIP, and provide extreme visibility
    * Measurement - Measure the flow through the pipeline, Implement full-stack telemetry.
    * Recovery - Architect and enable low-risk releases, Establish fast recovery, fast reversion, and fast fix-forward
 * DevOps is a Cultural shift 
    * Adopt a culture of shared responsibility for development and deployment
    * Requires a tolerance for failure and rapid recovery, and rewards risk taking
    * Learning across silos is encouraged
 * Automate
    * Automation is a key concept in DevOps
    * Automate as much as you can from the Continuous Delivery Pipeline and improve the flow of value
    * Build a comprehensive toolchain to help teams release value more frequently
    * Focus on automating healthy processes, if the underlying process is broken, fix it before automating it. 
 * Lean Flow 
    * Identify bottlenecks to the flow of value
    * Decrease the batch sizes of the work
    * Manage and reduce queue lengths
* Measure Everything
    * Collect data on business, application, infrastructure, and client layers
    * Collect data about the deployment pipeline itself
    * Maintain different telemetry for different stakeholders
    * Broadcast measurements
    * Continuously improve telemetry during and after problem solving
* Architect for release-ability and Recovery
    * Adopt a stop-the line mentality
    * Plan for and rehearse failures
    * Build the environment for both roll-back and fix-forward

Lesson 2 - Mapping your Pipeline
- 2.1 - Explain the purpose of mapping the Value Stream
- 2.2 - Visualize the current state of the delivery pipeline using Key Metrics
 * Why map the Value Stream?
   * Understand how work flows through the organization from concept to cash
   * Measure process quality and organizational efficiency 
   * Identify bottlenecks to the flow of value
   * Understand how we can improve the flow of value
 * Know how to draw the DevOps Transformation Canvas

#### Value Stream 
- [ ] Trigger 
- [ ] First Step 
- [ ] Last Step 
- [ ] Demand Rate 
- [ ] Current State Map 
- [ ] Future State map 
- [ ] Boundaries and Limitations 
- [ ] Improvement Items

https://vimeo.com/325445925/59913369d4

- 2.2 - Visualize the current state of the delivery pipeline using key metrics
* Identify the steps and people (current pipeline)
* Value stream measurements
 * PT - Process Time (Actual value-added work)
 * LT - Lead Time - (Time from when work was ready after the previous station to completion)
 * Percent Complete and Accurate (%C&A) - Percent of work that the next station could process as-is (can only be calculated by talking to the downstream partner)
   * Measure the steps  (PT 4hrs/ LT 4 hrs)
   * Activity Ratio = PT/LT
   * Rolled %C&A = %C&A 1 * %C&A 2 * %C&An….* 100

Lesson 3 - Gaining Alignment with Continuous Exploration
 - Create solution hypotheses
 - Collaborate and research customer needs
 - Architect the solution for continuous delivery
 - Synthesize the vision, the roadmap, and the Program Backlog
 - 3.1 - Hypothesize
  * Define the hypothesis to be validated through the Continuous Delivery Pipeline
  * Lean Startup, Innovation Accounting
    * Lean Startup - cycle focuses on identifying the viability of ideas
    * It follows the Plan-Do-Check-Adjust Cycle (PDCA)
    * MVP-Establish a baseline to test assumptions and gather objective data
  * Evaluate hypothesis: 
    * If the benefit hypothesis has been proven true, the Value Streams will implement more Features
    * If the hypothesis is proven false, the decision is made to either pivot with a new hypothesis or to stop work on the Epic
 * Innovation Accounting
    * New products and new features are hard to measure by traditional accounting standards
    * When defining an MVP it is important to use metrics that will validate its success or failure
    * It is important to focus on metrics that demonstrate real customer engagement and not on Vanity Metrics
- 3.2 - Collaborate and Research customer needs
  * Work with multiple stakeholders to understand customer needs
  * Lean UX, Research
    * Lean UX - User Experience is a mindset, culture and a process that implements functionality in minimum viable increments and determines success by measuring results against a benefit hypothesis
    * Features must be broken into Minimal Marketable Features - the minimum functionality that the teams can build to learn whether the benefit hypothesis is valid or not
 * Research
   * Design Thinking - Explore the problem and solution spaces using personas, journey maps empathy maps, and other Agile product management techniques
   * Customer visits and Gemba Walks - A Gemba work is the place where the work is performed, can be used by developers to observe how internal stakeholders execute the steps and specific activities in their operational value streams
   * Elicitation - There are a variety of structured elicitations techniques that can be used, such as interviews, surveys, competitive analysis, requirements workshops, and use-case modeling. 
   * Trade studies - Teams engage in trade studies to determine the most practical characteristics of a solution
- 3.3 - Architect the Solution for continuous delivery
  * Architect
    * Architect for testability
      * In a system that is designed for testability, all jobs require less time
    * Patterns that can accelerate value flow
      * Domain Driven Design
      * Loose Coupling & API-Driven Architecture
      * Cloud-Native Architecture
      * Microservices & Containerization
      * Serverless Architecture
      * Strangler pattern
  * Separate deploy and release
    * Separate deploy to production from release
    * Hide all new functionality under Feature toggles
    * Enable the ability to deploy and verify in production and release on demand
  * Decouple releases elements 
    * Different parts of the solution require different release strategies
    * Architect the solution to enable the various strategies and to shift them over time based on business demand
  * Architect for operations
    * Take the operational needs into account
    * Build telemetry and logging capabilities into every application and into the solution as a whole
    * Allow services to be downgraded or even removed in times of high loads or in response to incidents
    * Build capabilities for Fast Recovery and for Fix-Forward
  * Threat modeling
    * Information security considerations should start early
    * Identify potential security threats and attack vectors
    * Architect to address security concerns
    * Ensure backlogs reflect important security requirements
- 3.4 - Synthesize the Vision, the Roadmap, and the Program Backlog
  * Purpose: Synthesize the hypotheses, research, collaboration, and architecture into a vision, a roadmap, and backlog - Gain alignment with PI Planning
  * Feature Writing
    * ‘Feature’ is an industry-standard term familiar to marketing and Product Management
    * Benefit hypothesis justifies Feature implementation cost, and provides business perspective when making scope decisions
    * Acceptance criteria are typically defined during Program Backlog refinement
    * Reflects functional and Nonfunctional Requirements (NFRs)
    * Fits in one Program Increment
  * Behavior-Driven Development (BDD)
    * Behavior-driven development is a test-first approach to writing requirements
    * Gherkin Syntax (Given-When-Then) is commonly used
    * Permits building executable specifications
    * Acceptance criteria become executable tests
  * Economic Prioritization
    * In a flow system, job sequencing is the key to economic outcomes
    * Give preference to jobs with Shorter Duration and higher Cost of Delay (CoD)
    * WSJF provides a way of understanding the cost of delay and focusing on items that provide the best cost of delay reduction in the shortest time
* PI Planning
  * Planning is a cadence-based, face-to-face event that serves as the heartbeat of the Agile Release Train (ART), aligning all the teams on the ART to a shared mission and Vision.
    * Two days every 8-12 weeks (10 weeks is typical)
    * Everyone attends in person if at all possible
    * Product Management owns Feature priorities
    * Development teams own Story Planning, and high-level estimates
    * Architect/Engineering and UX work as intermediaries for governance, interfaces, and dependencies

Lesson 4 - Building Quality with Continuous Integration
  Develop the solution
  Build Continuously
  Test end-to-end
  Validate on a staging environment
  Why? Quality, How? Continuous Integration (CI)
  Sub-dimensions - What?
  Develop - Implement a Story or a part of a Story and commit the code
  Break features into stories
  Techniques for splitting Features and Stories to fit within their boundaries (PI and Iteration, Respectively)
  Workflow steps
  Business rule variations
  Major Efforts
  Simple/Complex
  Variation in data
  Data methods
  Defer system qualities
  Operations
  Use-case scenarios
  Break out a spike
  Test-Driven Development
  Write a Test
  Test Fails -> Write enough code to pass ->Test fails until it passes, Refactor -> Write another Test
  Version control
  Maintain all assets under version control
  From requirements, to code, to configuration, to tests, and test data
  Establish clear check-in and check-out procedures
  Version control improves traceability for automating compliance
  Engineering practice (Agile SW Engineering)
  Modern engineering practices boost speed and quality
  Test-First Mindset
  Agile modeling
  Emergent design
  Pattern-based Coding
  Pair work
  Boeing and Lockheed Martin follow this principle
  Pair work improves system quality, design decisions, knowledge sharing and team velocity
  A collaborative effort of two team members: Dev/Dev; Dev & PO, Dev & Tester
  Broader and less constraining than pair programming
  Team members spend 20% to 80% time pairing
  Spontaneous pairing, and purposeful rotations over time
  Application telemetry
  Application telemetry enables faster identification of problems from production incidents
  Telemetry should cover all levels of the code - from methods, to components, to services, to the entire application
  Application design must take into account operational health telemetry
  Features must include the ability to measure the benefit hypothesis against both leading and trailing indicators
  Threat modeling (covered in Architect)
4.2 Build - Compile source files into deployable binaries, verify that code functions as the developer(s) intended & Merge dev branches to trunk
  Continuous code integration - > Develop TDD, commit, Build, Mock Data, Version Control, App Package, Test Package -> End-2-End testing, Staging fully automated
  Build and test automation
  Initiate a build often, preferably on every commit
  Run unit tests as part of the build 
  Run static code analysis as part of the build
Visualize and monitor the build and test process
Report failures immediately
Broken builds are the Highest Priority*
Trunk-based development
Single trunk/Main for all teams
Each commit merges to Main
Avoid long-lived branches
Avoid multiple open branches
Gated commit
Gated commits ensure that broken code does not’ block the rest of the developers or the pipeline
Only changes that have passed all build and quality checks are committed to version control
Alert the code author immediately upon rejection
Application Security
Apply tools to automatically identify security vulnerabilities in the code during the build process
Assess open source libraries continuously for known vulnerabilities to identify risks during development or build processes
4.3 Test end-to-end
The purpose is to validate changes against acceptance criteria in an integrated, production-simulated environment
Test and production environment congruity
Make sure the test environments match production as much as possible
Maintain all configuration changes under version control
Service Virtualization helps alleviate some cost considerations
Invest in higher fidelity for more accurate testing
Test Automation
Many types of testing need to be run:
Functional Testing
Integration Testing
Regression Testing
Performance Testing
Security Testing
Exploratory Testing
Penetration Testing
Test Data Management
Data for all types of tests must be managed
Store data in a repository for consistent testing
Emulate production data to ensure tests reflect realistic situations
Service Virtualization (aka Simulator)
Ability to spawn environments which match production to test
Environments that support different types of testing
Maintain environment data in source control
Nonfunctional Requirements (NFRs)
Non-functional Requirements are system qualities that support end-user functionality and system goals
Sometimes known as the ‘ilities’ - Reliability, Usability, Scalability, Availability etc.
NFRs are constraints on backlog items
NFRs are not backlog items themselves
4.4 - Stage
The purpose is to Host fully-validated, systems in a production-grade environment, from which they can be deployed to production
Maintain a staging environment
Maintain a staging environment that matches production to prepare for moving to production
Deploy to staging at least every iteration and run your system demo from there
Ideally, deploy to staging automatically after all build and end-to-end tests have passed
Blue/Green Deployment
Maintain two identical environments: Idle and Live
New features are deployed to idle environment on a continuous basis. While staged, the features can be tested and showcased in preparation for release
New code is released to the idle environment, where it is thoroughly tested. When the code is ready to be released the team makes the idle environment active. 
If problems are discovered after the switch, the active environment is switched back to idle, restoring the previously active environment
Switching between environments is typically done by redirecting traffic at the load balancer
System Demo
Demo working integrated systems every two weeks
New Features work together, and with existing functionality
Demo from a Staging Environment that resembles production as much as possible
Program stakeholders provide feedback
Lesson 5 - Reducing Time-to Market with Continuous Deployment
5.1 Deploy to Production
Purpose changes into production with high frequency and low risk
Dark Launches
Separate deploy (to production) from release (to end users)
Enables testing and monitoring system behavior in the actual production environment before exposing new functionality to users
Feature Toggles
Dynamically show and hide features in production
Enables separation of deploy and release
Enables rapid rollback of problem features
Test toggles in both on and off position
Be careful of toggle overload and testing complexity
Infrastructure as Code
Automates environment setup and teardown
Manages all infrastructure assets and configurations in version control
Accelerates and de-risks deployment by provisioning standard/gold environments on demand
Enables infrastructure to always be in a deployable state (just like application code)

Deployment automation
Automate all steps from code commit to production deployment
Store all environment and package information in version control
Test the deployment process itself
Selective Deployment
Deploy to select production targets or environments
This can be differentiated by data center, geography, customer
Enables more flexible and sophisticated release strategies
Self-Service Deployment
If complete automation from code commit to deployment to production is not possible, automate the deployment of the package to production
Enable anyone to safely deploy validated packages
Provide simple controls to facilitate what gets deployed
Version control (covered in Build)
Blue/Green deployment (covered in Stage)
5.2 - Verify the Solution
Purpose: Assure that deployment solutions behave as expected in production before they are released to end users.
Production Testing
Testing of features in the live environment
This includes functional and nonfunctional testing
Running synthetic transactions through the services to verify fitness for purpose (utility) and fitness for use (warranty)
Test Automation (covered in Build)
Test data management (covered in Test end-to-end)
Nonfunctional Requirements (covered in Test end-to-end)
5.3 - Monitor for Problems
Purpose: Quantitatively measure system and user behavior in real time
Full-stack telemetry
We need proper data to monitor activities
Applications should clearly log and report meaningful activities and events
Architect applications and infrastructure to support telemetry
Monitor both technical data and business data
Visual displays
Visualize telemetry to the entire organization
BVIR - Big Visible Information Radiators - should project the health of the application and systems at all times
Information about key DevOps metrics should also be visible (time since last deploy, time since last outage, Average lead time, etc.)
Federated monitoring
Aggregate data from various sources into a collection point
Build big visual information radiators to display the aggregated data
Provide accessibility and ways to drill down into individual application and infrastructure telemetry
AI-OPs
The monitoring required for effective DevOps produces a flurry of data, events and alerts
AIOPs uses machine learning and Big Data techniques to quickly 
Aggregate, correlate and analyze events
Separate meaningful events from the “noise”
Identify (and predict) root causes of issues
Significantly reduce MTTR (Mean Time To Recovery)
5.4 - Respond and Recover
Respond - Purpose is Proactively detect and resolve production issues before they cause business disruption
Chaos Engineering - 
Refer to Netflix Simian Army - Latency Monkey, Conformity Monkey, Doctor Monkey, Janitor Monkey, Security Monkey, Chaos Gorilla
Proactively detection
Decoupling deployment from release allows problem detection before problems are exposed to customers
Proactively look for problems and practice disaster and recovery situations
Self sabotage, like chaos monkey helps build resilience
These should be coordinated practices in high-assurance environments, along with failure modes and effect analysis (FMEA) during architecture and design
Cross-team collaboration
Dealing with production issues is everyone’s responsibility
Having a team that can develop and support is preferred
Teams from across the value stream should collaborate on solving production issues and identifying root causes
Session replay
Record customer sessions and replay them to test problems
Make session replay available in production, testing, and development environments
Consider security and privacy when implementing this capability
Rollback and Fix Forward 
Be prepared with a Rollback plan or a way to provide a quick fix forward
Immutable infrastructure
Making changes directly in the production environment creates configuration drifts and has inherent risks
In an immutable infrastructure environment all changes are deployed through the Continuous Delivery Pipeline
Makes no changes directly in Production
Version control (covered in Build)
Lesson 6 - Delivering Business Value with Release on Demand - Why? Business value; How Release on Demand
6.1 Release on demand
Release value to customers all at once or incrementally
Feature toggles (covered in Deploy)
Canary Releases
Provide the ability to release value to part of the user population, be it internal or external
Add or remove user segments based on business decisions
Combine with selective deployments to enable incremental deployment and rollout
Decouple release elements (covered in Architect)
Dark Launches (covered in Deploy)
6.2 Stabilize the solution
Purpose: Ensure sustainability of high levels of business continuity, application service levels, and data protection
Site Reliability Engineering (SRE)
Ensure large systems are highly reliable and scalable 
Shared ownership of system stability between Dev and OPs
T-Shaped engineers with deep development and operations expertise
Approaching all operational activities as a software concern
Closely managing Service Level Indicators (SLIs) and Service Level Objectives (SLOs)
Failover/Disaster Recovery
Develop the ability to recover quickly
Failover mechanism allows service to resume quickly, or even avoid service interruption
Disaster recovery must be planned, architected into the service and practices 
Continuous security monitoring
Detect intrusions and attacks on production services and infrastructure (detective controls)
Security as code and penetration testing focus on preventing known vulnerabilities from getting to production (preventive controls)
Test services continuously for newly discovered and reported vulnerabilities
Architect for operations (covered in Architect)
Nonfunctional requirements (covered in Test End-to-End)
6.3 Measure the business value
Purpose: Test hypotheses of business value and customers are delighted with delivered solution before Operations takes custody
Innovation accounting (covered in Hypothesize)
Evaluate hypothesis
Application telemetry creates a way to evaluate the business results of a hypothesis
Measure both leading and lagging indicators
Build the ability to identify the correlation between business results and the hypothesis being tested
6.4 Learn and React
Purpose: Learn from the hypothesis on whether to pivot or persevere, as well as how to improve the flow of value
Learn Startup (covered in Hypothesize)
Relentless Improvement
In order to improve the ability to test hypotheses, the Continuous Delivery Pipeline must be constantly maintained
Team-level retrospectives and program and solution-level Inspect and Adapt events are crucial to improve the flow
Focus on the root cause of bottlenecks and research incidents to identify the most important place to improve
Value Stream Mapping
Continuously apply Value Stream mapping to optimize value flow
Apply current state mapping and future state mapping so objectives are clear

