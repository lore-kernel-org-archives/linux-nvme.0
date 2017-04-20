From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Apr 2017 15:25:12 +0000
Subject: [PATCH 08/23] scsi: introduce a result field in struct
 scsi_request
In-Reply-To: <20170420140316.6546-9-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
 <20170420140316.6546-9-hch@lst.de>
Message-ID: <1492701911.2642.1.camel@sandisk.com>

On Thu, 2017-04-20@16:03 +0200, Christoph Hellwig wrote:
> This passes on the scsi_cmnd result field to users of passthrough
> requests.  Currently we abuse req->errors for this purpose, but that
> field will go away in its current form.
> 
> Note that the old IDE code abuses the errors field in very creative
> ways and stores all kinds of different values in it.  I didn't dare
> to touch this magic, so the abuses are brought forward 1:1.

Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
