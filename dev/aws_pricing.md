aws pricing describe-services --service-code AmazonEC2 --format-version aws_v1 --max-items 1 --region us-east-1


aws pricing get-products --region us-east-1 --filters file://filters.json --format-version aws_v1 --service-code AmazonEC2


Response:

{
"PriceList": [
"{\"product\":{\"productFamily\":\"Storage\",\"attributes\":{\"storageMedia\":\"SSD-backed\",\"maxThroughputvolume\":\"1000 MiB/s\",\"volumeType\":\"Provisioned IOPS\",\"maxIopsvolume\":\"64000\",\"servicecode\":\"AmazonEC2\",\"usagetype\":\"EU-EBS:VolumeUsage.io2\",\"locationType\":\"AWS Region\",\"volumeApiName\":\"io2\",\"location\":\"EU (Ireland)\",\"servicename\":\"Amazon Elastic Compute Cloud\",\"maxVolumeSize\":\"16 TiB\",\"operation\":\"\"},\"sku\":\"TN2XFMNDXRZZ5CGK\"},\"serviceCode\":\"AmazonEC2\",\"terms\":{\"OnDemand\":{\"TN2XFMNDXRZZ5CGK.JRTCKXETXF\":{\"priceDimensions\":{\"TN2XFMNDXRZZ5CGK.JRTCKXETXF.6YS6EN2CT7\":{\"unit\":\"GB-month\",\"endRange\":\"Inf\",\"description\":\"$0.138 per GB-month of Provisioned IOPS SSD (io2)  provisioned storage - EU (Ireland)\",\"appliesTo\":[],\"rateCode\":\"TN2XFMNDXRZZ5CGK.JRTCKXETXF.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.1380000000\"}}},\"sku\":\"TN2XFMNDXRZZ5CGK\",\"effectiveDate\":\"2020-12-01T00:00:00Z\",\"offerTermCode\":\"JRTCKXETXF\",\"termAttributes\":{}}}},\"version\":\"20201229065513\",\"publicationDate\":\"2020-12-29T06:55:13Z\"}"
],
"FormatVersion": "aws_v1"
}
