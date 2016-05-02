From: axboe@fb.com (Jens Axboe)
Date: Mon, 2 May 2016 09:16:32 -0600
Subject: [PATCH v2 0/2] nvme_ns_remove() deadlock fix
In-Reply-To: <1461619219-18144-1-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
Message-ID: <57276F50.3090308@fb.com>

On 04/25/2016 03:20 PM, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
>
> Hi Sunad,
>
> I don't have device that can do namespace attribute change.
> Could you help to verify these 2 patches fix the ns remove deadlock?

Applied for 4.7, thanks.

-- 
Jens Axboe
