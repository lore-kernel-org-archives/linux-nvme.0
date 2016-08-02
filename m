From: hch@lst.de (Christoph Hellwig)
Date: Tue, 2 Aug 2016 14:53:48 +0200
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <dc6286c3-a5c0-48a8-284d-f53b6830da22@grimberg.me>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
 <20160801111530.GB16474@lst.de>
 <307087d1-88af-5244-38e8-5b9786285488@grimberg.me>
 <20160801155054.GD22771@lst.de>
 <dc6286c3-a5c0-48a8-284d-f53b6830da22@grimberg.me>
Message-ID: <20160802125348.GE13235@lst.de>

On Tue, Aug 02, 2016@09:39:48AM +0300, Sagi Grimberg wrote:
> I'm not exactly sure what you mean. Do you mean placing
> cmpxchg in nvmet_rdma_device_removal()? To what we cmp
> when we want to xchg?
>
> Care to explain in a bit more detail?

Right, plain xchg() should be enough.  E.g. do an xchg both
in the device removal handler and ->remove_port and only delete
the CM_ID if the caller was the one taking it out the private
data.
