From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 20 May 2019 04:03:38 +0900
Subject: [PATCH V2 3/4] nvme: Return errno mapped for nvme error status
In-Reply-To: <BYAPR04MB574905F74B2AC5E18BB39B0C86050@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190513170342.9497-1-minwoo.im.dev@gmail.com>
 <20190513170342.9497-4-minwoo.im.dev@gmail.com>
 <BYAPR04MB574936E1FDF464243691513286050@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190519175315.GA10876@minwooim-desktop>
 <BYAPR04MB574905F74B2AC5E18BB39B0C86050@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <20190519190336.GD10876@minwooim-desktop>

> Printing NVMe status with err by retaining existing behavior.
> 
> Since existing code might have assumption of err holding the nvme 
> status. Also since we are changing the return code functionality so
> it shouldn't affect the rest of the code pattern.

Thanks for the review.  Please review V3 that has been updated.
