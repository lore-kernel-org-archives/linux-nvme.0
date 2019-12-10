Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8093EC43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 15:13:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBA32053B
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 15:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o4QO3iKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBA32053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9+6DZ3PrN41F5i2lbFL3Sr2TfsqnKGFYhRcE37CMKTw=; b=o4QO3iKul6fSz0
	LPoGYa4L0TtqQBTpZFobxm6sNrxLJDrrvpoxFDPXe0VJmhlwZgUzjuPUCW+18A8O4CO5bo82lR7w1
	a5Pkyuiq8lt9lVPOwqMiZlXnUddFb6/v8PS5/E5+LCzblwuFhhHwEvsgMPAQ2FL1j4n8EsIMBNkJ0
	5Lgfm1NuZ/nov3wlVvLLVzLWmFOWPldkSUd4UkYP5hK/Ot3zIP5LNH7AKFWfTvVphKKQr+PAG+8Br
	gCnYDLteCoDWOeNt4ilxLY3kMwn9Yp0HwzrH4YWeba1DiGsrFVjqV6HTxV/909bLDNesAEjWZX0SN
	gGGcUL30dIiRTYKQI1Og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iehCC-0001cO-EA; Tue, 10 Dec 2019 15:13:04 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iehC8-0001c1-P9
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 15:13:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 096A7AE07;
 Tue, 10 Dec 2019 15:12:58 +0000 (UTC)
Date: Tue, 10 Dec 2019 16:12:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/4] nvme/pci: Disable interrupts for threaded handler
Message-ID: <20191210151257.2a36ny3yy5tdohda@beryllium.lan>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209175622.1964-2-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_071300_960241_9F5B5B54 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, tglx@linutronix.de, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

On Tue, Dec 10, 2019 at 02:56:19AM +0900, Keith Busch wrote:
>  static irqreturn_t nvme_irq_check(int irq, void *data)
>  {
>  	struct nvme_queue *nvmeq = data;
> -	if (nvme_cqe_pending(nvmeq))
> -		return IRQ_WAKE_THREAD;
> -	return IRQ_NONE;
> +
> +	if (!nvme_cqe_pending(nvmeq))
> +		return IRQ_NONE;

IIRC, returning IRQ_NONE tells the irq core code that this is
an unhandled IRQ. If the core sees too many of them it will print
'spurious irq' message. See __handle_irq_event_percpu,
handle_irq_event_percpu and note_interrupt

Thanks,
Daniel

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
