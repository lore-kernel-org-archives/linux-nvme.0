Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB251C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kRYNTJW7Eui3hy8EBAnqppNYhkTxqw4pyxEeG7s4wKs=; b=EI2pJGZr8od60TbUqcpPfLvwiT
	eXbzbA1zcmMXBbbVJfvAiyECZfrw1MQmLdyK5yG0lAbn++/Ohqnahlm53I/rxq2sSFSWXESEe61wc
	hizcN/R0piheftB0NuhBNEwmohTf1ZZ0MQjAlTcTyrqKX7EbubegtNvLfdBjyq1g5gDd10wOqWCGC
	wgWjiwM/iGsBwE7TfZOJX8DzwIXG/qrm+uNRyxkkPGBXm+0WtDExGy7Z/kqnl0I+YLFRIHlS6SRqt
	VuoPGMza5uaLRvrPJSGYgUrR1Sxumnyx5YxxROdextleH7wZfZPWQotyrAwzd0aBtIAg8ybsHSjZ6
	EIJEz8uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7MNX-00000008khu-2qNp;
	Tue, 22 Apr 2025 22:46:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7MNU-00000008khU-35Ne
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 22:46:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0ACEF5C5BA3;
	Tue, 22 Apr 2025 22:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB4DC4CEE9;
	Tue, 22 Apr 2025 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745361967;
	bh=BId8HiyXpSR3+LAxEsu8bktos8SGaOD3Ki0Fi2jQWwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8QsQei1TFwlKl01mmg2EFG8y1LeNjpISFY60CTi2eBxktvrL2dNC5eRo7edOrC6W
	 PoNmDjoomhquPAKSolzJOvaP3nmSe5/4Xy6fIuOkj3rlmUSWjlkBBzbKSc/LMiaqtG
	 skpyHe6OPgoDlmiHpH2VcxJWHKU6fdLBRtsXrCvJmr8LM8WCa4RkPq0mk67TJc9/gp
	 rQwcvbr8NQt6ao4y7AOrI1FblBHdBzFRZmqJDi8JA9/dMv5098UWAxHNdzRHVI6qE7
	 BZzGSTuBJ0/q9rlMmi/nfjkh4URRIbfXkpybrVpZ/voigBIrnCDUIo1HoJ3fwJvExP
	 ufNj6fglltoaw==
Date: Tue, 22 Apr 2025 16:46:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] nvme/pci: PRP list DMA pool partitioning
Message-ID: <aAgcLf-X_kWTPRGZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422161959.1958205-1-csander@purestorage.com>
 <aAfWUGAMTpwsHf2b@kbusch-mbp.dhcp.thefacebook.com>
 <CADUfDZr5nq9fAvxSZJwUmuZKry6pHqLrucLtJLmV8cAvZ6O6eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZr5nq9fAvxSZJwUmuZKry6pHqLrucLtJLmV8cAvZ6O6eg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_154608_821053_8E2E199A 
X-CRM114-Status: GOOD (  15.24  )
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

On Tue, Apr 22, 2025 at 03:04:37PM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 22, 2025 at 10:48 AM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, Apr 22, 2025 at 10:19:57AM -0600, Caleb Sander Mateos wrote:
> > > This reduces the _raw_spin_lock_irqsave overhead by about half, to
> > > 1.2%.
> >
> > Could you try this atop your series? I hope to see if we can squeeze a
> > little more out by keeping the spinlock and list links local to the node
> > using them.
> 
> That does help save some CPU time in dma_pool_alloc too. It's down
> from 0.87% of CPU time to 0.52% while doing 5% more IOPS. I'll include
> your patch (with a few tweaks) in a v5 of this series. Hopefully
> you're okay if I include your Signed-off-by.

Awesome! And yes, totally okay with me to fold the patch into your
series.

