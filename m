From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 12 Jul 2016 07:18:43 -0700
Subject: [PATCH -next] nvme-rdma: fix the return value of
 nvme_rdma_reinit_request()
In-Reply-To: <1468321577-16278-1-git-send-email-weiyj_lk@163.com>
References: <1468321577-16278-1-git-send-email-weiyj_lk@163.com>
Message-ID: <1468333123.6604.2.camel@linux.intel.com>

On Tue, 2016-07-12@11:06 +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
> 
> PTR_ERR should be applied before its argument is reassigned,
> otherwise the
> return value will be set to 0, not error code.

Another good catch.

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> 
> Signed-off-by: Wei Yongjun <yongjun_wei at trendmicro.com.cn>

>  	if (IS_ERR(req->mr)) {
> -		req->mr = NULL;
>  		ret = PTR_ERR(req->mr);
> +		req->mr = NULL;
>  	}
