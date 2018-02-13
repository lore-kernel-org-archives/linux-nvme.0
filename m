From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 13 Feb 2018 14:47:51 +0100
Subject: [PATCH 1/1] nvme: implement log page low/high offset and dwords
In-Reply-To: <20180213124916.28653-2-mb@lightnvm.io>
References: <20180213124916.28653-1-mb@lightnvm.io>
 <20180213124916.28653-2-mb@lightnvm.io>
Message-ID: <1518529671.3592.9.camel@suse.de>

On Tue, 2018-02-13@13:49 +0100, Matias Bj?rling wrote:
> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			????u8 log_page, void *log,
> +			????size_t size, size_t offset)
> +{
> +	struct nvme_command c = { };
> +	unsigned long dwlen = (size / 4) - 1;

Consulting my long gone maths knowledge suggests the parantheses aren't
really needed here.

-- 
Johannes Thumshirn ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Storage
jthu
mshirn at suse.de ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+49 911 74053 689
SUSE
LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane
Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38
9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
