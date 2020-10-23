Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EBC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C63024182
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="odMcHmNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C63024182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N0dLAGjjiseWE4+Zw99qeexkz1e+YQrRo2GjBAP69hc=; b=odMcHmNbk504YTQpWY8CLXE1w
	Zlb8oTK3qIn8CsSDbCGNuinRQsIZBXChNxE3iHeZ4dEpDyUOB3snmRHNw/gxsfT8G0MIvuQfo1bsx
	+xKxIRLNfC8o8x11z7AoW9142ZWxNNKC4EXFTuQZj6F//34WrsIQifsZi5y68R8tIx3rzX/lrJYdL
	azB2oLhiGUR5Wv46+7xdAvV/z/htrC6uogsV4OAFh/TO8vlVwPQ9dVx16z4/XfsDDrWXYAllwErnP
	piD8oqDNC+SdP6+l7VQa3DSXszNr5bh64sDt0X/jbkN0CcfqxQm5pHYWDPA/EMd6zzntflZeiTmTY
	4GjwGamrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVshc-0003we-0V; Fri, 23 Oct 2020 08:45:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVshY-0003vY-8F
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 08:45:33 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 496BE74777AFF58E673F;
 Fri, 23 Oct 2020 16:45:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 23 Oct 2020 16:45:24 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 23
 Oct 2020 16:45:24 +0800
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
To: zhenwei pi <pizhenwei@bytedance.com>, <kbusch@kernel.org>, <hch@lst.de>,
 <sagi@grimberg.me>, <axboe@fb.com>
References: <20201023065910.1358586-1-pizhenwei@bytedance.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <33381bb5-6daa-5f47-9e3c-a57eeb490950@huawei.com>
Date: Fri, 23 Oct 2020 16:45:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201023065910.1358586-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_044532_597472_CA9CA9B3 
X-CRM114-Status: GOOD (  18.99  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2020/10/23 14:59, zhenwei pi wrote:
> Hit a kernel warning:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
> 
> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
> Call Trace:
>   <IRQ>
>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>   __ib_process_cq+0x76/0x150 [ib_core]
>   ...
> 
> The reason is that a zero bytes message received from target, and the
> host side continues to process without length checking, then the
> previous CQE is processed twice.
> 
> Handle data length, ignore zero bytes message, and try to recovery for
> corrupted CQE case.
> 
> Thanks to Chao Leng for suggestions.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/host/rdma.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9e378d0a0c01..2ecadd309f4a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>   		return;
>   	}
>   
> +	/* received data length checking */
> +	if (unlikely(wc->byte_len < len)) {
> +		/* zero bytes message could be ignored */
> +		if (!wc->byte_len) {
> +			nvme_rdma_post_recv(queue, qe);
> +			return;
> +		}
> +
> +		/* corrupted completion, try to recovry */
> +		dev_err(queue->ctrl->ctrl.device,
> +			"Unexpected nvme completion length(%d)\n", wc->byte_len);
> +		nvme_rdma_error_recovery(queue->ctrl);
> +		return;
> +	}
> +
>   	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
>   	/*
>   	 * AEN requests are special as they don't time out and can
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
