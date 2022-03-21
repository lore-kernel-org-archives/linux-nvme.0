Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3766FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 09:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60W3VtKicpE+IqdqSUpAB/W/auIB9eHgJ1nnojMJZeM=; b=Eq058ow+pb773GOdXeE6bwCAO1
	l7Gq574raOYYhvS+Rjqu9FypYwkWk15C5LNYYxC/4bgVdYlXSuLsCJTiiNEd3HSP8p/gbrf6LPAaM
	o8Uel/poHMfeG4vQoGiS7nLq/qZckrxIXeIP+pU/5O7pnlOn1KQ1Li2/IKikqMYmJOZwl0rfK346H
	FHT8+tT27BV5ki8ipVp8crPFfE+Lxi/aTMXspcpuYloeYF/2YhiCHjoXYUNENA3LaEGi6DToZjg4B
	99o0kj4Aevj+vfFzLlS3Fy2Q4wr+Ggs3Gwtx+e/47m9yFCtZJR9oEP8hmtAsFTXbjyBa37smU2rH1
	6/mRnT1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWEKm-007AcR-Sr; Mon, 21 Mar 2022 09:28:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWEKg-007AXY-CB
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 09:28:12 +0000
Received: by mail-wr1-f47.google.com with SMTP id r13so4737684wrr.9
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 02:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=60W3VtKicpE+IqdqSUpAB/W/auIB9eHgJ1nnojMJZeM=;
 b=VNEoCjyoTKlkvTZXoyIOfHEKmWnoCG/SeqitN4ZhsaURLf0o5xdNNezAfHNUxlgPdJ
 QirUSTAplgOUlLK0tDvtJOOlrR1JY9CPpN7vGFdQwHKvDSONgSQWZmwrnBtIN/gN0kzz
 PrkRYCC+OOOEl3hsz0XHiduzSalzI9cbJ5iqm0wZwrU+eX43Sd7nEwOoNSY57lzteiIk
 UTce5Hj75F7K/BQlGw9NMpKukJWAHhVhQBG0Hvqci5C0QC7iWgOPap+dscdv8DWR39Il
 Euvj20ljsjg/Cf9FYM06x5TGaj/VTZV5bYffGsX5qg9C9novf5B3UHXtCimrAA6ciWM5
 41uQ==
X-Gm-Message-State: AOAM533dNLrgR2T5PwLeytDXLo1qoPMusVohDe4Tq62aq/1yRtPhpoxs
 fy1Fu20XPWqpIlFco+jfhOs=
X-Google-Smtp-Source: ABdhPJyJ3Nz1OjGr1wfDL+c73fxuMpPQ71qwRRPKYQc1U/BQskIQus8w0OsEi0Fm3YT/jdlRpLChOg==
X-Received: by 2002:adf:d1e5:0:b0:203:d609:38da with SMTP id
 g5-20020adfd1e5000000b00203d60938damr17252131wrd.675.1647854888318; 
 Mon, 21 Mar 2022 02:28:08 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 y7-20020a5d4ac7000000b00203e4c8bdf1sm11326774wrs.93.2022.03.21.02.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 02:28:07 -0700 (PDT)
Message-ID: <94b12c63-7deb-5c62-2c0d-e339fd5e7823@grimberg.me>
Date: Mon, 21 Mar 2022 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Max Gurtovoy <maxg@mellanox.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <CAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w@mail.gmail.com>
 <6d8f4525-f663-18cc-8644-bfddd7d86bd0@grimberg.me>
 <CAHj4cs_ff3TGnD2QJSzx3QJQKc1HkF=TJkh_MokqGK3n8NWyQQ@mail.gmail.com>
 <3d3f7b64-1c74-d41c-4c60-055e9fa79080@nvidia.com>
 <7e0abcac-791a-bd71-38c3-4a5490b7f209@grimberg.me>
 <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d8283461-8759-39ac-6ef7-a6f5cc739634@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_022810_450278_819A04E7 
X-CRM114-Status: GOOD (  20.55  )
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


>>> WDYT ? should we reconsider the "nvme connect --with_metadata" option ?
>>
>> Maybe you can make these lazily allocated?
> 
> You mean something like:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd4720d37cc0..367ba0bb62ab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1620,10 +1620,19 @@ int nvme_getgeo(struct block_device *bdev, 
> struct hd_geometry *geo)
>   }
> 
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> -                               u32 max_integrity_segments)
> +static int nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
>   {
>          struct blk_integrity integrity = { };
> +       u16 ms = ns->ms;
> +       u8 pi_type = ns->pi_type;
> +       u32 max_integrity_segments = ns->ctrl->max_integrity_segments;
> +       int ret;
> +
> +       if (ns->ctrl->ops->init_integrity) {
> +               ret = ns->ctrl->ops->init_integrity(ns->ctrl);
> +               if (ret)
> +                       return ret;
> +       }
> 
>          switch (pi_type) {
>          case NVME_NS_DPS_PI_TYPE3:
> @@ -1644,11 +1653,13 @@ static void nvme_init_integrity(struct gendisk 
> *disk, u16 ms, u8 pi_type,
>          integrity.tuple_size = ms;
>          blk_integrity_register(disk, &integrity);
>          blk_queue_max_integrity_segments(disk->queue, 
> max_integrity_segments);
> +
> +       return 0;
>   }
>   #else
> -static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
> -                               u32 max_integrity_segments)
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns)
>   {
> +       return 0;
>   }
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> 
> @@ -1853,8 +1864,8 @@ static void nvme_update_disk_info(struct gendisk 
> *disk,
>          if (ns->ms) {
>                  if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>                      (ns->features & NVME_NS_METADATA_SUPPORTED))
> -                       nvme_init_integrity(disk, ns->ms, ns->pi_type,
> - ns->ctrl->max_integrity_segments);
> +                       if (nvme_init_integrity(disk, ns))
> +                               capacity = 0;
>                  else if (!nvme_ns_has_pi(ns))
>                          capacity = 0;
>          }
> @@ -4395,7 +4406,7 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> 
> 
> and create the resources for the first namespace we find as PI formatted ?
> 
> 

I was thinking more along the lines of allocating it as soon as an I/O
comes with pi... Is there something internal to the driver that can
be done in parallel to expedite the allocation of these extra resources?

