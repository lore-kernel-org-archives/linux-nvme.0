From: hch@lst.de (hch@lst.de)
Date: Fri, 14 Apr 2017 10:22:31 +0200
Subject: [PATCH 02/25] block: remove the blk_execute_rq return value
In-Reply-To: <1492113800.24345.9.camel@sandisk.com>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de> <1492113800.24345.9.camel@sandisk.com>
Message-ID: <20170414082231.GC24901@lst.de>

On Thu, Apr 13, 2017@08:03:22PM +0000, Bart Van Assche wrote:
> That blk_execute_rq() call can only be reached if a few lines above 0 was
> assigned to the "error" variable. Since nfsd4_scsi_identify_device() returns
> the value of the "error" variable I think -EIO should be assigned to that
> variable before the "goto out_put_request" statement is reached.

You're right!  I'll fix it up.
