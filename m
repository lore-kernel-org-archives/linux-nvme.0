Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7615DC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=v4veiXHSd77TQGgK0KzIGmWIM8
	NXOTv7tXPzFQp3oMfRspuJ+yY1aJ/3UW0/oG4d+PJJcQyGt6suoIX6+7Yh42DTunUcM/E1o0HYClp
	qbApBwMw5TnnPDbQgPXnYDifZRZ5i4H0prEQPW3k4IyJBDqRibIIuV3cDBA0gLoQ4AguAq3Tv9PrZ
	MapqNzdD7HUIGtxgixgagZ0M73Kk35299BgDxNJt7diU/gCKJqsufBJYXdCX0tdqIv03Xaca6PUoI
	dgupAuCnkG2q2GUJn+OAvmOeKwm5iRxK5SZVMqxXVkU4g6F6ERJkCXvAUxBc8/NnXPlwoLGu4WhN/
	go5hFEvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkui-0000000G4vI-2tC3;
	Tue, 30 Jan 2024 10:00:20 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkug-0000000G4u2-0jYF
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 10:00:19 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e5980e1b8so7368855e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 02:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608816; x=1707213616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=J2waVQEwnMcUQHLejWBpF0FMUi06xQ6/k953fv3cEp0JM5p6EiwiWJziE3zAIEpbml
         qBrgs0pd69XPUkTXR1j3ucYJekGIgtQwN23bXNxfWkOTErBGAB+NjgMztQ/fB/PmxPMu
         NOs0IQ0UDXq2khB/8Ve7d6ukTNo0Ir21zGUABO89e47/9O3fsXOtaR0+aweb/NSLX1U2
         JJQFi4hKTaC14hJI4KARdgVdtKxmOSzhTIPXiGDfRHcS5XQyeiPQqdXXUvyNpfIHJ1AD
         mAZQKEA6dDZsHnn/GRelahGB+ewLlR4w4hwF4b3YTvMXl8suYFDPbAsMWiM584jdwWv/
         FY3Q==
X-Gm-Message-State: AOJu0Yw5F7H+GLaOpbbjNYK9ujZJXnV1jrRb/GupKmtjSgHcOqq7epLc
	lfBFNPCtRLlJwLX792jVhGwxrvLsbeRAmne6roxyB+pcmNoVJXT2nAsVfSra
X-Google-Smtp-Source: AGHT+IHbkvuSZtiT1ehS/7VgeDtOLlXgtCYRCgXI2dZtAjftoA+PKOI7rmC9n6/MARWXQ+dRfChKBw==
X-Received: by 2002:a05:600c:5185:b0:40e:f9ff:f80a with SMTP id fa5-20020a05600c518500b0040ef9fff80amr3011460wmb.0.1706608815482;
        Tue, 30 Jan 2024 02:00:15 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bt4-20020a056000080400b0033ae6e9faebsm7422419wrb.4.2024.01.30.02.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:00:15 -0800 (PST)
Message-ID: <1d9eba3c-739f-414e-9e25-b86f4609f143@grimberg.me>
Date: Tue, 30 Jan 2024 12:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown.
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-2-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129181953.1183084-2-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_020018_217916_D3FFDF9F 
X-CRM114-Status: UNSURE (   5.27  )
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

