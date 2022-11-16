Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20205C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V2h9ibijA8GX1GhdPU4ZjC+UM5m4ujpW/8XECIo0Flg=; b=uFDPSRRKPC/SnzW20Y9PbkWvhm
	hLTJvZDHSZnAPZCqYBNCRxOsZcy4GZ0SE5963DKDbC4RigfPl+ZP4+rIYeF7TXDn3nws8u5FWVyxx
	rvkhcHMGC9rM3iS+5MgcTYE00crwdsPxbtHR4QcDsrVxTm3ByJwmPkC66A9KzDZhdXKcA6yv860JU
	fDK/b5HfxHjIb0nrlFQi4+pbLiSYLKL/rVEF7NQLoj5HX0zGQiK8hZnEjMOtp4qw9hVoO6IUOrRep
	TrLDUX4th9W55AMW3Ul4dI+yVmiaeoqRMANxkgHXtidvsI0WFDE5yYI6LXEjjOrFySZJl2IFkNv2z
	XKj66zQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2Q-003dlF-KC; Wed, 16 Nov 2022 13:01:10 +0000
Received: from [2001:4bb8:191:2606:427:bb47:a3d:e0b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovI2P-003dkY-3y; Wed, 16 Nov 2022 13:01:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: block dangerous passthrough operation
Date: Wed, 16 Nov 2022 14:01:00 +0100
Message-Id: <20221116130104.2186334-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

I recently had to debug some testing code that tried to send fabrics
commands and caused a major havoc.  This series adds checks for various
very low-level passthrough commands that have no business sent by anyone
but the driver itself.  The list might now be complete, so discussion
is welcome.

Diffstat:
 ioctl.c |   75 ++++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 18 deletions(-)

