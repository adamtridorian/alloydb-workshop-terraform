resource "google_bigquery_dataset" "bq-dataset" {
  dataset_id = "bq_dataset"
  project    = var.project_id
  location   = "asia-southeast1"
}

# resource "google_bigquery_table" "bq-table" {
#   table_id   = "bq-table"
#   dataset_id = "bq_dataset"
#   project    = var.project_id

#   schema = file("schema.json")

#   external_data_configuration {
#     source_uris     = ["./demo.csv"]
#     source_format   = "CSV"
#     autodetect      = true
#     csv_options {
#       skip_leading_rows = 1
#       quote             = "\""
#     }
#   }
# }

# resource "google_bigquery_saved_query" "example_query" {
#   project     = "your-project-id"
#   dataset_id  = google_bigquery_dataset.bq-dataset.dataset_id
#   query_id    = "your_saved_query_id"
#   query       = <<QUERY
#     SELECT *
#     FROM `${google_bigquery_dataset.bq-dataset.dataset_id}.your_table_id`
#   QUERY

#   description = "Saved query"
# }