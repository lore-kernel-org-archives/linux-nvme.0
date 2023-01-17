Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238AC3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 04:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rOH2zJhVw2Ga4jWyenxU9HzfH019pAHSota4q/Cz/8Y=; b=JcjpDuKoIJVsN2Z+b/7HS4sYhC
	1rzQS7XgN6W6CP/tebrOGYc43qMs0oHGhH9viFXziHAlAsBPVx5B2M1O3jD7SiFUKxcBgUkCAvZ0g
	vEgIpkL8U2maGXx3ia26RkSvVtevszqV9BdZXd3fIq8AnfJBcUJdtT8Db7j25JozChsFaXbL+2FU9
	1+NYoP+duAIL9p6Ejg7rORbMdua6XIyACvb89TRT5GXXoeROQXi6zebrKgfCczA/0KW0Osf/Q6Xm3
	Hf8CTkbzMPIbTArrshsjLVDZ8HdxUD2Qe3uzvyOPJLATyv/J1bw/dweU0X/PaNf2U5WXwwh3+gR6b
	GcMtkByg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHe3I-00CvoR-3w; Tue, 17 Jan 2023 04:58:28 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHe3F-00Cvnc-GO
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 04:58:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 7A3EACE0E64;
	Tue, 17 Jan 2023 04:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DC7C433F2;
	Tue, 17 Jan 2023 04:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673931496;
	bh=dYVdx+Ww2CfXncIVy08wDRj2+oyhj7B25DQdw626ylc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/g8he4R219NhQ0PQlHB7xvg4aVNqjy2WT2X9VG71QkP4JgQtZa6p49aJ88btaUTa
	 ZBZm3IW43eIMGHncX6ZDOJ4V0MHFovZiUymL0n8gg5nKdTmthUZEjoq0fxxL/rnk/h
	 Kio2jMeOT9jNO5UJ0F99Lf5VSxdLBBkh5FRh7IC5FYBIBGDBmDCyM4avqsYbkgz4uL
	 YR2EJTM/m7t+1IeSiKk6aV87xQASkxMLxBcsBRRWk4U+dCJlXWjHLhuhWWvuzrR3C2
	 GoATeQLKsMz6WL5c547zdWEIcpYab6ODoF4Kf4pG6oNTVfpytdkagl7oo8RX83Yqzb
	 kNya7CY+qhhSA==
Date: Mon, 16 Jan 2023 21:58:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Message-ID: <Y8Yq5faCjAKzMa9O@kbusch-mbp>
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8W+H6T9DOZ08SoF@cormorant.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8W+H6T9DOZ08SoF@cormorant.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230116_205825_965131_F9A4C826 
X-CRM114-Status: GOOD (  25.47  )
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

On Mon, Jan 16, 2023 at 10:14:07PM +0100, Klaus Jensen wrote:
> I noticed that the Linux driver does not use the INTMS/INTMC registers
> to mask interrupts on the controller while processing CQEs. While not
> required by the spec, it is *recommended* in setups not using MSI-X to
> reduce the risk of spurious and/or missed interrupts.

That's assuming completions are deferred to a bottom half. We don't do
that by default in Linux nvme, though you can ask the driver to do that
if you want.
 
> With the patch below, running 100 boot iterations, no timeouts were
> observed on QEMU emulated riscv64 or mips64.
>
> No changes are required in the QEMU hw/nvme interrupt logic.

Yeah, I can see why: it forces the irq line to deassert then assert,
just like we had forced to happen within the device side patches. Still,
none of that is supposed to be necessary, but this idea of using these
registers is probably fine.

>  static irqreturn_t nvme_irq(int irq, void *data)
> +{
> +       struct nvme_queue *nvmeq = data;
> +       struct nvme_dev *dev = nvmeq->dev;
> +       u32 mask = 1 << nvmeq->cq_vector;
> +       irqreturn_t ret = IRQ_NONE;
> +       DEFINE_IO_COMP_BATCH(iob);
> +
> +       writel(mask, dev->bar + NVME_REG_INTMS);
> +
> +       if (nvme_poll_cq(nvmeq, &iob)) {
> +               if (!rq_list_empty(iob.req_list))
> +                       nvme_pci_complete_batch(&iob);
> +               ret = IRQ_HANDLED;
> +       }
> +
> +       writel(mask, dev->bar + NVME_REG_INTMC);
> +
> +       return ret;
> +}

If threaded interrupts are used, you'll want to do the masking in
nvme_irq_check(), then clear it in the threaded handler instead of doing
both in the same callback.

> +static irqreturn_t nvme_irq_msix(int irq, void *data)
>  {
>         struct nvme_queue *nvmeq = data;
>         DEFINE_IO_COMP_BATCH(iob);
> @@ -1602,12 +1623,13 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
>  {
>         struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
>         int nr = nvmeq->dev->ctrl.instance;
> +       irq_handler_t handler = pdev->msix_enabled ? nvme_irq_msix : nvme_irq;
> 
>         if (use_threaded_interrupts) {
>                 return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> -                               nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> +                               handler, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
>         } else {
> -               return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
> +               return pci_request_irq(pdev, nvmeq->cq_vector, handler,
>                                 NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
>         }
>  }
> 
> 



