Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E6EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:To:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CIsFiJqV2tEMCnAcYp33/wtQ4Ay+7UUrLP1K9taZuhA=; b=jjHCnksXOthYL8yxGZpa+kbROC
	4e4/YW9R+DwMtWGV1pe/akhwFY3LgyhyAbUi4uN6uuCm4ApY/UcG7RVG2lz4E/qw8TnGmlIgzK7k6
	EB58si7EeKmAZQgUh5a8bUHJcPmiKTdIB5TzH/8AP0ssp4Xe2KpwskqWRCLZLuHRkjYXUsgMcwS5Q
	+0ExzspZQ2ihosDiToQnb54w+XAIjQ7vcr/Y0yQT2YJtE24S9dZHrPyXqbHP7N3Sst/rHfTQger+Y
	KTOJisjhvUXqhPxk5b26eNIJLwbvB1kRKpmfCxArN3+OvGWM+e0sIb4rJSmUeEsHBnKfOMimuUGRl
	l3rZZwZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nznKQ-00AEd1-66; Fri, 10 Jun 2022 22:42:06 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nznKN-00AEcB-Rn
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 22:42:05 +0000
Received: by mail-wr1-x429.google.com with SMTP id c21so329532wrb.1
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:references
         :content-language:from:subject:in-reply-to:content-transfer-encoding;
        bh=CIsFiJqV2tEMCnAcYp33/wtQ4Ay+7UUrLP1K9taZuhA=;
        b=f6yLfseZ7BJF05Dj21AsyKXgxRVzQW02VIAUIoBhnhDlUn1IGv7wS77oiRQz9A7fLg
         rQ1zXEEL/ZrAi1BvCnLgiGrbt+uHTQnfoYcLDFDdQlQw5wOueN+sKu0CMiHo3j9FLadS
         V/8wQMBkZiu+KiaUXXGSM559AF+yR4RallZC3nGLzZdjs+v9Rdw+zPMkBTc6rbxv4K1g
         YicI1IvpiquievpaoT5sahSuNInthWNQkOGQ/gxPkPEK6uGD8MmDVfTl7TpYMRb6//3c
         /Dr/7H1RjXaVAqvMdZYAH10MqJx2FT/WQd379iTe9czqApPWRk3lH8mqIbO5JV8y6ufc
         aW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :references:content-language:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CIsFiJqV2tEMCnAcYp33/wtQ4Ay+7UUrLP1K9taZuhA=;
        b=c8+lOcSForC9zdu6r4mp8k9OWul3PQA7w6nysoj/pmmvTVMkGB5fxxZBPRze7uSEeJ
         7uc69oR0WS0hStcpR4kfxgyKMAdw0PSOcohBHD8joJ73MI2lnysBdzbM66GolgQqsUS4
         1yEGHY8eUQp3dAYr50REyzvL5bWfqIv1/+8IqGk9M6xokOfuqUK5ZV3vqTKBBSlzP4iz
         9np1XVrafu9rEdnVe+FvR/GmHhWpE8V7Reu0rQhKMRUb1Joa7OaYC6DbLi+6QYyTrrxI
         uxrLXEYejZ93CdF3hVVrVlwYOg95D1cJsW6F/B2SJTjF7k87mC+ungOScDT5ztb1kQ7f
         HZaw==
X-Gm-Message-State: AOAM532e+fMpZT/CbpcbAnA1UNjsl9w0tEJV+Ox+EQ44BW9d1EbyEjqn
	eoAR7gcvXfv825UKjYbyvluONc5ezeM=
X-Google-Smtp-Source: ABdhPJy2Fja3mY1rlq0FrtmC7+5OgBh1PHBdpqZy1yrna7LtCbjg4dOIwlBO8+p8Yb+w+sRdBT85jw==
X-Received: by 2002:adf:d1ca:0:b0:218:47c0:c4d2 with SMTP id b10-20020adfd1ca000000b0021847c0c4d2mr25287120wrd.639.1654900920625;
        Fri, 10 Jun 2022 15:42:00 -0700 (PDT)
Received: from [192.168.0.53] (77-254-6-105.adsl.inetia.pl. [77.254.6.105])
        by smtp.gmail.com with ESMTPSA id c16-20020adfed90000000b0020ff877cfbdsm590281wro.87.2022.06.10.15.41.59
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 15:42:00 -0700 (PDT)
Message-ID: <c2c1d203-2bb8-9959-02fd-7e8db65d5446@gmail.com>
Date: Sat, 11 Jun 2022 00:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To: linux-nvme@lists.infradead.org
References: <20220603114303.GA14056@lst.de>
Content-Language: en-US
From: Kamil Cukrowski <kamilcukrowski@gmail.com>
Subject: Re: bug report: one of /dev/nvme*n1 is not created on 5.18.1
 "globally duplicate IDs for nsid"
In-Reply-To: <20220603114303.GA14056@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_154203_968107_9D11D925 
X-CRM114-Status: UNSURE (   7.41  )
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

Is the identifier part of the nvme discs or part of the pcie<->nvme 
converter? I.e. does buying a different converter will workaround the 
issue? Should I complain to the vendor of the disc (Goodram) or of the 
pcie<->nvme converter or the chip from lspci (Silicon Motion)?

The output of lspci -nn :
$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 2nd Generation Core 
Processor Family DRAM Controller [8086:0100] (rev 09)
00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200/2nd Generation 
Core Processor Family PCI Express Root Port [8086:0101] (rev 09)
00:14.0 USB controller [0c03]: Intel Corporation 7 Series/C210 Series 
Chipset Family USB xHCI Host Controller [8086:1e31] (rev 04)
00:16.0 Communication controller [0780]: Intel Corporation 7 Series/C216 
Chipset Family MEI Controller #1 [8086:1e3a] (rev 04)
00:16.3 Serial controller [0700]: Intel Corporation 7 Series/C210 Series 
Chipset Family KT Controller [8086:1e3d] (rev 04)
00:19.0 Ethernet controller [0200]: Intel Corporation 82579LM Gigabit 
Network Connection (Lewisville) [8086:1502] (rev 04)
00:1a.0 USB controller [0c03]: Intel Corporation 7 Series/C216 Chipset 
Family USB Enhanced Host Controller #2 [8086:1e2d] (rev 04)
00:1b.0 Audio device [0403]: Intel Corporation 7 Series/C216 Chipset 
Family High Definition Audio Controller [8086:1e20] (rev 04)
00:1c.0 PCI bridge [0604]: Intel Corporation 7 Series/C216 Chipset 
Family PCI Express Root Port 1 [8086:1e10] (rev c4)
00:1c.4 PCI bridge [0604]: Intel Corporation 7 Series/C210 Series 
Chipset Family PCI Express Root Port 5 [8086:1e18] (rev c4)
00:1d.0 USB controller [0c03]: Intel Corporation 7 Series/C216 Chipset 
Family USB Enhanced Host Controller #1 [8086:1e26] (rev 04)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge 
[8086:244e] (rev a4)
00:1f.0 ISA bridge [0601]: Intel Corporation Q77 Express Chipset LPC 
Controller [8086:1e47] (rev 04)
00:1f.2 SATA controller [0106]: Intel Corporation 7 Series/C210 Series 
Chipset Family 6-port SATA Controller [AHCI mode] [8086:1e02] (rev 04)
00:1f.3 SMBus [0c05]: Intel Corporation 7 Series/C216 Chipset Family 
SMBus Controller [8086:1e22] (rev 04)
00:1f.6 Signal processing controller [1180]: Intel Corporation 7 
Series/C210 Series Chipset Family Thermal Management Controller 
[8086:1e24] (rev 04)
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GP107 
[GeForce GTX 1050 Ti] [10de:1c82] (rev a1)
01:00.1 Audio device [0403]: NVIDIA Corporation GP107GL High Definition 
Audio Controller [10de:0fb9] (rev a1)
02:00.0 Non-Volatile memory controller [0108]: Silicon Motion, Inc. 
SM2263EN/SM2263XT SSD Controller [126f:2263] (rev 03)
03:00.0 Non-Volatile memory controller [0108]: Silicon Motion, Inc. 
SM2263EN/SM2263XT SSD Controller [126f:2263] (rev 03)

Thanks!

