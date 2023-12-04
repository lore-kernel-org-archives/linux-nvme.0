Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98731C10DCE
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/kZEfquv3PzWv7RhmHIWPAp5NLsP1QfEWtp6KfQT5k=; b=QrI5XzH2NkoKWMbfF55uvjy0Rg
	1rC8+5xjlJOtdC82kx+o/pvE36dsz3XY3pUSSQLMhbpFIPSCcaKyefmExwuztEuteKWVbnYO95EmQ
	BtiB+Ss3cx76tDddVmGthU3C1tu7eXH1fydu3yqr5lG0H5BK0OQvYW7IhuBSkgwaxnr68nLwZ53vG
	xMsQpNCQaGo7GL7XoNlPA7NU1qxwKmBeRiJMpiRWNJ7x5TKpNeKD4nA9RAeMAPG8WtlVFTSj50kIr
	2h7/iNa1GoCdQTW/nIn2xGlmaFDU7Nmaw81bgdA8KD4zBmFM/sn0Wu3awOOoHJkrstas+bxMQcV9P
	6hXtevIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAA0X-004mnE-1Y;
	Mon, 04 Dec 2023 14:33:13 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAA0U-004mma-2R
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 14:33:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CC2E5CE10DB;
	Mon,  4 Dec 2023 14:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4AEC433C8;
	Mon,  4 Dec 2023 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701700384;
	bh=Xj3Wgg4nCdhCIGD1UZt2Az+jQyafI1GPtbLWMloLtVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qaomhWdKkE6cbZRFiIMOZo33GgvD7i5D5w5kCkdxBuAtNJZxlgOfplHvwCZJ/SRUP
	 DRjwDN4ojNplGGwBK+flDs0lsJOhYyecEYPsf1JOnOy5JJFKXN2I1AES+LI+EVSTjd
	 lxBggdY4NFQwGCDaf+EIXpzianB7usKtSZdo1lN3ViCjq6XNBD1NPB58wzqiwhEj/v
	 tMwzyQOcWzivtNhYEqWkM92I1/c69Vm/NgMdXeN7OFjKpWGbcpzdTiWR7Unhxqq9/Q
	 yTHCGTBMcwEPbXlxDXOfoRrcQqfi3QOxWJZwSVBVQXQ71M2NXrMryiy7rTaM6KGLup
	 cICkr/uEFS4Vw==
Date: Mon, 4 Dec 2023 07:33:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Message-ID: <ZW3jHePnYN_m7OU7@kbusch-mbp>
References: <20231130201919.2486553-1-kbusch@meta.com>
 <20231204083034.GA32360@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204083034.GA32360@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_063311_045078_02AC3B4F 
X-CRM114-Status: GOOD (  11.21  )
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

On Mon, Dec 04, 2023 at 09:30:34AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 30, 2023 at 12:19:19PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This can be an expensive call on some distros.
> 
> Huh?  How would a distro matter for kernel code?

Security monitoring: audit, LSM, and bpf hooks all make this function
undesirable for a fast path check.

