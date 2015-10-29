From: axboe@fb.com (Jens Axboe)
Date: Fri, 30 Oct 2015 04:48:50 +0900
Subject: [PATCH v14 0/5] Support for Open-Channel SSDs
In-Reply-To: <1446058499-24150-1-git-send-email-m@bjorling.me>
References: <1446058499-24150-1-git-send-email-m@bjorling.me>
Message-ID: <56327822.6070104@fb.com>

On 10/29/2015 03:54 AM, Matias Bj?rling wrote:
> This patchset implements support for Open-Channel SSDs.
>
> Applies against Jens' for-next and is available through the lkml_v14
> branch at:
>
>    https://github.com/OpenChannelSSD/linux
>
> Thanks to everyone for their help to get this ready for prime-time.

Added for 4.4 - I dropped the special null_nvm, the regular null_blk 
should just be updated to add this functionality.

-- 
Jens Axboe
