Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D9FC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=1CGxYqyQzuWi7AAO0SIXvjIbqo
	lGtsn6sbiqZNFLMfuvZ4G/DrMDeL9yKbmYq/jPZoWu5mekcu4qx++JZKQ16sogPqbcYCGtGqkTBVa
	VrLEhqDXDr0iR5u0v6bk3j+cn9KdN55sti3BHE40mB2spzEo9LCZyQTbiE3wPQmoc/vVxieRcyjQ1
	tRjCN3vplq+uemPT54vuhxNrdKmf+rSoUiRhErjR6FKm9ose+nVaruf5Hti1NHb2Bb2/SXAmIBscl
	5sRZL+aYVHW3C+yz8pYPCIMAqw2W7kguKe6Nj7+alh+GyWfisaXdXU2vPGcIQ39icTZeSpfeDxkzc
	ogwj8AkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rASGb-006usu-0q;
	Tue, 05 Dec 2023 10:03:01 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rASGZ-006urz-0I
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 10:03:00 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b4ff0f254so10091025e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 05 Dec 2023 02:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701770577; x=1702375377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O+PZnMCJYO2/I4Sdwp/G5URF4GaOYEqXx5dXB0TT6d/G1JE5BVEDOout6hC06c9Ccy
         uCznbrM+w+NwwhWJpJdUg8tsA+rhfPbtdjgCRT4N7NY5WrTiatFwTLy53kgAtLi1Kgk7
         7MfDI6iQO2B8wzsIkbyTx1HdY9aAR2YroaQZgLOtntzU4868p8ZjBcU2YFS06eUPKvGD
         TPTGCwvKs5gEZHhSWZjelhoGCOkPehKTt1s9JfFQFiyUHM0+USkOUTbsGD4VoPsHKMaH
         KJfRcrx/pT7/Uo4obf/SeYRMlAS8r660t0AHFIx4RxfXbmdYSaoS8XhPHqNhEuul/L9c
         0zEw==
X-Gm-Message-State: AOJu0YwvgONfjcJnR+lp2ffOn8NyO83srWFpk/Tgxm+qGO90I4rXw4BD
	WX/4GGbyymJ2ZaOdY93U9Ss=
X-Google-Smtp-Source: AGHT+IEEYLjCANN8vxbYzasNpkJ8eJ5bo2auzqF9J04kQi+RU+LnJyMC1NwyeymZA2F1ISHL20JLDA==
X-Received: by 2002:a05:600c:2102:b0:40b:516a:3856 with SMTP id u2-20020a05600c210200b0040b516a3856mr10501572wml.1.1701770577071;
        Tue, 05 Dec 2023 02:02:57 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k13-20020adfe8cd000000b003333c2c313bsm8339592wrn.100.2023.12.05.02.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 02:02:56 -0800 (PST)
Message-ID: <80ef0e78-7558-4ed7-814f-1093c1cd2c0d@grimberg.me>
Date: Tue, 5 Dec 2023 12:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-fabrics: check ioccsz and iorcsz
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <1701761860-17623-1-git-send-email-kanie@linux.alibaba.com>
 <1701761860-17623-2-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1701761860-17623-2-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_020259_123564_66017986 
X-CRM114-Status: UNSURE (   4.51  )
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

