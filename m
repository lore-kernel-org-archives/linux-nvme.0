Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0DC5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 21:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jr9eYKTRVVDN7ldqya3Dbl7nbSqPQXaDetUbrNqdQwk=; b=sRVGJolITRjRP7VlIlF/PPr4kC
	+s2yThshVOs1zWwcSoH/3K0HR7x6QOo4pacubgQasY8vFCXplfjEMoSUl95cy+exLaL8rWig1jBu+
	vU0EyPt/stfs3xnotHMHDzKvv8tfl6wTslLxNmMzRBiYwLmMv88CWIyw+hLfGNK4/QcjAxUTQAlCr
	dbZYOoIu1qF56lrAS7yMJg5mX1TC2/k0wdCrx9//KtkVayB1ca8GF9dhDf4Oh4WcSRtTlhsHTlxgP
	wJoFUJp15UR4OPnQlT55u4Zw6QHzFS+ROmVZjG8K65Rk4lQkhPdWI86MefwamObZ6H8HFuaJ+STsa
	dMgSHsHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riha8-0000000BLOc-3lmR;
	Fri, 08 Mar 2024 21:16:44 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riha5-0000000BLNy-2haF
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 21:16:43 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1dbd32cff0bso21990725ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709932600; x=1710537400; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jr9eYKTRVVDN7ldqya3Dbl7nbSqPQXaDetUbrNqdQwk=;
        b=clLb6DXLxmhXjGslIW54rSyT1He9cjJcE8/cRNmELcorB3vA7DhGK+DaKiSjXtcaW7
         fSSMuGIbNU+R1au3M0Uxi10nYMrByfdBeCkDyaQ0nMQor7P2dJJYGavYaRD2lD2zphce
         euYYJ6Op666plpaOhyp40zcMUs5yszLkloSQkqMqGE9A5xbt01GBWdltP2pu3BAo5hGv
         k0B6zstR6IQpcxYMJXBPuQ7uAggn/RngN2L/R3AblOuXrjtXZPdgunvITuXySlhDdG/s
         Hfd4QstvKYSXO4ATJtkb5qMgMRx0oiNQSq/v7Q/4kIcvFRzhZVD+RHnWIUmYNLQhdu7q
         89gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709932600; x=1710537400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr9eYKTRVVDN7ldqya3Dbl7nbSqPQXaDetUbrNqdQwk=;
        b=baCU8eO7sn9Fm7bS+bnzR3fruk+FITEF2X3GaaRVXbKt0UMFzXWX25W8Jn+sjhEKjq
         AkL2g16VRUDf4FfU+NJelbhRZVGTZAgPUx9NlLzUmC0cZEPFVMtdRyrqNmoiBL3gyX2X
         FJtuWqwU+IYgsDoJszbXhyJvVhJmIo92Hgl3UuNAm4hJx0Gst+BLxlZo9YBAftIlr5JR
         lnfFtwct3XVObBKOVJeKWyVLI3SaMpb9cDJcugVbQaEAidPtAcYStnDP6Mr1mIlJB910
         jUwbdv5k49HSTbqFM5YgZJszZc+n5ep/XR3msoTLdDPa8pFvHUKcMkVLscqwjONAmOuX
         GyXA==
X-Forwarded-Encrypted: i=1; AJvYcCW0i/zkppPuXPE5X42ZlU//zMD1sCwpB6eeBUtellofMlEwR9CAddwR+I8snq9Rqv/QMDFZmeN15KXLiyPnNndnnf+B4S73uCzX7ICTaGM=
X-Gm-Message-State: AOJu0YxZUoy8kRuWW3ICj/E/jWrSgtS6Y0V+bGrsJh0x8NSVsx3N6t5A
	ufLKILF4d+7YcZzbWeFI37iDKDJxs+ieDJ8dbDIX2O4Pcm8sLC8NCPhMFjIX3ETgkt75wCMG2JW
	W
X-Google-Smtp-Source: AGHT+IGC5toWvVymL2e4YI/lheIXtWwXJD0bcxn5Ysx/cu1diLDacyRuT/F5EyLXKOmgYPFjhR64QA==
X-Received: by 2002:a17:902:f551:b0:1dc:518e:45b7 with SMTP id h17-20020a170902f55100b001dc518e45b7mr343328plf.49.1709932599964;
        Fri, 08 Mar 2024 13:16:39 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d08300b001dbcfb23d6csm83177plv.267.2024.03.08.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:16:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riha0-00Grxy-1h;
	Sat, 09 Mar 2024 08:16:36 +1100
Date: Sat, 9 Mar 2024 08:16:36 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/10] block: move discard checks into the ioctl handler
Message-ID: <ZeuANC+r7TOSGHmd@dread.disaster.area>
References: <20240307151157.466013-1-hch@lst.de>
 <20240307151157.466013-3-hch@lst.de>
 <ZeoylEeVMt2fXT2R@dread.disaster.area>
 <20240308152244.GC11963@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308152244.GC11963@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_131641_952323_6E4BA5C4 
X-CRM114-Status: GOOD (  18.20  )
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

On Fri, Mar 08, 2024 at 04:22:44PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 08, 2024 at 08:33:08AM +1100, Dave Chinner wrote:
> > >  static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
> > >  		unsigned long arg)
> > >  {
> > > +	sector_t bs_mask = (bdev_logical_block_size(bdev) >> SECTOR_SHIFT) - 1;
> > > +	sector_t sector, nr_sects;
> > 
> > This changes the alignment checks from a hard coded 512 byte sector
> > to the logical block size of the device. I don't see a problem with
> > this (it fixes a bug) but it should at least be mentioned in the
> > commit message.
> 
> Before the exact block size alignment check as done down in
> __blkdev_issue_discard, it just moves up here now.  I guess I need to
> make that more clear in the commit message.

Ah, eyeball pattern matching fail on my part - you changed it from a
hard coded '9' to SECTOR_SHIFT as it moved (which is fine!), I just
missed that. All good!

-Dave.
-- 
Dave Chinner
david@fromorbit.com

