GitHub (frontend code)
        ↓
CodePipeline Source
        ↓
CodeBuild → build frontend
        ↓
S3 bucket → host static site
        ↓
CloudFront → CDN + HTTPS