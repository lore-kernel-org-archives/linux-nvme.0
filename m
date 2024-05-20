Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61243C25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KG1kV7a6J+60PKYk9ymbeTHXtrYcEUzQzN+I6ayOT94=; b=Z1g7BzFP9f8y3pju9fz4xr47wW
	lSn9/wn8VXrN99o48ItiCwvsj29V5chyLWdaXb6zmd/AkeYkylhaObKbn+aj1VtLTOt2w2pj8aSZf
	vwwN/SaMk4Jo5Urq0goNPG5dnvchf2knjoZF+iXhZa6sXl8mh5GBBL3LnCDk8VGeDLr5E8hRG7tL2
	ljybVRHO4EtpIH1njiuWCUCZVmuTeepcNUAMlpMOwa+G2cvpXNbdi87j60EbDqfG5Lv+zAzjwR3GF
	SuF9izd2NjHpLJ+vuwAPbjcxk/HPxTz7XYEH1K1borQgPR6QVdkpzMU9fuu5/NngtkczaBtZDf4JW
	cmntZD7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99ic-0000000FUUJ-3CfS;
	Mon, 20 May 2024 20:34:50 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99iY-0000000FUT0-0vG5
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 20:34:49 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716237281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KG1kV7a6J+60PKYk9ymbeTHXtrYcEUzQzN+I6ayOT94=;
	b=Bzs7jjNXrrHACM9AwaiyPYhPdvFRr23tKjLDNRNz/Tl/N2164vhcAIcYbpPLKauIv+C84f
	uC8BMS7E2nzGpnG5vArA/vI3OiaX7H7nS4etm7HamTiS8HuGR8j3Fv0j3lah4ICL3TruIr
	XH3P+HanDPxaaDuWqCDpQt3pDEUdaKhlmh1N8kLtrxYoRrBFiuz857utEPFBrDuC28o9Z3
	bggu5rPIs+PSEkUXneS17o7yHPkBhGCXap4FShhUXIm1pa9zL4mQT/8OEtaRASxo5WvEsh
	M+AXizi9jj2x4h+VXhNi68r1XW9Yg6Pl8J79Mup8f7c/ULOPRlKquQJiWChL9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716237281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KG1kV7a6J+60PKYk9ymbeTHXtrYcEUzQzN+I6ayOT94=;
	b=X1nfohYcrNiOenaHMvoa6DDdNQmFsG+ut2RQEfj0WKTy4bsxRVt1TBwpUJxZr3PgN6dF4T
	gDqXqSGWEAszqJAQ==
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
In-Reply-To: <20240520153742.GB921@lst.de>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
 <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com> <87r0e7mt9w.ffs@tglx>
 <20240520153742.GB921@lst.de>
Date: Mon, 20 May 2024 22:34:40 +0200
Message-ID: <87fruci5nj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_133446_445127_0491876A 
X-CRM114-Status: GOOD (  12.16  )
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

On Mon, May 20 2024 at 17:37, Christoph Hellwig wrote:

> On Sun, May 12, 2024 at 08:35:55AM +0200, Thomas Gleixner wrote:
>> That's expected as you pin the I/O operation on the isolated CPUs which
>> in turn makes them use the per CPU queue.
>> 
>> The isolated CPUs are only excluded for device management interrupts,
>> but not for the affinity spread of the queues.
>
> We'll probably need a version of isolcpus that also excludes the
> interrupt spread given that users are asking for it.  And I'd much
> prefer that over adding radom module options to every driver to disable
> managed interrupts.

No objections from my side.

