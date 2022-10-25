Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7FFC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KV7jq2zG6veYAlgtq6p/ASA6YBq4VylV/N2M7eSg8ZQ=; b=v2MB1RGIHoLO4QdtMt1o8WNWjf
	bEVYHX7mhwM2SUWHwA7tT8K6Zw3IM4ZSF8hG5x2T+YH0md0ATvx+dPKe7Zptb3KgwrTZCvDAkGsZC
	HqxOS2EJS2/S3I+pRhZ5eZj/jnZzw9ubKHgC71b8estYppCHij/cdFXSrp6jYixpkhGxIJA/gBCro
	cPXpuoWlWZVO9ilOrpqcB5GTEjML+6Hvdu95j/ymN+P9sEHX9EJdGEVSRsYHvXfi5l/r/p7zjOmB/
	HilHhjamh6Kd10hDMIx8BTs/EvLZUNMHxdzn+DWVkfQCdV8JGI84tor8QRkjFxkoZmjMqHXvNQgKP
	U9wPSSYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM8u-006AnV-IJ; Tue, 25 Oct 2022 15:47:04 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM8r-006All-0p
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:47:03 +0000
Received: by mail-wr1-f47.google.com with SMTP id bs21so5919246wrb.4
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 08:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV7jq2zG6veYAlgtq6p/ASA6YBq4VylV/N2M7eSg8ZQ=;
        b=HdQJVetRimhlgcGCGaU9gTqjd71ff4ju0tX6ukCxfaNvUUd1/nJqYrQ7lCCPfGSsN2
         ovI8kXMlVbtXKxsRbn8mXD0MzN0M4xt05DXhEXhbskSn4dj7+4N8xDPxIDkuXjixDGFD
         y/kT9S4qWSihSrLckKWlJfxDySSTZlRM0A59Ahf2nBapLqz7QZmEqsPSQCyQVJtS/A/2
         rZv9rAkeVJN5YxXcPK5E45FsymNlseH5Hpk253zcGIETYSFqa01CGFNSgFOYUAm2SSLm
         DOk+mTSq24G8bneH8MmzJJelPOF582k3Pq76qVPwsWNNi8nJXJix30SWH/pkL5q/hzea
         zrZw==
X-Gm-Message-State: ACrzQf3S8Uu3Cqk0baWFYPxHFdRcl0Za5niOOAn0usZDDQEoLEYFlEW7
	DSGmStOufoHgnIaSweAZ5T8=
X-Google-Smtp-Source: AMsMyM61ONdRQUXHzsFt3qzxVwR9UGT7RutXYkhuEArNwgnRFwjQQIK1C4of72mK02Pz4sm6cf/hsg==
X-Received: by 2002:adf:cd09:0:b0:236:659a:6902 with SMTP id w9-20020adfcd09000000b00236659a6902mr10813622wrm.574.1666712814622;
        Tue, 25 Oct 2022 08:46:54 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003c6f3f6675bsm11640778wmo.26.2022.10.25.08.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:46:53 -0700 (PDT)
Message-ID: <d8d87fd0-b217-0ba8-b94a-903db9bbf070@grimberg.me>
Date: Tue, 25 Oct 2022 18:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/6] nvme: a few nvme-auth fixes found during code
 browsing
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025153224.GA24369@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025153224.GA24369@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_084701_107633_26D77F80 
X-CRM114-Status: UNSURE (   8.40  )
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


> The changes all look reasonable to me, but I think we really need to fix
> the grave locking bug in nvme_auth_reset before doing more changs in
> this area.

In the works... this is part one.

