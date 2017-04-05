From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Apr 2017 11:14:30 -0400
Subject: [PATCH 4/5] nvme: move the retries count to struct nvme_request
In-Reply-To: <20170405141856.1862-5-hch@lst.de>
References: <20170405141856.1862-1-hch@lst.de>
 <20170405141856.1862-5-hch@lst.de>
Message-ID: <20170405151430.GS20181@localhost.localdomain>

On Wed, Apr 05, 2017@04:18:55PM +0200, Christoph Hellwig wrote:
> The way NVMe uses this field is entirely different from the older
> SCSI/BLOCK_PC usage, so move it into struct nvme_request.
> 
> Also reduce the size of the file to a unsigned char so that we leave space
> for additional smaller fields that will appear soon.

What new fields can we expect? Why temporarily pad the middle of the
struct instead of appending to the end? The "result" packed nicely
on 64-bit, at least.

>  struct nvme_request {
>  	struct nvme_command	*cmd;
> +	u8			retries;
>  	union nvme_result	result;
>  };
