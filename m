From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 3 Dec 2018 22:26:46 +0000
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <6d3cd3cd-35e1-9623-4b84-a4f994bbdc10@suse.de>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>,
 <6d3cd3cd-35e1-9623-4b84-a4f994bbdc10@suse.de>
Message-ID: <BYAPR04MB450255727DC71F9ED2C79A8286AE0@BYAPR04MB4502.namprd04.prod.outlook.com>







From: Johannes Thumshirn <jthumshirn@suse.de>
Sent: Monday, December 3, 2018 2:13 AM
To: Chaitanya Kulkarni; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] nvme-core: small cleanups
? 
 
Hi Chaitanya,

On 29/11/2018 18:18, Chaitanya Kulkarni wrote:
> @@ -1023,9 +1026,10 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
>??????????????? unsigned nsid)
>? {
>??????? struct nvme_id_ns *id;
> -???? struct nvme_command c = { };
> +???? struct nvme_command c};
>??????? int error;
>? 

[CK] Yes it is, let me resend.

This hunk looks wrong to me.

-- 
Johannes Thumshirn??????????????????????????? SUSE Labs Filesystems
jthumshirn at suse.de??????????????????????????????? +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
    
