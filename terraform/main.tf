resource "aws_route53_zone" "normpress" {
  name = "normpress.com"

  tags = {
    "Project" = "normpress"
  }
}

resource "aws_s3_bucket" "normpress" {
  bucket = "normpress"

  tags = {
    "Project" = "normpress"
  }

  website {
    redirect_all_requests_to = "https://github.com/norm/flourish"
  }
}

resource "aws_route53_record" "apex_normpress" {
  name = "normpress.com"
  type = "A"

  alias {
    name                   = aws_s3_bucket.normpress.website_domain
    zone_id                = aws_s3_bucket.normpress.hosted_zone_id
    evaluate_target_health = false
  }

  zone_id = aws_route53_zone.normpress.zone_id
}

output "nameservers" {
  value = aws_route53_zone.normpress.name_servers
}
