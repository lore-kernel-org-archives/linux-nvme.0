Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA565C3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Lld8+pNXFqQhh5Zj22Qf37Og31
	BPjVnTLNBMo9/8HqWaUtIutAn3sXfRUZcpYny8+eePL1gNzYQHrU9WC8MT5MYW7PvRLXZqdmv1fld
	g2UAz55WicNH6A8fh8QoEP/CI8ezbkI8PXoubNJ3toQmLZqoP69hONKQ/CI859IgIjzkn2GtArW/Y
	HPMRvB7tNj2gG85Wpg820PfDClDJyrQiS3K+11on4annof4gqhQqjqMGahHwlLmO0vsrnHHEiwGCE
	jdbvjR9M+LEfGPhUnoBN1T3oXj00ajfBd9zM1CyN947MZZ6nH0CGQQWuE7+BhvrulgTFt70BBV9XZ
	luF8y5WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBGt-0000000EqVX-1J8n;
	Wed, 17 Jul 2024 20:29:07 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBGq-0000000EqTq-12fS
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 20:29:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427b9fca517so105855e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 13:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248142; x=1721852942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=j9Pjj2xbp2x8X35bYNEUuNPXe4/tfeFFXmAbhKUOX+3uSvqxHVmveVF10MC7BdSmWw
         kgj8ErcjnuaxyUGHz6Jvmsi7OgWgW39V2LoTO7H/motscg9+62VU3CivPcXGPdSSsnHB
         caE5+XNhdDhj6KCvsxXHYEeM3BZHvclMIZkWVkSBCQPJP2e+0CT9OipfkyFZXUsTn9Mx
         gOMKO99Q2Fi6eFv8cSexyDJ/g0meXIbwOgrr8FSgkO4UBILwbkFQ421ndn/6ZXJkxQM4
         dHpATyJoZoFq41n8F1KlEGatq87LTLuMhjnGetEURnnc8vQh1gy9v9z8+AnXmjTh3EVw
         m12A==
X-Forwarded-Encrypted: i=1; AJvYcCVvEqpFy/2H4lvjtVh8ohsENYzkJS9iLW0bYSH1qUnDhzoAodzl0nltMdjonJ+Utu/31/G0OwQUVunIFmfJ58eHWz1YQ1Faaafd3zL0WiQ=
X-Gm-Message-State: AOJu0YyCPwf/Qmr/V6RRdMzczBiZT0drOCDaUcaypnICUyODzcrk5D2o
	7/Cgmcwe6fPsQrRBjIfLFUMjeHRVGJrN6Ha0snmOjBTN7T0D6U6p
X-Google-Smtp-Source: AGHT+IEgpTsF4KTygZw6dmo2qCMX729MyYcSTCY0zjO1oFNbzgvBxVxJSlaCNJD0BJNzGgyZyAfh7A==
X-Received: by 2002:a5d:64e8:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-368316fbf8dmr1204272f8f.5.1721248142165;
        Wed, 17 Jul 2024 13:29:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccb6fsm12361199f8f.65.2024.07.17.13.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:29:01 -0700 (PDT)
Message-ID: <cb419a98-e2b6-4836-92c6-928f00e4578f@grimberg.me>
Date: Wed, 17 Jul 2024 23:29:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet-rdma: add unbound_wq support for nvmet-rdma
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240717091451.111158-3-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091451.111158-3-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_132904_333056_59F943AA 
X-CRM114-Status: UNSURE (   4.96  )
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

