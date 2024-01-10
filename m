Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DFBC4707B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gV/25XO458e+IXbfHFTvvAGwBUh/NnuEXl/XrprNRsQ=; b=cmPev1jjuIjDpGfAk7yDMyDpyL
	u24ctM9keZjSTepNXV7ZjMWDmIDbJBQvE05ervasaDPg9WGZrNOAF9iBKscEDhSodrleUopMQHLw2
	SA58vNUCxb4DHDNfVNXrqlNmrJ5+wAhoT9lY58qYlp8EW69tLHiMowvvi6VdBZ3ABtVGQ1d5SulOn
	ItF1orxejOykJ88PDH2w8Z0HeZ7u6XPS5b7ztN3pp5CS00oqtnHksHmrdE9f5vSnYQKLGzoIqJ6Ha
	v2mpB6Po6wQNYTD+Cm+l2AJ/lxBMPHMHAni06/zLp2xS4QWQgwTeKBdzMSunnYNwDu4ITSARtaYqh
	CFQnAEZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNb55-00Cmn0-2l;
	Wed, 10 Jan 2024 16:05:27 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNb53-00Cmjz-1C
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 16:05:26 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33694c0ebd1so484369f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 08:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902722; x=1705507522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gV/25XO458e+IXbfHFTvvAGwBUh/NnuEXl/XrprNRsQ=;
        b=JQYclO7CXK7UFnqCzuMzbVrPoEL0KhM9eBeVIn28dHvTFTZiBikHg7PaPxg9U3TtvW
         Rh6MxdyKm3+0mAqEINWTdtVrU7kh2CWAPXezQV4hVUIQxXl8PKqPYxaFea+4tvY3CuOi
         kaZes21hEK1rebmYNzOoJfV5GvZPFlR9yAR10BC51OP4gIST44OEYaTIFru0IAEIs9tA
         Qt3k3koYSiAYd1/ldqpt6ZINGPP6rnPlLrosuZblDJMtsNk42JJFFlk3ygytTJFqEaDc
         MTMWpOagEuHy7vOS7e2Jh7sKoeod0ZEc02K1jM0Tv3izw8oebINxUqxMwkBbZSCPjtyE
         ol/w==
X-Gm-Message-State: AOJu0YwzYBSNV4LM1DECpNoNAuN7jdPSMGwXldBTYkap3fuPr9faZGLi
	bVNBL+6SPIoYPcEJ2K3Djq5CDXd5PJI=
X-Google-Smtp-Source: AGHT+IE8XRt6tUPcRi8yaZUBxN/MB+i9dYc7A8Cej77C7yLjysTbMzZtyNXkFvjOjbPP3isI6BPJxw==
X-Received: by 2002:adf:e990:0:b0:336:7f36:5225 with SMTP id h16-20020adfe990000000b003367f365225mr1632659wrm.4.1704902721954;
        Wed, 10 Jan 2024 08:05:21 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v5-20020adff685000000b003366cf8bda4sm5224003wrp.41.2024.01.10.08.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:05:21 -0800 (PST)
Message-ID: <7ff7046d-ce4d-44d0-86f5-8ed7cb0229a3@grimberg.me>
Date: Wed, 10 Jan 2024 18:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-7-aaptel@nvidia.com> <253zfxehmum.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253zfxehmum.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_080525_406459_1F894BCB 
X-CRM114-Status: UNSURE (   8.02  )
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



On 1/9/24 11:34, Aurelien Aptel wrote:
> Hi Sagi and all,
> 
> Do you have any other comments on the patches (nvme & netdev layer) we
> can address while the netdev mailing list is closed?

I don't have anything major I think. I'll review the nvme-tcp
part again.

