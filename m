Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61166C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 06:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hRcIA2tYJi4KR9/wJYSc0yMZMt
	086P/ip3uIN6oUVOicEx+szvle1QCZiOHjUu8B40Z5zZAqwkPZ7FbpRy6Q5qGIOpgi1nNRmWt2Fie
	glLxkjryM9/5n06jBBB/KUY5IpYFs2kX0OdZsEjZ8ThcKOsxSw47ouXMiITds/8b19I08zUc35+c0
	YrnZmZUlZ0gWaS/CyAuo41BRK2p+A+VTNgsXq2E4NVrmiDoN2aq7DsFkdDfhdnvV8wwJ7V++obuYW
	6132MAJtDJ+Egctv5kqBqJKwUMPVt22RHFqiLjzvn2VFWRNlXWfpUEG7K2xAm32N3p5vxsQbkj827
	Ri0UiTEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBUQ-00000003qBc-3l7o;
	Thu, 20 Jun 2024 06:41:46 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKBUN-00000003qA5-3Z6A
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 06:41:45 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b96eafeeaso76506e87.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 23:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865702; x=1719470502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fkInsdv/Phw/iO+g3vnxMR1j8mOyDBYqu6KQifTTg+thSO2SGS3NQv2EGw1tnpDlxQ
         HYKKx6uwVjtqauViEp4TTn5zxzEfBDM5l8QY7kDH0yTkTHwOTfiUNl+6ReMgMoTtTbiH
         nXOCRTH5GW3zLRTg9GJ8yEDIUSqVSRbHsghlAvdfPExkIXqv88jpjrPY49hsofsHgW8Q
         a3XD+jiOrtDNJsO9WHHkqSa2ewDvUeFH//zLnfxGDavTq6AoL6+7vH/HfirOiiqBdmll
         chWVcSha14RQ0F8ij/YatcSV61tmmURwjU7pKLnBGwNOSavC6FqGpxUys4F1b/XDH3uu
         ABCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkAjGlCkmqGrPT8H3/3OEDiZrGt1Nm4NijdG+Nh9RzT6Wn0WxwKhsP4SUxnypHwLNR5sY0600SPZbJWBxPlBAjt5hro7TUdHngU5rcDSA=
X-Gm-Message-State: AOJu0Yz+Z5GTNYglgJCs6c+eViMGDNYf260a1pOTe8LfIRYWyPRgBT9B
	/xGUFaAmZxTeDe2h0QUIlSOvtcEOamnYF2kUBEwRxYGLht4jr5wj
X-Google-Smtp-Source: AGHT+IGOC4BQj4OY3S/auNc6PVwOas5Gb4lQbz5Wu4u8PaV6+35jDO7h/KCQt0fAHessUMKoWiqsYA==
X-Received: by 2002:ac2:5e3c:0:b0:52c:a121:4b08 with SMTP id 2adb3069b0e04-52ccaa880a9mr1922911e87.6.1718865701862;
        Wed, 19 Jun 2024 23:41:41 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e08sm13690625e9.35.2024.06.19.23.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:41 -0700 (PDT)
Message-ID: <4966e9fc-987a-4a87-80cc-c70e09c548ce@grimberg.me>
Date: Thu, 20 Jun 2024 09:41:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] IB/isert: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
 <20240619171153.34631-3-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619171153.34631-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_234143_963470_749080B5 
X-CRM114-Status: UNSURE (   5.28  )
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

