From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 26 Jul 2012 12:22:16 -0400
Subject: [PATCH] NVMe: Set block queue max sectors
In-Reply-To: <1343254030-309-1-git-send-email-keith.busch@intel.com>
References: <1343254030-309-1-git-send-email-keith.busch@intel.com>
Message-ID: <20120726162216.GD22985@linux.intel.com>

On Wed, Jul 25, 2012@04:07:10PM -0600, Keith Busch wrote:
> Set the max hw sectors in a namespace's request queue if the nvme device has a
> max data transfer size.

Could I trouble you to reflow your comments in the future?  When one
types 'git log', it inserts four spaces before the message, so this
would look like:

    Set the max hw sectors in a namespace's request queue if the nvme device has a
    max data transfer size.

I find that typing !{fmt in vi does the right thing (it defaults to 75
columns), but I don't know which editor you use.

>  	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
> +	if (ctrl->mdts)
> +		dev->max_hw_sectors = ((1 << ctrl->mdts) * (1 << (12 +
> +				NVME_CAP_MPSMIN(readq(&dev->bar->cap))))) >> 9;
>  

There's something about seeing five close-parens in a row that makes
me uncomfortable.  Maybe I was molested by a lisp compiler as a child
or something, but it tends to indicate an overly complex expression.

Let's see, what might look better ...

	if (ctrl->mdts) {
		int mpsmin = 1 << (NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12);
		dev->max_hw_sectors = ((1 << ctrl->mdts) * mpsmin) >> 9;
	}

Alternatively, we could redistribute some of the arithmetic ...

	if (ctrl->mdts)
		dev->max_hw_sectors = 1 << (12 - 9 + ctrl->mdts +
					NVME_CAP_MPSMIN(readq(&dev->bar->cap)));

but that's a little obscure.  Perhaps a little less obscure:

	if (ctrl->mdts) {
		int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
	}
