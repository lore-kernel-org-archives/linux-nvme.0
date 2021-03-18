Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E853EC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 16:52:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C72B64ED2
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C72B64ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4z34fY7VJkbladZ5FkNOr2hCMr/OSPX6AHI7r2ou7xM=; b=jsiIucyk6ExewXrmcaR4K5WV5
	IZYiLvI5pbix2MGISCUBOG1/dW0AIyASGIo46A5UDlc92eHtRCFvza/Z1mkP+gVk8C7DioH+gi7md
	yTZMarTJqc62DcZj6yY9u/Ve568ZV03PSMGDSql5uoKF/nJxD4OcZcqO8IC3LV5FD2kXeTvj++gFl
	SxVx7JGFlsjVkRG+sfHXvDrd1ETlE08VQxvYPLBPRwi6WtHbCv0D1x6Rs2rDA5J2v3GM2A9jGkKt2
	59ID8Dz6LSGA3Vsn+QzVyLmzrFnKNJ3P7pD+b/4/DegntmtpMMtCwk50OiTKup9CEdZMC7DC4akN5
	MndntY7AQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMvsn-005dm7-7O; Thu, 18 Mar 2021 16:52:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMvsj-005dlk-GB
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 16:52:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CCEC64ED2;
 Thu, 18 Mar 2021 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616086340;
 bh=q58SngFHNKI/W4QBN53cy2cf74PMJWOhDGrRx3Dy3Nw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UXbpjnFpJb+TqYz5NqbjEjQIfz3ihOB/jP18ymfD0yOWGm5/NrVrMgy8viVGOq8Pf
 ccmMwx7doJCZXLsCnyuUXUzviaTHP0cBIQ16lfZhgsTtiE51iw0v+5OEKTRcqta8R5
 wXdf8SRqKiySgX4BFj8QWcBy442ghryx6bB4nBA14ldny6JT9fYyZy3XsMGSGyfNqa
 l+/fMBr9nchbObQ+Cc2lHQOAuiI9ce2ao29tA0lphXPrWVkThMCfA1bbvXyRu+B+Uq
 NFlZPRNv8MPxtsf1igFnAyZZ/sZ4VSrwzmtT+rh/ncBHPFe89mbVb3xJ0agYz2WJ8r
 IMDaR+fImsUCA==
Date: Fri, 19 Mar 2021 01:52:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_165221_794817_502BF08B 
X-CRM114-Status: GOOD (  15.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 18, 2021 at 04:28:24PM +0000, Alan Adamson wrote:
> 
> 
> > On Mar 17, 2021, at 9:38 PM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > On Wed, Mar 17, 2021 at 04:46:14PM -0400, Alan Adamson wrote:
> >> This patch exports the NVMe Controller CSTS register via sysfs.  This
> >> feature can be used by userland executables that accessed CSTS and
> >> possibly other registers by mapping them into user space.  Since this ability
> >> may not always available, exporting certain registers via sysfs provides
> >> a safe/read-only way to access registers from outside the kernel.
> > 
> > So what is this application doings with it?  Should we just have a
> > ready attribute instead of exporting a raw register encoding?
> 
> 
> Was using nvme-cli show-regs to manage nvme devices. This is no longer an option.

Most distributions ship with kernel CONFIG_IO_STRICT_DEVMEM these days,
so that user command will very rarely work on PCIe targets anymore.

Perhaps we could introduce a driver option allowing read-only mmap on
this memory?  While you're currently asking for just one register
attribute, it would be nice if we can make all future requests available
without piling on more sysfs properties.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
