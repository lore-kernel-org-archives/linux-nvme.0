Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D51C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 08:49:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8D4600CC
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 08:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8D4600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C7kQwmgBgGYU7MYVe1Za5AWUbbzweMm9RPit+hCTBm8=; b=rHPpdELKmXbVMcNtBI4wmOmHW
	NE0qHtJ0UETNiqnGJwnUGQyXkUXBmW23irFIVnFZD2U3YLGPR4HKVukKbDiSBiMFZI6Y3UUtA+zCK
	XY6cMLa6OKQ2FqBF2A6rR5nE2SnDaEk+9QAwA3SAXYkCgOzX+gJR75wAfx58ZeLbmI8/SG5aUyJbn
	2rjOGEh8Kr7XMA+mlrf/6myJaVE7Iw2vHmjGahb9MMTz0gzxfV4ZKWS9hRuH3of8e10VC8AI86HYc
	ftzz3m1kA83YFLlcPfXQGJMsETq7Mu3nVE3bjq2KthXx6U5avJPPHJa3SuyWx+NqKps0Kggdt5ElC
	gVCACPGnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEprT-0006R9-OT; Wed, 24 Feb 2021 08:49:35 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEprR-0006Q3-6X
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 08:49:33 +0000
Received: by mail-pl1-x630.google.com with SMTP id u11so767492plg.13
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 00:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XDjliifyCZi4rpWEAXTJUkaBOgqONbfFKArbHcfkHMU=;
 b=NnYaMJpqCiqU45lz47urDqS/zQfI/m8ruX0IrBlU+OD7XJ7ht7BC16UkcaEDk2tMZ7
 zPSuySd1hX5HgQEdmMxT5snOfwMDmC4BYvgM1kyjaaVnI7ACUtGN8S/mHvl7aA7IUo5J
 LWQC/Nam0L/e8mTPrRg1hP81ZVwYl5TqCu75C9uG5PFkjFYKIaXOwFCBHLEddA1PaF2m
 E4zxe/1FHkAOmwQG87YgrNW5d9N4DTnqFz/lXCalKzIlnkokkFbVEOJxem0THxYLQgmX
 4+NwyRHILdEcX37lkgO02E7r2/forPzWcO4nxumKjXt9oOXHZEfmHLKWhWRRouwhx/bk
 I6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XDjliifyCZi4rpWEAXTJUkaBOgqONbfFKArbHcfkHMU=;
 b=NgyeRo5Q8QYXfOnOk1tRDeH7NIZI6lkgBRXOsHG8wTHoOFCGDrmLQ+mq/f60AcL9ZQ
 1ztWg7rM4XzQw3kmOx78/tGL9RzZRS/MUI63kjKWKQOU1oHgOp0yRZJbYm8Lk19LY9mx
 t+FPt4qqKw5ElPGoNI3rISQk+DuwbRTwNUaivjmYScZr0MbUCtisaDKY4C1GUhOqYQ+1
 sovEOS8zl3rrC00oMgGAl+aNpFXea+8yiW2UExrbMFem24wgzglKxt4/B3/kszyQbxtE
 d18hjICZ7TT7A44PpffhcggfKrSs+5T7DskNvNhtBGgboALgQFxGegR5KAO6xOAl4VID
 9Lqg==
X-Gm-Message-State: AOAM531C+oxbPz1kwcnOPMP5ciwM0Enhp60hlkWpiGgd7vKw94TAg8PY
 3cIJDcbvpdQC+cwKOZCRgJE=
X-Google-Smtp-Source: ABdhPJwhVJxaWyGxVCAN2DLhRmdgKaNBZYNT7HXUzQklsPiiuNlTjsSHcqZ8wZV08KkWOCiTCHIAEg==
X-Received: by 2002:a17:902:d509:b029:e3:f512:e600 with SMTP id
 b9-20020a170902d509b02900e3f512e600mr6707689plg.81.1614156570725; 
 Wed, 24 Feb 2021 00:49:30 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b34sm1606141pgl.63.2021.02.24.00.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 00:49:30 -0800 (PST)
Date: Wed, 24 Feb 2021 17:49:28 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-pci; remove the barriers nvme_irq()
Message-ID: <20210224084928.GC2166@localhost.localdomain>
References: <20210223204741.38301-1-chaitanya.kulkarni@wdc.com>
 <20210223204741.38301-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210223204741.38301-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_034933_279348_0279848A 
X-CRM114-Status: UNSURE (   8.33  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, hch@lst.de, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If and when it's picked up, the title of this patch should be with:

	s/nvme-pci;/nvme-pci:/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
