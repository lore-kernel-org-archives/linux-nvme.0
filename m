From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jul 2016 16:21:24 -0700
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
Message-ID: <57857B74.2040003@fb.com>

On 06/20/2016 10:44 AM, Keith Busch wrote:
> Many controller implementations will return errors to commands that will
> not succeed, but without the DNR bit set. The driver previously retried
> these commands an unlimited number of times until the command timeout
> has exceeded, which takes an unnecessarilly long period of time.
>
> This patch limits the number of retries a command can have, defaulting
> to 5, but is user tunable at load or runtime.
>
> The struct request's 'retries' field is used to track the number of
> retries attempted. This is in contrast with scsi's use of this field,
> which indicates how many retries are allowed.

Added for 4.8, thanks.

-- 
Jens Axboe
