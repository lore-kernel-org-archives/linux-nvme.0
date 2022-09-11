Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FFEC54EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Sep 2022 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7SSYiogdPwy5AgzgPl2zf3eDXRMfkA0ZYbT+p4MLVEs=; b=Zb/hyQkJWRe8ymKlN3VdRqSDhk
	Uf8ANeHysKRog40bQpXMeFn6jAD4aT5PcVoeTY5RU1h5i8cfGb7t71mg8R3/kKvR9lpnbiCx7Ix/a
	naBxLK0FgadGTwN6d6iPF298asHmX1KILUviLfKiWNAyFOl82RB+i4O34wgEqYon+KYXRsJbNE+RH
	71/hlztnL9ZpI8hxwKJ3fnhx/JDbqfPsK8Rc8SbbGdUjUbqNzJ40ah6ArRjAcxbEQ1lZyuQOYDB+u
	oy9m+jNG6F1EpAkbKAUAjfEU8g3U9iIbs9CQweJsVyyeJijLr+p6irzA460fQC9WevZy2z1OjvKhS
	iV84G5vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXPpP-003B15-5V; Sun, 11 Sep 2022 16:29:03 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXPpN-003AzF-15
	for linux-nvme@lists.infradead.org; Sun, 11 Sep 2022 16:29:02 +0000
Received: by mail-lj1-x231.google.com with SMTP id s10so7296344ljp.5
        for <linux-nvme@lists.infradead.org>; Sun, 11 Sep 2022 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7SSYiogdPwy5AgzgPl2zf3eDXRMfkA0ZYbT+p4MLVEs=;
        b=YfbaiPM2c0SQ88+hOjCzIUtdHE9Ib6zAL1KQnXLN/8bjSuRNK9YpRj6KcNxGljUbwj
         mWrbVhBr1Evz8nwZxWcOFR/bEpT2ZS+WnX5olxlxfvBq3iGI01zYlrg2/+XSJd+J79EB
         3TdsWh5qY3c7RkJF82zYUuatGsnc4Aczj523odKFdkpGBElAalXWuWVxk670UpBOSMpo
         A7BtpbXAVhgjCu/pDicsPhmcn5J+k66yykPXWcz8ciEM2D1sBzopAfwoFKpcRVkIbT4r
         MVpyYm0bQ2A4b6sh5d2tBcnlyuXBSHmIxSWg0iFdgs6UIJaYYHRPzT/Zzo9oKhQ2796Y
         m+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7SSYiogdPwy5AgzgPl2zf3eDXRMfkA0ZYbT+p4MLVEs=;
        b=FtCSkR4npqMAXre+QgbU1Ky6FlqTc2FbRSuPClXNOHkLc2YU0MfGOnDPhJ4F1w479d
         GNi7Zwgil1fwaN/f3izMxXtVhH1WuNKTegCTIXU0BC4g9yL8XFb7mR3xiJN3Y5iHeAQq
         IP5R5s+XPieQhh9v8ZT3suxNY4fciqQgHSVjDj3nKzCPdGfn9L/acPo9xqSb1DCr5WHm
         W+WhGQ6847fyl7liiS37ryJqQngeZ0a/oww747fbInGU/LoID/WYj9N8uM5k4GMG/VEL
         c+8Z66qqp4rYTTIUwveTTeqg1MVs6Rta2ABX+aJfUir96UBXoq0EdM/ou+pwfvxMLoGR
         n60g==
X-Gm-Message-State: ACgBeo0pKySCmj+lM/oAqxJQaiG6YYWF6SPUyrJ7K4F9s929UwS5Ktut
	vch7navOFj+DsYbK/Uni1gE=
X-Google-Smtp-Source: AA6agR4Zi+innVbGnXfYvPwkXVoV8gF6dyCBDra6YdCBc01e/sbcUiiqLusPVyrZiraGkKfsgQJcqw==
X-Received: by 2002:a2e:890f:0:b0:26b:ddca:863e with SMTP id d15-20020a2e890f000000b0026bddca863emr4819481lji.30.1662913737349;
        Sun, 11 Sep 2022 09:28:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id n26-20020a05651203fa00b0049876c2befasm453542lfq.289.2022.09.11.09.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 09:28:56 -0700 (PDT)
Date: Sun, 11 Sep 2022 19:28:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
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
Message-ID: <20220911162854.ivoeyzilpboplldw@mobilestation>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
 <20220909191916.16013-3-Sergey.Semin@baikalelectronics.ru>
 <20220910053203.GB23052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910053203.GB23052@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220911_092901_111409_9C51F59F 
X-CRM114-Status: GOOD (  17.99  )
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

Hello Christoph

On Sat, Sep 10, 2022 at 07:32:03AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 10:19:16PM +0300, Serge Semin wrote:
> > In accordance with [1] the DMA-able memory buffers must be
> > cacheline-aligned otherwise the cache writing-back and invalidation
> > performed during the mapping may cause the adjacent data being lost. It's
> > specifically required for the DMA-noncoherent platforms. Seeing the
> > opal_dev.{cmd,resp} buffers are used for DMAs in the NVME and SCSI/SD
> > drivers in framework of the nvme_sec_submit() and sd_sec_submit() methods
> > respectively we must make sure the passed buffers are cacheline-aligned to
> > prevent the denoted problem.
>
 
> Same comment as for the previous one, this should work, but I think
> separate allocations for the DMAable buffers would document the intent
> much better.  Given that the opal initialization isn't a fast path
> I don't think that the overhead should matter either.

Thanks for the comment. I see your point. Let's hear the subsystem
maintainers out for their opinion regarding the most suitable solution
in this case. If they get to agree with you I'll resend the series
with altered fixes.

-Sergey

