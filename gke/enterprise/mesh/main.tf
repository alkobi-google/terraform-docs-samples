/**
* Copyright 2025 Google LLC
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

# [START gke_enterprise_mesh]
resource "google_project_service" "default" {
  for_each = toset([
    "meshconfig.googleapis.com"
  ])

  service            = each.value
  disable_on_destroy = false
}

resource "google_gke_hub_feature" "default" {
  name     = "servicemesh"
  location = "global"

  fleet_default_member_config {
    mesh {
      management = "MANAGEMENT_AUTOMATIC"
    }
  }

  depends_on = [google_project_service.default]
}
# [END gke_enterprise_mesh]