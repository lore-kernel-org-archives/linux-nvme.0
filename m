Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C508EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 22:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7822261050
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 22:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7822261050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dk8T5RDJYBkYGzu1bj1+5lYekez96YzrXAkQqaemI9A=; b=Jb/bz4hp0sFCsWw5t8+ccoH5uD
	bFaQ7ZTsGCSCmZj3/0/Ft/0uIq14kpqyFzU5OX9tIPOPAgYIacanHFINYnUANd7JGSWzlY4dHrQmC
	Yf1795nockYe8MOkkHKWVSYdjx3RSqxhqAA1wtknx5UFjhvkJyyAzmLPWZQ2NbK3OWHXwEumz2Ne7
	yS2Y9XpfjJWAw2SrF70bB3B/KeLMnENDSdIq7FXl9y8eNt9H8Z6b3AMw3ViD44XESTrsQKcKUg2Rq
	RCorIXZdfCiHdIO/cAwWWb/ARq8JZhjHayMFz7chNRbwyXoeWigSBlLenQNZWufefFCpwd8mPRxPe
	FG3Iyb2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSoYO-006BVb-0J; Tue, 21 Sep 2021 22:47:56 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSoYL-006BVB-8l
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 22:47:54 +0000
Received: by mail-wr1-f51.google.com with SMTP id w29so1119955wra.8
 for <linux-nvme@lists.infradead.org>; Tue, 21 Sep 2021 15:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oyCSR/4cQt09aXxzgphMQtiwrj2pA9aFBvzcPjP9LYc=;
 b=lVVwwr9rH0tcNBQ7qlvdodb3k5EucH4FX+p9DIaUH0ukE9iH4qks3AQjXP5Nify9rl
 ip5HSDXvj37rSyN5Cy4BEIwQjY8le5fkXsiiYiDPP3ifYnem2BDp92iUqWYY3nhnCdhx
 pS+qwvGFeuxDkoz5HGoqoKEral4ZJuejc7049eiWgm9bJ+Z7gNgcDVE7sQUyUAEovyoO
 bLDmRtUE8OtSVFT8KBccPGzehIXMWdvUUdut+Z9mGaFpCaZra5/VKSJ73zZNFiANvMNs
 FyNZXrwhTK4tASlznzXsYnqcntf9qQJTfM/TQCFEh7EAqdqh3zZJNIFQrPcDCVfgSkcX
 T1Bg==
X-Gm-Message-State: AOAM533LcpcC2cdfsJnm+r71tkbcMsDpfMP9rKHDq7Shn0Sys58+WsLD
 Kaps3uH6aiu7mK45d+E0fxI=
X-Google-Smtp-Source: ABdhPJz/09qzz9x9S46Zw2XgZ10qk95FZImue3ciZS6vZ2YHZrI9T/dhXBf706Ct6XsLs4TqgKC/Fw==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr38588130wrc.296.1632264470867; 
 Tue, 21 Sep 2021 15:47:50 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id m18sm326450wrn.85.2021.09.21.15.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Sep 2021 15:47:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: add get_queue_size op for controllers
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, chaitanyak@nvidia.com
Cc: israelr@nvidia.com, mruijter@primelogic.nl, oren@nvidia.com,
 nitzanc@nvidia.com
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-2-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <62df9e92-1530-2fb6-68f2-4040fea02fb4@grimberg.me>
Date: Wed, 22 Sep 2021 01:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921190445.6974-2-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_154753_366479_D9747B8D 
X-CRM114-Status: GOOD (  13.46  )
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


> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b8425fa34300..cd42655d2980 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1205,7 +1205,10 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>   	/* CC.EN timeout in 500msec units: */
>   	ctrl->cap |= (15ULL << 24);
>   	/* maximum queue entries supported: */
> -	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
> +	if (ctrl->ops->get_queue_size)

Maybe call it max_queue_size? it is a maximum supported in essence.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
