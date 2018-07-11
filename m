From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Jul 2018 12:39:28 +0300
Subject: [PATCH for-4.18 2/2] nvmet: check fileio lba range access
 boundaries
In-Reply-To: <BYAPR04MB4502471F3BAA1FC8A1ECC8F5865B0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180710111702.12541-1-sagi@grimberg.me>
 <20180710111702.12541-2-sagi@grimberg.me>
 <BYAPR04MB4502471F3BAA1FC8A1ECC8F5865B0@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <e9ef3a17-73cb-88d3-38e0-1a280b29d45c@grimberg.me>


> Thanks for providing the fix. We need to free the memory when the pos comparison
> results true for out of bounds before calling the nvmet_req_complete() in
> nvmet_file_execute_rw(), please have a look at the following diff on the top of this patch,
> it frees the memory and adds the status variable instead of using the ret which has a
> different type than nvmet_req_complete() 2nd argument.

I'd just move it before the allocations, we need to perform boundary
checks before allocating any request resources...
