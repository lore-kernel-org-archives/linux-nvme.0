Return-Path: <SRS0=mcGk=ZW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EC1C432C0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2019 18:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6E82082E
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2019 18:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d/a7yF6O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5REh3Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6E82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZpqdYkKr3iSsJ9Na0pv+XQXLSM8gsij1Ej+Fw3sZ8U=; b=d/a7yF6Ol2zYCJ
	fi2aHhOqrtXuwhKTdbkccbGPhrOPHoWF5SW6jaME3OIBi8blyqv7m1OLx3I3YiLsyifzdYn2p0kZE
	vTtH/6FqrCBEztb2vwF0S5UiGugaQMpft7gSy8sbYzMCxTChsQfBolzOZiHmrDdK+JOtRouyW3tqw
	gJg/YzVGTfif5E2gTqt5qvnBPzIKRxLZefWtP76QUs9bm1lZUPtTy1CgqPpeVHwjR0aZs0P4o7gXz
	Ibz7I4uWQLvVHeHoJIxybH2rGsm1bBFKMjvLmdBCdrM3eNinqnAVYQq5wPsGTq10cRLnZHEKKlzxs
	Pkjq1rwC/nMA3CThupng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ib7CR-000116-MZ; Sat, 30 Nov 2019 18:10:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ib7CO-00010c-H0
 for linux-nvme@lists.infradead.org; Sat, 30 Nov 2019 18:10:29 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D0EC72075A;
 Sat, 30 Nov 2019 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575137427;
 bh=RVRF3pwWh41xQRM9pTXcv3/JoZI+2tVe922JMkZykNc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O5REh3HuT3f2E7BLgekH7zghxS4xNNpwu9hmwc3VPqQmSvPRBAMmJGmpxJoykv4iQ
 d1SBBj1hvsyPf8q6M6DJZ/mzwnRJlHVa5ZsxjGEiuxDHBDKeYDDJ7KmII4XdsWpmuZ
 bbDWUTA5KHURtkFP+bRrrZjiQRBMeHVhJjfqjFNQ=
Date: Sun, 1 Dec 2019 03:10:20 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191130181020.GB5273@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
 <20191129091302.bngxlcsbexiktqbk@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191129091302.bngxlcsbexiktqbk@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191130_101028_594848_1BEB4247 
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

On Fri, Nov 29, 2019 at 10:13:02AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-11-28 02:58:24 [+0900], Keith Busch wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 571b33b69c5f..9ec0933eb120 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >  	return ret;
> >  }
> >  
> > +static void nvme_irq_spin(int irq, void *data)
> > +{
> > +	while (nvme_irq(irq, data) != IRQ_NONE)
> > +		cond_resched();
> > +}
> 
> That interrupt thread runs at SCHED_FIFO prio 50 by default. You will
> not get anything with a lower priority running (including SCHED_OTHER).
> You won't get preempted by another FIFO thread at prio 50 so I *think*
> that cond_rechsched() won't let you schedule another task/IRQ thread
> running at prio 50 either.

Hm, if we're really spinning here, the current alternative is that
we'd run a cpu 100% in irq context, which has its own problems. If the
interrupt thread has other scheduler issues, I think that indicates
yet another task needs to handle completions. Perhaps escalate to the
irq_poll solution Sagi advocated for if the threaded handler observes
need_resched() is true.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
