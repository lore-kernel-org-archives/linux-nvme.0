From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Sep 2017 15:50:07 +0200
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
Message-ID: <20170925135007.GA9725@lst.de>

On Mon, Sep 25, 2017@03:47:43PM +0200, Hannes Reinecke wrote:
> Can't we make the multipath support invisible to the host?
> IE check the shared namespaces before creating the device node, and just
> move them under the existing namespaces if one exists?

That was what my first version did, but various people talked me
out of it.  Unfortunately just multiplexing breaks a few things,
including the userspace passthrough ioctls.
