From: zabushima@micron.com (Zakaria Abushima (zabushima))
Date: Wed, 3 Dec 2014 11:41:53 +0000
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <20141202205015.GW11522@wil.cx>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
 <20141202205015.GW11522@wil.cx>
Message-ID: <37D709DA9AEECD448AE8DD01BDD193F7ED88A3@NTXBOIMBX02.micron.com>

Hi Guys,

Off the topic, I have read that namespace in nvme is equivalent to SCSI LUN

So how can I write application to create name spaces up to 32 from the userspace.

In other word is there any application to write SCSI LUN from userspace,

Also, it says that creating name space is a vendor specific ? how can the vendor find out the way to create a namespace ?

Any explanation or clarification ?

Please guide me because I'm completely lost.

Zakaria.

System Architect Intern at Micron.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Matthew Wilcox
Sent: 02 December 2014 20:50
To: Keith Busch
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation

On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
> +	if (readl(&dev->bar->vs) >= 0x10100) {

I think we want an NVME_VERSION() macro that maybe looks something like this:

#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))

Then you can make this:

	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))

What do you think?


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
