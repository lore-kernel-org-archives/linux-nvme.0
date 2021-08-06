Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442E3C4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:57:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C0261050
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1C0261050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MaAUKXve3bTbGZo5n+EpuY3z3Zw+IwG73tOv+jJXTn8=; b=fDZ2rLrA/f0wF1uQqjN3sDd4Lb
	dFKK3ZnhIrmMBNZlwxDey12pvY2irJGw8aft/hi8RSCLfEIOHSHAZ/AzsRjDzKQWtVJ2xGLJxWAiT
	W0XjXqwx77HBdYiUkmGbE+Lyubkq4INqOzERRRJXpEBkXtzZE11BQsTtJ4STjnQJoQltYzgGYOv5k
	hxPbOyyE4zrTBxRB9C5DusWVatYfWDbnUarw4qiFIFSlXd6AnS3wDDeeXL37T2OZgb/5gDPrOgxUs
	flYPrEA48KVjs6onYj+BhL3SxAZ7yKEwtPqWQVbS/U6w3yUyayY6kqBq4RBrUYDTaE8xBYBwzxN/X
	SOXE/OSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5y6-00DOCH-VC; Fri, 06 Aug 2021 19:57:22 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5y4-00DOBI-Fo
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:57:21 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 u5-20020a17090ae005b029017842fe8f82so10279824pjy.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r3vnzaT72y5e2wz7p02YKqBIGki8uRtZL1NCQSFt+Ng=;
 b=eve7u71YE5ILi0/Jx8WBpr/8Qzo7MfnkWxkii3+5hXVyXNgI4QkVBDa4yWfm3lxNHv
 DTrXgyeDwxlHMNhqw+9SmBoNroZl0TvhBCqRt5ftQVd/F9tO/cXovcSNU8q96o8l3fD7
 bWASmxHhCJ/oqlpU+kW/iiJvRuJUecMtUjXmHCMDbY/Q6IHFQ/18T/Fd24XZalgXRVIo
 p2px8bDMhQnvYdsZHYlClRO/sKwHQ6oW3DNZF4D0chcEhi1XvBpm59RMCm+IuSNjOtOt
 3kiuJ87YEz4Ws0Ug/bECbp615fnZZWkkiy4agEK+89RgMMKfhMfGOzHQ2+DPV55ApSKI
 EbJg==
X-Gm-Message-State: AOAM533iwFYGpn4U7dOoo7jwRX7V/DoQrDMrQOfIzK5Zr9dn49YU64FD
 Kj7/lHT7791RJrfov1fVmZ0=
X-Google-Smtp-Source: ABdhPJztkMWl+2DyskHSTMLgY5kM8Vvrk62LRHlCrCvovXf09q08MZ8P1B/1E6KEuKIcF/HSqq8qzw==
X-Received: by 2002:a65:51c9:: with SMTP id i9mr7444pgq.102.1628279839583;
 Fri, 06 Aug 2021 12:57:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id v25sm11198844pfm.202.2021.08.06.12.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:57:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
Date: Fri, 6 Aug 2021 12:57:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-3-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_125720_584647_FF61125E 
X-CRM114-Status: GOOD (  24.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Hannes Reinecke <hare@suse.de>
> 
> When the number of hardware queues changes during resetting we should
> update the tagset first before using it.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0a97ba02f61e..32268f24f62a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1789,6 +1789,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
>   static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   {
>   	int ret;
> +	u32 prior_q_cnt = ctrl->queue_count;
>   
>   	ret = nvme_tcp_alloc_io_queues(ctrl);
>   	if (ret)
> @@ -1806,14 +1807,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> -	}
> -
> -	ret = nvme_tcp_start_io_queues(ctrl);
> -	if (ret)
> -		goto out_cleanup_connect_q;
> -
> -	if (!new) {
> -		nvme_start_queues(ctrl);
> +	} else if (prior_q_cnt != ctrl->queue_count) {

So if the queue count did not change we don't wait to make sure
the queue g_usage_counter ref made it to zero? What guarantees that it
did?

>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
>   			 * If we timed out waiting for freeze we are likely to
> @@ -1828,6 +1822,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		nvme_unfreeze(ctrl);
>   	}
>   
> +	ret = nvme_tcp_start_io_queues(ctrl);
> +	if (ret)
> +		goto out_cleanup_connect_q;
> +

Did you test this with both heavy I/O, reset loop and ifdown/ifup loop?

If we unquiesce and unfreeze before we start the queues the pending I/Os
may resume before the connect and not allow the connect to make forward
progress.

>   	return 0;
>   
>   out_wait_freeze_timed_out:
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
