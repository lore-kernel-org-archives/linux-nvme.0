Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B73ECAAD3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KS4TP2ze3jkqEm4agkQq4ZcaXK2TLvPAvVTwXaoewAE=; b=2+dPmpQ6BilblcyzqGUUSsdpuq
	Gw/6ShZzClaBp3GKb4jzSW53Xmnjwyv0gourfKJAEQg1E5xvbGwofUL0L2ndBgwRhTPIoh0RDfa5y
	g6lJnQEASd6aI05EBbFr0MBY+RbANLj2/N1Gn50hdjkOKMKnvs9SioicZ9WUFbZnIW5YZwB0yxGpm
	RpssnWJ8n1PuDStHq/wN2kQhxzmLdYuqTbYWodckdx/3fql0fF1WnoDtxa20mjqpfBeKwyU4wVaw4
	TGuBYmG2cDB32joBfo/YVRu9Um8qm6DMAk8178KYH5AULzXr1I7DCQo2R0ftbrkRXX30jm6bbxzaK
	WtOyhn8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX4v0-00CAOw-5L; Sat, 10 Sep 2022 18:09:26 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX4ux-00CAJC-7S
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 18:09:24 +0000
Received: by mail-lj1-x22c.google.com with SMTP id by6so5769666ljb.11
        for <linux-nvme@lists.infradead.org>; Sat, 10 Sep 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KS4TP2ze3jkqEm4agkQq4ZcaXK2TLvPAvVTwXaoewAE=;
        b=aaJ9jnC2m2QxfJ1x4hvagtBftMmxZMeEd7klq9aX0U2pGVAJfB6cNu0ywEgjmbCQa1
         nK/oe3TerCKLpE0H/l+SXyI5c9SNFCsaC1ejkM7w+FwdkeoJIF2z0/Qk/RIrEMtqiruw
         rX+887c6mE9Rj8lkPClsFcsr39JMz/SLgpwD+fqqz/MjTEn1cHOI/N645P+k7M97H9Fb
         Mmi4PJP5ShmhauUID1qpIsa7vvio0KsG6Z0yf83EblCl1IN3NIo90ln2XavI2a8tmzJ/
         1kErlJahBP69D8NmfJI+zy6VDqryxvqDFh5IkkoFU84p24gcHEijAbrPf+oNi05Urie9
         CvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KS4TP2ze3jkqEm4agkQq4ZcaXK2TLvPAvVTwXaoewAE=;
        b=K9K7R+WAZGVvBTvTB/bB/Xue6AoZXOWPrySE61YzDYp1Vx+vm32a+6ZPzRVi54qxe2
         7Rt1EirsOi9UZ1+LtUqAgl4xlkBcciKI7J3Emb6ehFDVIrrzkGnDZCNb3kn4pEr4xb8z
         WyWycAARS3ic3KoozUaYGZjhdnv2DQzrsUJUQ5IGHcoViM+hIkBrSUstDEM73tVW4MZl
         KNvdY4i5/JpMo2vgkrdRi56RGJSSE+sHYB0OkOZGi7crzzHyZyjqM1A1bY80rzAYq7hI
         5w+5QvfCiMVR9ejNBydupc9B8uHGVWC359qUNFx6YQFwXF2yrbYxVajDjHi0chezM7p4
         BZ8A==
X-Gm-Message-State: ACgBeo2XIKcIa3Vs9nmYK6pq++EDtfhTMDcTPv0+4891lNNZ5ZYtU97N
	2VFGqjxchIIVPjNp4KilAoA=
X-Google-Smtp-Source: AA6agR5r30odkaE5DK7PIWzQ2ruiFG4YP1rMHOV27OWfASoPKQuDfLBKQ0OjTKlnHWOk5VfhAtqUlQ==
X-Received: by 2002:a2e:700e:0:b0:26b:fadf:87b2 with SMTP id l14-20020a2e700e000000b0026bfadf87b2mr612116ljc.520.1662833360099;
        Sat, 10 Sep 2022 11:09:20 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512229100b00498fc3d4d15sm325984lfu.190.2022.09.10.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 11:09:19 -0700 (PDT)
Date: Sat, 10 Sep 2022 21:09:17 +0300
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
Message-ID: <20220910180917.plhtjt3lp7b6wlb5@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <20220910053045.GA23052@lst.de>
 <20220910123542.tzxg2blegw55z5fj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910123542.tzxg2blegw55z5fj@mobilestation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_110923_309511_CE1BEA7B 
X-CRM114-Status: GOOD (  22.49  )
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

On Sat, Sep 10, 2022 at 03:35:45PM +0300, Serge Semin wrote:
> On Sat, Sep 10, 2022 at 07:30:45AM +0200, Christoph Hellwig wrote:
> > I think this will work, but unless we have to I'd generally prefer
> > to just split dta that is DMAed into into a separate allocation.
> > That is, do a separate kmalloc for the nvme_smart_log structure.
> 
> Well, both approaches will solve the denoted problem. I am just
> wondering why do you think that the kmalloc-ed buffer is more
> preferable? IMO it is a bit less suitable since increases the memory

> granularity - two kmalloc's instead of one. Moreover it makes the code
  ^
  `-- I meant fragmentation of course...

> a bit more complex for the same reason of having two mallocs and two
> frees. Meanwhile using the ____cacheline_aligned qualifier to prevent
> the noncoherent DMA problem is a standard approach.
> 
> What would be the best solution if we had a qualifier like this:
> #ifdef CONFIG_DMA_NONCOHERENT
> #define ____dma_buffer ____cacheline_aligned
> #else
> #define ____dma_buffer
> #endif
> and used it instead of the direct ____cacheline_aligned utilization.
> 
> -Sergey
> 
> > 
> > Guenter, is this ok with you?

