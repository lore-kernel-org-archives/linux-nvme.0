Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F1DC2D0CD
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbbVODr4gaEDxrnnp05zXtvWeKtRvM4HD6NrxCXUTiA=; b=XNrBl4Ve+J1ubBIAao3Qd1Dull
	P5+g+GnKlk4iqeuozdYnqTpH0Vs+wZf6nFDwt7dstP/f27HqCV6z6gt4R//fSFl2JK7GkoeKFTUut
	YOXRICd93ZIee1O1uHgeFQatTOOWGo2LynnU2NFEw4z0JCa0wE/J9gIF2itG9GW26HewmVKD05OnS
	y5Ytjwx1H4WtgJvY2GZ8Spr7VEaYyZUc1htxsVr6fX2EpWnXQp9MHTUB1R8JI+Dn74qCFejDCFUdH
	EXF/M5kDS4d9D9y66ztjxgc881rGWmySN7RpnbAIOXngPmevUtUQJcy8mFqH34NYPoWBKp6kPhPD2
	4Wkk2sRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHkW7-0000000G7kf-2fyX;
	Wed, 21 May 2025 14:33:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHkNQ-0000000G6Ok-0XcM
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 14:25:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 31666629FB;
	Wed, 21 May 2025 14:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83917C4CEE4;
	Wed, 21 May 2025 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747837498;
	bh=0fnnAFtFKsQIcRH8LyEVceGL/BANSDgnQLwfY7gFX6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZdeILG5ruCYJ/iwyPewo1eeP72y6doeYq/WQUG6wmC8Vbyq2wihCgfBRYGOd/O2Z
	 I4NzJtqDFs4eSkScb4DTTiaTu/C6IAqMAk6uNkT0BbCi2OCM2s0tsmia7Wmz1EaRbq
	 knAeqZ/ZchBF+I9NONh0IFp/pzegrj8TbPK5v4W1xcpt0gEmt77VnXQnemuqN7ynz6
	 AwRVHd9zX8Cj0F3tqhfy9Sz6hcKDk+WTBFCkD1+oIA6IbU4aDK5TiYc1oKuulmYqT8
	 tyvSFtt0lmmMBdzyUBq3GDxVJG6z1iVuG99Kbiu51O4VFh6qX86TsUWLUyOQvJsP6w
	 vGbK+obVDK3Ow==
Date: Wed, 21 May 2025 08:24:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] nvme: fix command limits status code
Message-ID: <aC3iOCSN8kcJ8MAp@kbusch-mbp>
References: <20250520202037.2751433-1-kbusch@meta.com>
 <20250521061400.GA3539@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521061400.GA3539@lst.de>
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

On Wed, May 21, 2025 at 08:14:00AM +0200, Christoph Hellwig wrote:
> On Tue, May 20, 2025 at 01:20:37PM -0700, Keith Busch wrote:
> 
> > Fix the name and remove the incorrect
> > special handling for it.
> 
> Where the incorrect handling is the mappings in nvme_error_status
> and nvme_status_to_pr_err?  Yes, limit exceed should not be a not
> supported, so this looks fine.  But it would be good to actually
> spell that out in the commit message.  I'll fix it up if you don't
> object.

Yes, those two error mappings on the host side, and the target side use
of the misnamed status code too.

