Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14845C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:06:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA9E610CE
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFA9E610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=85JT+pRw7M+Nwra3kR8afZi6/Mk807w/KSGBbdMrgPQ=; b=CqkNsQVAji6Ul9
	U+C9dc9y+M/5zzGb/ypNqUYPLKj8g+xjAMsb7LAvHVL45XylsSA/Z3n0hsSm474TImm8/ZZMzgK+N
	9dnkuUZ58OXWAOFQf64mAO1yGiJEoFPB17Lj1AwthJeOeXIStj45LxpURph5S7WzCoLtAjvRwUyh/
	BN2/8U3useS3nj0Jp5Pj9cZYFdzIkcr2fdE2YTAbSUaYLB6swWfcbBQL+kFluM42SQfczYOunZhUK
	zAFCoFRf3LFYfDeldz8qs1kFyWGOdfwlLC/Yx9NDRBE6PCGlP4aE3ZiDcojq8mbJImeAfhZh5RnnT
	oEykVD5VXf3M4b9TlzCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOKge-00A5XT-8n; Thu, 09 Sep 2021 14:05:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOKgc-00A5X3-Pn
 for linux-nvme@bombadil.infradead.org; Thu, 09 Sep 2021 14:05:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pvmNeNfpdHz74rQ4QHL5p+4e2BP59QM36+aaiijGsSI=; b=byV4PtMTSpvNluAW28WSFNsNUK
 /NMy+RsrOAn6xXRJRBhnE/zhXMeNK5VTotr5BKKgytOjHw9iO8mIDjpfQha6roOl9Yo/MFwmiKBPq
 XPYK0oGM8+4kB1N0KDbQRTjlRXaACrjHa2WJThbH4SIonWm5xkIl22yv1UAfxJYOcE9iqAcOxal3Z
 msuUAgaAOya09gXZr7CNBrMj64JGklMUy2MPbFRayx/JaAbSQH21j3dK/lW3QDWWTMNHJYcm/XU6v
 wumm7f7hTJfCk4RUuJMGgT/KcZvX6ZmUwG6JOnS7WpvO2aAROuws+0Sp2dyhm6JrjflTgGogkcheu
 ovyFBwzg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mOKfm-00A281-93; Thu, 09 Sep 2021 14:05:28 +0000
Date: Thu, 9 Sep 2021 15:05:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] nvme-rdma: destroy cm id before destroy qp to avoid
 use after free
Message-ID: <YToUji9WujpL9vnt@infradead.org>
References: <20210906035134.14789-1-liruozhu@huawei.com>
 <20210906035134.14789-2-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210906035134.14789-2-liruozhu@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This looks reasonable to me.  Sagi, Max: any comments?

On Mon, Sep 06, 2021 at 11:51:34AM +0800, Ruozhu Li wrote:
> We should always destroy cm_id before destroy qp to avoid to get cma
> event after qp was destroyed, which may lead to use after free.
> In RDMA connection establishment error flow, don't destroy qp in cm
> event handler.Just report cm_error to upper level, qp will be destroy
> in nvme_rdma_alloc_queue() after destroy cm id.
> 
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>  drivers/nvme/host/rdma.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index a68704e39084..042c594bc57e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -656,8 +656,8 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>  	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
>  		return;
>  
> -	nvme_rdma_destroy_queue_ib(queue);
>  	rdma_destroy_id(queue->cm_id);
> +	nvme_rdma_destroy_queue_ib(queue);
>  	mutex_destroy(&queue->queue_lock);
>  }
>  
> @@ -1815,14 +1815,10 @@ static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
>  	for (i = 0; i < queue->queue_size; i++) {
>  		ret = nvme_rdma_post_recv(queue, &queue->rsp_ring[i]);
>  		if (ret)
> -			goto out_destroy_queue_ib;
> +			return ret;
>  	}
>  
>  	return 0;
> -
> -out_destroy_queue_ib:
> -	nvme_rdma_destroy_queue_ib(queue);
> -	return ret;
>  }
>  
>  static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> @@ -1916,14 +1912,10 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
>  	if (ret) {
>  		dev_err(ctrl->ctrl.device,
>  			"rdma_connect_locked failed (%d).\n", ret);
> -		goto out_destroy_queue_ib;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -out_destroy_queue_ib:
> -	nvme_rdma_destroy_queue_ib(queue);
> -	return ret;
>  }
>  
>  static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
> @@ -1954,8 +1946,6 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
>  	case RDMA_CM_EVENT_ROUTE_ERROR:
>  	case RDMA_CM_EVENT_CONNECT_ERROR:
>  	case RDMA_CM_EVENT_UNREACHABLE:
> -		nvme_rdma_destroy_queue_ib(queue);
> -		fallthrough;
>  	case RDMA_CM_EVENT_ADDR_ERROR:
>  		dev_dbg(queue->ctrl->ctrl.device,
>  			"CM error event %d\n", ev->event);
> -- 
> 2.16.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
