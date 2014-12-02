From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 2 Dec 2014 15:50:15 -0500
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
Message-ID: <20141202205015.GW11522@wil.cx>

On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
> +	if (readl(&dev->bar->vs) >= 0x10100) {

I think we want an NVME_VERSION() macro that maybe looks something like this:

#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))

Then you can make this:

	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))

What do you think?
