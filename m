Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDD0C7EE2F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Hx6JaA1VFMYuuPRejPTqH+/kHaaNNp+8XTwPIciGZk=; b=VDpxWw1laz0wbkE8F9sJ35k4OE
	NLHMdbhZPpeGeiwaMzPocFnl4fsXf96RnZivPto5N5cQFLq+tQBXX3zd8UiZRmEROtpIgRXZ/CMJr
	W6cvVXfEGdkffShAd/Ht0oxw1kZDrnGFk54bCDc6IjtU7FxWOfcMPBs8JiKg9UgCI3AQe9fjPWut4
	g+l+Y5hEXJLD5JBK4Ab3Bns0xL0JpnE8ATQIjyfl8vLcT9t1aI2kcKeQA1KHgUaJ/XQ0yTmiynfm4
	BuIfMepBfJ4IBvuK+tsSEetiBw1XKDu34c4uJcn0K/OTQCa6Juq/p1VxemHjE8zmLB/7XFs9goHum
	kGolLAvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iN6-004H67-0e;
	Mon, 12 Jun 2023 14:18:16 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iN3-004H4l-0y
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:18:14 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9eea9d0a1so18152951cf.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686579487; x=1689171487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hx6JaA1VFMYuuPRejPTqH+/kHaaNNp+8XTwPIciGZk=;
        b=D7eGkhPav+Iw9SGA7aEVSTNfKwuRTKm5G+sl0JlstlReKmUBBQSK9e9wUhNmXP7o4z
         UHHeAM+A2oaPorjylRyHzR1iSgcK/mmUP9WjLwZRc1d+m+Spb8WGKRyGZIX+V+acrk++
         JB5MzpxRKQWZDWtmNfGyRNJyNUdzAUJaUAPlRtxGAFPXh0N2WGU/JOryeICEZ3On+zyN
         BG+4CAxzqY0LnXhAwObkeEBDjnbZWUqMiFYpwlPOIspCciA61nSDFC+nd2HUKExpdgvK
         ELky1u1iZLU3Yc9cjXm+ee1Aa0ofQ05s6A3ZejB5iyxqlMulXKXOca85JG5D9vaN/bWI
         xOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579487; x=1689171487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hx6JaA1VFMYuuPRejPTqH+/kHaaNNp+8XTwPIciGZk=;
        b=WYKGu8qLII8S2TgyCD10VMBiDKt0nvn7dY4vPRoTRK3GB7Dz3m38TVCQPfuoS8tAP5
         AS1V6hxYGU3UuD1tlFVeOJ1wLHiz727qHHOcrh1CZ6tNto4iYPPmsth1k/CLihc/mqwU
         NAxctCbHDl0nuuvqvKI/wLzccKMNdqQzYKBZhNEzXda7Kyu9NoMwHzgYaCS/ikjRRJ4F
         HCMDTiDbiNjmHVRXYKE5FpJj2B2Mjy5Sbabm4M6FAMnj37n7H/88GQQnIFfYSORn9Fgz
         Ag+l2HngMrmE2zxTKuQELNtVEMtIpmHBTpzQi8dZGN5doM4sDQjApGT07lqxAFOupqwu
         Nazw==
X-Gm-Message-State: AC+VfDyU3IpQeHdr5q7734FVQfVEoJun+vBz/r3vekwnlbgg9rZSa4lS
	gbowXmVjOx4hvBFSlX2wlkalhg==
X-Google-Smtp-Source: ACHHUZ5uXYK3k9fARcVs12zkAlloXFgFswgLnTGTsduaqOQC0Q2Jq7lsI3SuS0aFpOUsHwK9sN4gjA==
X-Received: by 2002:ac8:57cc:0:b0:3f9:7251:30f4 with SMTP id w12-20020ac857cc000000b003f9725130f4mr12276118qta.4.1686579487027;
        Mon, 12 Jun 2023 07:18:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id bs17-20020ac86f11000000b003e3860f12f7sm3412801qtb.56.2023.06.12.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:18:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1q8iMv-004amy-JE;
	Mon, 12 Jun 2023 11:18:05 -0300
Date: Mon, 12 Jun 2023 11:18:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <ZIcpHbV3oqsjuwfz@ziepe.ca>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_071813_441729_F94475BD 
X-CRM114-Status: GOOD (  20.80  )
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

On Mon, Jun 12, 2023 at 02:42:37PM +0900, Shin'ichiro Kawasaki wrote:
> When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
> *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler() [1].
> To prevent the destroy of id_priv, keep its reference count by calling
> cma_id_get() and cma_id_put() at start and end of cma_iw_handler().
> 
> [1]
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in __mutex_lock+0x1324/0x18f0
> Read of size 8 at addr ffff888197b37418 by task kworker/u8:0/9
> 
> CPU: 0 PID: 9 Comm: kworker/u8:0 Not tainted 6.3.0 #62
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x57/0x90
>  print_report+0xcf/0x660
>  ? __mutex_lock+0x1324/0x18f0
>  kasan_report+0xa4/0xe0
>  ? __mutex_lock+0x1324/0x18f0
>  __mutex_lock+0x1324/0x18f0
>  ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
>  ? _raw_spin_unlock_irqrestore+0x30/0x60
>  ? rcu_is_watching+0x11/0xb0
>  ? _raw_spin_unlock_irqrestore+0x30/0x60
>  ? trace_hardirqs_on+0x12/0x100
>  ? __pfx___mutex_lock+0x10/0x10
>  ? __percpu_counter_sum+0x147/0x1e0
>  ? domain_dirty_limits+0x246/0x390
>  ? wb_over_bg_thresh+0x4d5/0x610
>  ? rcu_is_watching+0x11/0xb0
>  ? cma_iw_handler+0xac/0x4f0 [rdma_cm]
>  cma_iw_handler+0xac/0x4f0 [rdma_cm]

What is the full call chain here, eg with the static functions
un-inlined?
> 
>  drivers/infiniband/core/cma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 93a1c48d0c32..c5267d9bb184 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -2477,6 +2477,7 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
>  	struct sockaddr *laddr = (struct sockaddr *)&iw_event->local_addr;
>  	struct sockaddr *raddr = (struct sockaddr *)&iw_event->remote_addr;
>  
> +	cma_id_get(id_priv);
>  	mutex_lock(&id_priv->handler_mutex);
>  	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
>  		goto out;
> @@ -2524,12 +2525,14 @@ static int cma_iw_handler(struct iw_cm_id *iw_id, struct iw_cm_event *iw_event)
>  	if (ret) {
>  		/* Destroy the CM ID by returning a non-zero value. */
>  		id_priv->cm_id.iw = NULL;
> +		cma_id_put(id_priv);
>  		destroy_id_handler_unlock(id_priv);
>  		return ret;
>  	}
>  
>  out:
>  	mutex_unlock(&id_priv->handler_mutex);
> +	cma_id_put(id_priv);
>  	return ret;
>  }

cm_work_handler already has a ref on the iwcm_id_private

I think there is likely some much larger issue with the IW CM if the
cm_id can be destroyed while the iwcm_id is in use? It is weird that
there are two id memories for this :\

Jason

