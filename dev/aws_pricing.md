

aws pricing describe-services --format-version aws_v1 --region us-east-1

```json
{
    "Services": [
        {
            "ServiceCode": "AmazonEC2",
            "AttributeNames": [
                "instanceCapacityMetal",
                "volumeType",
                "maxIopsvolume",
                "instance",
                "instanceCapacity10xlarge",
                "locationType",
                "toLocationType",
                "instanceFamily",
                "operatingSystem",
                "clockSpeed",
                "LeaseContractLength",
                "ecu",
                "networkPerformance",
                "instanceCapacity8xlarge",
                "group",
                "maxThroughputvolume",
                "gpuMemory",
                "ebsOptimized",
                "maxVolumeSize",
                "gpu",
                "intelAvxAvailable",
                "processorFeatures",
                "instanceCapacity4xlarge",
                "servicecode",
                "groupDescription",
                "elasticGraphicsType",
                "volumeApiName",
                "processorArchitecture",
                "fromLocation",
                "physicalCores",
                "productFamily",
                "fromLocationType",
                "enhancedNetworkingSupported",
                "intelTurboAvailable",
                "memory",
                "dedicatedEbsThroughput",
                "vcpu",
                "OfferingClass",
                "instanceCapacityLarge",
                "capacitystatus",
                "termType",
                "storage",
                "toLocation",
                "intelAvx2Available",
                "storageMedia",
                "physicalProcessor",
                "provisioned",
                "servicename",
                "PurchaseOption",
                "instancesku",
                "productType",
                "instanceCapacity18xlarge",
                "instanceType",
                "tenancy",
                "usagetype",
                "normalizationSizeFactor",
                "instanceCapacity2xlarge",
                "instanceCapacity16xlarge",
                "maxIopsBurstPerformance",
                "instanceCapacity12xlarge",
                "instanceCapacity32xlarge",
                "instanceCapacityXlarge",
                "licenseModel",
                "currentGeneration",
                "preInstalledSw",
                "transferType",
                "location",
                "instanceCapacity24xlarge",
                "instanceCapacity9xlarge",
                "instanceCapacityMedium",
                "operation",
                "resourceType"
            ]
        },
        {
            "ServiceCode": "AmazonRDS",
            "AttributeNames": [
                "productFamily",
                "volumeType",
                "engineCode",
                "enhancedNetworkingSupported",
                "memory",
                "dedicatedEbsThroughput",
                "vcpu",
                "OfferingClass",
                "termType",
                "locationType",
                "storage",
                "instanceFamily",
                "storageMedia",
                "databaseEdition",
                "physicalProcessor",
                "LeaseContractLength",
                "clockSpeed",
                "networkPerformance",
                "deploymentOption",
                "servicename",
                "PurchaseOption",
                "group",
                "minVolumeSize",
                "instanceTypeFamily",
                "instanceType",
                "usagetype",
                "normalizationSizeFactor",
                "maxVolumeSize",
                "databaseEngine",
                "processorFeatures",
                "Restriction",
                "servicecode",
                "groupDescription",
                "licenseModel",
                "currentGeneration",
                "location",
                "processorArchitecture",
                "operation"
            ]
        },
        {
            "ServiceCode": "AmazonRedshift",
            "AttributeNames": [
                "productFamily",
                "memory",
                "vcpu",
                "OfferingClass",
                "termType",
                "locationType",
                "description",
                "storage",
                "storageMedia",
                "LeaseContractLength",
                "ecu",
                "servicename",
                "PurchaseOption",
                "group",
                "concurrencyscalingfreeusage",
                "io",
                "instanceType",
                "usagetype",
                "Restriction",
                "servicecode",
                "groupDescription",
                "pricingUnit",
                "currentGeneration",
                "usageFamily",
                "location",
                "operation"
            ]
        }
    ],
    "FormatVersion": "aws_v1"
}
```
####

RDS

aws pricing get-products --region us-east-1 --format-version aws_v1 --service-code AmazonRDS --filters Type=TERM_MATCH,Field=instanceType,Value="db.t3.large" Type=TERM_MATCH,Field=location,Value="US East (N. Virginia)" Type=TERM_MATCH,Field=productFamily,Value="Database Instance" Type=TERM_MATCH,Field=termType,Value="OnDemand" Type=TERM_MATCH,Field=databaseEngine,Value="PostgreSQL" Type=TERM_MATCH,Field=deploymentOption,Value="Single-AZ"

aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name instanceType

aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name databaseEngine
```{
    "AttributeValues": [
        {
            "Value": "Any"
        },
        {
            "Value": "Aurora MySQL"
        },
        {
            "Value": "Aurora PostgreSQL"
        },
        {
            "Value": "MariaDB"
        },
        {
            "Value": "MySQL (on-premise for Outpost)"
        },
        {
            "Value": "MySQL"
        },
        {
            "Value": "Oracle"
        },
        {
            "Value": "PostgreSQL (on-premise for Outpost)"
        },
        {
            "Value": "PostgreSQL (on-premise for Outposts)"
        },
        {
            "Value": "PostgreSQL"
        },
        {
            "Value": "SQL Server"
        }
    ]
}
```

aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name licenseModel
```
{
    "AttributeValues": [
        {
            "Value": "Bring your own license"
        },
        {
            "Value": "License included"
        },
        {
            "Value": "No license required"
        },
        {
            "Value": "On-premises customer provided license"
        }
    ]
}
```


aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name volumeType  
```
{
    "AttributeValues": [
        {
            "Value": "General Purpose-Aurora"
        },
        {
            "Value": "General Purpose"
        },
        {
            "Value": "Magnetic"
        },
        {
            "Value": "Provisioned IOPS"
        }
    ]
}
```

aws pricing get-attribute-values --region us-east-1 --service-code AmazonRDS --attribute-name deploymentOption
{
    "AttributeValues": [
        {
            "Value": "Multi-AZ (SQL Server Mirror)"
        },
        {
            "Value": "Multi-AZ"
        },
        {
            "Value": "Single-AZ"
        }
    ]
}


####

aws pricing get-products --region us-east-1 --format-version aws_v1 --service-code AmazonEC2 --filters Type=TERM_MATCH,Field=capacitystatus,Value="Used" Type=TERM_MATCH,Field=instanceType,Value="t2.micro" Type=TERM_MATCH,Field=licenseModel,Value="No License required" Type=TERM_MATCH,Field=location,Value="EU (Ireland)" Type=TERM_MATCH,Field=operatingSystem,Value="Linux" Type=TERM_MATCH,Field=preInstalledSw,Value="NA" Type=TERM_MATCH,Field=tenancy,Value="Shared"


Response:
{
    "PriceList": [
        "{\"product\":{\"productFamily\":\"Compute Instance\",\"attributes\":{\"enhancedNetworkingSupported\":\"No\",\"intelTurboAvailable\":\"Yes\",\"memory\":\"1 GiB\",\"vcpu\":\"1\",\"capacitystatus\":\"Used\",\"locationType\":\"AWS Region\",\"storage\":\"EBS only\",\"instanceFamily\":\"General purpose\",\"operatingSystem\":\"Linux\",\"intelAvx2Available\":\"No\",\"physicalProcessor\":\"Intel Xeon Family\",\"clockSpeed\":\"Up to 3.3 GHz\",\"ecu\":\"Variable\",\"networkPerformance\":\"Low to Moderate\",\"servicename\":\"Amazon Elastic Compute Cloud\",\"instanceType\":\"t2.micro\",\"tenancy\":\"Shared\",\"usagetype\":\"EU-BoxUsage:t2.micro\",\"normalizationSizeFactor\":\"0.5\",\"intelAvxAvailable\":\"Yes\",\"processorFeatures\":\"Intel AVX; Intel Turbo\",\"servicecode\":\"AmazonEC2\",\"licenseModel\":\"No License required\",\"currentGeneration\":\"Yes\",\"preInstalledSw\":\"NA\",\"location\":\"EU (Ireland)\",\"processorArchitecture\":\"32-bit or 64-bit\",\"operation\":\"RunInstances\"},\"sku\":\"STTHYT3WDDQU8UBR\"},\"serviceCode\":\"AmazonEC2\",\"terms\":{\"OnDemand\":{\"STTHYT3WDDQU8UBR.JRTCKXETXF\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.JRTCKXETXF.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"$0.0126 per On Demand Linux t2.micro Instance Hour\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.JRTCKXETXF.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0126000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2021-01-01T00:00:00Z\",\"offerTermCode\":\"JRTCKXETXF\",\"termAttributes\":{}}},\"Reserved\":{\"STTHYT3WDDQU8UBR.CUZHX8X6JH\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.CUZHX8X6JH.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.CUZHX8X6JH.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"43\"}},\"STTHYT3WDDQU8UBR.CUZHX8X6JH.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.CUZHX8X6JH.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0049000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-10-31T23:59:59Z\",\"offerTermCode\":\"CUZHX8X6JH\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"Partial Upfront\"}},\"STTHYT3WDDQU8UBR.7NE97W5U4E\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.7NE97W5U4E.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.7NE97W5U4E.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0102000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-10-31T23:59:59Z\",\"offerTermCode\":\"7NE97W5U4E\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"No Upfront\"}},\"STTHYT3WDDQU8UBR.6QCMYABX3D\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.6QCMYABX3D.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.6QCMYABX3D.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"72\"}},\"STTHYT3WDDQU8UBR.6QCMYABX3D.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.6QCMYABX3D.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0000000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"6QCMYABX3D\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"All Upfront\"}},\"STTHYT3WDDQU8UBR.38NPMPTW36\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.38NPMPTW36.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.38NPMPTW36.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"77\"}},\"STTHYT3WDDQU8UBR.38NPMPTW36.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.38NPMPTW36.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0029000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"38NPMPTW36\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"Partial Upfront\"}},\"STTHYT3WDDQU8UBR.Z2E3P23VKM\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.Z2E3P23VKM.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.Z2E3P23VKM.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0073000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"Z2E3P23VKM\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"No Upfront\"}},\"STTHYT3WDDQU8UBR.NQ3QZPMQV9\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.NQ3QZPMQV9.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.NQ3QZPMQV9.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"145\"}},\"STTHYT3WDDQU8UBR.NQ3QZPMQV9.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.NQ3QZPMQV9.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0000000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"NQ3QZPMQV9\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"All Upfront\"}},\"STTHYT3WDDQU8UBR.BPH4J8HBKS\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.BPH4J8HBKS.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.BPH4J8HBKS.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0063000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"BPH4J8HBKS\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"No Upfront\"}},\"STTHYT3WDDQU8UBR.R5XV2EPZQZ\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.R5XV2EPZQZ.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.R5XV2EPZQZ.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"89\"}},\"STTHYT3WDDQU8UBR.R5XV2EPZQZ.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.R5XV2EPZQZ.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0034000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"R5XV2EPZQZ\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"Partial Upfront\"}},\"STTHYT3WDDQU8UBR.HU7G6KETJZ\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.HU7G6KETJZ.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.HU7G6KETJZ.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"37\"}},\"STTHYT3WDDQU8UBR.HU7G6KETJZ.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.HU7G6KETJZ.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0042000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"HU7G6KETJZ\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"Partial Upfront\"}},\"STTHYT3WDDQU8UBR.4NA7Y494T4\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.4NA7Y494T4.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.4NA7Y494T4.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0089000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"4NA7Y494T4\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"standard\",\"PurchaseOption\":\"No Upfront\"}},\"STTHYT3WDDQU8UBR.MZU6U2429S\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.MZU6U2429S.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.MZU6U2429S.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"174\"}},\"STTHYT3WDDQU8UBR.MZU6U2429S.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.MZU6U2429S.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0000000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-08-31T23:59:59Z\",\"offerTermCode\":\"MZU6U2429S\",\"termAttributes\":{\"LeaseContractLength\":\"3yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"All Upfront\"}},\"STTHYT3WDDQU8UBR.VJWZNREJX2\":{\"priceDimensions\":{\"STTHYT3WDDQU8UBR.VJWZNREJX2.2TG2D8R56U\":{\"unit\":\"Quantity\",\"description\":\"Upfront Fee\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.VJWZNREJX2.2TG2D8R56U\",\"pricePerUnit\":{\"USD\":\"83\"}},\"STTHYT3WDDQU8UBR.VJWZNREJX2.6YS6EN2CT7\":{\"unit\":\"Hrs\",\"endRange\":\"Inf\",\"description\":\"Linux/UNIX (Amazon VPC), t2.micro reserved instance applied\",\"appliesTo\":[],\"rateCode\":\"STTHYT3WDDQU8UBR.VJWZNREJX2.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.0000000000\"}}},\"sku\":\"STTHYT3WDDQU8UBR\",\"effectiveDate\":\"2017-10-31T23:59:59Z\",\"offerTermCode\":\"VJWZNREJX2\",\"termAttributes\":{\"LeaseContractLength\":\"1yr\",\"OfferingClass\":\"convertible\",\"PurchaseOption\":\"All Upfront\"}}}},\"version\":\"20210115195025\",\"publicationDate\":\"2021-01-15T19:50:25Z\"}"
    ],
    "FormatVersion": "aws_v1"
}


aws pricing get-products --region us-east-1 --format-version aws_v1 --service-code AmazonEC2 --filters "Type=TERM_MATCH,Field=ServiceCode,Value=AmazonEC2" "Type=TERM_MATCH,Field=location,Value=\"EU (Ireland)\"" "Type=TERM_MATCH,Field=volumeApiName,Value=io2" "Type=TERM_MATCH,Field=volumeType,Value=\"Provisioned IOPS\""
{
    "PriceList": [
        "{\"product\":{\"productFamily\":\"Storage\",\"attributes\":{\"storageMedia\":\"SSD-backed\",\"maxThroughputvolume\":\"1000 MiB/s\",\"volumeType\":\"Provisioned IOPS\",\"maxIopsvolume\":\"64000\",\"servicecode\":\"AmazonEC2\",\"usagetype\":\"EU-EBS:VolumeUsage.io2\",\"locationType\":\"AWS Region\",\"volumeApiName\":\"io2\",\"location\":\"EU (Ireland)\",\"servicename\":\"Amazon Elastic Compute Cloud\",\"maxVolumeSize\":\"16 TiB\",\"operation\":\"\"},\"sku\":\"TN2XFMNDXRZZ5CGK\"},\"serviceCode\":\"AmazonEC2\",\"terms\":{\"OnDemand\":{\"TN2XFMNDXRZZ5CGK.JRTCKXETXF\":{\"priceDimensions\":{\"TN2XFMNDXRZZ5CGK.JRTCKXETXF.6YS6EN2CT7\":{\"unit\":\"GB-month\",\"endRange\":\"Inf\",\"description\":\"$0.138 per GB-month of Provisioned IOPS SSD (io2)  provisioned storage - EU (Ireland)\",\"appliesTo\":[],\"rateCode\":\"TN2XFMNDXRZZ5CGK.JRTCKXETXF.6YS6EN2CT7\",\"beginRange\":\"0\",\"pricePerUnit\":{\"USD\":\"0.1380000000\"}}},\"sku\":\"TN2XFMNDXRZZ5CGK\",\"effectiveDate\":\"2021-01-01T00:00:00Z\",\"offerTermCode\":\"JRTCKXETXF\",\"termAttributes\":{}}}},\"version\":\"20210115195025\",\"publicationDate\":\"2021-01-15T19:50:25Z\"}"
    ],
    "FormatVersion": "aws_v1"
}
