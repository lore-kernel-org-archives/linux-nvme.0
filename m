Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E3C25B78
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmQkvo1QjqVqq/0mlyFtK3ja/SzWD411cFlsyivogBw=; b=ZOfq64VWbRDvQfyjkDLzXYXN33
	kXkJGxZ1EYfw2F+/8wn0M84f2IQFNY3+VhkzfgFzk6ZFD92Bl3vRJpn/m74SMa7cbJJEU/lbF6H8h
	ctzaIRzwTRk6eBEopUM2BufoGiSuRluVftFXjzmcHqawR6lj7R6V+iw1eGKFt2HVMgnUddBW9IQgY
	Osrlszc8NSU2/DlJPdPP5ww3Q/xdr64gt+nmSur+yCI5b7Hj3UXITkGjj9CCxj+//KEp4vV3pQi8n
	+iyd070CNXVs/CR9J/zZKTV98YF/KYq2Kr7CBVlXpiblV0yMngAM4audI4+XieLs1uW3ZLSjs+6As
	dPY/WulA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVW4-00000002omt-0rY0;
	Tue, 04 Jun 2024 14:52:00 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEVW0-00000002oln-37Ep
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 14:51:58 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42111c2892bso6685895e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 07:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512714; x=1718117514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmQkvo1QjqVqq/0mlyFtK3ja/SzWD411cFlsyivogBw=;
        b=PxbHJv10+BFTRJ9mBTiqIAiCxjLV3AoNYExyr8/ZC0SQxTbazcjaTy4ySz1TYkB/mb
         hXQiZ2g+ZVUoSf2akZMbqfXun/bIQGAFy2rv6rVd+P47qYgEeuRm5/eLA/ceSn9gFQet
         BrLl65TZVi1iQUb7FBiJkfExlyQcUSmba9+v9yGEDcF3SrwMnCEZ9VYUwRVzEy/JM8KP
         Lu4V9U0V9/cpfu3PMgOH/El8z8NtdoTpFAnWvPUBZYU1Ndit/eC5c4ZvNe6pgkCJtcHN
         EBh+HYsyMH3KWJ3admTVdcmo+uZh+5fgLUSzE06/3CsDoBu3nSQLBqnIt8O3GdXb5egv
         3AKw==
X-Forwarded-Encrypted: i=1; AJvYcCX1zakuIf9ej5jSQqBfXv2CdyrvbXYR4tWzKtoL2NmKZX0589koWNHFsV7leKQezDadus1AlUQKQz+SwFGc4URxbaXKfnyT22C6TLzMuS4=
X-Gm-Message-State: AOJu0Yyg0VPIM7uu+yK06w/CPUWo1T6+G0UBudW8t6HbPVZzHUUWVvaB
	kj6hCKrYTLNpxkqzKqQ9kuAWd/DDUtLJATVO9XxQF1Xj0m1DtYl6Ma7dDU+Z
X-Google-Smtp-Source: AGHT+IEkY5sRX3+t87P+ABX81sgD7xGiud+cEpPzXFP7Zr/2rSr4XoYF9dp0mIEtDdIRYcM1mjpAcA==
X-Received: by 2002:a5d:6842:0:b0:358:a09:2677 with SMTP id ffacd0b85a97d-35e0f259161mr9152207f8f.2.1717512713557;
        Tue, 04 Jun 2024 07:51:53 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b5e9sm11811486f8f.96.2024.06.04.07.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:51:53 -0700 (PDT)
Message-ID: <3d4595ff-5f45-458e-81f4-7ed513d9f725@grimberg.me>
Date: Tue, 4 Jun 2024 17:51:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-RFC 0/5] nvme: fix initialization memleak
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, mlombard@redhat.com, hare@suse.de,
 shinichiro.kawasaki@wdc.com, Keith Busch <kbusch@kernel.org>
References: <20240603230524.3854115-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_075156_810622_0680037A 
X-CRM114-Status: UNSURE (   6.81  )
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



On 04/06/2024 2:05, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> The pci driver is the only one runtime tested. Everything else is
> compile tested, except for apple.
>
>
> Keith Busch (5):
>    nvme: apple: fix device reference counting
>    nvme: tcp: split controller bringup handling
>    nvme: rdma: split controller bringup handling
>    nvme: fc: split controller bringup handling

For some reason patches 3,4 got lost from my inbox...

I'll wait for your v1.

