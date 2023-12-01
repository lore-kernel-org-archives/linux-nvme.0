Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF0C07E97
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Dec 2023 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G+bQuGu8WtmRHY5nrATL/CVUjD35rrBxJ8NTr0oEC1c=; b=1CDqWRbYYotDJITuUFx558oTeU
	nrKpLQhwj4rXTNZlDQFiKvBaZcMRAmZ6DvD5F3OwTLWbTf0lo3xL5S4l3jx8DeUSbo/DNkMtAV3ZK
	Bhp25XvJyt0PA1zv27wiWi5T/SgT1RqkxovviEslB21zL1O3rEzIILGItSX/nhpQEyFIXMyytkAyP
	tmp3KrVLeTZT0X6hisVf7rWWuJjQ4FtgRVm+uOXP8M84jGUxlLLOwd5+Vvwid6v0tDiNUiR1zwRsH
	2Etu+FQuJEiUVygYzP2tvUK1YmSgdeYEYw3PyyManEYoX1rBN4+3ySiqB4/iFcwjgDpEoRBQ3r9J3
	eTV0XDaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r95yE-00E6dU-39;
	Fri, 01 Dec 2023 16:02:26 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r95y9-00E6d1-2U
	for linux-nvme@lists.infradead.org;
	Fri, 01 Dec 2023 16:02:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0434EB82252;
	Fri,  1 Dec 2023 16:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D24AC433C7;
	Fri,  1 Dec 2023 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701446539;
	bh=vdzlr/tDy0aRnkM4UXdzOsMiuS9zBdi7lGH2MIOiB5A=;
	h=Date:From:To:Cc:Subject:From;
	b=dPGRLVmPAJdvp85DCpgSJxiUuX185th4y+qbPzlHPKZ7XR5KPozPMhCm87wIMEZPb
	 Mwnvj+/7HxkV83TLXghUvijCj/JF+DPuaA3totM24BXzP5Mv1UaLvxDYL/kPc9i5vT
	 py7F75DNfHks8y4l27vR8St+tLeKo9OXCcQYZW0S6xZBNcQBOzbdh/F1JcEFEalvwD
	 no4ngrB7NgKdR2uUCWeKcFfmRSjfu43bw5VgHB6gFs0yGzcZx5Wgou5Isvh6pvwJDS
	 yOkgWP5OHSJ/6HPsxt9xrW6DBkIfwN/OpsiudrIgPRwxTwmB6qZuFb8/oS60l1MLRV
	 /fRZV4+2FFVrw==
Date: Fri, 1 Dec 2023 09:02:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.7
Message-ID: <ZWoDiHfUgBs0riE6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_080221_974020_18541AA3 
X-CRM114-Status: UNSURE (   6.07  )
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

The following changes since commit bb6cc253861bd5a7cf8439e2118659696df9619f:

  bcache: revert replacing IS_ERR_OR_NULL with IS_ERR (2023-11-24 09:39:03 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-01

for you to fetch changes up to 74fbc88e161424b3b96a22b23a8e3e1edab9d05c:

  nvme-core: check for too small lba shift (2023-12-01 07:49:50 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.7

 - Invalid namespace identification error handling (Marizio, Ewan, Keith)
 - Fabrics keep-alive tuning (Mark)

----------------------------------------------------------------
Ewan D. Milne (1):
      nvme: check for valid nvme_identify_ns() before using it

Keith Busch (1):
      nvme-core: check for too small lba shift

Mark O'Donovan (1):
      nvme: fine-tune sending of first keep-alive

Maurizio Lombardi (1):
      nvme-core: fix a memory leak in nvme_ns_info_from_identify()

 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

