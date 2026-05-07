Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47389CD343B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 08:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIPqxPxC442ekrS5iZZYrSUH7eNMIZP8Hwrh6VPcuQ4=; b=NU9B7l4vRwu2F9dEs2NnsZQb2d
	xHJ5MK0kVB7MsacWyAB1PlSJ8ez68mHjdHMDCgEkGl9FkDeibYz/NXWDHyLugBimSk4VbFG1sD71g
	aacysCkMlfIeZ3iNAwzsI6yFheRC1uGeSIHVgogZdJxbdBjCSpCYj6m1eDAhl2Mso4W3d1J3WEYr9
	yF9s8L6e8esuoXorsod4ZkKN0+pFl9Q3kJ/LDmHUZtjwVJQ/PSQJ6cJA9377vGs0P4R81SkUVAcCl
	vyUPmEDFoXMakEg8TZuaShsPJnf59Qk7F8hUxZ3v0jeN47GwDB0B6HdlEi2lwbG2glphyhoAr1lET
	sjHNm5RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKtkA-0000000368Z-1xqh;
	Thu, 07 May 2026 08:06:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKtk8-00000003682-2C3m
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 08:06:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91B5A43ACF;
	Thu,  7 May 2026 08:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A13C2BCB8;
	Thu,  7 May 2026 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778141159;
	bh=mzo5hInL1GMeoZKQdJ0QsbZ5h1dsaidU5BwUTNW4xDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU1l5guOHozYQTJukgPDSQ2QDuPnBbrysovPftNfBsDpo/0ZS2J8/95Gw6hEXpVkP
	 sPzJe9aRk58BMYJ70OgzvJ8CpJ/PekGv56QPmgacBnB0zJskLWqHp0s2Mqjgy9tbNK
	 noAOrhRq49e30wkMxd4GPpYPYe0X2iViwktIYg4q/uPrxd9UPpYhXzbQi5hbeHBeNN
	 6zAtmIFNWo3VxSGAH5rtAs6fFxjdIYmkJiAxtRTNSw46qVoyeoiJkHR0ZKsBP3pPZg
	 H9cOkn4EP1gpr1P3opvgaLaec3GAxYdSmPqctmTdhOQLy2EVMqkvw/2NQqZ9PmYiE6
	 QhR6YNIQ15HAg==
Date: Thu, 7 May 2026 10:05:54 +0200
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS
 non-PI namespace
Message-ID: <afxH4g52fRXOyBsP@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <20260427003457.1264511-2-coshi036@gmail.com>
 <20260507054944.GB19796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507054944.GB19796@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_010600_578605_3D66BB61 
X-CRM114-Status: GOOD (  21.44  )
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

On Thu, May 07, 2026 at 07:49:44AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 26, 2026 at 08:34:57PM -0400, Chao Shi wrote:
> > +		/*
> > +		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
> > +		 * capacity to 0 (we return false) to prevent block I/O, but a
> > +		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
> > +		 * and reach nvme_setup_rw() with head->ms != 0 and no
> > +		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
> > +		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
> > +		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
> > +		 * at nvme_setup_rw() (addressed by patch 1/2).
> 
> This sounds like the Bug Keith is trying to fix in the block layer
> ("blk-mq: check for stale cached request in blk_mq_submit_bio") ?

Both issues are dealing with cached request corner cases, but they're
not really related. My bug fix is specifically when those requests are
freed, while this one is just racing with them.

For this patch's issue, how is the host being triggered to rescan? If
you're sending a "Format NVM" command, the driver would have frozen the
queues first, which would have waited for any cached requests to flush
out and prevent new ones from being allocated until after the format has
been updated in the driver.

It's possible to format the namespace from a different controller the
host doesn't know about, so we've always had a race where the actual
format is different than what the host knows about. The rescan would
have to be triggered some other way in that case (either through AEN or
manual sysfs/ioctl trigger).

We always ensure the queue is frozen when we update the queue limits in
this path too, so the driver and block layer should always be in sync
even if it's not in sync with the device. That in itself can be pretty
nasty, but we'd need a new NVMe TP to define a way to fix that. But
specifically on the driver warning here, I'm not sure how it is getting
triggered due to the existing freeze semantics around the queue limits
update.

