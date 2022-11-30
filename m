Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4348FC4708A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kL6Gves/vsl/38QPLSSNt+RAMhRPO4g/aBcfT81YEtY=; b=o4dbX8uUKkmpEaNxOShszg5o3h
	n1PRov0klAYJzmPkbngoMDfggPFyepRt4/DhkdFr3yc1cjy6bmDeeq5B6cdo1N9xvHnG0Zne111cf
	HMCy056yCEds2kUecmbdTFXUGAG1DQIuvxpJ6yaQjABoPHOPWVqd5mGIOjj5VOj8IPZixsRjA2pal
	fw0o+0gdzN1gviv/KQ8kLo0fxPGEuII7PJVcK4OONgX5kUl6TE4xPqJtcDZBC6oiQrTika4BDvixh
	kVfU6NH/BFxh4MAhrjsKQI4jMHc9Wmz7C1qNMC4Lo8Idg6cX+zo7aYFb/RHL4giaLmXxigVC7x8vI
	nF5bdpuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IQs-00EWMD-JZ; Wed, 30 Nov 2022 08:27:06 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IQq-00EWKY-FC
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:27:05 +0000
Received: by mail-wr1-f51.google.com with SMTP id h11so18575765wrw.13
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL6Gves/vsl/38QPLSSNt+RAMhRPO4g/aBcfT81YEtY=;
        b=k3uKJ5k0aVExoR7U+6v440e5Hle6haK8tfdVhawN2h+SGUDFtY4CvwQ/I/8u8ibWIG
         iLOtc3cMfryAGpoG6J7xBWC97OfG+rYQNvs30BIqnRpPvUsKjt3qtTUL7IiYDjveV3vp
         bgLioA+R6fsLhzAEXdXB2F+L42Fuj2MPu2vDX72xOHzlb8/yQvCTmNf2tnk9AEJ9JPJD
         lHHwZ5TUX59ISohrVnKU8Q2fNkO0msvrOdE6bAuhjTkQLLRzK0tQFuRu7LZamp2a+9We
         Pi5qtkTjs8jxhwhQXt0yy34Lm/xnDJ46OJYRhbRLiZQrJC5U1OFF6tPuiJW0j0/5vy9X
         s7gQ==
X-Gm-Message-State: ANoB5pknoVs2FBNHqiYwMPi6UgjWg/R7h/uy3CJPvEkwZVwvHuYP9V/L
	OfuGrGPRjawCT0Bhe7PM0qr8gvYlyMs=
X-Google-Smtp-Source: AA0mqf7o25hYe+Cvt/rK8wwuKLO+eX/OnHs8qIQkWhvybDCNsECS6R1nM3USnDNtkS1D0uN0fIF8Zw==
X-Received: by 2002:a5d:604b:0:b0:236:6442:3a48 with SMTP id j11-20020a5d604b000000b0023664423a48mr26893013wrt.41.1669796821721;
        Wed, 30 Nov 2022 00:27:01 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b002368a6deaf8sm780622wrn.57.2022.11.30.00.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:27:01 -0800 (PST)
Message-ID: <bc8541f0-77d5-3384-b62f-9ad0f2384fe4@grimberg.me>
Date: Wed, 30 Nov 2022 10:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-pci: Netac has bogus namespace ids
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221122112428.1573353-1-sagi@grimberg.me>
 <20221129084655.GA26082@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129084655.GA26082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_002704_538123_F061A4AE 
X-CRM114-Status: UNSURE (   9.76  )
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


> This seems to be the same device we just quirked with
> "nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000"

Don't see that one in my mailbox, you can disregard this if you
have another patch for it...

