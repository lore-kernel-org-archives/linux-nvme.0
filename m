Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD372C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLr5/SgY566XLOgrt4eOm6X/hHzh+uL5CSJsfDweC+0=; b=08bCT3Sx0kSAekYzcECdMOzZyE
	BJbJ6y/x3Ai9k7jDUpI4SHHjj47Vdjc6/QrA/A5PGfj7nZSR1PAELunR8HITQ+Fmij8Yqp0a9HRpc
	a9jPDAJmoeJDyBEDpKTxv4xF6Marr4SpHwXcgtOxhVkdp83xje+N6Ue3vbcfTVxLinFzWTqyJz6G2
	pjvjlhjNHhxPHTz2gYgnkLAiN0XU4/CyTOMMB8f+/nkS2yZCurd+UvMVYpVFAUZS9sCEsoRAeiNsr
	ndPW3lgIQgl2v2BzuLc8VkeEA5euQYi+UBM4FJ0O67M+dfN3Q7X7eo6stPUFhaZ5EHGw0k2CkcIEx
	3w7qz8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHGR-0000000EUl7-2ljV;
	Fri, 24 Jan 2025 10:50:15 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHGO-0000000EUkf-3wOG
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 10:50:14 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436341f575fso20367125e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 02:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715811; x=1738320611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLr5/SgY566XLOgrt4eOm6X/hHzh+uL5CSJsfDweC+0=;
        b=RD7SkAlRYOUctJ72UInJ5wWlmxqfNab5mDYRZ3E2yNvXBRSU8Y+opYjKFe0oSZktI5
         iaxo+ix1g+G5mKYjaRTjUJwymJ2Y6uP02cXOcgZPvwbDo0L0ddyL7XFhUzY2tKWC7EaO
         a6O2bUDzVwUzaa6/MkoUIXRC06oGVcxmkC6AIgjzK12roiPnQcGJLLp9iwTRbRb7PgpW
         ZjkhMmkUm+o17nsXplQ/tKv72l3w27eHGjFnGfK/sW0A7aLhXJJayUFk6mUgOBl0ZzaE
         o133r/Xuw5HV6J3nnktAFm14VOEoex6FKfce3Pk8f5Z3w8yzhlhDW0xiFrOujHeBnDR6
         v9fA==
X-Forwarded-Encrypted: i=1; AJvYcCWJNFDUYABbPzZ+D9cFw3HC0vkAbUpjFRN9bghXocEUsnBM3fasFhZ8oit81kpyii0U29fRzFo1bfWj@lists.infradead.org
X-Gm-Message-State: AOJu0YxYUp11n/e+lTp2vTvZS1F9Nnwiwr0IHNhizsSt5cbR3Hbhoq9y
	9BmO/z1oNSVIEswYwsHJlrBEUM7BzgsbSsYcLnf+Nh3UII9n7F9Iu2R5UQ==
X-Gm-Gg: ASbGncsLuQ0tZt8rNm6ItuNsjbm90uec9PO2H9dDefA5reYky9jtsSGtY3QVRaggpok
	rkhpiWHenPDsYF1m7UWqdtx0NhHlA1TGaAgBOa3/aPL4iOOae6wxvK1z+mxAu2iPCcD7D3O3IWz
	dFFzUmhyqZ2qLREP3Jv5AHAgSAYl/uedsTeZgv3zOaPXW+knxHsIJuOi486n6XbRNH3SR8c2MSM
	td4eyiHJZD65OyuR8s+1xunWzcvp3U204S/Q4dL2xkfE2PYtWMjm/XTQarjRflSy49zxooqfsnp
	FLA92dm9pDctmK+dKlXS9FB91oRHupskcIpQy1r+
X-Google-Smtp-Source: AGHT+IGk/w9lCWh2ifkB5aJ6Uq/qf2CnnmdAnR6P40XOptc0MF4CBK5c8Th4KfFu1zuucvZ+JBRiqQ==
X-Received: by 2002:a5d:6c61:0:b0:385:fe66:9f32 with SMTP id ffacd0b85a97d-38bf57be5c1mr28509567f8f.52.1737715811049;
        Fri, 24 Jan 2025 02:50:11 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb057sm2324872f8f.62.2025.01.24.02.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 02:50:10 -0800 (PST)
Message-ID: <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
Date: Fri, 24 Jan 2025 12:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124082505.140258-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250124082505.140258-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_025012_988508_05184159 
X-CRM114-Status: UNSURE (   9.60  )
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




On 24/01/2025 10:25, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
>
> The namespace percpu counter protects pending I/O, and we can
> only safely diable the namespace once the counter drop to zero.
> So we need to init the percpu counter in nvmet_ns_enable(), and
> wait for it to drop to zero in nvmet_ns_disable() to avoid having
> I/O pending after the namespace has been disabled.
>
> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

Can you please describe the bug and scenario which you are hitting this bug?
It is also unclear how the above patch is causing this.

 From quick look patch itself looks reasonable.

