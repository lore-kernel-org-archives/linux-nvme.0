Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5703EE69E81
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KaCzqgrZPYHaFwQyzCKm3ACnt8LQfFY9UE93xSfeig8=; b=aqlNYsS38e9jHI8q5kZpcieG/A
	my5f+H8A1SDKex5oYYh4UCq88w2ySKaOlGa15Z8lSg5M0/nMX7oNPagdoFR0IEuHpFSVRGZCXyrmo
	VhUbSKT51HJb3wyfBvFIqdwXVlkKwYByCU8JYtEDGHFJC+KCxq/bLzmxY5Y6jeHAuOlWfBoOYakj8
	m0402wlRmCTOclJ9xyP1Th+efnNof0oPJAJIZNj0g2/RPUMB472rlXSN4DvvJByTj97CgUkkwaIDr
	4xJkSeOYT3U7dhpywuCqbcA0qi0Nz9Dz8wfvvcFHrox4kK2Hw/myLvQVAfjlrBZI3ybGklQR0EFyc
	a0ZBqxQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBrf-00000007GDI-0cUY;
	Mon, 02 Dec 2024 19:13:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAqS-000000077lM-36Th
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Dec 2024 18:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KaCzqgrZPYHaFwQyzCKm3ACnt8LQfFY9UE93xSfeig8=; b=Y7OoI9nmDwethKexHYdkGmB2s5
	Gq+1sI5x3NDpa2USRuiTikgOBIHge58k5X7krDcMpSbUVbnUv/n0YrHtLMBx6IFKuQUkO0mwA6Imy
	Lhh7eSDgDUMroo50D7IyGTXtXWeV9cXJZpNH+NwEdrd082gr9ORpcoPEGoCgl0/n7JCGvU3VHsokD
	L9stSSUyQmuzBcfO0hPrES/TuOUCeikI6yVffMMsqyVVibbP8yrUK1ZoKYoY+Uj5zHa62PPHs8eLB
	y18eS80/BMctGvOLrAum1gMMjvusvNC2NSOJ/B91ruyBuDfXHsr53PKVX6yUIiLmg2jRghBHK6Rja
	OG7b0OAw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIAqP-00000002ELr-3YJF
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 18:08:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C1EF5C6126;
	Mon,  2 Dec 2024 18:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86D2C4CED1;
	Mon,  2 Dec 2024 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162904;
	bh=KaCzqgrZPYHaFwQyzCKm3ACnt8LQfFY9UE93xSfeig8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkq9twMFrLnwMaia3ctClo0pzUGn2wqfX5WSvTP+gB6gIakrmRr3ijfvcIfK2taEK
	 pFNp++Rh41+Lh+Ftow2z0MQfg5nN+F4pWlTQbrOX/JwPSToOUEZDCbqu0rSYrcVaSg
	 KUEjFDUePZ+2rAKaLG8LLAqpwarhYuY59A7U9gr8DwzG1IiJT6RWXxSwO4MeQMYHit
	 tLfHgYoifZINnEgayIeVIvfRHvK6ebHkVChaPDb0Kz656QRZmuJ9O3N7Raw27Eu54R
	 Dj+qdKu6v2odil2G9+DefI4RhhkyYMYdFEeXauSkoNIfT9aLdQXN3ULTj5RsV/D+2a
	 X78MapCImf1Yw==
Date: Mon, 2 Dec 2024 11:08:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Message-ID: <Z033lXyZt4w4V6be@kbusch-mbp>
References: <20241127064218.42688-1-hch@lst.de>
 <Z030cuQOvjtLm-hT@kbusch-mbp>
 <843B01FE-5121-4BF4-A305-65F38A1C05E9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843B01FE-5121-4BF4-A305-65F38A1C05E9@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_180826_115161_B456D1BD 
X-CRM114-Status: GOOD (  10.44  )
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

On Mon, Dec 02, 2024 at 06:03:02PM +0000, Saeed Mirzamohammadi wrote:
> Thanks! Can this be applied to 6.11+ stable releases as well since the broken commit is in 6.9.y?

I don't think it can go to 6.9.y because it is not an LTS and that
branch appears to have already ended stable support.

Since this patch has the "Fixes" tag though, the stable auto patch
selection should grab it for the appropriate stable branches that are
still supported, so branches like 6.11.y and 6.6.y should get it. I'll
keep an eye out for it after the next pull request just to make sure.

