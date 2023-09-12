Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AFCCA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ez5yOCgWh6+IdYt5V62xOCehHBvMW9ONvki2UtDHKRg=; b=SHlexyClddJP8nMOui0CyCZITZ
	/H4RvBGx9BMEkRQFw3hxPsNAdlGFVK7xy3OO5O8lLAfP2Ipo2SVgs3Q2NkRSPNHrlC3oenFjGVetu
	SXeYixf7aE+VB/fCLZBk8rhi6Eeqg0yaCECuTCs+4DhrmcHFSfKQ+7BeelElMi7aNxPHVSZ0CT6sD
	nr2d1+8GK5Wyz7OcQKqybeKdk316v6eOO9rjEU/a5k3AAOPPnLAzC1XBCjVnf3BUztCvCMqyXMLdo
	ddPc4jEaXn/jg76nvpWyP1TcaR55ojhluRQr1MdBI68B5cDQwJex8AVdR8FEzGEHawwZle0rp7yUr
	jsKb4rgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1vb-003GD4-1Y;
	Tue, 12 Sep 2023 11:51:35 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1vZ-003GCL-2D
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:51:34 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c4e426714so99233766b.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694519492; x=1695124292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez5yOCgWh6+IdYt5V62xOCehHBvMW9ONvki2UtDHKRg=;
        b=pwSvN2WywDPRDO9UoB2/epIAqww0oglole1ixJ6Jir4CHKOve+VXKemSj8R7ligMbb
         d+6FLXZrZMqnbQ+QNPS8kT0DGHQwMz+oU0uupU68qDguGGQEKOQKO52vA8s9KX24OHeZ
         e7MOMWVchu0G9oKas6Q9uz7JnOFU2LlKThHKFK1H2XS73j1o2Soi3fyyCjt/yplgWGux
         52Wq1HOuo8XeIogQhqX4tZhRiM6e82TsY1DFizfEqhftngcnwfdMN4AjymBRo51MQq1b
         hRJ0jRLicJ4DGRCfxAAm//VwoxvPuBUfNmu8bHR+e2kGLXAt+3FB/FLcvpnf26LH70SR
         f8Zg==
X-Gm-Message-State: AOJu0Yz3JdhIOR3F4PQk2aGBOpaCZh9BFvyKpTTH1//IFq3gBqHoDmM5
	lPZ5gqn+XcjvJuLKpwIFQFPfUKU0yIw=
X-Google-Smtp-Source: AGHT+IGLJgw5Zkl9fc8mY7aVzqCOUo7mic4TehC0eDBONIeKeexrQfya1i22m8iahsVZmk/jpj4HPQ==
X-Received: by 2002:a17:906:7398:b0:9a1:ddcc:3a04 with SMTP id f24-20020a170906739800b009a1ddcc3a04mr10887610ejl.5.1694519491604;
        Tue, 12 Sep 2023 04:51:31 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ck8-20020a170906c44800b009a5f1d1564dsm6697163ejb.126.2023.09.12.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:51:29 -0700 (PDT)
Message-ID: <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
Date: Tue, 12 Sep 2023 14:51:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230908100049.80809-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_045133_721126_EF653315 
X-CRM114-Status: GOOD (  14.16  )
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

> Hi all,
> 
> there have been some very insistent reports of data corruption
> with certain target implementations due to command retries.

None of which were reported on this list...

> Problem here is that for TCP we're starting error recovery
> immediately after either a command timeout or a (local) link loss.

It does so only in one occasion, when the user triggered a
reset_controller. a command timeout is greater than the default
kato (6 times in fact), was this the case where the issue was
observed? If so, the timeout handler should probably just wait
the kato remaining time.

BTW, the same happens for rdma as well. Nothing should be
tcp specific here afaict.

