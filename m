From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 09:37:41 +0200
Subject: [PATCH 10/17] nvme: switch controller refcounting to use
 struct device
In-Reply-To: <05edcff6-4c56-39d9-83c8-e3eae03b824d@grimberg.me>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-11-hch@lst.de>
 <b4e85bf7-f0ae-4ea9-2caa-3ba3645f88ea@grimberg.me>
 <20171019072053.GA12168@lst.de>
 <05edcff6-4c56-39d9-83c8-e3eae03b824d@grimberg.me>
Message-ID: <20171019073741.GA12348@lst.de>

On Thu, Oct 19, 2017@10:31:20AM +0300, Sagi Grimberg wrote:
> I don't think the fabrics device does not help us to keep the ctrl
> allocated until we finish removal.

All fabrics drivers grab an extra reference during ->create_ctrl,
which we will drop when releasing the file descriptor that we used
to create the device.

By the time we call ->delete_ctrl in nvmf_create_ctrl we must still
have that reference because we are still in a ->write call and thus
->release can't have been called yet.
