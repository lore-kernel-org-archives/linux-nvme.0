Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08852C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 08:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7SVLNCTur58grG9xBNQd/ZGYHPub/Chm8ihudqPDQA=; b=uXin4OrNaSlZUw49HhZ1La04zx
	b/tiuoEdxmGrLYsHDuQ373r0sc+AKiHeH4vWty15eBW5M9/HualreCt2WbAHv64QkNCuM0zQvzzg1
	Dbpb2NiSb2H0Se+Ydji1/x2t0CgDcR9xXiqddN4XiRAqvxIE7g34AECNRg+aiQOW3GRVvHSHzb2uk
	y+kZFFLo+9hs2ucy9y9n+MFfH5VvT4yxNk6kF6IqE/U2EADhwVY22wo1mF9kMbq3N/znPKvm5iMj1
	s/x9NUAo6BgK0UagmQ2OP5EkjJbJ1adFwlC+4qItKuOFBqkv/FYI5/WFnvwBoFgB+QpU0oxYVLEAh
	Zbi7a8zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgip-00000004LsF-2uDx;
	Tue, 28 Jan 2025 08:13:23 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcggu-00000004LDa-0hzq
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 08:11:25 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436a39e4891so35273395e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jan 2025 00:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738051882; x=1738656682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7SVLNCTur58grG9xBNQd/ZGYHPub/Chm8ihudqPDQA=;
        b=QuRe0BE9HBZ7eTNndjONUTl6sO1PTRXEtnemYqiYT1kHuXV+I89IVB3T/Em2oyq5NL
         7bOcbTobTX+3WsHbGixVyJGzYB4igsazI1Su+woERZRNLtCJ4o0xlYEYjP9pid525wRC
         3hlGS8hK1OmffqcguF7QfTw6ah3xvxZUOUxIHfm8oMIWqRqE9Nm7LQUZVBlJVZwWNyIX
         C/8xMaLxNca3B+xkbsuZounQRn9pKLTdlRuFr51cnIqb+f/IPAvHoXshiy5yRmEaN2iL
         5x1a/wuT05KjTsM55snhxN47FGzb3gFKgoR/4nNgm0t9OlCeBQTJpcBAs/XQ/KqHYxkk
         U5kw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Svg81r3LgHef72N+pEb4jbUvXiZtD400+Ikhhn8jldb2H4V7msHM9YDzj/eGJN9cDILtIDwTcVsp@lists.infradead.org
X-Gm-Message-State: AOJu0Yyw3vQNuxPPgWXphfWbCrjsAT9urSxi4+h/6QTezD+Pu6Ll86gQ
	7huVgw66rxHrzdgEGFlPBuYMJik69YX1JUWWwVZZ92fv+Bg6B8tQkDcdAg==
X-Gm-Gg: ASbGncuClP1J9vp6jtWXhm7f4sevheRzDqGC1jb4sMeM1HrrSuiM0UWrP0am/S+nyo3
	5BT5KUSeWFTxROYSqCHQVzXJ8tzFR/C5anQuLvATO5lEvBtjWDGXCjv8DJR4yQN1hRRyYm62MEX
	Qv8z24zxRhlFk19ObXQ65Pn5cyrf3e1do2t4sBKzlLfzTRTo6MSql4ieMC4zk34dJJFEcm6QzCG
	bJYb0XSI6paKbz4xnKc5p6Rb02Dvb6N2/L095VTggnmH1xjNehw/a1v+IPG/jOGMyd417Q6pHpO
	pa6RrgbWSqcPZRN20cywlnk1bBV4bxz8hCGDeI6l8W+8dQD+e1tn3u/VWg==
X-Google-Smtp-Source: AGHT+IEy3fc31iaMrv3wo+WAiuAQEYQ8hfCy0U3c0M0m0kaccwhAc2gDyTNOselnW0xZzY0NbdxdwA==
X-Received: by 2002:a05:600c:3d06:b0:434:eb73:b0c0 with SMTP id 5b1f17b1804b1-438913c7e31mr426868995e9.5.1738051882432;
        Tue, 28 Jan 2025 00:11:22 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501f1esm159590945e9.12.2025.01.28.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 00:11:22 -0800 (PST)
Message-ID: <6c4f6fb5-d3a1-4674-902a-6719cbb8b13f@grimberg.me>
Date: Tue, 28 Jan 2025 10:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: Implement 'admin_only' authentication
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250124114738.115882-1-hare@kernel.org>
 <20250124114738.115882-2-hare@kernel.org>
 <6d74b77d-df2a-4622-8acb-3e5ac74be4d6@grimberg.me>
 <3a6370c2-75c6-43ef-860e-979c714abfc1@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3a6370c2-75c6-43ef-860e-979c714abfc1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_001124_214062_A51E1DA3 
X-CRM114-Status: GOOD (  13.14  )
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


> On 1/24/25 14:49, Sagi Grimberg wrote:
>>
>>
>>
>> On 24/01/2025 13:47, hare@kernel.org wrote:
>>> From: Hannes Reinecke <hare@kernel.org>
>>>
>>> The spec allows for authentication to run on admin queues only, and 
>>> secure
>>> concatenation even requires it. So add a configfs attribute 
>>> 'dhchap_admin_only'
>>> to the target configuration to allow for testing independently of 
>>> secure
>>> concatenation.
>>
>> Why do we want it conditionally? why not always?
>
> Because we did support it originally, so I thought to play it safe.
> Plus it'll cause a regression with the host implementation if applied
> on its own.
>
> But if you say so ...

I'd like to avoid the extra configuration if possible, however we cannot 
break
existing hosts.

Is there a way to not authenticate I/O queues but still allow it?

