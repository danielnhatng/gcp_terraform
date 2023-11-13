resource "google_monitoring_notification_channel" "nhatnd19-gmail_notification" {
    display_name = "Gmail Notification"
    type         = "email"

    labels = {
    email_address = "danielnhatng@gmail.com"
    }
}


resource "google_monitoring_alert_policy" "nhatnd19-alert-policy"{
    display_name = "VM Creation/Deletion Alert"
    documentation {
        content = "Reporting to Nhat-sama"
    }
    combiner = "OR"
    conditions {
        display_name = "VM Creation/Deletion Condition"
        condition_threshold {
            filter    = "resource.type = \"autoscaler\" AND metric.type = \"autoscaler.googleapis.com/capacity\""
            duration = "0s"
            comparison = "COMPARISON_GT"
            aggregations {
                alignment_period = "60s"
                cross_series_reducer = "REDUCE_NONE"
                per_series_aligner = "ALIGN_MEAN"
            }
            trigger {
                count = 1
            }
            threshold_value = 2
        }
    }
    notification_channels = [ google_monitoring_notification_channel.nhatnd19-gmail_notification.name]

}