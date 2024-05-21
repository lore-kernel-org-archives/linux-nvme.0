Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9748AC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zwUT0GP4+Wx+8rxTFrYySzoVQ317sU+rvI5+RMC6ngg=; b=WYOHvC9MMogcsO3RijQE/6S+8/
	2c0Wxpq+hvBK8GOcc9oCDu7cYl0VEkPGgQIM7j4JzyVXB5GFDuoet5M6QIDDlV5fe9wsLrMZtNM1c
	3fneYjfI5PIvmFK4GsfgWm6vRdeCe8G3dFZha+HRZ/6NtYpKR9VE9Z7ncCzluwDRPliMVhYycAAW9
	3BpH2EtP4631yeDi2ErFF/PZUBzUlkU8ki3bS/56b9jgMuloeC5pq07GQJyTx6f30AC+5+fKuM49T
	CDJIRZPYgwORTvBnxFmT0BLgWU9pRbNOMbQZz6O8PGsHbdOaqYYoSLw4SbcACIMZAQtcgVwnYWB/+
	RcjLoBLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9UL2-00000000meM-3zE6;
	Tue, 21 May 2024 18:35:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9UKz-00000000mdv-3GBA
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 18:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716316548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwUT0GP4+Wx+8rxTFrYySzoVQ317sU+rvI5+RMC6ngg=;
	b=J5pRglqnP/nI1r04GW1MQro8ogdSt4qgM4A5HDtcDeAzjT+wEq9HXwsaLglyf2les1eLqo
	RGle7Rhew8oHSygnIkQh65g+TAKIkAbGDzLPLO0WLoHvTqRQw0K7bqytMFWA2ZHeOkjqM+
	Ozhe6DaAOkGz0zXnCeiUKLUk/1N24ok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-4lcUBoKxPR-g5Rtt-h2hsQ-1; Tue, 21 May 2024 14:35:46 -0400
X-MC-Unique: 4lcUBoKxPR-g5Rtt-h2hsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5D93800281;
	Tue, 21 May 2024 18:35:45 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D7A440C6CB4;
	Tue, 21 May 2024 18:35:45 +0000 (UTC)
Message-ID: <7fd93488-2c3c-472a-8560-7359b07c3870@redhat.com>
Date: Tue, 21 May 2024 14:35:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
To: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: nilay@linux.ibm.com, Keith Busch <kbusch@kernel.org>
References: <20240521180712.2423165-1-kbusch@meta.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240521180712.2423165-1-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_113549_928271_93AC7442 
X-CRM114-Status: GOOD (  16.22  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Awesome. I've noticed that there is an iostat bug lurking someplace during my many days of io policy testing these last two 
weeks. I'll add this patch to my test build and let you know if it fixes the problem!

/John

On 5/21/24 14:07, Keith Busch wrote:> From: Keith Busch <kbusch@kernel.org>
> 
> There are io stats accounting that needs to be handled, so don't call
> blk_mq_end_request() directly. Use the existing nvme_end_req() helper
> that already handles everything.
> 
> Fixes: d4d957b53d91ee ("nvme-multipath: support io stats on the mpath device")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c      | 2 +-
>   drivers/nvme/host/multipath.c | 3 ++-
>   drivers/nvme/host/nvme.h      | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 79cdd34dfa18e..7706df2373494 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -422,7 +422,7 @@ static inline void __nvme_end_req(struct request *req)
>   		nvme_mpath_end_request(req);
>   }
>   
> -static inline void nvme_end_req(struct request *req)
> +void nvme_end_req(struct request *req)
>   {
>   	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>   
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9c1e135b8df3b..1bee176fd850e 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -118,7 +118,8 @@ void nvme_failover_req(struct request *req)
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   
> -	blk_mq_end_request(req, 0);
> +	nvme_req(req)->status = 0;
> +	nvme_end_req(req);
>   	kblockd_schedule_work(&ns->head->requeue_work);
>   }
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index cacc56f4bbf44..fc31bd340a63a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -767,6 +767,7 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
>   	}
>   }
>   
> +void nvme_end_req(struct request *req);
>   void nvme_complete_rq(struct request *req);
>   void nvme_complete_batch_req(struct request *req);
>   


