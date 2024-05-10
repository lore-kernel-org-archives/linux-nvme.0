Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6350DC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJ6sq9d+DeuvhE+UVNB7335OHS/0ytDL+dKCTdAYg8U=; b=CHFMlWjYNSSnxE4vLMO9xYtSEE
	JqBSV7MmybqpQ4Ash8vGyUdNV6aNq61lKJUJQDNSAeKsZf6Vik5EFQW50K1nSRhBzbvcgq8GtuVui
	KxoL0vHgOVrFgJ0PmGx0TjN3Wfd0hUJsXnLnIimBo+IVOBaBQTVZl12FDR/XFJkdhHky8QAC2CyYc
	BbyQbr5QjmR6qsFX72rFMBd3kST3BcxJWKw/ylt71sLH5M/2KAL/2OKwgNIA3l7ifbLtoR2prOQ8B
	nTjQ9FCHelCMSpkiAsPJVxAojkwrUAUYPLUHh5hl0vsCmkx61QdxskjDUk5zzXL7rXhOAOkmq9NdS
	G4IRwnOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Syh-00000005qOA-23Oj;
	Fri, 10 May 2024 16:20:11 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Sye-00000005qMt-1ubz
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 16:20:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0AB89CE1E37;
	Fri, 10 May 2024 16:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721BC113CC;
	Fri, 10 May 2024 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715358005;
	bh=CF8Nf3rfqr2ncS/J0xp4oHnRS2E3OUw0FJDGJKNSq/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnNrBJye4r8wFkX4YaHhnzSf6Bj+yeERi0onolrcgAKGavgSIbw4SjvRooP+Gzpw2
	 kd8BTX6RWWVo6C1cKeItxfFCxv7hXCfNbBOHxXhCJoYUftI1PtScLxHkaEGVGmqRLB
	 c5fPQHLIK55ILI+j177+w+GYhYi+lz83hB1i8gRTVQtGLqtB1MoDjDdmWYLYtl9uod
	 eSrZpLTWE/33O3xd5dusWN4o+GtwsFPu6UyULIz9RvPQp3ltTPxn5n8NLiC5F0/AO2
	 1NEoqh1VnO+SubjSRRkSAfH8iX364gA9mhoDibbx6pZc+AUti2p3c6chKQ5XfzUxXF
	 QUqlw+bE2Ul7g==
Date: Fri, 10 May 2024 10:20:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	ming.lei@redhat.com
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510151047.GA10486@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_092008_692764_4FEC9BF9 
X-CRM114-Status: GOOD (  12.98  )
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

On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Some people _really_ want to control their interrupt affinity.
> 
> So let them argue why.  I'd rather have a really, really, really
> good argument for this crap, and I'd like to hear it from the horses
> mouth.

It's just prioritizing predictable user task scheduling for a subset of
CPUs instead of having consistently better storage performance.

We already have "isolcpus=managed_irq," parameter to prevent managed
interrupts from running on a subset of CPUs, so the use case is already
kind of supported. The problem with that parameter is it is a no-op if
the starting affinity spread contains only isolated CPUs.

