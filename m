From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 7 Dec 2015 15:31:12 -0800
Subject: [PATCH] NVMe: Export NVMe attributes to sysfs group
In-Reply-To: <1449530455-25485-1-git-send-email-keith.busch@intel.com>
References: <1449530455-25485-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151207233112.GB26585@infradead.org>

On Mon, Dec 07, 2015@04:20:55PM -0700, Keith Busch wrote:
> Adds all controller information to attribute list exposed to sysfs, and
> appends the reset_controller attribute to it. The nvme device is created
> with this attribute list, so driver no long manages its attributes.
> 
> Reported-by: Sujith Pandel <sujithpshankar at gmail.com>
> Cc: Sujith Pandel <sujithpshankar@ gmail.com>
> Cc: David Milburn <dmilburn at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> This is based on the patch from Sujith. It is merged up to Christoph's
> block tree, exposes all the saved nvme controller attributes, aligns
> coding conventions with scsi, and simplifies sysfs attribute management
> by providing it at device allocation time.

This looks good, BUT:

We really need to expose the NGUID on the namespace at the same time.
Otherwise people will use this information to incorrectly provide a
serial number of the block devices in udev because not better
information is available.
