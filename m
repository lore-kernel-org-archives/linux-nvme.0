Return-Path: <SRS0=6Pwq=ZV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB4C432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 09:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FA1215A5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 09:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6MDANDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FA1215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ryuvUCDKXN6YEM9kf+KIm4o3MeNU7h2BldUR+sI0sGQ=; b=s6MDANDtXHx4e7
	yaIYoEHWjXm8I87evgBLcqJk0RiuyCnFF5aiwrkAKCymyQXcR6GdvNxWHPgnxVXTgRp7grw4QgQDR
	R5gZtddb1moihfKBCjr6EJLlWg6JcBGVrx5e70AvXqXbv9T/WWioYpaV2efFjcwlIoHP+UlwNG7+e
	JguAmvVQrdjI03TEMs/Cur2U6lrjIcnWR0rl3VnMj8G8ZSHaGJaq23BC363Zu/o0y98+jV019e37y
	+t4yfJEumbH5H2f5qRnKhajaFL4zAt+3ztEXem5bUMYcpNNtaSwHFiv1WUm3Akthbrn54EzRG3R9e
	UnY24nPHQGUjVVor+/CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iacKq-0004za-Ky; Fri, 29 Nov 2019 09:13:08 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iacKn-0004zC-8F
 for linux-nvme@lists.infradead.org; Fri, 29 Nov 2019 09:13:07 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iacKk-0001mu-DA; Fri, 29 Nov 2019 10:13:02 +0100
Date: Fri, 29 Nov 2019 10:13:02 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme/pci: Spin threaded interrupt completions
Message-ID: <20191129091302.bngxlcsbexiktqbk@linutronix.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191127175824.1929-5-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191129_011305_433383_3BD2D185 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
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

On 2019-11-28 02:58:24 [+0900], Keith Busch wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 571b33b69c5f..9ec0933eb120 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1042,9 +1042,15 @@ static irqreturn_t nvme_irq(int irq, void *data)
>  	return ret;
>  }
>  
> +static void nvme_irq_spin(int irq, void *data)
> +{
> +	while (nvme_irq(irq, data) != IRQ_NONE)
> +		cond_resched();
> +}

That interrupt thread runs at SCHED_FIFO prio 50 by default. You will
not get anything with a lower priority running (including SCHED_OTHER).
You won't get preempted by another FIFO thread at prio 50 so I *think*
that cond_rechsched() won't let you schedule another task/IRQ thread
running at prio 50 either.

Sebastian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
