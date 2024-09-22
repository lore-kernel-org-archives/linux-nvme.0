Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88ABCF9C64
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ntcecgTamSRvXmX8hmdRwZR8rXRGFJQbjibcgGWlcYA=; b=kOU3TGnU7knAU9+xNWToVgGWeo
	j4+HAvz0NfISX4CgrU+vVFp6kss/4aorxW83eSQ5wUaSgSKwcUdONolfBFa46dhduZqa80nMjRI+E
	bpp+wscooCdKtMDolhh5igFHkfOsqhjuYNZaJZHc7QJp9XeobVVNUhgdpb0OUfjQV63ZsIOGgYifa
	bG5BN1XBIuVcpxS/kryTtDHPqpZS8/gmWA+5SGFuoL8pnLcK4lrHGekeXk/F+2NjG8xpCYs4pYaNx
	bkYcHy2m/gCg0BB/ibVCQi+FF81Y/GFQfTyHNBh20pySHGazdyXFOc+3cqR59jGyKerZ6Pq8lEb5C
	tavvewvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRZG-0000000FZTM-14gT;
	Sun, 22 Sep 2024 18:44:22 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRZD-0000000FZSu-2WoH
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 18:44:21 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7179802b8fcso2558394b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727030658; x=1727635458; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntcecgTamSRvXmX8hmdRwZR8rXRGFJQbjibcgGWlcYA=;
        b=Lltyod0ZXPqyvCUWtKcxoDYIx33Pjr/vBCU6EqeMzIgyZCQGEMge/H1c6uDIaMD86k
         iodD99nhR/87Eg7OOPEJW/lGcNawWeEuOao9GyHxwitqqSls5F/3wAPronJzezv+5eu2
         9G/ZuIoAkcxvY2Asxrf9SCTLdRwmISq6cJRxce/OMOgVoCJIlXg1zZvKICA0MAVtD/hR
         iF9G8Dea1BFB0UZtTqD2Nu0wiiYe8jBbgQA1YTH7Cnc3h00moVMokLkkm+DRUVhmtnVl
         oiDPoqTESED32eIWkD4EZJ4MBlbogV7d6J6CknqCKRRgoz5hAxjf3UMlbiRLAqBtFrjG
         IB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727030658; x=1727635458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntcecgTamSRvXmX8hmdRwZR8rXRGFJQbjibcgGWlcYA=;
        b=oUg/Gz1rvFGI1g1ENhzRsC/+vEeD4olz8PDNWQxXE1zMyazxb0RKR4+D97aB2ZPWIF
         NZKqt5YQBqxjulZDckTIo/+1aexwgS4AUT8gKYRbmdWj65yyTogdSja8cnOFvY2jvU+Z
         Cf0oUNCiTpc1BDPAuHk+QaHeBdzNfZH0oXpABYupZ6o7PJPFSdv2JhIFrxgAjdcyLqGg
         CLRfcYrpRRf9/lBH/U1LTrvfFGNkYSXafAL2uzTqnJ3qikSUP1Bm0Wd8i4+71cZCxNCD
         dSzrqAqQEzxWEmdVltKgFvvrhPaxpM7fsy18A3rskkLu4MLctmMK1SIDNBoYO0JMomx2
         BnTA==
X-Gm-Message-State: AOJu0Yw2URDYAKotqREej5o20KD1L0LTcwjRSUIq3ElV/b+ycmZJgSla
	N0Oo/tazKyU6n1Aky2bSfq6zLcg29Fvjyh2JONcxEDnEocA0wZ3b
X-Google-Smtp-Source: AGHT+IG94kbPudCUydywHGhCPZXBrusfP3A7rHvHInr1Ix4wl0CdqMbUyHv1QpanNISOs+b2/+Jsxw==
X-Received: by 2002:a05:6a00:21cf:b0:718:e162:7374 with SMTP id d2e1a72fcca58-7199c97b1c2mr12478394b3a.5.1727030658514;
        Sun, 22 Sep 2024 11:44:18 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:7cd9:6049:93c1:442? ([240b:10:2720:5500:7cd9:6049:93c1:442])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998b7fesm12017963a12.67.2024.09.22.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 11:44:18 -0700 (PDT)
Message-ID: <f9af37af-940c-4bfe-a721-1db4106fc2cc@gmail.com>
Date: Mon, 23 Sep 2024 03:44:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: add 'lbaf_index' ns attribute
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20240922053850.5494-1-ikegami.t@gmail.com>
 <ZvA3wZAvZlhxfepT@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZvA3wZAvZlhxfepT@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_114419_677743_1BE1F150 
X-CRM114-Status: GOOD (  10.75  )
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

The format command only uses the LBAF index so the attribute can be used 
by the command. About the LBAFs list I will do consider to add into the 
ns attribute, etc. if needed later. Thank you.

On 2024/09/23 0:29, Keith Busch wrote:
> On Sun, Sep 22, 2024 at 02:38:18PM +0900, Tokunori Ikegami wrote:
>> The lbaf_index attriute is needed for the format NVM command.
>> This is to reduce the identify commands to get the information.
> I'm not sure how knowing this is particularly useful. You'd have to run
> the identify namespace command anyway to understand the significance of
> what the index tells you.

