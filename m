Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF5C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9c/pj/j5xFxHGCDH5tv7UdWTKPmNbapbSdHYVJNeS44=; b=HIrtozNM7VBjFQjjQZsdUm1d79
	Tj0hsGgvsvN/Tj2k6TGhPY0fkR7Igd3ARY0XwvsGArPMeEmGi3gZHsMoBcQ2CkJpV9olGTFESfyto
	nuQuwvf9D+t6dvuLLNcmI4qJi8lduLWztsHqgGir3AbpMYhR+0Qn0tXL59+sOTixN6xfKO2d+RXoY
	mPEc2yo6r82xQBF381NNVknIygjOsgLw5pU6Y6U/K3ztMt1nxPFDnXVRmxs6mG2DaG2kI57NqYtKN
	iGuN8448dh0jbBa6R+TyQ5Oh39orICwTfGrDGD16M5k9ODUTDKxBm1WkH7eiS314kSoLhJL/5zAWX
	WOLfemig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSym-0000000725y-0LVy;
	Wed, 26 Jun 2024 13:46:32 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSyi-0000000725E-39t7
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 13:46:31 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4212b102935so6158225e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 06:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409587; x=1720014387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9c/pj/j5xFxHGCDH5tv7UdWTKPmNbapbSdHYVJNeS44=;
        b=YN0xs+dx/xAzqRUotjDd3hISVqzK2p80pLa/gN9JM5fsMLDmxnowG3jSbWdGQ03yw6
         6F+WCl9nCC4SbINxptvtmvlFTevPyljgizhgXmLDQH+ePCLmE8NTpEqLRX5QVVmzqOhh
         9/FTQU0UhjZVMCJuDaWN33/8glJnU2t212RCn05d4Uay1fAUN+P5L4PnCMKezx9vuYeX
         f6oKpHJQQqsLTod79S+kta72zMMSGJ6qZu9Q8IFFVFiT/Te49iNrVAM+yCT58hqvLGjX
         TcR4021ffKnh4cdgxNoOs6g5Vt1ItWytPZY7RYixeKRSm1c20cTmqR4bBoMYl6hLF0Vn
         Y6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUaQAkM7GPU1CAogd5ab6+t+Su8rsJNZjQoEtV48TtEE2cm05UQif2YkSGPJpsWdBD1rBGKnNLY4tObOVxHmQr8mI41xOyyR6vDg3fflD8=
X-Gm-Message-State: AOJu0Yy4A4szgy7XH2SzQp3Vb43UcRVaFHtf1aQMdYRa09uH0RQ2l4Ih
	P7dmpoHdfmTXy9DLZ/goNvJ8twWW6t/6GGPB47zmNNuLRTcGC5qyAuaPIg==
X-Google-Smtp-Source: AGHT+IGuvlY8d7buZcMTT/5/G+Ccyb0lNHSJ/jfoB1UJtU+/FBD29o9fGA3TeZNr7vsV0mX6vxWoEg==
X-Received: by 2002:a05:6000:186e:b0:360:89ff:350f with SMTP id ffacd0b85a97d-366dfa3bb87mr9605181f8f.5.1719409587102;
        Wed, 26 Jun 2024 06:46:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8597sm15810962f8f.36.2024.06.26.06.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:46:26 -0700 (PDT)
Message-ID: <fe77e1a4-63bc-4038-a290-24ecc5028162@grimberg.me>
Date: Wed, 26 Jun 2024 16:46:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] nvme-tcp: make softirq_rx the default
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240626121347.1116-1-hare@kernel.org>
 <20240626121347.1116-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240626121347.1116-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_064629_376884_137F7888 
X-CRM114-Status: UNSURE (   6.41  )
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



On 26/06/2024 15:13, Hannes Reinecke wrote:
> Remove the 'softirq_rx' parameter and make it the default.

What improvement have you seen from it?
Was there a workload that suffered from this?
Should we even keep it as an option or just make it
the only behavior?

