Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B69AC2D0C5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAB22173E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 00:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UN8yVF55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAB22173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DDGu+/kkb1cbNjzboaSnP/WRq/z3K2haoOLUuvlQyRY=; b=UN8yVF55VfOpcVN3p5dcyINXh
	cj+NPHj4NTd7fyGDegkEbWoU7tY93hihWITI4SwXv5KGLu5ncGnw6TJ6yl6IV9lTI/+6h3pUlbpjP
	T6mitIeZzrQTE+Tx54yY1zDjUBIZuASNFJPgyoI1WavpWOUlYCmcQuv/8lgIbPZ8Ux90BSNO97hg2
	ty7hRIoK9k+NcaYcbbcMHgyKbxyQMW69VLlUQCL24HsO4kfnX8N44CQLKSpJyccFH/qfnBaMFwQ4Y
	ww8UVILQpUyhuWtJ8e6Zf2Z0NZ5piciCsM2GepFNqmfDB3CXc5QhMgXe4HdMAU6CoSRt56Ccar0kg
	4QFIF0COg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifCgX-0007Dj-9G; Thu, 12 Dec 2019 00:50:29 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifCgU-0007Cw-HV
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 00:50:27 +0000
Received: by mail-ot1-f68.google.com with SMTP id g18so592271otj.13
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 16:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M58jhzz7JZJ05K7SXUTF1bqrvNdphjuNv7SGl++vzc0=;
 b=XS+tIzCb0RUR4/MGl62PxDW1UyBtBKFDkJJcZZZaJc/dY24J+CVHzEfDocSKJcKMs3
 ffyMKUclT/FdGwm0U3IsdR88F9XPhewUYB8eb6xwT9zEWc+UolNu3SqIQE5i+X4HMoKn
 nY6XyF5CBDtFmbTrNgbVcBBg/2SkXpxu4LbBgj3mNZCzlNZ5C90qxKvf2OorF1KO5Rit
 KVDeiKjdCSmo22L4UdoOgdMHPVM82aAoMt60pIj0YITPM+23UY4XtOM9kOhnKgpTTSSL
 Kqgi6BZ82dfgO4bdKohpgAwsaWKagkDCRMvkV9nU6ILjoCxXPhWt7+6yyzmYEvWrIHCA
 l0og==
X-Gm-Message-State: APjAAAUacq5reVRimM1MqkMDQVQmyfcgE/bMTsrz6wyDste3jPvr6OFY
 TNxPbxWDsoheCtEgxSln0b0=
X-Google-Smtp-Source: APXvYqyo3vzsBZC/KH9k9yv62o00//jeyVX4MEezoupoiJ/v2z1ks0qORY3nl/PPSGsMdg0tVO1Ahg==
X-Received: by 2002:a05:6830:10c9:: with SMTP id
 z9mr4938238oto.200.1576111825486; 
 Wed, 11 Dec 2019 16:50:25 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id w201sm1446102oif.29.2019.12.11.16.50.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:50:24 -0800 (PST)
Subject: Re: [RFC PATCH 0/5] to add more nvme reset functions
To: Keith Busch <kbusch@kernel.org>, tsutomu.owa@kioxia.com
References: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
 <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d4583505-d3f2-238b-c323-94216c910e29@grimberg.me>
Date: Wed, 11 Dec 2019 16:50:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_165026_580067_63DDF327 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: hch@infradead.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Any comments would be highly appreciated.
> 
> The majority of this series is at the pci protocol level, and the pci
> driver already provides the requested capabilities (but with a more
> safe implementation). Let's not reinvent it just because one nvme
> transport happens to use the pci bus.

This is messy. Everything here needs to live in nvme-pci.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
