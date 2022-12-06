Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB8FC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=X7srUHnDjXc4q+TumOoEqCvK6R
	g4qEU5AWFMRLNXWQfhMK2BhFCRyo1cbLKQoUFQPAFiqA5pDnQ7OPnLWubbclASpKdGQIDUm9sr/ai
	fo2tMYOcrji4SHbAStgLWSdY8O/OC2Wg0CKKrpqwBKumN4vUnGFRDX/C0IPkbZjeeKQ5gMF4W4fYw
	YMB+0x4K4IRfCJ8u+ZBICYruwos6qPR59lFOaOaSnNOJOA0pBMgK5TJWzs2QiGnSVmoVNzpaQ/T8/
	HAkrtJncxlvSojzBTD3+EbOt8DztV2Mv+TfE0CZLsIVgMWp3nY9JaAkUP+SsM4sfXM8gHPT92JSFI
	7wPctagA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WvM-0091nr-O9; Tue, 06 Dec 2022 12:19:48 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WvK-0091kh-GC
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:19:47 +0000
Received: by mail-wr1-f49.google.com with SMTP id h10so13656539wrx.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=K89JbBYDV/DVf19Spz4YVqXYR/6fhy3qsr9X9vOU22lfucPIhON02tD1quFS2isZ4y
         FX9J3IeTkrq4TlLMwEfWCy7kxt79BM0mB/Wju6j0eQGYwdmzLSVp/k9muID5P6/bglVF
         m6+M1b4mJE+nQCT+FIwOodnY3N2z1KxQu21U8ulplQOWgAq4uqtLkMzWNp4Zu3ADC6cJ
         vC/bu+7ZjZcjQ7Cv4cZV2nUN+NF9WeEtCX35TRjTKJtkCTYXs0z6ZcxcSGk6/SpRwOhD
         waqAkcNfG2atX8WLBvirXx2psgrpM7Wd3GJddO2RbmhQSdMgSG8bH3b4r1tQ/5AKtBkU
         XHDA==
X-Gm-Message-State: ANoB5pniHJ2a6vDNqxejzCerZiZXhZeBVLg2wPgOwECniTvTaZAdsibx
	RiJkcGHAva2RDTVYvm0tjb8=
X-Google-Smtp-Source: AA0mqf7v1UlLV4f477x/Ue6nrxzmLBunigzqvak/B5uMV1B6IOIJH0NO3HSYpVXa+hUGQjEmQsYc2g==
X-Received: by 2002:adf:e412:0:b0:242:2cd:259 with SMTP id g18-20020adfe412000000b0024202cd0259mr32671682wrm.718.1670329181963;
        Tue, 06 Dec 2022 04:19:41 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id i10-20020a1c540a000000b003cfc02ab8basm23873992wmb.33.2022.12.06.04.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:19:41 -0800 (PST)
Message-ID: <1803f2a6-2846-488f-362b-9d17830d816e@grimberg.me>
Date: Tue, 6 Dec 2022 14:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/9] nvme-pci: remove nvme_pci_disable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_041946_620533_D8423289 
X-CRM114-Status: UNSURE (   7.11  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

