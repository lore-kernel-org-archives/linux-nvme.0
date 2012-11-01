From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 1 Nov 2012 16:56:50 -0400
Subject: NVMe SCSI support
In-Reply-To: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDAD7@corpmail1.na.ads.idt.com>
References: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDAD7@corpmail1.na.ads.idt.com>
Message-ID: <20121101205650.GR4244@linux.intel.com>

On Thu, Nov 01, 2012@06:36:41PM +0000, Panah, Khosrow wrote:
> I noticed there is a development in process to support NVMe SCSI
> interface. Can anyone clarify as why Intel is supporting SCSI interface?

It's not really an "Intel" thing, it's something I think that the NVMe
driver needs in order to be successful.  There are tools out there
which send SCSI commands to devices, and supporting those tools makes
it easier for people to transition from SCSI to NVMe.  There's precedent
for this; for example the Linux ATA driver translates SCSI commands into
ATA commands.

> I have not been able to pull NVMe SCSI driver from Intel site. When I

Do you mean from the infradead site?  That's not an Intel site (although
the owner does happen to work for Intel).  I used to host on kernel.org,
but since the break-in, I've hosted on infradead.org.

> pull the latest driver, I get a driver that does not include support for
> "sg_ioctl". I would greatly appreciate if you could point me to where
> I can gain access to the source that includes above source version.

I haven't accepted the patches into the driver yet, so there's nowhere
to pull them from.  You can apply the patches yourself if you want to
try them out.
