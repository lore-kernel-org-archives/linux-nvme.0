Return-Path: <SRS0=6Pwq=ZV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351CC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 16:27:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864EE21736
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OxvY73OG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvjfeG/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864EE21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/YHkMYO/UXU7YYcF5JBpazc0gK3JCwkgwjNfQRc6T2o=; b=OxvY73OG+S02t3
	lTGP1VjT5nhF5h6zbzaigGKJMkO8C2k6rcAbL9hyDXkFNOmRgahw/Pbx4JzmvmrnwACMiTlMXnlw2
	e2hAfR9VUWLGTcxcjrIKSvbJx3dOZNwewbOHH+QnU7nkjOWQC8ujIfsNAT8K373v3sXRpAsVCpc6V
	yLx/8ECByuCH9TyOGVtdSa0oyq3oN8kp23DCdoqiNEHY0OXxyHV1SZuUi8HfycQIY7UenkplJMSqM
	E6ESajZgNvyrETo7pvmdl8nwmTJ1Au5anYdJci8x5q4QT08i98vbV/n53Bw3U/v5/UUOWiS4a4nNC
	vHE5XfEVQFkF6fsYF2Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaj78-0000hE-NP; Fri, 29 Nov 2019 16:27:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaj75-0000gv-IG
 for linux-nvme@lists.infradead.org; Fri, 29 Nov 2019 16:27:24 +0000
Received: from C02WT3WMHTD6.lpcnextlight.net (unknown [161.97.246.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00D0121736;
 Fri, 29 Nov 2019 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575044842;
 bh=PtXZBX2tJ7ZFj2m9poMD4MEvE99te2flrdbx/lBsEIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IvjfeG/hdSzSG5sWiI3xcKznK6dNXgAuyOBE9c89M3rNmQ9JidCPVD+IYk3G/uOTF
 YKdtG1tjPBwGOoeATTWBWqYW2JbOQuTZQfisxQh4TD4nDoPo3wZlnML7eBtM374pKF
 B4XU45T9Oz0V+xWhIgPyIKd2Aq+pqhXA+g91GbrA=
Date: Fri, 29 Nov 2019 09:27:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191129_082723_622428_FAA4DE00 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: ming.lei@redhat.com, helgaas@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 29, 2019 at 10:46:40AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-28 02:58:20 [+0900], Keith Busch wrote:
> > Threaded interrupts allow the device to continue sending interrupt
> > messages while the driver is handling the previous notification. This
> > can cause a significant amount of CPU cycles unnecessarily spent in hard
> > irq context, and potentially triggers spurious interrupt detection to
> > disable the nvme interrupt.
> 
> Thank you for looking into this.
> To be clear: the "spurious interrupt detector" won't do a thing if you
> never return IRQ_NONE. As long as you return IRQ_HANDLED, everything is
> fine.

That's not entirely accurate. We have to return IRQ_WAKE_THREAD
from the hardirq handler, which gets converted to IRQ_NONE if
desc->threads_handled hasn't changed and considered spurious. If
the threaded handler runs sufficiently long, desc->threads_handled
won't get updated frequently enough, so this series fixes that for
nvme by masking the interrupt in the device, preventing future hard
irq callbacks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
