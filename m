Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:22:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC7064E0F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC7064E0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xg7SLf+/bWmY+k3/a+WQscAsjw7yyQiX6fWMzCdDZS4=; b=U+Ftyb/dk31puSZnJ6/LfI65i
	qbuXss+J1SDLOMDRl+EMaAv7yMVrDB1RwUIyjxDtTzU/lhMSNj1OQ1UEAaA4qf+icQORHC1m15KX6
	vFGJEIFT91uWLy9MdynF1BPR5aew6nflnJb61UUOvnDBGBC+wpVnWLelAk/6t37ZlU3wuqAMsVbnT
	WItYwvtGCGtN+mtjMYPEXlZnhrhf2eQPdSIZhSkLbmdXVF0pQRpyMPAJal5GVfIPoqGPSMMTbiSpI
	baOlFscxcKoIBmaZpo18gyk949j0zcAMwU0oyuUo9ueTIsHyE2Jap+lUtSlAAF/ACzKgRgMusxPUg
	QAPBDw8ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7QXG-00032v-U6; Wed, 03 Feb 2021 22:22:06 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7QXE-00032T-HJ
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 22:22:05 +0000
Received: by mail-pl1-f175.google.com with SMTP id b8so625582plh.12
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 14:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i/NbabQJZBZ366AVWIrLP+6MNQ/MvruNt9+cq1+IsS8=;
 b=JgSyHbTvesYEUVi0Do/dGIBwSY7HWBY5AmgbMwtFGLujwQvptpiy0cR2BBSwmaywiK
 Ep7z/aMxh62rLyEtqbm1R27BPUZie8Lbgx/+g/9GR6NGlGgADmET6cZed/gReCb2OayH
 hbvO2gF0rgghsQoF57wSJU7HzFTIziVFgik9YpHzPgYwbxp+zJP/8GUFxAaZyScYUcwS
 OUJOf0LCZ1QeaQZ8eIztleUDHvu5tNmXMvPe7gAWvZSqygKgnOKA5dR2Oye5XX/N3rEO
 naJApXZ26nmbR9t/wkSUxFzaYog7qNLHFjjkr3U9mAg2JSWkLYMWpGwO/lLIGcbqFMu5
 RJoA==
X-Gm-Message-State: AOAM532x+cMvxShVhdOFBMmg2EcysNs8kdYSqpCaODD+vcg2hxuX3cp0
 1ewZJJcAN91+maUcgXFAqrA=
X-Google-Smtp-Source: ABdhPJxM20NILI5ccKSLTileVt27NeMAC0am8zdczs0gB0BrleepC1oWoLCFW0e46w6hDm46biU87g==
X-Received: by 2002:a17:90a:fd0f:: with SMTP id
 cv15mr5303238pjb.36.1612390922345; 
 Wed, 03 Feb 2021 14:22:02 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:cd99:e813:1dae:a15a?
 ([2601:647:4802:9070:cd99:e813:1dae:a15a])
 by smtp.gmail.com with ESMTPSA id d18sm2943910pjs.31.2021.02.03.14.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 14:22:01 -0800 (PST)
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
To: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210203161455.GB4116@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae2ff390-739e-ac2d-a7a8-162a6297653f@grimberg.me>
Date: Wed, 3 Feb 2021 14:22:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210203161455.GB4116@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_172204_642423_BD0967DC 
X-CRM114-Status: GOOD (  26.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/3/21 8:14 AM, Christoph Hellwig wrote:
> So I think this is conceptually fine, but I still find the API a little
> arcane.  What do you think about the following incremental patch?
> If that looks good and tests good for you I can apply the series with
> the modifications:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0befaad788a094..02579f4f776c7d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -355,6 +355,21 @@ void nvme_complete_rq(struct request *req)
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_rq);
>   
> +/*
> + * Called to unwind from ->queue_rq on a failed command submission so that the
> + * multipathing code gets called to potentially failover to another path.
> + * The caller needs to unwind all transport specific resource allocations and
> + * must return propagate the return value.
> + */
> +blk_status_t nvme_host_path_error(struct request *req)
> +{
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +	blk_mq_set_request_complete(req);
> +	nvme_complete_rq(req);
> +	return BLK_STS_OK;
> +}
> +EXPORT_SYMBOL_GPL(nvme_host_path_error);
> +
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   {
>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index cedf9b31898673..5dfd806fc2d28c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -552,11 +552,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
>   		return BLK_STS_RESOURCE;
> -
> -	nvme_req(rq)->status = NVME_SC_HOST_PATH_ERROR;
> -	blk_mq_set_request_complete(rq);
> -	nvme_complete_rq(rq);
> -	return BLK_STS_OK;
> +	return nvme_host_path_error(rq);
>   }
>   EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a72f0718109100..5819f038104149 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -575,6 +575,7 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
>   }
>   
>   void nvme_complete_rq(struct request *req);
> +blk_status_t nvme_host_path_error(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 6993efb27b39f0..f51af5e4970a2b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2091,16 +2091,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>   			req->mr ? &req->reg_wr.wr : NULL);
>   	if (unlikely(err)) {
> -		if (err == -EIO) {
> -			/*
> -			 * Fail the reqest so upper layer can failover I/O
> -			 * if another path is available
> -			 */
> -			req->status = NVME_SC_HOST_PATH_ERROR;
> -			blk_mq_set_request_complete(rq);
> -			nvme_rdma_complete_rq(rq);
> -			return BLK_STS_OK;
> -		}
>   		goto err_unmap;
>   	}
>   
> @@ -2109,7 +2099,9 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>   err_unmap:
>   	nvme_rdma_unmap_data(queue, rq);
>   err:
> -	if (err == -ENOMEM || err == -EAGAIN)
> +	if (err == -EIO)
> +		ret = nvme_host_path_error(rq);
> +	else if (err == -ENOMEM || err == -EAGAIN)
>   		ret = BLK_STS_RESOURCE;
>   	else
>   		ret = BLK_STS_IOERR;
> 

This looks good to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
