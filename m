Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F2C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 07:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZsha9LzM9FqRRtEmBdm7U5OjwyiUlgYFuCNORI53G4=; b=2UdPy/P7oIIv1IURuNTYTELCJj
	RVVwYXYrLCINpIDQ/iWAejmpaB0c2BlzwV/NX3bCPvCY2bxknGJKxUHfMBf0GrBUMUtm4xT8BxLkX
	AUB4A0C1Kvh20hMSJ28Jew3AT/LySB8sKyfMPzkhiAtIm0tx5Qo59RXoQli8B4BZFRZ/ClmxHaNTY
	Pu+7j96RHbE6eId7sxpcWehJzQynsdsvOuEJaVcDq3yczUahg485/tbxdF5OQoZkAQCJku5/01IQ2
	nq1wzN7e/SgV8MeoPQJlv2/OkuHvATWBzKFVJbAI9SQhEAuKX4DV3mOodIbdeOaFFAoJZRyNI+1a4
	I2F7HqfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKZgA-007ICO-09;
	Tue, 02 Jan 2024 07:59:14 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKZg7-007IBM-0M
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 07:59:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5d9adf6eso10505445e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 23:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704182347; x=1704787147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZsha9LzM9FqRRtEmBdm7U5OjwyiUlgYFuCNORI53G4=;
        b=R6gf51uST8y+f/z4xOa2FcBOyIuxREsLJ6W5Pp0lDs1YbkmGRyADQOi6u0g0E6WyUX
         7qiDD8OgQZgnqi71uQVsyMhKuAFSQ40yhkt6/gLboJ6Z3qquRJuYEAtuzxeyc+f/u7K2
         +PfmeNzjtP+Z06k8yql9jg0bzuN/gc7CQUW0LcXoYZry5bTQcsRG9nqDlhC8Ah4dKhEy
         TO/ZgEH/m7Vjm71Nkh6aPn/sUqlMbduXR2IqP64KbnSldxe1Q9keykCguTon/BHmiZcu
         zHDMah7+SRg07lF/bCcMIaoq9pb7mAgVufDhaoWAD8ZZ2X6qOsArtm7f7saB8HEWhRFk
         ur/w==
X-Gm-Message-State: AOJu0YwRq9xcj7Y7k0wrvr8GQMH013qKhG1DSgXK/u0JHLbwF+6xP+NU
	qDj8l1VtyPE2YLUTWbtoetU=
X-Google-Smtp-Source: AGHT+IGyRwsyjjnkGSkbUk39GfB/aNGu0qngyl4OvT/q3GXkAqB+pL5V8rRHcz6GWhJsT2+i7poyMA==
X-Received: by 2002:a05:600c:1c07:b0:40d:3dfb:1cbe with SMTP id j7-20020a05600c1c0700b0040d3dfb1cbemr21036814wms.2.1704182347087;
        Mon, 01 Jan 2024 23:59:07 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b0040d6e07a147sm17522081wmb.23.2024.01.01.23.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 23:59:06 -0800 (PST)
Message-ID: <5605f644-9a41-46ff-8b89-80b74b46928c@grimberg.me>
Date: Tue, 2 Jan 2024 09:59:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nvme-rdma: clamp queue size according to ctrl cap
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-9-mgurtovoy@nvidia.com>
 <764288fe-0a62-4c22-9f10-307d5a156239@grimberg.me>
 <1633aed8-47d3-4998-b2a8-394783adf899@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1633aed8-47d3-4998-b2a8-394783adf899@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_235911_177066_228C65B3 
X-CRM114-Status: GOOD (  10.23  )
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


>>> If a controller is configured with metadata support, clamp the maximal
>>> queue size to be 128 since there are more resources that are needed
>>> for metadata operations. Otherwise, clamp it to 256.
>>
>> Does the qp allocation succeeds or fails if attempting to create
>> 256 size with metadata?
> 
> It succeeds (tried ConnectX-4 and ConnectX-6 dx), but there are a lot of 
> metadata resources we allocate so the scale will be lower. I don't see a 
> reason to allocate more than 128 entries for metadata controllers.

Me neither, it would have been nice to get this information from the
rdma core though.

