From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 12:18:35 +0200
Subject: [PATCH] nvme: make NVME_SC_UNWRITTEN_BLOCK a thin-provisioned
 error
In-Reply-To: <20180418072723.25874-1-hare@suse.de>
References: <20180418072723.25874-1-hare@suse.de>
Message-ID: <20180418101835.GA15833@lst.de>

On Wed, Apr 18, 2018@09:27:23AM +0200, Hannes Reinecke wrote:
> According to the spec NVME_SC_UNWRITTEN_BLOCK signals
> 'an attempt to read from an LBA range containing a deallocated
> or unwritten logical block'.
> So this is not so much about the medium being faulty, but
> rather should be classified as a thin-provisioning error
> and should be mapped onto ENOSPC.

Use up your available space for the commit log, please :)

Otherwise this looks fine, although we are unlikely to ever hit it
given that Linux never sets the DULBE bit, and setting that bit
would break all the partition table and fs probing we have.
