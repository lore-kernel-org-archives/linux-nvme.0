From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 2 May 2016 09:12:13 -0600
Subject: [PATCH v2] nvme: add helper nvme_cleanup_cmd()
In-Reply-To: <1461620000-18707-1-git-send-email-mlin@kernel.org>
References: <1461620000-18707-1-git-send-email-mlin@kernel.org>
Message-ID: <57276E4D.5090801@kernel.dk>

On 04/25/2016 03:33 PM, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
>
> This hides command cleanup into nvme.h and fabrics drivers will
> also use it.

Added to 4.7.

-- 
Jens Axboe
