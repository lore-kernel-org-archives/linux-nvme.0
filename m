From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:30:25 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <1500026296.4808.8.camel@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-4-mwilck@suse.com> <20170714075451.GD17877@lst.de>
 <1500026296.4808.8.camel@suse.com>
Message-ID: <20170714123025.GC26187@lst.de>

On Fri, Jul 14, 2017@11:58:16AM +0200, Martin Wilck wrote:
> If this is what you think, you must also NAK my patch 2/3, because
> stripping the 0-bytes also changes how the WWID is presented to user
> space. For example

True.  Although that only really is a fix for buggy controllers,
and should not affect the PCIe controllers (for which a compliance
test for this exists, unfortunately that doesn't work for fabrics).

> User space that relies on the string in the first format would break
> already with 2/3. However, multipath, which is probably the main
> consumer of the WWID for practical purposes, can't handle the overlong
> format anyway (I'm preparing a patch series to fix that).

We'll handle multipath in NVMe and the kernel itself, so we really
should not be worried about dm-multipath here, which is the wrong
thing to do for NVMe.
