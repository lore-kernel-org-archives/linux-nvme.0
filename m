From: hch@lst.de (Christoph Hellwig)
Date: Sun, 7 Feb 2016 10:22:41 +0100
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <1454783624.2809.6.camel@HansenPartnership.com>
References: <1454783624.2809.6.camel@HansenPartnership.com>
Message-ID: <20160207092241.GA15331@lst.de>

Keith said it should be on by default, and I promised him to change
it once we run into problems, which I guess this counts as.

But just curious:  what distro are you using?  Upstream systemd
explicitly rejected using scsi_id for NVMe here:

	https://github.com/systemd/systemd/issues/1453

and all my test systems don't do this either.
