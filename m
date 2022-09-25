Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA33C6FA83
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a0hPbzQaBpMZbWVLyY6Ndr2md1EPl8heRcl2lfx1uao=; b=H3klti9BIllSfejLAzMOHmkAFn
	fUxiMZVB56mNvWa1mOwUcqUdHiXGtkKPJD2yjCt7tmrTSw0KKfAX4Oy/XMMn+ey4a7FlCq5eosyKt
	OFCPFzDhPZ2ul/6nqSuDffMsAcThXpflqIbgVi8Ji72MxXKqIo0mAkBb1DqVyfBDb7ktxGjjeRwni
	ay4eg3/gezms30gcH3vpshmyfdQvwFR0lx7U6AEdBK6JEZ6YdmUiXK1wq5nqy5jww8IH+CDsFS4AG
	aRO6/tRBDE66BXBUDTjUtGHSALfn3t2UpndooBD9MADeNxqxmPTuwG/acrL7iW/l0wwtEGT2WnpPi
	U3Pn/+VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oca9N-00HFzD-2v; Sun, 25 Sep 2022 22:31:01 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oca9J-00HFwY-CB
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 22:30:58 +0000
Received: by mail-lj1-x232.google.com with SMTP id b24so5600275ljk.6
        for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a0hPbzQaBpMZbWVLyY6Ndr2md1EPl8heRcl2lfx1uao=;
        b=prIsjwSViz1wXo7G4+dw2QMAUYRqb+JaN8xLaFU0Mpm720vsQlKbiP86kSyjK6/J2f
         UGL1JMA+tZbm+36axWkxsWe76LZ50jIgn88og12tFEhHuVazHWUXqmuxCGQQTATOLLmZ
         spdrcaq4Lzuq2ssEmvib39fmILwUzpX8VRsbe7Lq+Qajv529JR0stTj6IQi6cEHLkmKh
         OafABWRhWwcww6JDyoK0lU7XrAFw9x3u/15eQrfGPJIta/7hVKMeZBDesROTh0WhRfJi
         Nfd032HRBElAfY2jFOTPhNqIK1eLWkfEokcM8b151gDnjM4vSzgW3h4PbTqXJUyDvznl
         W5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a0hPbzQaBpMZbWVLyY6Ndr2md1EPl8heRcl2lfx1uao=;
        b=hCAh27sDyviiiFDp703nNWdFHjWwABERgdh7xAyoQC9lf4LS3yYXNzx9PyDCM89BfI
         amsSg4ws4ruq8WIFl5WUHMnw22/ywl92sweCSUDUGiPG7WX3V89/9fwKdFOrhK2r81FZ
         wM7qmozpHF9NG1uMTrCmgfKqUeHs0Jg5brMtAeLN+/+GwHdYEpyCB69CC8afAv4JdCUL
         MbeOmukXIal5kTQqO9XR9Qdo9kEMc7qZmBE9hslGBGJjXczihnOYBh27+4rHIjrGbqbF
         cPET3RfvLeU3oobamCWDN5s+uDyt2GOc2Km/fOLd9cw8OnlF93ZDLXCZsrRihpx8uRzD
         H0IA==
X-Gm-Message-State: ACrzQf0cookZZH79sAXtZUdzlKK82yxta71j00+O0eURq/XTrSvjjBUi
	tfMeXhYa0WtWG01ubZX00eU=
X-Google-Smtp-Source: AMsMyM6HNh9b7WyDnzcSuSoW1HsGYT8oADEab3CivQY//vuQJo3RvP7/TJc7qf3WbBEZsPmwfLKAhQ==
X-Received: by 2002:a2e:7d13:0:b0:26c:4062:acfe with SMTP id y19-20020a2e7d13000000b0026c4062acfemr6763157ljc.201.1664145053791;
        Sun, 25 Sep 2022 15:30:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b0049f9c732858sm2322995lfg.254.2022.09.25.15.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 15:30:53 -0700 (PDT)
Date: Mon, 26 Sep 2022 01:30:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Rafael Antognolli <Rafael.Antognolli@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: sed-opal: Cache-line-align the cmd/resp
 buffers
Message-ID: <20220925223051.5vem3ab4267jlxeg@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
 <20220910053203.GB23052@lst.de>
 <20220911162854.ivoeyzilpboplldw@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911162854.ivoeyzilpboplldw@mobilestation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_153057_456427_62E2588B 
X-CRM114-Status: GOOD (  21.31  )
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

@Jens, @Revanth, @Jonathan do you have anything to say regarding the
patch and what @Christoph suggested?

On Sun, Sep 11, 2022 at 07:28:57PM +0300, Serge Semin wrote:
> Hello Christoph
> 
> On Sat, Sep 10, 2022 at 07:32:03AM +0200, Christoph Hellwig wrote:
> > On Fri, Sep 09, 2022 at 10:19:16PM +0300, Serge Semin wrote:
> > > In accordance with [1] the DMA-able memory buffers must be
> > > cacheline-aligned otherwise the cache writing-back and invalidation
> > > performed during the mapping may cause the adjacent data being lost. It's
> > > specifically required for the DMA-noncoherent platforms. Seeing the
> > > opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> > > drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> > > respectively we must make sure the passed buffers are cacheline-aligned to
> > > prevent the denoted problem.
> >
>  
> > Same comment as for the previous one, this should work, but I think
> > separate allocations for the DMAable buffers would document the intent
> > much better.  Given that the opal initialization isn't a fast path
> > I don't think that the overhead should matter either.
> 
> Thanks for the comment. I see your point. Let's hear the subsystem
> maintainers out for their opinion regarding the most suitable solution
> in this case. If they get to agree with you I'll resend the series
> with altered fixes.
> 
> -Sergey

