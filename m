From: axboe@fb.com (Jens Axboe)
Date: Mon, 16 Nov 2015 15:25:49 -0700
Subject: [PATCH 00/13] lightnvm updates for 4.4-rc2
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <564A57ED.5050403@fb.com>

On 11/16/2015 07:34 AM, Matias Bj?rling wrote:
> Hi Jens,
>
> This is the patches targeted for -rc2 of 4.4.
>
> Ten of the patches fix bugs and small specification updates. While the
> last two are larger patches. They are necessary because of specification
> changes. The updates are applied now before it is set in stone for 4.4
> (or at least makes it a lot harder to change)
>
> Patch 1: Adds the linux-block list to the maintainers list for LightNVM.
> Patch 2: Fixes a ushort bug reported by Geert.
> Patch 3: Updates the implementation to support the new bad block table
>           format.
> Patch 4-9: Small fixes.
> Patch 10: The specification had support for both linear and device
>            specific addressing. It was replaced by ppa format, that
>            defines the device ppa format used by the specific device.
>            This patch adds the support and removes the previous two
>            modes.
> Patch 11-12: Two small cleanups to the lightnvm nvme integration.
>            Caused by specification changes.
>
> Patches 3 to 12 is the first time they are posted to the list for
> review.
>
> Will you pick up the patches when convenient (and reviewed):
>
>    git at github.com:OpenChannelSSD/linux.git for-jens
>
> I'll update the for-jens branch and post a separate patch if any
> fixes is applied to the patches.

Applied, thanks.

-- 
Jens Axboe
