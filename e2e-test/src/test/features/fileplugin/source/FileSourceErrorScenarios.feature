@File_Source @FILE_SOURCE_TEST
Feature:File Source - Verify File Source Plugin Error scenarios

  Scenario:Verify File source plugin validation errors for mandatory fields
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "File" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "File"
    Then Click on the Validate button
    Then Verify mandatory property error for below listed properties:
      | referenceName |
      | path          |
      | format        |

  Scenario:Verify File source plugin error for invalid input path
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "File" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Enter input plugin property: "path" with value: "incorrectFilePath"
    Then Select dropdown plugin property: "format" with option value: "csv"
    Then Click on the Get Schema button
    Then Verify that the Plugin is displaying an error message: "errorMessageInputPath" on the header

  Scenario:Verify File source plugin error for incorrect pathField
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "File" from the plugins list as: "Source"
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Enter input plugin property: "path" with value: "outputFieldTestFile"
    Then Select dropdown plugin property: "format" with option value: "csv"
    Then Click plugin property: "skipHeader"
    Then Enter input plugin property: "pathField" with value: "invalidOutputPathField"
    Then Click on the Get Schema button
    Then Verify file plugin in-line error message for incorrect pathField value: "invalidOutputPathField"

  @BQ_SINK_TEST
  Scenario: To verify pipeline preview gets failed for incorrect Regex path filter
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "File" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "BigQuery" from the plugins list as: "Sink"
    Then Connect plugins: "File" and "BigQuery" to establish connection
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Enter input plugin property: "path" with value: "csvFile"
    Then Select dropdown plugin property: "format" with option value: "csv"
    Then Enter input plugin property: "regexPathFilter" with value: "incorrectRegexPathFilter"
    Then Click plugin property: "skipHeader"
    Then Click on the Get Schema button
    Then Verify the Output Schema matches the Expected Schema: "csvFileSchema"
    Then Validate "File" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "projectId" with value: "projectId"
    Then Enter input plugin property: "datasetProjectId" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqTargetTable"
    Then Click plugin property: "truncateTable"
    Then Click plugin property: "updateTableSchema"
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "failed"
