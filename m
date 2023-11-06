Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B16AC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LeWEpCXZhe04R5m2VqOEWEY7MTWg8yA92KBHdE8dgk=; b=BhmoHr5gWhaQGChQwb2omqAHXQ
	pPIdpUy0qmQbIWb7vBy+EzPIpxOtt2r441RrKxPpZTt1ismltRP7vOtzwWDCjC/SC12dM2BQX7VfN
	hjNQo7SOLOuOx/bVDG4vHKLZWHFQ7T1ZnpugnVP5Eo3SB2jvlbShTQCDfvS0fyXSfupJTQ1/ktvqX
	zjE/jh/Tqsc18tELCHJyMg8H2PEd6uo10wZxcZK/MRpppsaSk1bm3NnLPlEiB8WUuPvAGMN/EHS5p
	L8Cyz/Z7BOAw6sOOGQix7SgYhJQhaANAp7IByw6NNKGLqhnnZHiHTxKl654i/MtkDrPwxxmad2xZT
	fuIOa56A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r01uM-00H2Ke-2o;
	Mon, 06 Nov 2023 15:52:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r01uK-00H2Jd-1h
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 15:52:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9D531CE0BA2;
	Mon,  6 Nov 2023 15:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD877C433C9;
	Mon,  6 Nov 2023 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699285969;
	bh=265m6dluOUws/+UlcUoSYOVb4qKB7QFJ7B737QRFIxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbrZcSs96neCrNfvhgp1WIdRi8p8+rkyS0oq78DlvYoMY8HnkwcOMlR3X4uoKQUKI
	 zd8z/LAfLG+16uKG6RutNGrTtfGXZL+G4zy/04uVn/Wm6yvvMfR11x7wHMQ4O/SJpr
	 6ZKHP7bvLP0hvGvdrlYMsdgqXE41afYVd3J26UAkCwYFieR5g5Fj8CG9COQxXrnyOP
	 d+BuLFbFru26HmnTXaZadq2kr4ftOShm0c0AmAps9KFX4Ph6hvR095huebaesi3C/P
	 d4JAbR/WDpOwU22RAG9/06F1abKSKF5qmvZyANUqNw5o2WkG+z+70EsSUvzjTgwiOU
	 BnlAwDAO/uzRg==
Date: Mon, 6 Nov 2023 08:52:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, Niklas.Cassel@wdc.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH v2] nvme: fix error-handling for io_uring nvme-passthrough
Message-ID: <ZUkLzgw92h2gV4V-@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231018193056epcas5p404b1fb38d3e9037862703690336d2d10@epcas5p4.samsung.com>
 <20231018192430.43606-1-joshi.k@samsung.com>
 <17543a8f-d1cf-e158-3208-afedab7c539d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17543a8f-d1cf-e158-3208-afedab7c539d@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_075256_751616_C7BC149E 
X-CRM114-Status: UNSURE (   6.33  )
X-CRM114-Notice: Please train this message.
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

On Mon, Nov 06, 2023 at 11:10:24AM +0530, Kanchan Joshi wrote:
> Keith,
> 
> Can this be picked?

Got it queued up now, thank you for the reminder.

