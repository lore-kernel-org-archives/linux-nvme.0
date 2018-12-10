From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 10 Dec 2018 22:53:15 +0000
Subject: [PATCH 07/12] nvmet: add error log support for file backend
In-Reply-To: <b2bc67f7-0b75-40cd-ff74-3b4f3284be3b@grimberg.me>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-8-chaitanya.kulkarni@wdc.com>,
 <b2bc67f7-0b75-40cd-ff74-3b4f3284be3b@grimberg.me>
Message-ID: <BYAPR04MB450254940F29FC613F42445F86A50@BYAPR04MB4502.namprd04.prod.outlook.com>







From: Sagi Grimberg <sagi@grimberg.me>
Sent: Monday, December 10, 2018 12:32 PM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Cc: hch at lst.de; keith.busch at intel.com
Subject: Re: [PATCH 07/12] nvmet: add error log support for file backend
? 


> +???? case -EILSEQ:
> +???????????? req->error_loc = offsetof(struct nvme_rw_command, nsid);
> +???????????? status = NVME_SC_INVALID_PI;

Same here...
[CK] Will skip this errorno in the next round.
    
