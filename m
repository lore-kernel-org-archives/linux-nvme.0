Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6C4C3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eyJpE3KWQYn/ymHW3x9YOT3A5+fVcqbK/X3WriJMynY=; b=ka6mxafsEOiaypb/JgT7CN4pXh
	jein0oaJ8uzFPfwgw0qcVODpcLCaICYCEQJOEIq1w934KFpNyBN6h5aUqu+qVlf1edAMRp7jfokqm
	N8ZPTwoyb8BE9mOWz9pafm3WzwhmHOiP/KhqwObLP/KC+/aPPHQyu78XimRpenliAUQNBP0lb+2le
	Bkm2acjSjto6NrWQ/Zb16Fj4vObSK+ro3RN67WwY8n6NbrYrivSx4M7x44NewqrksMlgSZ2f+XHRL
	M3sZabZVIfIpT/Au890LCt/NDF4v0FrAGL2DgUUZkhLuOnZ5KwQJbaWhvSl65+ZA84b4vMK3L9QDq
	c4GBu8dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHoWr-00F2Yl-0O; Tue, 17 Jan 2023 16:09:41 +0000
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHoWm-00F2XD-56
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 16:09:37 +0000
Received: by mail-oo1-xc33.google.com with SMTP id c145-20020a4a4f97000000b004f505540a20so1378476oob.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyJpE3KWQYn/ymHW3x9YOT3A5+fVcqbK/X3WriJMynY=;
        b=TKzxUzP9aWkBrGHz2stDEPf8q/102GWOXg1DuFkL8F3B1BePjzooAzvsS8ZM+L0xIm
         vM6On96C98KnABu6573OknqcsDs14rGl17HCkHjbYkuZ6nehItNSDscztxMgafbHJdWq
         wyEMD2MUjutpKC8bXzvDrOmbC24skj2LJ+bQji9B4XQP3lDjPtW9Qov3QlSl024Z1W9L
         s8EvKNPiy5wiM8VhNSPOF0ZSWDmG6p2r8qTCtPBA9DdYd6y3GtDKBiPURCXVojsn8Jmi
         33FI46a1U4JPwmBbIL3ciryFpbSLrU32v9POCSHQ657fKvPal36KudX1aItdOTfShGS2
         sclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyJpE3KWQYn/ymHW3x9YOT3A5+fVcqbK/X3WriJMynY=;
        b=aLs9MhtviGL+KNrLpahJJuoXBptNEpr8PlSc8cNwwNcUE3TGlwWV+U3UwboCZSbaIH
         /zlsJnDfLu09yTdY7fPcLdUxAVE/uIB/2ig7Y/L3+9/2SSpCbcp70kEg1Q6vgD/6dGyg
         NNLjv9iydqNqhObfhwpFEFvwTCCeHFBNmmEEkCoqkwU1eo0w8ocoDa1GsOC6SHbeQKRZ
         Z+xZDyjpbWxIcU1WgOTcx7YtvFwkENIDgrEcrc+we9ijSbNrKT7xesfg4f852aDCEOcW
         wkyg5q24ZuH5rk92a2W+lANsU7u/XE/2R0kG+qupsI/VH2W135v0FsJMJ5IjamF1BtNp
         ZI1Q==
X-Gm-Message-State: AFqh2krKyO7nTBwqbZjNi71t0Im63arCpFE+pbgPKXyWjU5GRYZNnVOm
	KqPP5e+bWfchRs0dfB5MMO0=
X-Google-Smtp-Source: AMrXdXviCxf8DNsXD+PpjJZ4mm8n4XqJ9ruIkFLOBN+9gmjZRPym9NR4Nyw462Lpp227wxTlWbWKhg==
X-Received: by 2002:a4a:d302:0:b0:4f2:b68d:31aa with SMTP id g2-20020a4ad302000000b004f2b68d31aamr1705139oos.1.1673971775030;
        Tue, 17 Jan 2023 08:09:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020a4ae08f000000b004f1f6b25091sm12989560oos.41.2023.01.17.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:09:34 -0800 (PST)
Date: Tue, 17 Jan 2023 08:09:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <20230117160933.GB3091262@roeck-us.net>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
 <Y8Yq5faCjAKzMa9O@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Yq5faCjAKzMa9O@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_080936_234135_B25E2ADF 
X-CRM114-Status: GOOD (  31.39  )
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

On Mon, Jan 16, 2023 at 09:58:13PM -0700, Keith Busch wrote:
> On Mon, Jan 16, 2023 at 10:14:07PM +0100, Klaus Jensen wrote:
> > I noticed that the Linux driver does not use the INTMS/INTMC registers
> > to mask interrupts on the controller while processing CQEs. While not
> > required by the spec, it is *recommended* in setups not using MSI-X to
> > reduce the risk of spurious and/or missed interrupts.
> 
> That's assuming completions are deferred to a bottom half. We don't do
> that by default in Linux nvme, though you can ask the driver to do that
> if you want.
>  
> > With the patch below, running 100 boot iterations, no timeouts were
> > observed on QEMU emulated riscv64 or mips64.
> >
> > No changes are required in the QEMU hw/nvme interrupt logic.
> 
> Yeah, I can see why: it forces the irq line to deassert then assert,
> just like we had forced to happen within the device side patches. Still,
> none of that is supposed to be necessary, but this idea of using these
> registers is probably fine.

There is still no answer why this would be necessary in the first place,
on either side. In my opinion, unless someone can confirm that the problem
is seen with real hardware, we should assume that it happens on the qemu
side and address it there.

Guenter

> 
> >  static irqreturn_t nvme_irq(int irq, void *data)
> > +{
> > +       struct nvme_queue *nvmeq = data;
> > +       struct nvme_dev *dev = nvmeq->dev;
> > +       u32 mask = 1 << nvmeq->cq_vector;
> > +       irqreturn_t ret = IRQ_NONE;
> > +       DEFINE_IO_COMP_BATCH(iob);
> > +
> > +       writel(mask, dev->bar + NVME_REG_INTMS);
> > +
> > +       if (nvme_poll_cq(nvmeq, &iob)) {
> > +               if (!rq_list_empty(iob.req_list))
> > +                       nvme_pci_complete_batch(&iob);
> > +               ret = IRQ_HANDLED;
> > +       }
> > +
> > +       writel(mask, dev->bar + NVME_REG_INTMC);
> > +
> > +       return ret;
> > +}
> 
> If threaded interrupts are used, you'll want to do the masking in
> nvme_irq_check(), then clear it in the threaded handler instead of doing
> both in the same callback.
> 
> > +static irqreturn_t nvme_irq_msix(int irq, void *data)
> >  {
> >         struct nvme_queue *nvmeq = data;
> >         DEFINE_IO_COMP_BATCH(iob);
> > @@ -1602,12 +1623,13 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
> >  {
> >         struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
> >         int nr = nvmeq->dev->ctrl.instance;
> > +       irq_handler_t handler = pdev->msix_enabled ? nvme_irq_msix : nvme_irq;
> > 
> >         if (use_threaded_interrupts) {
> >                 return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> > -                               nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> > +                               handler, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> >         } else {
> > -               return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
> > +               return pci_request_irq(pdev, nvmeq->cq_vector, handler,
> >                                 NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> >         }
> >  }
> > 
> > 
> 
> 

