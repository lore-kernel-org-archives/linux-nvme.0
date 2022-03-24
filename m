Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9A7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OkKkO8e5R0CNbBxkr+IlTf0NZGyl/UBRXFt0dTuR5aM=; b=iE1zaoP+Bk94yCx+cRvr9D0oi1
	xyKxVWKFIaYhbV+jpasGUSkNxNNlHXR76R0KcXbmfm3Ab3MVacUL5M7ABQO4xPrTjj1ipmqYsmdy4
	UOJAkdqnPOAlNY1dUZHRmGZtkezBVXvVgJcmSYi7fDquPZfT7WHCCGa4Ih4Z1x8n5MfqYXck+fORg
	OBoZl4I7EQQmNNMmvV589jwU+VFk3ZwF2utu58KMWkLX17xZgTWHY2LAnZRpUfI5G7AAU2SUUw69X
	U7xNwh9Y0DjTgSByWirYpJgn7ipptmGhg7lb5maWJA2L0KVCeDKbaQmXG2n9xKgQovwVlmf5EJ8Qd
	YL6UN92w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXL9e-00GHKf-UX; Thu, 24 Mar 2022 10:57:22 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXL9b-00GHJv-N1
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 10:57:20 +0000
Received: by mail-ed1-f46.google.com with SMTP id y10so5147235edv.7
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 03:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OkKkO8e5R0CNbBxkr+IlTf0NZGyl/UBRXFt0dTuR5aM=;
 b=xgbvhopj339nluHQqu3n2OCtu18jSBrylf3feW5lfi2izg3pU9qImLkfH5Jr35FBxj
 oMgFgzm/uM0iU3Wfw5kLTNhqgFeP8Jh7c1iINtE4nvpYVhEy+Uj+XGk4KzMSbm1ZbsNt
 kFCYFgr1OIc1xYtTiPzmbeMoqCnmJcu5a6Efi7fSTdfJRAAGpnHyBGAnJPZ0EQcIQ+vQ
 QNzFwOkZjuJS6H6+1CGfg4yoAEOPvFArmTXtluAZ0P8wDiNxJTdHd/xzHF2IihKOU/b7
 FwaHujv38uwoTucN2YyPz8f2otAWxeXFNjrcqCbPJhVaAGHah94S6UAiEzWG690RZE+m
 aTcg==
X-Gm-Message-State: AOAM533o5HYBN3n+62x/HjEhQVWmseEM2Dqqs5yq4Srp/0/MT38Ldi6z
 O2Fp9QJxs/q8k07fZnAuU5A=
X-Google-Smtp-Source: ABdhPJyY9e/wNTuN/EevN7LUlYSY23EqdvQXk88J4kiOu+nxc45ixkaDaOKX+M5FeKUyxqHqhQBdEg==
X-Received: by 2002:a05:6402:3593:b0:419:7a2d:4b0b with SMTP id
 y19-20020a056402359300b004197a2d4b0bmr5837020edc.39.1648119436686; 
 Thu, 24 Mar 2022 03:57:16 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 z11-20020a50e68b000000b00412ec8b2180sm1252125edm.90.2022.03.24.03.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 03:57:16 -0700 (PDT)
Message-ID: <d36db04e-17b1-858d-bf8c-82be298f5ff1@grimberg.me>
Date: Thu, 24 Mar 2022 12:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Unable to build branch nvme-5.18
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45446560EB7A86ABFFA6BA9FF2189@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ddf69f88-480e-a05f-da06-ed106926769c@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ddf69f88-480e-a05f-da06-ed106926769c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_035719_791547_20361356 
X-CRM114-Status: GOOD (  13.07  )
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


>> I tried to build branch nvme-5.18 on Fedora 35, but I get this error:
>>
>>     LDS     scripts/module.lds
>>     MODPOST modules-only.symvers
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-tcp.ko] undefined!
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-fcloop.ko] undefined!
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-fc.ko] undefined!
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-rdma.ko] undefined!
>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-loop.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
>> make[1]: *** Deleting file 'modules-only.symvers'
>> make: *** [Makefile:1746: modules] Error 2
>>
>> Any thoughts?
>>
> 
> this should work :-
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 8f3762f4450f..7c17a9d79da1 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -18,6 +18,7 @@
>    struct workqueue_struct *buffered_io_wq;
>    struct workqueue_struct *zbd_wq;
>    struct workqueue_struct *nvmet_wq;
> +EXPORT_SYMBOL_GPL(nvmet_wq);
>    static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>    static DEFINE_IDA(cntlid_ida);

This fix was already folded in.

