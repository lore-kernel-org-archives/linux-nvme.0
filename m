Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC39CC47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=lrghw/wyJiwkYL3FQ7gDPGCbvr
	vI24AliF0eD30nBb83qopOeLW51PaZUQObBxH+y/W3w8FFWTrzHuEAXiG2mFm2d2qHvIk1nDG5KGF
	mZ30zwGyCCRmUjY3Nn38MiS1ns3WLZK5v2Agb/XlnETNukaHe56Hj290JnJGKHTQMieSKKQpX/th7
	8uFydbe4MdibJjw9yTQH/0NG4LL+rQvhy6pt8VT06wI0GYX2g7yv5Yi9R2C8wWPA/uipi0SSRFtDH
	tCTKu4KyeBA79NbO/1I25wPvQe4tlxKnrmswi0ltJTn+xi5JB6K6EYiDxIv6X1rA/z7Fo+QTcIc5k
	dJ2dyDKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRuDH-00CGf8-2n;
	Mon, 22 Jan 2024 13:19:43 +0000
Received: from mail-lj1-f175.google.com ([209.85.208.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRuDF-00CGdG-1Z
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 13:19:42 +0000
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd7ebdd489so6592871fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 05:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705929576; x=1706534376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uOKfxsj/ZrXML/awbJgzQVA7oAOTyleKmWtI5OuExgXxp7NM9yAp7wEeW/w9xm/qOc
         KLl0h2x3/jdr7Mhm6m3StoQRyv3ybC/puAce54fHuLBTbpw02e3Yzle9ejNfF+H+6q4Q
         5lHveUzb5HCwWRKBazonD89AAIhac2wEenZwdpNueCyDHPE5HINMfclZLJ/u/3Fa4wGs
         rebX2mWY/6h6QX5jCQd9gOb/FpGxG2o45IXArka7JhdVDdUeyshOdjnkqfMsvkavmBcF
         qpkKZgF8sUzVCohd+VFLvrUoZ1/EW4WuuNDwxvSwSZC1XbafCudwYolhicrgiEBRM6EX
         QdmA==
X-Gm-Message-State: AOJu0YxXW6ETsw5mZyQ5hNeuMvEkZ1Pg940sPcridq+9JSImfa0DneHA
	UMl0Th+rI9dIbewULzsvAhHHnvuxjHwXbMy9O7WKmB3tm8o/6ULy
X-Google-Smtp-Source: AGHT+IEwSNvGMt+evZDnZLznqFVGpgplxgxLovFjBzSp2xMGuWE2PALsfvo+jX2ShHJxRR8hHupuqA==
X-Received: by 2002:a2e:9bd2:0:b0:2cd:8414:30b with SMTP id w18-20020a2e9bd2000000b002cd8414030bmr3597181ljj.5.1705929575786;
        Mon, 22 Jan 2024 05:19:35 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l21-20020a2e7015000000b002ce0d96ace9sm530042ljc.40.2024.01.22.05.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 05:19:35 -0800 (PST)
Message-ID: <0a582f83-8889-4317-a963-936008409d2e@grimberg.me>
Date: Mon, 22 Jan 2024 15:19:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme-rdma: introduce
 NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-6-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240104092549.25721-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_051941_522201_44913F67 
X-CRM114-Status: UNSURE (   4.52  )
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

