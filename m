From: axboe@fb.com (Jens Axboe)
Date: Tue, 3 Nov 2015 12:58:33 -0700
Subject: [patch] NVMe: Precedence error in nvme_pr_clear()
In-Reply-To: <20151103195049.GA17238@mwanda>
References: <20151103195049.GA17238@mwanda>
Message-ID: <563911E9.6080605@fb.com>

On 11/03/2015 12:50 PM, Dan Carpenter wrote:
> The original code is equivalent to:
>
> 	u32 cdw10 = (1 | key) ? 1 << 3 : 0;
>
> But we want:
>
> 	u32 cdw10 = 1 | (key ? 1 << 3 : 0);
>
> Fixes: 1d277a637a71: ('NVMe: Add persistent reservation ops')
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

Thanks Dan, applied.


-- 
Jens Axboe
