Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987A9CA5FCE
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gKyYcvjLjwGtTwE4S1toXopSOO0s1xiKUhsPIFrsb0I=; b=4Dx0jhWAvG9tpG6d41bufTBBpq
	bsMWzjcNPyxe9sp0Bfj7ATv1e0TrTNnftLqWpdD/XnwYwf6x224fIXPLwka0JOp6rJtjVDX8zibWy
	PoRZRliIgORU3w6DSU+0H11ePwQUxf3iXg2igumfPrmXrCUwkqAVUkCLQC6qfrqbQMiblLDbR7rA9
	rGFJOyr65KflAW5lnT07wogxpyU4fL1onZNPyAycK+rJqhIZv/Fgd5ACz/thr/Ug2uS/FLFoxbEcg
	jBuEZXcUV2N8uq5dNOvsQegVJiMZxUYNqhwVTrBD2i+WsRMde8T4b+CvJaBYiET4WxyXYg7Bd3o1c
	2Bb4KeSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDiah-0000000GVlW-17WR;
	Mon, 05 Oct 2026 13:18:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDiag-0000000GVl7-0XHS
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 13:18:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 830BA60A64;
	Mon,  5 Oct 2026 13:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659B11F000FF;
	Mon,  5 Oct 2026 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206329;
	bh=gKyYcvjLjwGtTwE4S1toXopSOO0s1xiKUhsPIFrsb0I=;
	h=Date:From:To:Cc:Subject;
	b=YrjpnLZ2hAeAlbc6MTKMtiLS70ZdW8mAiL6VhK7pleFuxj+3Xs2F+vr3By6Lx5q2l
	 HKZnzyA15Hb0x11XDN5cdQDkC37qoJjO4o47ctnVrOUcwZQVpajKYbdkZOLWJ7cksd
	 YRiduB32gcaBqZgqJQxlSE7Zexbz02uTecefafyUZm+LS9rJYBGVAOVG9sWz8U1tAU
	 kdA3hOtG1kd24onkkXhjC7s3EnKpeW09D8v0GY1I8YwXi8s4UN4FTo+4XNiK6nHQul
	 Y/TtyJHAePnYcrIYKU8aeP/cReZQwHAUvYpkSTc6vmrCpOU+vjwkvQlPjf/TyIJvxg
	 OFhxKuaW7HxYg==
Date: Mon, 5 Oct 2026 15:18:45 +0200
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 7.3
Message-ID: <asOjta815QimaDcN@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Jens,

Sending the nvme PR earlier this week as it doesn't look like I'll have
any other chance for maintenance duties.

The following changes since commit 684b413b5483f57c890c171b9400076a0143b918:

  virtio_blk: set the zone write granularity (2026-09-29 12:54:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.3-2026-10-05

for you to fetch changes up to 5755f1bd0217ffe3c5cf85467bf6b0680f398265:

  Revert "nvme: do not reset controllers in NVME_CTRL_NEW state" (2026-10-05 06:07:37 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.3

 - Fix lock ordering revalidating zoned multipath heads
 - Fix swapped ZRASF zone state values for full and read only
 - Fix target p2pmem cleanup when the metadata allocation fails
 - Fix target status code for invalid NSIDs on reservation features
 - Revert the NVME_CTRL_NEW state change, which broke the Apple driver

----------------------------------------------------------------
Guixin Liu (1):
      nvmet: return Invalid Field for invalid NSIDs feature 82h

Karl Bonde Torp (1):
      nvme: fix swapped ZRASF zone state values for full and read only

Keith Busch (1):
      Revert "nvme: do not reset controllers in NVME_CTRL_NEW state"

Palla Raghunath (1):
      nvme-multipath: revalidate head zones after unfreezing the head queue

Sang-Hoon Choi (1):
      nvmet: use the local P2P device on metadata allocation failure

 drivers/nvme/host/core.c   | 12 +++++++++++-
 drivers/nvme/target/core.c |  2 +-
 drivers/nvme/target/pr.c   |  4 ++++
 include/linux/nvme.h       |  4 ++--
 4 files changed, 18 insertions(+), 4 deletions(-)


