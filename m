From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jul 2016 08:27:22 -0700
Subject: [PATCH -next] nvme-rdma: fix the return value of
 nvme_rdma_reinit_request()
In-Reply-To: <1468321577-16278-1-git-send-email-weiyj_lk@163.com>
References: <1468321577-16278-1-git-send-email-weiyj_lk@163.com>
Message-ID: <57850C5A.1050208@fb.com>

On 07/12/2016 04:06 AM, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
>
> PTR_ERR should be applied before its argument is reassigned, otherwise the
> return value will be set to 0, not error code.

Applied, thanks.

-- 
Jens Axboe
