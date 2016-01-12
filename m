From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jan 2016 15:12:22 -0700
Subject: [PATCH RESEND] NVMe: Export NVMe attributes to sysfs group
In-Reply-To: <1452636571-309-1-git-send-email-keith.busch@intel.com>
References: <1452636571-309-1-git-send-email-keith.busch@intel.com>
Message-ID: <56957A46.70107@fb.com>

On 01/12/2016 03:09 PM, Keith Busch wrote:
> Adds all controller information to attribute list exposed to sysfs, and
> appends the reset_controller attribute to it. The nvme device is created
> with this attribute list, so driver no long manages its attributes.
>
> Reported-by: Sujith Pandel <sujithpshankar at gmail.com>
> Cc: Sujith Pandel <sujithpshankar@ gmail.com>
> Cc: David Milburn <dmilburn at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> I think this was meant to be picked up. At least the namespace attributes
> were that came right after this. This patch respins on top of that one
> so it applies cleanly.

Agree, added now.

-- 
Jens Axboe
