From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Sep 2016 11:14:31 -0400
Subject: [PATCH] nvme.h: resync with nvme-cli
In-Reply-To: <1474584589-32655-1-git-send-email-hch@lst.de>
References: <1474584589-32655-1-git-send-email-hch@lst.de>
Message-ID: <20160927151431.GC24200@localhost.localdomain>

On Thu, Sep 22, 2016@03:49:49PM -0700, Christoph Hellwig wrote:
> Import a few updates to nvme.h from nvme-cli.  This mostly includes a few
> new fields and error codes, but also a few renames that so far are only
> used in user space.  Also one field is moved from an array of two le64
> values to one of 8 chars so that we can more easily access it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
