From: axboe@fb.com (Jens Axboe)
Date: Thu, 10 Nov 2016 10:10:47 -0700
Subject: rework NVMe command passthrough V2
In-Reply-To: <1478791954-30152-1-git-send-email-hch@lst.de>
References: <1478791954-30152-1-git-send-email-hch@lst.de>
Message-ID: <a97ccb23-ae7e-55fe-77d3-6339a0a049e2@fb.com>

On 11/10/2016 08:32 AM, Christoph Hellwig wrote:
> Hi all,
>
> this series started out as part of my attempt to get rid of the SCSI
> passthrough fields in struct request, but reviewing the NVMe FC patches
> and subsequent discussion with James gave them additional priority.
>
> This series introduces a nvme_request structure common to all transports,
> which allows us to stop abusing the SCSI passthrough fields in struct
> request, and also allows us to stop passing the full CQE up to the
> callers of the request interface which is rather painful for FC.

Applied for 4.10, thanks.

-- 
Jens Axboe
