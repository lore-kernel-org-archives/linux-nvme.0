From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 12 Jul 2016 08:34:13 -0700
Subject: [PATCH -next] nvmet: fix return value check in
 nvmet_subsys_alloc()
In-Reply-To: <1467806529-23712-1-git-send-email-weiyj_lk@163.com>
References: <1467806529-23712-1-git-send-email-weiyj_lk@163.com>
Message-ID: <57850DF5.2090209@kernel.dk>

On 07/06/2016 05:02 AM, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
>
> In case of error, the function kstrndup() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.

Added for 4.8, thanks.

-- 
Jens Axboe
