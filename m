From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Oct 2018 10:57:52 +0200
Subject: [PATCH] nvme: make sure ns head inherits underlying device limits
In-Reply-To: <20181019222450.25397-1-sagi@grimberg.me>
References: <20181019222450.25397-1-sagi@grimberg.me>
Message-ID: <20181022085752.GD18755@lst.de>

On Fri, Oct 19, 2018@03:24:50PM -0700, Sagi Grimberg wrote:
> Whenever we update ns_head info, we need to make sure it is still
> compatible with all underlying backing devices. Start with unlimited
> stacking limits, and every info update iterate over siblings and
> adjust queue limits.

Why?  Neither the block layer, nor the nvme multipath code should
even look at this values.
