Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC266C6FA82
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 22:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FtEqwG/K5xL9hXf+ZrP/wIckLjWw253tSx59CJRjURo=; b=QZWA23tunmBq7IWvpar0a8UQtV
	ErQl7fXg+EBXpjqSG7KTCnqX9zVA0B/k015EhAzx3qTi9iie0wlMwsm5yUpHAyRwD47pe3cMMg3Om
	Ek7Ah1DHDAxuBZFEH/KS0uu6i5/Qtn+uDuRdZrJZe7mV9pu+wGCa6oTdYm+gzeMi87IznHtrCAymb
	dk3kv5teebj8naEA58qQBcQT6nuw5mtEq5dnyqvEPHJ82q8k879Rumeez+qH2axPy/H6jPo1XuGzL
	WKjdbqqlKFz8j+3r938kyNRBwEOkyK6MJCqEd56/9tSA+gQBMokIQirV2sl7vcKidThAeEhUgyQV1
	wOPnNq5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oca2F-00HBxj-1I; Sun, 25 Sep 2022 22:23:39 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oca2C-00HBsB-J0
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 22:23:38 +0000
Received: by mail-lf1-x12c.google.com with SMTP id bu25so6279422lfb.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FtEqwG/K5xL9hXf+ZrP/wIckLjWw253tSx59CJRjURo=;
        b=N3zreAPfbahoEwQV/C8efRAOUCuOnhdFwUg8hikd4a1/01yPQNnPcCpOsb7gLEPng6
         rn16dNKQol45mqFmIneUl4ARey1O/Ac7Oxx1N+hgHC+69ZLn/nOrvF6pqQim3i4ygx5t
         qCh9zb5P5C2gs8MgWrmeBFZCx/huBngE7tMhCW7JVwdjGTvfemIsTbMTde+hkI6ydsGD
         Y8tSALjoT+bEbAav394L9zBxwsaB8eI7Fuu8PJWwI6VuPXtbvjVNtA7CBL23meDH3zw/
         SQFR+be4EQnNerC9or4kS9qwx+M2jTJbpwg20BcvjwmVRKTMhknskmZkn2Cvi24zLIej
         lgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FtEqwG/K5xL9hXf+ZrP/wIckLjWw253tSx59CJRjURo=;
        b=nBxmLXxVme6ZbnsAZF0z6SEXjLRCdWBeC0fiiguZeHl6nqYyfX5F59A6RKcNZ0pfFh
         X+Sl6LuPdgzkQaugisegEHSgNVSq9w6eEf7mC1aiCmhnLti4QeIkF/wCszS1EMwW2C8q
         BRAM9zrsHr3ESpU5of2flo5vtcQwDAUOwz3Uh+B+PDrqA126b4tbSKv3P2ZufVq6zMEY
         T49plyW+QGMf1d7a16S5g5555niszE/acfkZX/t5Vbwuxlj65zIVFPMWkjkH82kdKmR4
         lu0Kvsi6RA+Qd0THSxOqYd1cV2VTCEPFEUeDtLe7Vhvpinnaiif2Nnvx0UaOWHOmeWZD
         rCJw==
X-Gm-Message-State: ACrzQf2tMVvQEvk3yBBYQ6pAHooJIKEDEtNaxG2a0i52/eIC7wbJ8Z/P
	Yb7gWZBYj9ryk46q9FjMSX8=
X-Google-Smtp-Source: AMsMyM5qFMDgU027/Sm9muPHKDgrE5SpekpER+jHiBO95ZmOUdyFKex46JvtxCjMFbSXa2HOzzYqrQ==
X-Received: by 2002:a05:6512:3ba:b0:497:a116:3f86 with SMTP id v26-20020a05651203ba00b00497a1163f86mr7296009lfp.142.1664144608290;
        Sun, 25 Sep 2022 15:23:28 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2327682lfj.266.2022.09.25.15.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 15:23:27 -0700 (PDT)
Date: Mon, 26 Sep 2022 01:23:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220925222325.irltbraf4e2j4vtq@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
 <20220912082909.GA10666@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082909.GA10666@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_152336_709399_82EC01FC 
X-CRM114-Status: GOOD (  24.54  )
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

Hello Christoph,

Sorry for the delay with response.

On Mon, Sep 12, 2022 at 10:29:10AM +0200, Christoph Hellwig wrote:
> On Sat, Sep 10, 2022 at 03:35:42PM +0300, Serge Semin wrote:
> > Well, both approaches will solve the denoted problem. I am just
> > wondering why do you think that the kmalloc-ed buffer is more
> > preferable?
> 

> Because it clearly documents the intent.  Here is one buffer that is
> just a data buffer, and here is one with kernel internal structure.
> The concept of embedding on-disk / on-the-wire structures into internal
> stuctures always seemed rather weird and unexpected to me, as we now
> need to ensure that the alignment works right on both sides.  With
> the right annotations (as done in this series) this will work, but
> it feels a little fragile to me.

IMO both the approaches seem unclear if a reader doesn't know what
they have been introduced for. Anyway do you insist on using the
kmalloc-ed buffer here instead? If so I'll resubmit the series with
this patch updated accordingly.

-Sergey

> 
> > What would be the best solution if we had a qualifier like this:
> > #ifdef CONFIG_DMA_NONCOHERENT
> > #define ____dma_buffer ____cacheline_aligned
> > #else
> > #define ____dma_buffer
> > #endif
> > and used it instead of the direct ____cacheline_aligned utilization.
> 
> So independent of my preference for separate allocations, this suggested
> additional would still be very useful for the places where we need
> to use the alignment for performance or other reasons.  I'd use
> something like __dma_alligned or similar, though.

