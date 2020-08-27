Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE3C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8351222BEB
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Brv59UWr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWs/tevX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8351222BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GamurcR6Q9Cap+PbeWHWv9htNn8qrP93MhP6MxcE/EA=; b=Brv59UWrkpuKPYkzv64VPG1AR
	9bVo9Fnm0P/bmxt7i+42lcpgFH12dMB09Pvd7qeD4QTkLbib3qRnZ49DKlHnA/3B+tZqqbSHn5Pmu
	e/8pTHNjhyVeaA+pJEP5DhsMw3gYORxO59fdOiQ6853zJW5R/M9tll9FP3JuJjII36gg/Ue7fWPBs
	use74cIEpJdJNHzf5CQfB1/3L2OKD87fR+AII+K8rGRGJ/cgz3Avv7p359bkgxYkmxwIpuflm8O95
	ZShVOfXhd46xHSH7X6Lzerrcc9aJkGcFWDhKpQIES2Q3KIV+JU/TJAC+dv3cJHKnHfG405fAaoX2e
	VbD9YhgXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBL0U-0005pd-I3; Thu, 27 Aug 2020 16:44:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBL0S-0005p9-C4
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 16:44:09 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51B0222BEB;
 Thu, 27 Aug 2020 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598546647;
 bh=Vh+Yh1MjQZRRENbcRplKqekWzbDDFmSGRhOolpRikqY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HWs/tevXpNyQfUrtzh1PPgttiRBTERrK7rSJyc7qkyxi3/O3ZmIK9OwNO15diWTjp
 P11QhPXM0ns3zuQR0rxNrklYqCgSZP1y7sxBoki3B5HXhlisC2ZTXN1i3pc03x9nRr
 82kQSOaw/VeGk8turSkLwE9WgcC8NfBOZOLmro3c=
Date: Thu, 27 Aug 2020 09:44:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200827164405.GA2810820@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <20200827160644.GA10869@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827160644.GA10869@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_124408_503692_D55E8C48 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 27, 2020 at 06:06:44PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 27, 2020 at 08:28:24AM -0700, Keith Busch wrote:
> > +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
> > +		blk_queue_chunk_sectors(ns->queue, iob);
> > +	else if (iob && !(disk->flags & GENHD_FL_UP))
> > +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
> > +			ns->head->ns_id, iob);
> > +
> 
> Similar to the zoned stuff I just find this super hard to read.
> 
> I wonder if we need to untangle this a little.  Something like

That's fine. Do you want to see a prep patch splitting chunk settings
first then power-of-2 check second, or okay as a single patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
