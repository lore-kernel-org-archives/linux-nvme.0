Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADCC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 21:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE19B2173E
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 21:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FmFUHvtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE19B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jWjpYsgR79NWBH+U/Q0ZABDwGzqHOzf85t7Z4nwK41M=; b=FmFUHvtqsmvo9svYF66ZI94UE
	AtyjS59GgsCO2rBcR1R3N426w2u8UGu960qFOaW1VRPJ/8TCR69bIL4aLeVMA2b4c8r8AzGOOShwP
	3qeIbp+v+WSbAZD6TkomVAHFBR0zE+O5jn4pkMqCIA0tk63hzAzCRFSG33eDvzOQ/XcmcIRjVqcCo
	wafVAO+xvdRgXHKwvswvxJdSmymRPDXHBP6AoZYXHJEpDdl9SutEfWIS3hFNGCKhd3UdO/MVdhtxO
	Ens2Zkfo67VLGgkzLX4sTXknNx6CP+ZY9pUOVbtmy954Rmh5FKl2vs3112MZAZfT4I5yipWzoEgKj
	BRdn1ubAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jXAA6-0001mT-NE; Fri, 08 May 2020 21:04:02 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXAA3-0001m6-LI
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 21:04:00 +0000
Received: by mail-pj1-f68.google.com with SMTP id a5so4851717pjh.2
 for <linux-nvme@lists.infradead.org>; Fri, 08 May 2020 14:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bUnThTnTqroCBp1kPXhzkGoYmt0il0E7bFbo3Q/RKu0=;
 b=VbxhrNMNma93b/lEBFxsAKgtaYH6OrR2D/Kguuadpy9oTckQceOox5QRRh+Qtl5p6g
 A9OjrhtziqOJm3iDNikRb0FoYmSYyrEpNBaQzPn4HC8LzlcCpdU7lu5a+JUTJEJEvGzK
 oJfzyw3mTxgAoSlcUxskDxjp0ECIasv80NoLqyMshliVGjMqnQHvWskrKw1yuYtTpVrG
 SxDFv/UsgADYTMqmUfaY7s15eKcxsbGuL5pFxHX696f2m+yBs1FPzvR0Z8TKp5s+daBA
 MAphR15bzsrbGylx2YQ7SLZOdTEUBiUxNl/59LEUa1bMvtSkHxfHGFBps3XKklQUiFD/
 k8xg==
X-Gm-Message-State: AGi0PubGNJrd6/IvtKx4Gy2WAvcLbdi+Kake4qy+HlEA8vlZxGVzzPr1
 buW7dqCHQ7SrQO/2Aty6SzrgFXYc
X-Google-Smtp-Source: APiQypI8xNte3bLmy1ItJZ7XLgd43s6wVahdlikfc0ck1DTZxzfTL9ew+esUIPtqp1981FZZZrVNwg==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id
 q70mr7919294pjq.55.1588971837166; 
 Fri, 08 May 2020 14:03:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bc73:49fb:3114:443?
 ([2601:647:4802:9070:bc73:49fb:3114:443])
 by smtp.gmail.com with ESMTPSA id a129sm2725996pfb.102.2020.05.08.14.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 14:03:56 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: dma read memory barrier for completions
To: Keith Busch <kbusch@kernel.org>
References: <20200508200406.2814437-1-kbusch@kernel.org>
 <34740788-df94-d2e0-fa63-5568e379cdd9@grimberg.me>
 <20200508210033.GA2814530@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4c6d036a-0b6b-603c-9130-fb7407d7e4eb@grimberg.me>
Date: Fri, 8 May 2020 14:03:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508210033.GA2814530@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_140359_700150_7DFC35C5 
X-CRM114-Status: GOOD (  11.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
 hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Fri, May 08, 2020 at 01:12:50PM -0700, Sagi Grimberg wrote:
>>
>>> Control dependencies do not guarantee load order across the condition,
>>> allowing a CPU to predict and speculate memory reads.
>>>
>>> Commit 324b494c2862 inlined verifying a new completion with its
>>
>> I think we need a "Fixes" tag to get it into stable 5.6.y right?
> 
> 5.6 doesn't include the commit that reintroduced inline completion
> handling, so there's no stable this would apply to.

 From some reason I thought I saw it in 5.6, but you're right it isn't,
so you can ignore...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
