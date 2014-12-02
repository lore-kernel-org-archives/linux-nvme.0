From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Dec 2014 21:13:30 +0000 (UTC)
Subject: [PATCH] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <20141202205015.GW11522@wil.cx>
References: <1417550176-14775-1-git-send-email-keith.busch@intel.com>
 <20141202205015.GW11522@wil.cx>
Message-ID: <alpine.LNX.2.00.1412022059180.4225@localhost.lm.intel.com>

On Tue, 2 Dec 2014, Matthew Wilcox wrote:
> On Tue, Dec 02, 2014@12:56:16PM -0700, Keith Busch wrote:
>> +	if (readl(&dev->bar->vs) >= 0x10100) {
>
> I think we want an NVME_VERSION() macro that maybe looks something like this:
>
> #define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))
>
> Then you can make this:
>
> 	if (readl(&dev->bar->vs) >= NVME_VERSION(1, 1))
>
> What do you think?

I didn't even know what a 1.1 revision was supposed to look like until
1.2 clarified that, so a macro to hide the weirdness sounds good.
