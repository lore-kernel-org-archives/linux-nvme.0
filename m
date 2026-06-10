Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F66CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MDQhFaJEUfeLCc/cyzqlvQ/sAoG+c8LDXzkZkZtlQVE=; b=bBBIm3oxBCum2VL7/7G6UD5nIP
	KVCAi0sqCtpJcXetYfiOyhUPF89lb+IVebJiSiC6hDrLjvBqd4xfYD5nPafgx3xubY3qB33KoXcjm
	1SNd3nUU4nykwT89VLs8tAankstoHwDjbnz81mUL4IpEHcRIGNZvI5r3GXim515z6RwzJbTKEwxBV
	E2aUQbpaTpSp+QdN2t1TCqFrn+b3itelvUSc3TLgdbMMymDX8Nj1l4J5RchUKdjHy1aqhVwCckvW9
	gKSM8Tr3TaTaQO5Mk0xyLSBBmOsaIJVmW8u8EihR6y9NwIpCuuyPyGmzyCrTz/dgKYh1bZ99B/YcH
	h1m4Z+Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJzd-00000007u6W-2Wdl;
	Wed, 10 Jun 2026 14:33:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJzc-00000007u6K-1l6R
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:33:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BB053600AA;
	Wed, 10 Jun 2026 14:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243FE1F00898;
	Wed, 10 Jun 2026 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781101999;
	bh=MDQhFaJEUfeLCc/cyzqlvQ/sAoG+c8LDXzkZkZtlQVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSKejtATItnJBe1Y8xfbCZGGgrh53CD9vfOP4zgrU8xv+CnnPJ2SobEHajoDu5lQ9
	 9ppLBYxk4MS62jIrMm5dkJaIS9r0mSdvu/JOO6RIPvfm16kjB5wFpC0yELfEwpFnZV
	 fJdr4n18GE5hsk7yRmGWe6kOil8wqA1BaX7qcjGvR3eVGeEUhDfTXPD9VWwH7Dm2Y0
	 bat8nkOK1GQ63Ghrl7Rb79ESOD6l85MA8QtR9WYleg8H1gb251VxZzcksEKLHxrrfl
	 /IepxH3CySChzML6iKzywQnRyRma1H8PMJ8Q18cQ5BQDiX1s0w8HZkp3MrOkHcfJ23
	 2/N+dX4l8X7Fw==
Date: Wed, 10 Jun 2026 08:33:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, mlombard@redhat.com
Subject: Re: [PATCH] nvme: make nvme_add_ns{_head}_cdev return void
Message-ID: <ail1rSmWLuYVErO1@kbusch-mbp>
References: <20260610111608.3252988-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610111608.3252988-1-john.g.garry@oracle.com>
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

On Wed, Jun 10, 2026 at 11:16:08AM +0000, John Garry wrote:
> The return code from nvme_add_ns_head_cdev() and nvme_add_ns_cdev() is
> never checked, so make those functions return void.
> 
> A cdev add failure is tolerated during initialization, and flags
> NVME_NS_CDEV_LIVE and NVME_NSHEAD_CDEV_LIVE are for determining whether
> a cdev needs to be deleted during un-initialization.

Thanks, applied to nvme-7.2.

