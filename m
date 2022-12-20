Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F55C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DT5yhpHYcRABbtINdGwy8x6y4C1Xjt3+wFQnxPpSbA=; b=NeSFKSGs55WT0cTW4U1Buu/qmQ
	c4yltoHW3SHLBr0ngsXaFlOYgAbnT/XZ8wZm4HjEtNu0XaZPod+gvTdaWiAsZSFJMwZA+1ty2fKZz
	BwgDgh+AVLeNIXvYCLkskoXf098sm9fThWCFAWWCMgLbEjeaB31GvzaEAyADQBShb96mBupmIRpLK
	IqNHSMuLys9QQQvJt7scik2TRq2NdU+N6vPfMRnesUdE1FYP/ZcUf0nZYSQ3sx62FilIFFOI7Ut+r
	U3jcJJ19/cglULdAxeauzZvKUmrqzyKeh1pCS5/azqFPyiWGP6C/LjUf6IVPOEUAyDcvNabaTFKtL
	8kg4Akqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7h4o-001yUN-AU; Tue, 20 Dec 2022 18:10:54 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7h4i-001yRm-PR
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 18:10:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2D3D1B81730;
	Tue, 20 Dec 2022 18:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1FEC433D2;
	Tue, 20 Dec 2022 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671559845;
	bh=QGxLe3jzuz0bmib5uFDyuFiJ/BHRx5e+wE4eAz1ahN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8KGLKbd5tGFn20TBPMXh6oXiyC2ZD+h2HBtHpAoL/KQQ5sdGZ5a3TW5mLu/qxSwV
	 z2qKSwFI9w6mjr59dTsIanahdaXbzFqfIr7Q1StypC0qJrgn18JBEQRmb9NNnU1E+E
	 65tBJjGm8oQMasYy3iH50jKZGKGoPmkxs0yRu7k6nUnEiGeGjFAhalOHsK9AZ3F4Bo
	 AnAPhH6mt4vm1fiZmR4JBRt31HkQgGN6iRrl9sB/uHdqLJvQr34nmAD1mKSJ4tVK5S
	 42GHTAhPgyIncV6DBOr6owY+l31zmSHhDoCOM2xCXOVGBNtOguK10WVgm5YzCRqVVE
	 tVYaIbziYLZiQ==
Date: Tue, 20 Dec 2022 11:10:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y6H6ogCyyWGHcbZ0@kbusch-mbp>
References: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
 <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
 <f2b6305b-ffd5-51cf-74bd-de39d50c67dc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b6305b-ffd5-51cf-74bd-de39d50c67dc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_101049_006391_EC85D315 
X-CRM114-Status: GOOD (  12.21  )
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

On Tue, Dec 20, 2022 at 08:40:58AM +0900, J. Hart wrote:
> My apologies on that last, it was a typo. I should have said /dev/nvme0n1p2.
> 
> There are two ext4 partitions on the nvme drive.
> One is /dev/nvme0n1p2, which is a 64 MB partition.
> The other is /dev/nvme0n1p3, which is the remainder of that 500GB drive.

And what about nvme0n1p1? What are the offsets and total sizes of these?
What is the logical block format size of your nvme namespace? I'm asking
because some drives are known to behave badly if access is not aligned
to its NAND page size. NVMe doesn't actually provide a way to know what
that size is, but if all partitions are aligned to a power of 2 at least
16k, then partition setup is probably fine.

