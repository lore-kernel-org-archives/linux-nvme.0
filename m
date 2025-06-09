Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467C5C5B552
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5gVzdnsBE03ZTIUW+axa3vYf7txkpwMb8tjyPYFWXuI=; b=xGX4UiJdMslkBMtaMzrOsyC5+O
	TwtFGJLkAxQ34DLss0eHMK9eNxTlF8nLFdkW782MpXqcrJPuZywG5XBTSCHJ5dVUjMS1YltV13f0u
	1snLRwcApEuIeS8gphhjbCl9SgBxJMNBhF5Jvsb6RibHxOhaR2X/ikA3mkh2VP+JjdbvplY3Sft70
	3m4MRpiPEvsL1db7HXYU8i6TBcgiZMmo/N4rNS6JyNmfqnomMqeY7XK2yGaYYdyveLlowvoKxBtDG
	YE/x6eSsLA6aRYg9wyuGzZN65do4O2MbC11Z3mm5x1uVfomxREgDIxqVVfymshZVloiSLInolcBlZ
	hILNKGEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOeTX-00000004Wpn-0qvi;
	Mon, 09 Jun 2025 15:31:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOe3Q-00000004ST7-2uP1
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 15:04:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CFFFF615F2;
	Mon,  9 Jun 2025 15:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446D8C4CEEB;
	Mon,  9 Jun 2025 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481491;
	bh=V9R/MlXkDxF8BcfPqNzbvEqrs6zAbVcZgELa1g9IE3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSL/Vd3wCBE2pYIJY1CXXvjGJLBptYttI7nc36++QiqsFY+326Whyb0jHu5+h/b8k
	 B/8XM6nroSV7iG6l1PpmKBqyyqA5Zwy1P3n/+z/jI4w5ZUUtjHk5WrKpRZyoH15Mz/
	 dRyoVQ56uokfoNO8OADQharWJpnnzXLBnBPuYwPoWGimk7t5TqBU5B4+CrJdhplMP2
	 TCJcmcxlFbhuDQzKbZg9usDlk1A4IamPhRC9ynNOgTKRtleKOcyfJWE/nAktt5GRL/
	 vsLMzGSwXikIKppTyAl1dzxm5QMud30CAJpNBV5CG47LzrYk6Ds0kzzOirVFXV6CLG
	 tRd32RnIGTDMQ==
Date: Mon, 9 Jun 2025 09:04:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Message-ID: <aEb4Ef7ODvAX528j@kbusch-mbp>
References: <20250606003015.3203624-1-kbusch@meta.com>
 <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
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

On Sat, Jun 07, 2025 at 12:54:50PM +0000, Shinichiro Kawasaki wrote:
> On Jun 05, 2025 / 17:30, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Get more coverage on nvme metadata passthrough. Specifically in this
> > test, read-only metadata is targeted as this had been a gap in previous
> > test coveraged.
> 
> Thanks for the patch. I ran the test case on the kernel v6.15, and it passed.
> Is this pass result expected? I guess this test case intends to extend test
> coverage, and does not intend to recreate the failure reported in the Link.
> So, I'm guessing the test case should pass with v6.15 kernel.

Oh, I thought it would fail in 6.15, or at least part of this test would
have. I changed a lot at the last second before posting, so maybe I
messed something up. I'll do another version after making sense of
what's going on.

