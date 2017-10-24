From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 24 Oct 2017 17:40:00 -0400
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <20171023145126.2471-7-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
Message-ID: <20171024213959.GB23307@redhat.com>

On Mon, Oct 23 2017 at 10:51am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.

Having the NVme driver go to such lengths to hide its resources from
upper layers is certainly the work of an evil genius experiencing some
serious territorial issues.  Not sugar-coating it.. you wouldn't.

I kept meaning to reply to your earlier iterations on this series to
ask: can we please get a CONFIG_NVME_MULTIPATHING knob to make it so
that the NVMe driver doesn't implicitly consume (and hide) all
per-controler devices?

Ah well.  There is only one correct way to do NVMe multipathing after
all right?
