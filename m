Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73633C432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:28:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC0A2075C
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FTrNGzer";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK8HyBS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC0A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7hUuj+5f9fzzo54ZsRZHlYliRLy5elqLcmOLWNrA3PI=; b=FTrNGzerMMpync
	+UekzBPRVCatD0eG44R6JkJ/CBE8V5RxRrKGZ/c04qQEJKGfNEVYC9ZzJMe51ZOrAz2/R5TYZ0PWO
	WfhOhN4aUlaW6rzH7bnaHj0Z767KVmEdnGgd3dhxVkW7b5R55rhBclWxCm27K2yq4JNFspvxBd5A6
	CNfLENM0pKTr+62Mq7C6GqE6iPnwPhq1lH4xafOihVKExVwq2kY+Q9z3fIacUxXtjlWWzSmwxcOeT
	f6kMV+lgloKjL9espkXmEHOs+d7XJ3GKWhL+ApRfQjbYgxAm3fwy++lxIBTQ2KJ9+NV/+fZG4SfUO
	25Wjk+iab35B21PUUucQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZjJu-0007sX-KT; Tue, 26 Nov 2019 22:28:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZjJs-0007ra-4t
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 22:28:29 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D35472071E;
 Tue, 26 Nov 2019 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574807307;
 bh=G8TsFm4HtiIeFlcphuwR9DaPZgFIr8kwyMli18xR6qw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sK8HyBS3LTQY0XF+qk7NOb6HC5FCQXsl74zuPbu3NfiAj3BJvqRD3bn7uLIPXnS6g
 /hix1Wnb0SOQAYBQzHGlKBnO+YvBFiMOdDOL7ieIwElEjfs57XoIttYFiBJpt/H861
 Zh3uBa8dCYOzd5WCzufhyBh96ei151Aeryppxfrk=
Date: Wed, 27 Nov 2019 07:28:20 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] nvme-pci does not disable interrupt-source in threaded mode
Message-ID: <20191126222820.GA18211@redsun51.ssa.fujisawa.hgst.com>
References: <20191126202814.vrfezzu6eon7tbf6@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191126202814.vrfezzu6eon7tbf6@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_142828_212707_1442E38C 
X-CRM114-Status: GOOD (  10.56  )
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
Cc: Jens Axboe <axboe@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 26, 2019 at 09:28:14PM +0100, Sebastian Andrzej Siewior wrote:
> One of these should be done:
> - remove "use_threaded_interrupts" and rely simply on the "threadirqs"
>   kernel command line.
> - Let nvme_irq_check() disable the IRQ-source and nvme_irq() should
>   enable it again once done.

There is an nvme specific way to mask interrupts really quickly, but it
only works for MSI. Can't use it for MSIx...

> - Pass IRQF_ONESHOT as irqflags.

IRQF_ONESHOT adds two non-posted transactions through pci_msi_mask_irq()
and pci_msi_unmask_irq() on each interupt. That's pretty slow.

Maybe we could have the nvme driver provide its own MSIx mask routine that
skips the readl(). That might mean local interrupts get renabled before
the device sees the MSIx mask set, but maybe that's ok?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
