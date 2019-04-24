From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 24 Apr 2019 22:30:08 +0200
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
In-Reply-To: <20190424200706.GB15412@localhost.localdomain>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <fb33a464-af65-abec-5ff1-15925e7669a4@grimberg.me>
 <20190424200706.GB15412@localhost.localdomain>
Message-ID: <983e5d039dce9de1d32c71d28fd59bbc01c3fee5.camel@infradead.org>

On Wed, 2019-04-24@14:07 -0600, Keith Busch wrote:
> On Wed, Apr 24, 2019@09:55:16AM -0700, Sagi Grimberg wrote:
> > 
> > > As different nvme controllers are connect via different fabrics, some require
> > > different timeout settings than others. This series implements per-controller
> > > timeouts in the nvme subsystem which can be set via sysfs.
> > 
> > How much of a real issue is this?
> > 
> > block io_timeout defaults to 30 seconds which are considered a universal
> > eternity for pretty much any nvme fabric. Moreover, io_timeout is
> > mutable already on a per-namespace level.
> > 
> > This leaves the admin_timeout which goes beyond this to 60 seconds...
> > 
> > Can you describe what exactly are you trying to solve?
> 
> I think they must have an nvme target that is backed by slow media
> (i.e. non-SSD). If that's the case, I think it may be a better option
> if the target advertises relatively shallow queue depths and/or lower
> MDTS that better aligns to the backing storage capabilies.

It isn't that the media is slow; the max timeout is based on the SLA
for certain classes of "fabric" outages. Linux copes *really* badly
with I/O errors, and if we can make the timeout last long enough to
cover the switch restart worst case, then users are a lot happier.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190424/73f9b9ff/attachment.bin>
