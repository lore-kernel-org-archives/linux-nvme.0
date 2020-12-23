Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 18:31:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F30022286
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 18:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F30022286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AnFn2Z5c7IK4WYi4flF4ov8VGDM3mO7u0Qpz3HgTeuc=; b=evM8LgxK+DXwf8yw1d53ac+db
	hdPFQgMZw2cXmh23VLg5j4glzQ8QhJ3+9p/iHGOxMi52K/vxtnpIaemT2q89hRJS//xMJWE0CU0bm
	BMnO1BooHNXZ9IdMD3v/k3SF6ke0xlysXrVjIvA4vg0rCF8RW08npCbn3tIDMdECedBiwgnxOB0hI
	ifXXy6xlrpjEDmeT/TniYhzRe+gTaVfm5eRHtzolkTgMZbGBA3aUJlM2FDgnM+b+rLT2n2WwaXGfB
	f6ULxuGVZQ7XzWzscQFPbryvRCv8Wn+QGuGXzrHPD0mBa4a6Oi9zhGks6ef/Pr5SLNvx2pfqVEiQp
	ZF2JxBpUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ks8vO-0006Mz-59; Wed, 23 Dec 2020 18:31:50 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ks8vM-0006Md-6O
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 18:31:49 +0000
Received: by mail-pg1-x531.google.com with SMTP id 15so115855pgx.7
 for <linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JnpI6LhmMGk+FuAkC4hEiEZ/iwoRhterIinJkyNBzjM=;
 b=tHz+bIdufgAO/iPkCzEAlhb9iW9D9hsevXt5aV7agMNPAk8571dJqBgeUb0IHNrtvr
 e5XKPu2e+hOTRJngdF8FdnqsLhmmY3FAfNTZlLAmq1ugcnISqqOF8GTUGiMYCTlaRcpP
 pCbfvw7n5t25cnJLSbE2BCbRgk6g7PrusG8e7NUAlzwwJom2TAS+7p7nbzGW4Va1wION
 9HPvSOZalbmhR2XeNAvVfP1mAuowl7JWcEr11/oq8RFK5njhVxMV/QptsjuukUz22RS5
 e/AMTpDyrIlsRLr0niyvEyPiWeJ6fhU3uFPS6+ojYQlPg/KKm7BUSmu0WhqeppJ7uh13
 7miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JnpI6LhmMGk+FuAkC4hEiEZ/iwoRhterIinJkyNBzjM=;
 b=nEv/piesyC1pPu8NOhOEyPRyq2rRqjrAVC2XdMxa8TXMzd5tc+0xEz0g604MPKurSy
 o9b4LqacHS9YLDJadXwp2gIku7RwTUAb0TnJwgaNgni66Dich6fkSzpbBNQMIoIA2EYj
 7OC4T4q4fpW9Mv7+RmOt1GzNLQjRzJzrX2Boe2kCMvZNc8t5MyqBf8h6hoB754c350qa
 oPGb/o7clMFnVxgWbyXFJlqHfykpgy7JfUldCeQ/PjOlkMkLw74O4joKJeUFQpbYM9PK
 OTO1GelHG7SDWBk36M91ixzJCTTjv19xogkOounJjJDD8Vs8Q8MPh7fZ/TuzkgdoEA0J
 282Q==
X-Gm-Message-State: AOAM533nWPUD3VPq1oE2ObdgD/VndITDiXeAQmPMx+wAT20cBeAmB1jC
 rSPZgAOWtn8Kb4l7W8qGojM=
X-Google-Smtp-Source: ABdhPJzTHLgLHvUOB5xQOKUa2UPBletPb0mM3/gpCiwCZI8Tb+Z1pvLFNquqb1Vo/hF3tAXkcjVOKQ==
X-Received: by 2002:a63:fc42:: with SMTP id r2mr7457043pgk.234.1608748305810; 
 Wed, 23 Dec 2020 10:31:45 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id a18sm23945720pfg.107.2020.12.23.10.31.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Dec 2020 10:31:45 -0800 (PST)
Date: Thu, 24 Dec 2020 03:31:43 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223183143.GB13354@localhost.localdomain>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
 <20201223154904.GA5967@lst.de>
 <20201223161650.GA13354@localhost.localdomain>
 <20201223162737.GA8688@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201223162737.GA8688@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_133148_279670_7F980332 
X-CRM114-Status: GOOD (  25.84  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 20-12-23 17:27:37, Christoph Hellwig wrote:
> On Thu, Dec 24, 2020 at 01:16:50AM +0900, Minwoo Im wrote:
> > Hello,
> > 
> > On 20-12-23 16:49:04, Christoph Hellwig wrote:
> > > set_blocksize just sets the block sise used for buffer heads and should
> > > not be called by the driver.  blkdev_get updates the block size, so
> > > you must already have the fd re-reading the partition table open?
> > > I'm not entirely sure how we can work around this except by avoiding
> > > buffer head I/O in the partition reread code.  Note that this affects
> > > all block drivers where the block size could change at runtime.
> > 
> > Thank you Christoph for your comment on this.
> > 
> > Agreed.  BLKRRPART leads us to block_read_full_page which takes buffer
> > heads for I/O.
> > 
> > Yes, __blkdev_get() sets i_blkbits of block device inode via
> > set_init_blocksize.  And Yes again as nvme-cli already opened the block
> > device fd and requests the BLKRRPART with that fd.  Also, __bdev_get()
> > only updates the i_blkbits(blocksize) in case bdev->bd_openers == 0 which
> > is the first time to open this block device.
> > 
> > Then, how about having NVMe driver prevent underflow case for the
> > request->__data_len is smaller than the logical block size like:
> 
> Not sure this helps.  I think we need to fix this proper and in the
> block layer.  The long term fix is to stop messing with i_blksize
> at all, but that is going to take very long.

Agreed.

> 
> I think for now the only thing we can do is to set a flag in the
> gendisk when the block size changes and then reject all I/O until
> the next first open that sets the blocksize.

Let me prepare work around patch for this issue soon.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
