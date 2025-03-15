provider "google" {
  project     = "symbolic-math-446906-f2"
  region      = "us-central1"
  credentials = file("terraformkey.json")
}