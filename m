Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E0C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jan 2022 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ai3Lm0Urgf8Bdoy1C/dgI1kGNQEXtzDX/c2T964G0TM=; b=dP6XYAtMrxdgBE4J/dTcDwrvEQ
	mBw6GokE/CpL9sXDuMu2Pf1rgIZaa+BZwP/XBjIT3Df9hiMUSD7mS87EgMUkj+iVSiJjWyXBejukO
	0+zPD83eIoF7P4lVVAAxtgQpUGDJ1TCxHSgO4rzsypZSwB5fK9chwUlAONr8HR4USrrx6C+LkpZ4D
	KiHQthlIo0NW7Dn2MLlK28tKxOhlA8ayx5eb5nEOXm3iyrWJkorc6Jw79mLH+XeuBAd7UU/TZF+5D
	QVxjGy7f7OKd/7qZd6aswKo14gQl0z3gumtIvOkr8Uk2Bm/aEDFkrKfqHOwW/c4VTpHaAQPqzono2
	76DvCL8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9rji-002IsA-LN; Tue, 18 Jan 2022 16:53:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9rjf-002Iqd-Go
 for linux-nvme@lists.infradead.org; Tue, 18 Jan 2022 16:53:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A1DE6B81238;
 Tue, 18 Jan 2022 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC88C340E0;
 Tue, 18 Jan 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642524808;
 bh=hj6cgF8nqJUDMXfSevCsDKP3HTwnEamooJYkoM7Kvns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cI/3+ELb1BO7XjuTEVngbV/xxNGYbpZJOS87HYLo3jL/W9zr4VIkXF/j+dr1KzeB5
 Y6UJE6RbT6KBGFSFyXF/JJY84pQf8y6RngMXN8PO6Kta7EOw2X0u+K6tkYlObhXBFs
 25A/VWJUZMDedKwIZ8u3svG5O3LJfq/iZzvu0O6LYipOlmnQFchv4wVNM3B/41XCA7
 +oj7aRU332K+PadAKKj6JaKugkbGvhJRGj59KBKNN1URwG5XXGWUz2iP/7lighYZOv
 FzLzYvS+fpKVMoTsQ5EoIp75D5NEm8XvSCkQwXTwvNwOQPndKrCzBKm1zlIlkMmmS7
 IEsRPgff81FBA==
Date: Tue, 18 Jan 2022 08:53:25 -0800
From: Keith Busch <kbusch@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: nvme: IO_PAGE_FAULT logged with Intel SSDPEKKF512G8
Message-ID: <20220118165325.GA3301052@dhcp-10-100-145-180.wdc.com>
References: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366b1545-fdea-3423-10a7-308ca2bef746@molgen.mpg.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_085331_729413_2F1FD74F 
X-CRM114-Status: GOOD (  13.20  )
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

On Tue, Jan 18, 2022 at 03:32:45PM +0100, Paul Menzel wrote:
> On a Dell OptiPlex 5055 with an Intel SSDPEKKF512G8, Linux 5.10.82 reported
> an IO_PAGE_FAULT error. This is the first and only time this has happened.
> 
>     $ dmesg --level=err
>     [    4.194306] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc080 flags=0x0050]
>     [    4.206970] nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000c address=0xffffc000 flags=0x0050]
>     [    7.327820] kfd kfd: VERDE  not supported in kfd
>     $ lspci -nn -s 01:00.0
>     01:00.0 Non-Volatile memory controller [0108]: Intel Corporation SSD Pro 7600p/760p/E 6100p Series [8086:f1a6] (rev 03)

I think it's a bug with the iommu implementation. If it causes problems,
you can typically work around it with kernel parameter "iommu=soft".

