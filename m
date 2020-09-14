Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFEC43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:25:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC092065E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jhp8RqqG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Ayatqx5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC092065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4og3CiT2OJIFaHXRyltRsP+HPJrg9G2ZooIhEIgzZPk=; b=Jhp8RqqGCW63URZ/H2GDNeCuT
	YK5U/GTLw5hWIZyNLxGSuN8i/2BO1DTBqi8U+TcY1B6t0xyHgL1kTdQaGfkW0Zkgly9Wqkl4Vt9h3
	DpKgul5BkXZBhMarj88DrXK278SkQvKiaGmlfowfK7KoRnS9UfAD5RbPWf3Z38GAbM73g1kUQK7mm
	l5udoMvTIQsD71PrAQIF7RaLh6HyjhlW7DRlqa8c/+I9x5Tq5EJzhmC/oUHJ1tz/JHJ9GuLb7FpCo
	qbRmZeqO+IgkkKgblEXNdBSdK2AJVBosPVXkNqpZDN1y96z3yAxwgCHjCQacfMm43iDYN3Gg4b0dJ
	d/xsu6uiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwug-0001k7-Cj; Mon, 14 Sep 2020 22:25:30 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwue-0001jQ-KE
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 22:25:29 +0000
Received: by mail-pg1-x543.google.com with SMTP id g29so907569pgl.2
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=M5wCt+OTi//+UZPp9lZ8x8LVzh9kAqqfuVLoBP95ssI=;
 b=Ayatqx5Icdv+ngirXvBkjllsk0TymRJmCqS9POPC53lvVQhrS5rW8CCHiktSpIdB+a
 7i9fQEod319jFREivSoV19vw0dVcrFa3uQjV+omBpdFBPCe4Iu9mOS/o8GBJjfK3iq46
 IOcPTUC//gqrCDAatB40TBK76dRxxqgXfkN+g4PlAbAGebxeS/9eY15cm8l+wfxjcx2i
 uqrXsUcgA2Oe4oFnDfjzT64BmVyv7yfep5/7KidEt4o4AW5tMnzm3h772Z/9fWYZ7TgC
 ab+Wy8L4SSXgLuSN78p6uVHAlsoLktgdHU9mBm7blpS/EpgpeYNLF+aBGedp4vlmUz4W
 kWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M5wCt+OTi//+UZPp9lZ8x8LVzh9kAqqfuVLoBP95ssI=;
 b=Orm6vklEOb+FJhLNlMMLg51TBsXfO7rjSgVpFlK9797ZpstFvtdtl4TIbqy08XZuL7
 EwC2PjqNCAkKrH5qMZnjlP/Ae5bmwnGgWtU1XqCn4g1GNVQcuXPQP4xieNjR/pRSL5+v
 1jek//GbqxGgCZC3s+xLH0O7VevoYEeoW8TtISCujKT4ckWrR866cO963Ri5nNPcEgDe
 dXOwoe4pdrl8R7NbkSVxu5qRayKh7BSs6Y5CbWE0z/IH/GP6Ox8/KYK0Y9F/Q+8ll3XO
 M3HbGJtSt2c1CY0UIMSw5b+88uiRwzx87Kbv2WFAfABWJXohECQgjrZzhzU+GYLlb11d
 egYw==
X-Gm-Message-State: AOAM5334oYKZGtrx7ZbtE8npvA0fy5Bz/xdKHsFYm1cVlfhFrQY2fBw7
 CD2Izc186XZEzLn+B8ULPWHHIw==
X-Google-Smtp-Source: ABdhPJxpCUBJQSOBCgvrIM+eniOd9SoxU5v/FHgayO67f4pbpUJzSw78y+czPTHbuP0zioBtVGjTqA==
X-Received: by 2002:a62:1b86:0:b029:13e:d13d:a05b with SMTP id
 b128-20020a621b860000b029013ed13da05bmr14835611pfb.33.1600122325527; 
 Mon, 14 Sep 2020 15:25:25 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1687])
 by smtp.gmail.com with ESMTPSA id d128sm5157784pfc.8.2020.09.14.15.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 15:25:24 -0700 (PDT)
Date: Mon, 14 Sep 2020 15:25:23 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Message-ID: <20200914222523.GE148663@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
 <20200914220951.GD148663@relinquished.localdomain>
 <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_182528_729474_E2AA3D2B 
X-CRM114-Status: GOOD (  22.83  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 14, 2020 at 04:23:32PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-09-14 4:09 p.m., Omar Sandoval wrote:
> >> I noticed this too during my review, but based on my read of the current
> >> blktest code, the return value of the requires() function is not
> >> actually used. It seems to only check if SKIP_REASON is set.
> >>
> >> If we want to ensure the return value of requires() is correct, perhaps
> >> we should check it after we call it and then consult SKIP_REASON? And
> >> WARN or fail if SKIP_REASON is set when requires() didn't return 1.
> 
> > Oops, you're right, I actually changed this a few months ago in
> > 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
> > Totally forgot about that :) IMO it's still cleaner to chain them
> > together.
> 
> In my opinion, this creates a bit of confusion when reading the code.
> The &&s make it look like the return value is important when, in fact,
> it is not.
> 
> It is also easy to make the assumption that adding any bash command to
> the && list will skip the test -- however that is not the case and
> people may introduce subtle bugs that look correct, but go unnoticed.
> 
> Logan

Fair enough. Sagi, don't worry about changing this, I'll queue this up
once I try it out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
