From: axboe@fb.com (Jens Axboe)
Date: Thu, 26 May 2016 09:47:59 -0600
Subject: [PATCH v2 0/2] move nvme_cancel_io() to common code
In-Reply-To: <1463605502-27839-1-git-send-email-mlin@kernel.org>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
Message-ID: <57471AAF.5000108@fb.com>

On 05/18/2016 03:05 PM, Ming Lin wrote:
> From: Ming Lin <ming.l at samsung.com>
>
> So it can be used by fabrics driver also.
>
> v2:
>    - not declare "ctrl"
>    - rename nvme_cancel_io to nvme_cancel_request
>
> Ming Lin (2):
>    nvme: update and rename nvme_cancel_io to nvme_cancel_request
>    nvme: move nvme_cancel_request() to common code

Added for 4.8, thanks.

-- 
Jens Axboe
