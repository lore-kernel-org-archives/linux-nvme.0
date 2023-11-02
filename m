Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC65C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Nov 2023 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PJapYrFiAMmv362BFUxi1ucwnmZqU7rS0CcfdNqddxc=; b=ED7MeklMapu1/+F6isqMDpJQNa
	cp1b0XgAwdXUPN0nLJYBenB4MfrRXziSHzd1vIwLI/ZYgb0bfWVmcBXfuw2BAkTd7tkBwa+3pdjx4
	YipqyL2jEPNk/CkT1dn3U7p0d2BY3M9gk/MIoSrerZFqvGGAMCJ47WEuj1ucG/Z9PQo8HJfhfEzhL
	BMEnylg4ap1VY4PLy0I+J3h0+0aFwuMpTjYxDDJjRJxstia17QTWDtch28K2qv1rBUBocumupZH9o
	X/s0eHpifcX2phrItZFDf8s0dfh4OGB+pDEgrQp/x2QMtnzQ4A29q8sh8UfoQXnUuytVVTelJlj7A
	6DS4aO4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXY-009cpI-1Y;
	Thu, 02 Nov 2023 14:19:20 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyYXS-009cnx-0J
	for linux-nvme@lists.infradead.org;
	Thu, 02 Nov 2023 14:19:18 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E0DA91F8C8;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698934746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PJapYrFiAMmv362BFUxi1ucwnmZqU7rS0CcfdNqddxc=;
	b=Yk1hx803T+TX/ZgKNToPKkHRNnuZt8SNP3XFyKI/5qzr4w+kF7yIlA652f7WTDrAdItUyB
	YJ7y16B7rVdXFoN3HKw+RB5hWi9p5aqlFtpmP5XTcgLN8ndastes7shV4+A/flGiQPxgLu
	IY4JHcxIP98pxAo7wKpbL0wtzI1nSHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698934746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PJapYrFiAMmv362BFUxi1ucwnmZqU7rS0CcfdNqddxc=;
	b=Oenu1J9eXXRNaAK5td+7bcRTDP7gXS7uCgaSGKyNS1tNcvnEN4Z19ckEPa8ClhLcgFQk3D
	BbKxHSwFf4ilZtCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 99E552C8AE;
	Thu,  2 Nov 2023 14:19:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C55AB51ECABB; Thu,  2 Nov 2023 15:19:06 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/2] nvmet: avoid circular locking warning
Date: Thu,  2 Nov 2023 15:19:01 +0100
Message-Id: <20231102141903.66515-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231102_071914_281110_6D43D8DE 
X-CRM114-Status: UNSURE (   9.91  )
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

nvmet-rdma and nvmet-tcp trigger a circular locking warning when
tearing down; reason is a call to 'flush_workqueue' when creating
a new controller which tries to cover for the fact that old controller
instances might be in the process of tearing down.
However, this is pure speculation as we don't know (and don't check)
if there really _are_ controllers in shutdown.
And even if there were, that should be short-lived, and would have been
resolved by connecting just a tad later.
So this patch returns 'controller busy' if we really find ourselves in this
situation, allowing the caller to reconnect later.

Changes to the original version:
- Update the rdma patch to implement 'install_queue()'
- Include suggestions from Jens Axboe

Hannes Reinecke (2):
  nvmet-rdma: avoid circular locking dependency on install_queue()
  nvmet-tcp: avoid circular locking dependency on install_queue()

 drivers/nvme/target/rdma.c | 24 +++++++++++++++++++-----
 drivers/nvme/target/tcp.c  | 13 +++++++++++--
 2 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.35.3


