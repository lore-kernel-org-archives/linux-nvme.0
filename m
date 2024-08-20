Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B46C531DC
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 13:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5Ym9Qp9E7MfCV7To+0JD5zEyWK3hbZwW9g9lElnKZ8=; b=qnC0VKo7lMruHiAn8UyQfcO2AN
	1E0z3sFnOcz6Q2M7BDokUA2a2k4XlkK6yTDgxSBTRugMlJLHevzXJf3V+3so/lwRNx0TD9xSmAUTJ
	IJON4vdTcHTtnu9UHYSlFMbLoYCMSJPALUbFwhkfVm0dmIa/d4aUGZ66QQrTTLAOAP6wCOhIlEz4K
	iJvH59AQ08pFpu8eCl6L/wTJTjYqvXLPGyWtwwj5+G2y1p4brseMm8ki91n1yD9bQ0/4qQg/9T5lj
	pZgeSiVM+7WXarGKuR0liAJOu032f9h6V8mRthCgBAXJLrfWwSV5lLEe6mx6kW5gDvMMlSKNhfZA5
	U0gYhPFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgOrj-00000005Lix-0fKo;
	Tue, 20 Aug 2024 13:25:39 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgOrf-00000005LgD-2KnH
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 13:25:37 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428243f928cso44320315e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 Aug 2024 06:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160332; x=1724765132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5Ym9Qp9E7MfCV7To+0JD5zEyWK3hbZwW9g9lElnKZ8=;
        b=l31Y6F+EraDqz5AMEYnO8e6xYMhOcu4QlzAb0gpdbD+JBgrGNTpFx0hZp3v9mkOt07
         bSv1PoNnedlgjR4SR/1XE3q18LTPHfhwshCdpXM/6tGpi90AeLnzeWvZqYfDLDnXs4ub
         HMYUaUzcpySEWTZo8MO//0xT9Xlpqe9+5qIbCHNHKvcXlED4dGxW5um6zWbnaOM+qBxf
         +q8xAv/oLdZpUeDMf6SH6nzOqa1L+jmHtBl/VL2xIrYt+iy3SqNPl9zdS2k4dCwlkQkQ
         LFLJCFqMbi5HQdt8CUFv5jY486fgxawrVwNN6IotH3JgNA9o9HHgeWy5y4sqXuYjZ34h
         tszw==
X-Forwarded-Encrypted: i=1; AJvYcCUYHJplbfmiQ7xYQx7oZqG9xOpgukfQeqi9cOtRRWxlp7EkbikgnnAvZKDNOY6MtZ0aoHwXfhFyP1cK@lists.infradead.org
X-Gm-Message-State: AOJu0YxxaHq4RJ+7ErP3y40Ptl1S94CxmIVyXho/JW6b+JqYJejsBIAe
	fI/wRN5whbEbmky9N1iJWwvDl4x2J4GNdUX3N0w/kRtmSZxCesj9
X-Google-Smtp-Source: AGHT+IFdxEjJMgEHLXLrPGLfXpXOEV5/QGDrBGNyQVng/5t3XQZfSCGwI7NCuzcoIhEDRN9zrOZYWg==
X-Received: by 2002:adf:ea87:0:b0:371:87d4:8f23 with SMTP id ffacd0b85a97d-371946c2fbamr7784796f8f.58.1724160331875;
        Tue, 20 Aug 2024 06:25:31 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm195253095e9.43.2024.08.20.06.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:25:31 -0700 (PDT)
Message-ID: <bc54be12-b7d6-42a6-9afe-298422b89046@grimberg.me>
Date: Tue, 20 Aug 2024 16:25:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] IRQ Affinity Setup for NVMe over Fabrics (RDMA) Target
 and Host
To: Jigao LUO <jigao.luo@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <GV1P195MB2055FBE89BC74CF83305CF40EE8C2@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <GV1P195MB2055FBE89BC74CF83305CF40EE8C2@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_062535_642875_8C5A9065 
X-CRM114-Status: GOOD (  14.68  )
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




On 19/08/2024 15:48, Jigao LUO wrote:
> Hi everyone,

Hey,

> I’m currently benchmarking NVMe over Fabrics (RDMA) using the Linux kernel driver and would appreciate your guidance on setting up IRQ affinity for optimal performance.
>
> - **Target Side**: It is logical to place both the NIC and SSDs within the same NUMA node to minimize latency, and to pin the IRQs to cores within this NUMA node. However, I'm unsure about the optimal number of cores that should be dedicated to handling IRQs. Are there any guidelines or best practices for determining this?

Steering the IRQ vectors to cpu cores on the same numa as the backend 
SSDs is definitely desirable if possible.
How much is hard to say. The more cores you spread the vectors among, 
the better. If you are trying to host other workloads along side nvmet-rdma,
then it depends on what are you optimizing for (as well as the platform 
you are using).

>
> - **Host Side**: Most of my questions relate to the host configuration. Assuming we are running fio on the host, my understanding is that both fio and IRQs should be on the NUMA node where the NIC is located. Should fio and IRQs share the same set of cores, or is it recommended to separate them with two isolated core sets? Additionally, what would be the recommended number of cores to allocate for IRQ handling in this scenario?

The nvme host design is where submission-completion are cpu local as 
much as possible, such that multiple threads/workloads do not interfere 
with each other and provide good scalability.
If you have prior knowledge of you workload, you may prefer to dedicate 
some cores for completion processing and have the associated load 
removed from the cores that are submitting I/O.
I don't know of any specific guideline on how one would arrange the 
cores and IRQ vectors to optimize any given workload. Empirical tests 
may guide you.

