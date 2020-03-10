Return-Path: <SRS0=yUYt=43=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D0C18E5A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 19:16:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D279321D56
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2020 19:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohuFK+Lh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbtAlh71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D279321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WkazASeLTr8QVCEh7mhSAXGuGKC24yFm0w6aKHSxGJA=; b=ohuFK+Lh/JoZft
	Ig7SLeTZHnsEXgGOIoLPbTSK+66SOtp8hNqhG+L4oqQaNK8IMLh+O+M9IdNvCuo5E+lvolkQ+9yBn
	pX6uCo7vFFoMS7PFQfVRJkz4qySi53u6zlE19JuH3UN80MZL0VLAyZx9zNmxL3FBQQb6WvpQH3bvn
	fqwTs6oAhcIwX4gZpRciHZCs5kZ910ZpH6FT6jn530YX3Pi0s+3SakWgY2LGh42M7sXDckXSpvrjB
	93C4iuh6qva2TwR5LDAMHea8alGm7s7ox7ksH7p0JYkrxeuzIbg/BKJgNLlVVoCvSbzTtCVypXWiG
	M/4oSrPDE9AGpirkbICA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBkMf-0003oj-Ez; Tue, 10 Mar 2020 19:16:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBkMc-0003oI-Di
 for linux-nvme@lists.infradead.org; Tue, 10 Mar 2020 19:16:27 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 667D020727;
 Tue, 10 Mar 2020 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583867786;
 bh=peLo4m7flZWNXU5TgxRc5LxwDIeNsGT4w1UWbpq3EhE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lbtAlh71CZbSFDkaP93ODwkol/THLYsFFq58OqsJZklUO/31QqundDgwbIYMPWfHi
 sGdCK7Kz0V8GVtVkorK9vgbwhLJLgnfA+FTksmRsg3daIIgMgHdcqyslUpmwspTAD4
 UEiV5sVoHIWAmw4ZlNBWEag7ZjK8zWWGgwtFpUwU=
Date: Wed, 11 Mar 2020 04:16:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 3/3] nvme-pci: Simplify nvme_poll_irqdisable
Message-ID: <20200310191619.GA17237@redsun51.ssa.fujisawa.hgst.com>
References: <20200304181246.481835-1-kbusch@kernel.org>
 <20200304181246.481835-4-kbusch@kernel.org>
 <20200310170226.GC7114@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310170226.GC7114@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_121626_479563_97CF977B 
X-CRM114-Status: GOOD (  14.76  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 06:02:26PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 04, 2020 at 10:12:46AM -0800, Keith Busch wrote:
> >  /*
> > - * Poll for completions any queue, including those not dedicated to polling.
> > + * Poll for completions for any interrupt driven queue
> >   * Can be called from any context.
> >   */
> > -static int nvme_poll_irqdisable(struct nvme_queue *nvmeq)
> > +static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
> >  {
> >  	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
> >  
> > +	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> > +	nvme_process_cq(nvmeq);
> > +	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
> 
> This could use a:
> 
> 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));

No problem.
 
> >  }
> >  
> > -static int nvme_poll(struct blk_mq_hw_ctx *hctx)
> > +static int __nvme_poll(struct nvme_queue *nvmeq)
> 
> Do we really need the magic __nvme_poll?  struct request has a
> pointer to the blk_mq_hw_ctx, so we could just pass that.

Sure, I just felt like req->mq_hctx should be private to blk-mq. It
isn't, so we can use it from the timeout path.

> > +	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags))
> > +		nvme_poll_irqdisable(nvmeq);
> > +	else
> > +		__nvme_poll(nvmeq);
> > +
> 
> Any reason for the odd inversion and not simply:
> 
> 	if (test_bit(NVMEQ_POLLED, &nvmeq->flags))
> 		nvme_poll(req->mq_hctx);
> 	else
> 		nvme_poll_irqdisable(nvmeq);
> 
> ?
> 
> Otherwise looks good.

Thanks, I'll rework the suggestions in.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
