From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Jan 2017 00:14:52 -0800
Subject: [PATCH v4 5/6] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <20170108142020.GC25986@infradead.org>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
 <20170108142020.GC25986@infradead.org>
Message-ID: <20170124081452.GA19333@infradead.org>

On Sun, Jan 08, 2017@06:20:20AM -0800, Christoph Hellwig wrote:
> > +	ns = container_of(ctx, struct nvme_ns, sed_ctx);
> > +	cmd.common.nsid = cpu_to_le32(ns->ns_id);
> 
> Until we support the configurable namespace locking extension we should
> have the sed_ctx in the nvme_ctrl structure, and not be tried to a
> namespace here.  I hope to get some concensus out of the working group
> about which value to pass exactly soon.

No progress on that yet.  What do you think about just passing in the
nn value from the Identify Controller structure in here for now, as that
should always be a valid nsid?
