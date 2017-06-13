From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 13 Jun 2017 10:00:23 +0200
Subject: [PATCH] nvme: move protection information check into nvme_setup_rw
In-Reply-To: <20170612163632.23009-1-hch@lst.de>
References: <20170612163632.23009-1-hch@lst.de>
Message-ID: <95127f6a-9e74-3c21-3d76-8b65dbb53288@suse.de>

On 06/12/2017 06:36 PM, Christoph Hellwig wrote:
> +static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
>  {

Hmm here you're changing nvme_setup_rw to return blk_status_t

[...]

> @@ -386,6 +395,7 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
>  
>  	cmnd->rw.control = cpu_to_le16(control);
>  	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> +	return 0;
>  }

And here you're returning 0 instead of BLK_STATUS_OK.

Intentional?

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
