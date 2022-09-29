Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B1C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 10:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxkvvAfnCGuvjtfPXgTbYWw1JYp05+ALMY/xnHuKfn0=; b=NUSNDbX49WouscoLJWZsBOXGpb
	DNx+9WuDE2uXrmHMM5FNV/w3MchFQ0hLqELQ5M4/0I+GDYleIysweWxFwYpkbSkxcOVE1iZELl7M2
	GBApBAW22pEP5wCvK8txYDUE6dTk/R/8B69gcvR9RN3qUA1GLajRmtgF5EsSqZj8KnNkxTZchX1rt
	kHtQuGC7HO9dZq5kEmwOtMoexxfpEah/to0XosAT+pfZbiJix4DVR1WRkALOPSi4UCqzl/hcg7k2O
	nNSYGNTsdPTAVDvzaIX26RJajFtM+CkaZ+rRQZHHluXaftLNlmmKVHIKYbUxw5W+nPB+WNfZ20D+6
	dhkrH95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odqPN-002IZY-4I; Thu, 29 Sep 2022 10:04:45 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odqPK-002IXW-V1
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 10:04:44 +0000
Received: by mail-wm1-f44.google.com with SMTP id iv17so601784wmb.4
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FxkvvAfnCGuvjtfPXgTbYWw1JYp05+ALMY/xnHuKfn0=;
        b=IiOPqyqP7OnhGy/Nqp+JbWDn43MFm/2J6m7pzJPilVtq6+Tb3YfHmBcLBBBwa3WaqE
         wz78k6S5wL8MIU1RDabnHuxFwY/aBEso3U4KSE6A3L7KqU/nfcwlD8BCLDKojgbvukiD
         7wqG35R8b7diJOU8KobJ5pHzhNDrUKzAkW45+Fl7iEAAeP37ahTe7C9LFoWAesgzMaTC
         HeEpz1e0bpST1hd8rpiUtghSqEl4/Wm//C6cRZPqxpYSt7svfpeTGV0+v6OkRN75Y47x
         kdb3/AOdKLlFLxLHCQlMIfTueZ/2Ro7i1eP+1yTkdtsTPYsYxyIN5YZ7D4xNAeAhsNBW
         NHBQ==
X-Gm-Message-State: ACrzQf2r2HMfKmtkp0gZcupcpHdPc3U4eHQW1Gto9YgBLHLhc9KXRoeK
	3kEkNF5k9DLMygUtx+WX9GaRw5ZkimA=
X-Google-Smtp-Source: AMsMyM57k7IedzBt41w5fiHirYHurQJaovvOKJvMNF2wKvGL2tmQAsGZmlTr71s472zMk4IVShz0CA==
X-Received: by 2002:a05:600c:35c5:b0:3b4:bf50:f84a with SMTP id r5-20020a05600c35c500b003b4bf50f84amr1630072wmq.22.1664445879778;
        Thu, 29 Sep 2022 03:04:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003b4924493bfsm5026382wmq.9.2022.09.29.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:04:39 -0700 (PDT)
Message-ID: <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
Date: Thu, 29 Sep 2022 13:04:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
In-Reply-To: <20220928195510.165062-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_030443_024133_A2E8622F 
X-CRM114-Status: GOOD (  20.49  )
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



On 9/28/22 22:55, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete);
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/apple.c     |  2 +-
>   drivers/nvme/host/core.c      | 10 ++++++++++
>   drivers/nvme/host/fc.c        |  2 +-
>   drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>   drivers/nvme/host/pci.c       |  2 +-
>   drivers/nvme/host/rdma.c      |  2 +-
>   drivers/nvme/host/tcp.c       |  2 +-
>   drivers/nvme/target/loop.c    |  2 +-
>   9 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..6df4b8a5d8ab 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -763,7 +763,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			goto out_free_cmd;
>   	}
>   
> -	blk_mq_start_request(req);
> +	nvme_start_request(req);
>   	apple_nvme_submit_cmd(q, cmnd);
>   	return BLK_STS_OK;
>   
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bacfd014e3d..f42e6e40d84b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
>   	blk_mq_end_request(req, status);
> +	if (req->cmd_flags & REQ_NVME_MPATH)
> +		nvme_mpath_end_request(req);

I guess the order should probably be reversed, because after
blk_mq_end_request req may become invalid and create UAF?

