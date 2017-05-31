From: hch@lst.de (Christoph Hellwig)
Date: Wed, 31 May 2017 11:46:31 +0200
Subject: [PATCH 3/7] nvmet: add eui64 field to nvme_ns and populate via
 configfs
In-Reply-To: <d2bd7b74-aa81-f00e-282b-ff51deecbe39@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <fe6439add636d3fd31ef357230101819ae7f5090.1496131397.git.jthumshirn@suse.de>
 <20170530092510.GB16736@lst.de>
 <d2bd7b74-aa81-f00e-282b-ff51deecbe39@suse.de>
Message-ID: <20170531094631.GC10718@lst.de>

On Tue, May 30, 2017@11:45:25AM +0200, Johannes Thumshirn wrote:
> Mostly consistency. The current nvme host code has the EUI sprinkled all
> around. Sure I can drop it, but then what's the point in evaluating it
> on the host side? Other targets may send it, so we need in on the host
> and do we care about potentially awkward host implementations with Linux
> as a target? Also it's rather handy for testing as well, after all it's
> not too much and complex code.

There's only one place in the host code proper (discounting the
scsi translation mess), and that's because the field is still better
than not having any uniqueue identifier.  But I don't think we should
spread it any further.
