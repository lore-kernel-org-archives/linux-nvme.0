Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E19C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:28:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1557215F1
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jK2aVXm9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oot3z/ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1557215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bQunRcbl4uYRgKOSfkL3+PO8UGQwFYdbpP6aRHbdZdE=; b=jK2aVXm9pb1Ivs
	gEVWbexz0picvpVI8Srklik290wAAUoTMFr6OEyR1TT3T08KpEz/0eLD5/MC1YYqOj/+FO7UTp0D6
	VfuTYiIa5/NvZQwBrwVr46Dfm1z8m8qJmJtv4YieyFlq/teDBTYNeaYkvdnwLwN62+L+wqM2PbSzB
	FQDGbcA5/KpqnEms0duc1RlRXTftx06gNkdfqbZHjUKcrqQZIyZ5wsC6+lltb5L8izxBuxY3pqnrl
	afJyrMWPV/7hxe2ls/z3sLSQ58o1nsSvbYZt8rW1EuTyQUoHOhDY4Mgh1YicoSGXD28oFjG/nFk1i
	zM6hDnm8vNXwwpCH8NYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaAU9-0001HW-Sc; Thu, 28 Nov 2019 03:28:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaAU7-0001Gv-Ro
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 03:28:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BC8D2084D;
 Thu, 28 Nov 2019 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574911731;
 bh=Pt8lZ6VWj5pPa+knVbq9K6IBaipvmuxDNEStDzn0Jgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oot3z/ihi/VWFluUe1HsEwp81cf3f0w4dMdpwNIeajmJvDiqrk78s80btAGBclmCQ
 K2voV8KVsho1kk9FaoNwspKEzIu8tOyB3YAK44O/vcOAE6P2rQCamPf977a1yfRhGR
 UPBJzk4AZ3t+iYjp2m6/7crnw8vTEZsbCfVEPtXg=
Date: Thu, 28 Nov 2019 12:28:43 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191128032843.GA1738@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
 <11325d8e-e9f8-408e-18c3-182c69e90eab@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11325d8e-e9f8-408e-18c3-182c69e90eab@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_192851_928806_50FF74BB 
X-CRM114-Status: GOOD (  16.43  )
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
Cc: bigeasy@linutronix.de, helgaas@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 27, 2019 at 06:46:55PM -0800, Sagi Grimberg wrote:
> > For deeply queued workloads, the nvme controller may be posting
> > new completions while the threaded interrupt handles previous
> > completions. Since the interrupts are masked, we can spin for these
> > completions for as long as new completions are being posted.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   drivers/nvme/host/pci.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 571b33b69c5f..9ec0933eb120 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >   	return ret;
> >   }
> > +static void nvme_irq_spin(int irq, void *data)
> > +{
> > +	while (nvme_irq(irq, data) != IRQ_NONE)
> > +		cond_resched();
> 
> So the cond_resched should be fair to multiple devices mapped to the
> same cpu core I assume.. did you happen to test it?

It should, but I'm having difficulty expressly testing that. Frequent
spinning here needs a single queue mapped to multiple CPUs, such that
one or more CPUs can constantly dispatch new requests. I've one test
where this spin never exits for the entire duration of an fio execution,
and /proc/interrupts confirms only 1 interrupt occured for many millions
of IO.

When you have two or more devices with queues mapped to multiple CPUs,
their threaded interrupt handler affinities will not share the same CPU.

When we have per-cpu queues, all the devices' thread affinity will be
the same, but the while loop usually spins around only a couple times
because the submission side is sharing that same CPU. This naturally
throttles the number of completions the irq thread can observe, so the
thread ends up scheduling itself out without the cond_resched().

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
