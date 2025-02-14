Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4FC021A4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2025 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GfW1gpLXY2EdPkpzb9y1K4qdQiidSpe4e1MAvQjCD/A=; b=y1jh4O/Fmn90j9
	c84oCACtpGM3i1OsDP79bnx6lxpxvSMM29TWM1eL2aMv/b5QvAnnmTCc2cazz1OJtkjjSqkvZnEQv
	kXLnzux25ap3um0Lel27EcEwykdbthDNH5+mJ1200lrP1pXHylyG+8DcAmgMXwglTTakT7N5cpSEB
	BqMDqCREdWuQTwSF0gN8pa4BaX9KJrCA/o9bCanTQR18H/Vq6AOJ8gYUVLDNLEaaB1bfjrYiNB1bW
	iW2PCyJwNEFyKgY8iXYJ9NPCbRYexWV1zFbZ0zbnHUkVKEOwyhEVyKA+Hb5AUvQbWRzD7YycZKPPA
	hEajju2Gp9EGouZm61UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiqeR-0000000E2R1-1n79;
	Fri, 14 Feb 2025 08:02:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiqeP-0000000E2QQ-1Z7m
	for linux-nvme@lists.infradead.org;
	Fri, 14 Feb 2025 08:02:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C76A45C58D7;
	Fri, 14 Feb 2025 08:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D68C4CED1;
	Fri, 14 Feb 2025 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520136;
	bh=+DvmIDAFvzsza7cyWGZSUdLzfYbcKamkNgmexqX3s/U=;
	h=From:Subject:Date:To:Cc:From;
	b=uPpiH/bFpw69xtS5sKK7gmd7o3r520yn2Q4g6FCCcXrbg04d3qMiGCQumJX780sZ4
	 hrLfPK1CsFy1cDR2UXju4iGl9IWXCA3PJ+COggZYHsJrWlxWsCGmK6aH+Gl/8LYiDd
	 jVSCwb/QmPmlxUObac7iLlfbjrOe92aQEq54MgQLVVjtOvyIIYylMDDAtCXuK5FaPW
	 x1xF7Ksgkwk73xWPb6DZeYTIh2BS9+yKQ17qMATO3AuCJHN+PD5lWhPRKfMOv5+QTU
	 0t3VqmBFtmtHiokSxfcACSpe50eREKjRivoVKm04S9nROjzfgdu2HC5G15skRLyeHq
	 xSH1bGxo7yylQ==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Date: Fri, 14 Feb 2025 09:02:02 +0100
Message-Id: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHr4rmcC/x3LQQqAIBBG4avIrBtwlDZdJVpI/tYsslCIILx70
 vLj8V6qKIpKk3mp4NaqZ+6QwdC6h7yBNXaTs260Tjzn+wCnlZM+qIwYJIiNSH6k/lwFf+jLvLT
 2AcszEpxfAAAA
X-Change-ID: 20250213-nvme-fc-fixes-eda1a10def35
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_000217_473492_42798EE1 
X-CRM114-Status: GOOD (  13.92  )
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

Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
introduced a bug. I didn't spot the schedule call in
nvme_change_ctrl_state.

It turns out the locking is not necessary if we make the state machine a
bit more restrictive and only allow entering the LIVE state from
CONNECTING. If we do this, it's possible to ensure we either enter LIVE
only if there was no connection loss event. Also the connection loss
event handler should always trigger the reset handler to avoid a
read-write race on the state machine state variable.

I've tried to replicate the original problem once again and wrote a new
blktest which tries to trigger the race condition. I let it run a for a
while and nothing broke, but I can't be sure it is really gone. The rest
of the blktests also passed. Unfortunatly, the test box with FC hardware
is currently not working, so I can't test this with real hardware.

[1] https://lore.kernel.org/all/denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m/
[2] https://lore.kernel.org/all/20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org/

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (2):
      nvme: only allow entering LIVE from CONNECTING state
      nvme-fc: rely on state transitions to handle connectivity loss

 drivers/nvme/host/core.c |  2 --
 drivers/nvme/host/fc.c   | 67 +++++-------------------------------------------
 2 files changed, 6 insertions(+), 63 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250213-nvme-fc-fixes-eda1a10def35

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


