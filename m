From: jim@thebergstens.com (James R. Bergsten)
Date: Wed, 3 Dec 2014 09:36:55 -0800
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <37D709DA9AEECD448AE8DD01BDD193F7ED88A3@NTXBOIMBX02.micron.com>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
 <20141202205015.GW11522@wil.cx>
 <37D709DA9AEECD448AE8DD01BDD193F7ED88A3@NTXBOIMBX02.micron.com>
Message-ID: <240a01d00f1f$bf600c10$3e202430$@thebergstens.com>

First post - please be gentle...

For all present practical purposes you can think of namespaces as logical
units, though logical unit numbers typically start at zero, while namespaces
start at one.

Presently all production drives have one namespace (numbered "one").   The
NN field in the Identify Controller command response tells you the number of
namespaces supported by the device.  They start at one and must be
contiguous numbers (no gaps).

Typically the only SCSI "devices" that support multiple logical units are
arrays which in turn map these logical units to individual drives within the
array (RAID arrays are left as an exercise for the reader).

You "create" (well, more precisely "allocate") a namespace via the Format
NVM command.  The Identify Namespace tells you what topologies are supported
by that namespace (e.g. block size).  Production drives typically ship with
a pre-formatted, empty, single namespace of 512 or 4,096 bytes (no DIF).
Formatting really doesn't "format" it generally just clears out the logical
to physical block associations (effectively unmapping everything).  In
passing, this means if you are doing performance testing, you need to write
something to the device first, otherwise reads won't access flash and you'll
get good, but inaccurate real-world numbers.

So, specific answers to your questions..

You can only "create" as many namespaces as are supported by the device
(today "one").  With the standard Linux driver, it is possible to issue SCSI
commands to an NVMe device which are then emulated by the driver
(nvme-scsi.c).  So one could send a FORMAT UNIT and hope for the best.  If
you want more "devices" on your physical device you can use a virtualization
driver or create software partitions.

Alternately, all of the vendors I know about provide utilities for doing
NVMe specific things such as Format NVM, and there is an "nvme-user" package
(of which I know almost nothing).

But, today, you can pretty much plug the device in, put a filesystem on it,
and off you go.

Hope this helps...
Jim B.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Zakaria Abushima (zabushima)
Sent: Wednesday, December 3, 2014 3:42 AM
To: Matthew Wilcox; Keith Busch
Cc: linux-nvme at lists.infradead.org
Subject: RE: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation

Hi Guys,

Off the topic, I have read that namespace in nvme is equivalent to SCSI LUN

So how can I write application to create name spaces up to 32 from the
userspace.

In other word is there any application to write SCSI LUN from userspace,

Also, it says that creating name space is a vendor specific ? how can the
vendor find out the way to create a namespace ?

Any explanation or clarification ?

Please guide me because I'm completely lost.

Zakaria.

System Architect Intern at Micron.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Matthew Wilcox
Sent: 02 December 2014 20:50
To: Keith Busch
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation

On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
> +	if (readl(&dev->bar->vs) >= 0x10100) {

I think we want an NVME_VERSION() macro that maybe looks something like
this:

#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))

Then you can make this:

	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))

What do you think?


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
