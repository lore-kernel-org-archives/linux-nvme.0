Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E7BD743FE
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Xgj3Bzuk6Eu5lJYeVXW834/ho2H6FI5cpapJf9kO2OQ=; b=Mp6O7uoADJ61LnDBP6LXOsyZm6
	AlFDodGtU9D1MQJAxVWi5k0dhMo8WEuCe4WHm37YKlXyLLJgmqyjTqTOF3cZJAZtaxIMMLah6QLep
	P8r1GXChnw29lvgi6qwj1WePt3se+d2WJwZSqKnPm6bXZ3ICaNsksmIJnn7/KFYAheNiYZf6/JRry
	u1YoSxpQmklZiRtPTODvfNWcjw91w74iPpoOcGFc0HRTcq5kRuYuuUYHOz7dWvTml3tc2qFBZFUYI
	pfMHyDkowa1iwXmI/lPhZ1kneaZ5SfxuwfQmopLOiuJOiHNZCdxnGBMlYtFzIMUrJEtbEDU/28kFD
	IrnHb/Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEBNb-00000000b0n-2HvV;
	Thu, 21 Nov 2024 17:54:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEBNY-00000000b0N-2Vg5
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 17:54:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 05F1F5C58A5;
	Thu, 21 Nov 2024 17:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B40CC4CECC;
	Thu, 21 Nov 2024 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732211647;
	bh=QXivwrCHKzHfUCMWEBdqhkCZl7cB0PqC4rJFOhxC8rU=;
	h=Date:From:To:Cc:Subject:From;
	b=Kw+nuiABL99KOhwUq73D0X2QvnD+3cTKvAqWYHTUNpfanASx8IYu2+7Eq6lZfgbDM
	 Ag+qYPs78IQlRCp1mh+VPGpjcCPy7EauvMV4kI16ayKnyus6Tlkf9JUP9tEvSTa3CR
	 geDu4Xq20NPv6hYHT9xXiDC36f7OuswfKo2J/vrjfi6+FIYl4JU6gqHLhSGez3Wmg+
	 P0/qtuvZYsx4D3/hm3zwiQiEAHwMHFEDHulo1pk4zJnhdojBD/Vrg4oU/4z+Cn8Tnw
	 5/ENl5L0nDFQc0Ox+5al475zmkwvoCyCj9dK3VyL84m6/q6eP/BQZE/Ik10sodGXDc
	 xbfZ8t02gCmiA==
Date: Thu, 21 Nov 2024 10:54:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.13
Message-ID: <Zz9zvAF0yqzVbzoq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_095408_680245_CD65075B 
X-CRM114-Status: UNSURE (   8.19  )
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

The following changes since commit a3f143c461444c0b56360bbf468615fa814a8372:

  rust: block: simplify Result<()> in validate_block_size return (2024-11-18 09:10:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.13-2024-11-21

for you to fetch changes up to 029cc98dec2eadb5d0978b5fea9ae6c427f2a020:

  nvme: tuning pr code by using defined structs and macros (2024-11-21 08:57:42 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.13

 - Use correct srcu list traversal (Breno)
 - Scatter-gather support for metadata (Keith)
 - Fabrics shutdown race condition fix (Nilay)
 - Persistent reservations updates (Guixin)

----------------------------------------------------------------
Breno Leitao (1):
      nvme/multipath: Fix RCU list traversal to use SRCU primitive

Guixin Liu (2):
      nvme: introduce change ptpl and iekey definition
      nvme: tuning pr code by using defined structs and macros

Keith Busch (3):
      nvme-pci: add support for sgl metadata
      nvme: define the remaining used sgls constants
      nvme-pci: use sgls for all user requests if possible

Nilay Shroff (2):
      Revert "nvme: make keep-alive synchronous operation"
      nvme-fabrics: fix kernel crash while shutting down controller

 drivers/nvme/host/core.c        |  22 +++++++++++++++-------
 drivers/nvme/host/ioctl.c       |  12 ++++++++++--
 drivers/nvme/host/multipath.c   |  21 ++++++++++++++-------
 drivers/nvme/host/nvme.h        |  10 +++++++++-
 drivers/nvme/host/pci.c         | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 drivers/nvme/host/pr.c          | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 drivers/nvme/host/rdma.c        |   4 ++--
 drivers/nvme/target/admin-cmd.c |   7 ++++---
 include/linux/nvme.h            |  14 ++++++++++++++
 9 files changed, 274 insertions(+), 85 deletions(-)

