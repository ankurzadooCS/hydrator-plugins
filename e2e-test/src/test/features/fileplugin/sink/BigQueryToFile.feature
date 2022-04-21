@File_Sink @FILE_SINK_TEST
Feature:File Sink - Verification of BigQuery to File successful data transfer

  @BQ_SOURCE_TEST
  Scenario Outline: To verify data is getting transferred from BigQuery to File successfully for different formats
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "File" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "File" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "projectId" with value: "projectId"
    Then Enter input plugin property: "datasetProjectId" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqSourceTable"
    Then Click on the Get Schema button
    Then Capture the generated Output Schema
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Enter input plugin property: "path" with value: "filePluginOutputFolder"
    Then Replace input plugin property: "pathSuffix" with value: "yyyy-MM-dd-HH-mm-ss"
    Then Select dropdown plugin property: "format" with option value: "<FileFormat>"
    Then Validate "File" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on the Preview Data link on the Sink plugin node: "File"
    Then Verify sink plugin's Preview Data for Input Records table and the Input Schema matches the Output Schema of Source plugin
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate OUT record count is equal to IN record count
    Examples:
      | FileFormat |
      | csv        |
      | avro       |
      | tsv        |
      | json       |
      | orc        |
      | parquet    |

  @BQ_SOURCE_TEST
  Scenario: To verify data is getting transferred from BigQuery to File successfully for delimited format
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "File" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "File" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "projectId" with value: "projectId"
    Then Enter input plugin property: "datasetProjectId" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqSourceTable"
    Then Click on the Get Schema button
    Then Capture the generated Output Schema
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Enter input plugin property: "path" with value: "filePluginOutputFolder"
    Then Replace input plugin property: "pathSuffix" with value: "yyyy-MM-dd-HH-mm-ss"
    Then Select dropdown plugin property: "format" with option value: "delimited"
    Then Enter input plugin property: "delimiter" with value: "delimiter"
    Then Validate "File" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on the Preview Data link on the Sink plugin node: "File"
    Then Verify sink plugin's Preview Data for Input Records table and the Input Schema matches the Output Schema of Source plugin
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate OUT record count is equal to IN record count

  @BQ_SOURCE_TEST
  Scenario: To verify data is getting transferred from BigQuery to File successfully with file properties as macro arguments
    Given Open Datafusion Project to configure pipeline
    When Select plugin: "BigQuery" from the plugins list as: "Source"
    When Expand Plugin group in the LHS plugins list: "Sink"
    When Select plugin: "File" from the plugins list as: "Sink"
    Then Connect plugins: "BigQuery" and "File" to establish connection
    Then Navigate to the properties page of plugin: "BigQuery"
    Then Replace input plugin property: "projectId" with value: "projectId"
    Then Enter input plugin property: "datasetProjectId" with value: "projectId"
    Then Enter input plugin property: "referenceName" with value: "BQReferenceName"
    Then Enter input plugin property: "dataset" with value: "dataset"
    Then Enter input plugin property: "table" with value: "bqSourceTable"
    Then Click on the Get Schema button
    Then Capture the generated Output Schema
    Then Validate "BigQuery" plugin properties
    Then Close the Plugin Properties page
    Then Navigate to the properties page of plugin: "File"
    Then Enter input plugin property: "referenceName" with value: "FileReferenceName"
    Then Click on the Macro button of Property: "path" and set the value to: "fileSinkPath"
    Then Click on the Macro button of Property: "pathSuffix" and set the value to: "fileSinkPathSuffix"
    Then Click on the Macro button of Property: "formatMacroInput" and set the value to: "fileSinkFormat"
    Then Validate "File" plugin properties
    Then Close the Plugin Properties page
    Then Save the pipeline
    Then Preview and run the pipeline
    Then Enter runtime argument value "filePluginOutputFolder" for key "fileSinkPath"
    Then Enter runtime argument value "fileSinkPathSuffix" for key "fileSinkPathSuffix"
    Then Enter runtime argument value "csvFormat" for key "fileSinkFormat"
    Then Run the preview of pipeline with runtime arguments
    Then Wait till pipeline preview is in running state
    Then Open and capture pipeline preview logs
    Then Verify the preview run status of pipeline in the logs is "succeeded"
    Then Close the pipeline logs
    Then Click on the Preview Data link on the Sink plugin node: "File"
    Then Verify sink plugin's Preview Data for Input Records table and the Input Schema matches the Output Schema of Source plugin
    Then Close the preview data
    Then Deploy the pipeline
    Then Run the Pipeline in Runtime
    Then Enter runtime argument value "filePluginOutputFolder" for key "fileSinkPath"
    Then Enter runtime argument value "fileSinkPathSuffix" for key "fileSinkPathSuffix"
    Then Enter runtime argument value "csvFormat" for key "fileSinkFormat"
    Then Run the Pipeline in Runtime with runtime arguments
    Then Wait till pipeline is in running state
    Then Open and capture logs
    Then Verify the pipeline status is "Succeeded"
    Then Close the pipeline logs
    Then Validate OUT record count is equal to IN record count
