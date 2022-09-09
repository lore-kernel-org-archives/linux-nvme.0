Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A33FECAAD5
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 20:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9uJhMPjNtanajGUXFh7EWJy2ETbUMNIiBMvaNfS3PKg=; b=tSHk2wMuftmYNufPuCUtq/sDvy
	VUFXk2uC+xNka/4qgNb6+HDmV6SRiu8UzXufgSN/SarEzteNRziFRx20cFFEBX0ndm6hmboflZp1g
	AvyKmEJMkoPbk/uk0icJApoGwAwAFpQaPrRG39m1Sfj+1/bkO8qWNi2EvlpTedybRWlaSvetEfbMY
	Z6TwZdH3y32zX99e5NGR+gBrLG76QqLR0up15EOmthUo4lUHBJF5Kkn8qDBVJAtQmgcnA4DP5r6h5
	edU/F+848UN80kmkjLvDMfOcHwhnqok66uddIEICmFpw3bNi9QRnn+5WkUtVlzq1XGaYFHouLbaBA
	O43lxSNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWl0K-002nsb-V0; Fri, 09 Sep 2022 20:53:36 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWl0I-002nhV-54
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 20:53:35 +0000
Received: by mail-lf1-x12d.google.com with SMTP id a8so4704773lff.13
        for <linux-nvme@lists.infradead.org>; Fri, 09 Sep 2022 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9uJhMPjNtanajGUXFh7EWJy2ETbUMNIiBMvaNfS3PKg=;
        b=iYZRMFOgtxJgEyoS9zaA8hEv3F5GRJ4VR1CwPtWw+QQJwrb4owBjcbOwd56/AfVL6U
         CeGF8+yX2/YvNhnvyfpTf4VUYHjFxDfVpPN2iyHMRgxF9aZEC+RA13t9BU8XCzVojBsg
         T5hiI8TpWCPFUqG9bmmLaPDl8UNBAr43ubo48dvZFiHbQIewUkoNm6q9jWHou2hAG5ty
         2J44+UdiQHxe2RhlNtwfHPwf6twf3bEE76GLPVvqzrB1J3QoJVQfyiNTnm9f+I/hYQaG
         lJdwRnnUS1KI/3oZ2DD45A7dWoImO8ClK4TJ3HKkBa3EshIArPFZGw+Ztn3R1iptnS9h
         WQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9uJhMPjNtanajGUXFh7EWJy2ETbUMNIiBMvaNfS3PKg=;
        b=Yu1q0aRlDQpdenM2kBw95Y3FrsGC6nzWceqNHpS+ZtB6eesVU2agzvQZ8bPKQ6INj7
         G/PI4mkrUgeiu2pWUNoKwhIvxZXK2p9eSeLyMpI4bwu+TO4QjiMYV9pdjwiNYr4uLf5R
         l63M/bhzWAKntQ+COsb4YM0Q2EhhQRd1r3CAkN9eIhMMpBltO0YgaU2IilETLT6aAhp8
         xy+/7kXqy+LFSsNmCP89LLlWVhcxkm5PbtbmwEQACH+7SslrfA5VbaxGMSFTO3dECein
         4pXikPCCf+laP+CdTHFTBBMxlroI8od0GmN+Cm8I65nQ+0zzPqDGIFsYZk9YfNBK5H5J
         cKFQ==
X-Gm-Message-State: ACgBeo2TpT3UMEt8BtReShUQCPccXWJKP1SzBQHKYr7OK4qUYtvgFwge
	qeJfMo5Z1tdwSYrqSdT4wro=
X-Google-Smtp-Source: AA6agR5WMB4Pyl705A4BROqcMh9fI4blbkel8r3Vzya7cmCyp8RJc/YwVZvn6Kw4z3o012WBfUTNPA==
X-Received: by 2002:a05:6512:2254:b0:498:f454:ec9a with SMTP id i20-20020a056512225400b00498f454ec9amr2482976lfu.58.1662756811191;
        Fri, 09 Sep 2022 13:53:31 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651c118e00b00261ccf566e3sm47407ljo.65.2022.09.09.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 13:53:30 -0700 (PDT)
Date: Fri, 9 Sep 2022 23:53:28 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220909205328.yv6y4f3t2zznhlkp@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
 <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxuXKrkVbGBJwxRS@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_135334_218917_BE847B11 
X-CRM114-Status: GOOD (  29.50  )
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

On Fri, Sep 09, 2022 at 01:42:34PM -0600, Keith Busch wrote:
> On Fri, Sep 09, 2022 at 10:19:15PM +0300, Serge Semin wrote:
> > Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
> > 
> > Folks, I've thoroughly studied the whole NVME subsystem looking for
> > similar problems. Turned out there is one more place which may cause the
> > same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
> > the nvme_sec_submit() method. The rest of the buffers involved in the NVME
> > DMA are either allocated by kmalloc (must be cache-line-aligned by design)
> > or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
> > method implementation).
> 

> What about user space addresses?

Reasonable question. Alas I haven't researched the user-space part as
much thorough. What I can say for sure that we haven't detected any
unaligned buffers passed to the DMA-mapping procedure other than the
ones denoted in this patch and in the next one. So to speak so far
none of the NVME-involved user-space buffers have had unaligned offset
in the physical address space. I have merged in the next patch in our
local kernel tree:
https://patchwork.linux-mips.org/project/linux-mips/patch/20161125184611.28396-3-paul.burton@imgtec.com/
So if an unaligned buffer was passed we would have immediately got it
detected.

> We can map those with cacheline offsets.

If we could do that easily it would have been great. But I don't see
an easy way out. AFAICS we'll need to fix the blk_rq_map_user_iov()
method so one would CPU-based copy the unaligned part of the buffer
and perform the DMA-required operations with the rest of it. Do you
have any better suggestion in mind?

> 
> > ---
> >  drivers/nvme/host/hwmon.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
> > index 0a586d712920..94192ab7a02d 100644
> > --- a/drivers/nvme/host/hwmon.c
> > +++ b/drivers/nvme/host/hwmon.c
> > @@ -10,9 +10,10 @@
> >  
> >  #include "nvme.h"
> >  
> > +/* DMA-noncoherent platforms require the cache-aligned buffers */
> >  struct nvme_hwmon_data {
> > +	struct nvme_smart_log log ____cacheline_aligned;
> >  	struct nvme_ctrl *ctrl;
> > -	struct nvme_smart_log log;
> 

> So this by chance happened to work before 52fde2c07da6 because the field
> started at a 4-byte offset on your arch?

Correct. The offset is 4-bytes indeed so the log-field base address is
4-bytes aligned. Due to that the bounce-buffer used to be used for the
NVME SMART log getting. Since the denoted commit the log-buffer have
been directly used for DMA, which has revealed the problem caused by the
cache-invalidation on the buffer mapping.

> 
> The change looks good.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks.

-Sergey


