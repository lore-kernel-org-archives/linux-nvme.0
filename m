From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 21:07:21 +0100
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning
 event
In-Reply-To: <20171204092435.20000-2-sagi@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-2-sagi@grimberg.me>
Message-ID: <20171204200721.GB17023@lst.de>

On Mon, Dec 04, 2017@11:24:34AM +0200, Sagi Grimberg wrote:
> In case a controller sent us a critical warning AER,
> we should query the smart information and in case the
> media was placed in read only mode, we need to set
> all the controller namespaces (and the namespaces heads)
> in read-only (or set to rw in case its not set).
> 
> Given that in fabrics we may also connect to a read-only
> subsystem, we add the disk as read-only to start with.
> Once the subsystem will be in rw mode, we restore
> the disk rw permissions.

We are sending the smart log notification on to userspace, so with this
we now have two parties that are trying to clear the log page..
