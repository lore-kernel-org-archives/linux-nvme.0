Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8F9C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 18:36:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1DB206DA
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kcELSndV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kASz42o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1DB206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nBNRO97hNrg1c+VXTngbr5KUYD0eCoZ3U6mWnJf3F5c=; b=kcELSndVJF/uVb
	mL2MnaEQKMnZNu7Y3EdBSLZ597FW/gaopFAdp2MhvaHh3Avf3opgTd1KJxxv31kUYRS7zgP9GDSHs
	aknnPOSZEAj4efjQkxZV24/DGIjstp6oVwyRu4LOSHvKWcW1ibJehHVeFiBHK9Z+SAxQIqhawgZ6T
	fKmzoJAeNRR5IHX15nLMD+rTubNj9jNK+Ue1HW4PdtNrIH9dPHK9dC01CNSTxIKt586dWiU3qSWJC
	9+BKJ+0Aw8FEyPtqkjPHkth8h+O3yuZQvB4gBwMeg/vqWaCSp4w08Fo01fcXq8M9mfUOfl5Y2K1sH
	TAP7WVi0g9+90QPaA2ZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifTK5-0006Za-LF; Thu, 12 Dec 2019 18:36:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifTK2-0006OO-R6
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 18:36:24 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F6912073D;
 Thu, 12 Dec 2019 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576175780;
 bh=bQOCFPfJG8bj70xL7fLc23pGr7lXc7LmPgNE06gXHNo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kASz42o4du3lMjbs9oNocTRYBUfNdYPok9qeCG7kqI4i2jtbBV341GdR4F9hw1JKY
 RArY11NsmRZ8e0QG0JYdbgYZc/B5B+baayI2QTTCFApu9fdOMZcH0om8RX+13BzoPM
 KB2QiPZs5HrWm3i13+8Vz1/oHfV5ezgPUFg18jAI=
Date: Fri, 13 Dec 2019 03:36:12 +0900
From: Keith Busch <kbusch@kernel.org>
To: tsutomu.owa@kioxia.com
Subject: Re: [RFC PATCH 0/5] to add more nvme reset functions
Message-ID: <20191212183612.GA30877@redsun51.ssa.fujisawa.hgst.com>
References: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
 <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
 <58ecb196bb1844fda85b3ae4bfc5bfe4@tgxml778.toshiba.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58ecb196bb1844fda85b3ae4bfc5bfe4@tgxml778.toshiba.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_103622_916274_129EEA80 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: hch@infradead.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2019 at 08:36:27AM +0000, tsutomu.owa@kioxia.com wrote:
> > From: Keith Busch [mailto:kbusch@kernel.org]
> > Sent: Thursday, December 12, 2019 1:18 AM
> > 
> > The majority of this series is at the pci protocol level, and the pci
> > driver already provides the requested capabilities (but with a more
> > safe implementation). Let's not reinvent it just because one nvme
> > transport happens to use the pci bus.
> Thank you for the comment.  I'll look into the pci driver again to look for 
> functions avilable.  Would you please point out function names good for
> conventional hot reset and/or link down reset which can be called within
> the kernel if you know.

The pci level reset that's safe for a user to invoke is through generic
the pci driver's provided 'reset' attribute. That will verify different
types of pci device resets until if finds a supported one. You can reach
it for an nvme device like:

  # echo 1 > /sys/class/nvme/nvmeX/devices/reset

The kernel's entry is defined in drivers/pci/pci-syfs.c, reset_store(). It
calls pci_reset_function().

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
