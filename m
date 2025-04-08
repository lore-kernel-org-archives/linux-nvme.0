Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA4C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rDsxrbgLSytHHcGIaecLuBVy+tv6KhEqOOelLf6BfQ=; b=meQFdLmy76pizCPoCYm92SZ6xz
	jLzTJZkuZX+kanbQUXI5XIdp6isjsBaxddDYOn4t3H2J61sgqZAA7sDMwsMetqr91yycvROVMAjvn
	hvfpCsi+lFyoaKhDLILGC9WFerOcDqQoFouOdM0FtC6HIzbMwbA0Gtqzn6nHnD6WL7g7GIyxAeYfs
	D2M08H/F25wz2cgSjzxaP615VEwL4h2DRWCS1TBgMfxWGdZt8C5XTZ9LsXstVK5XSlzSewTWh6KJ1
	eR5dEWFCj6QWY79goTp7lb0TGarGs/k8fGtcHfJSSbkXAe1EMaMM314TPF9CEsy5HptDBoVT8wKDN
	ve89iL3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0g-00000002XvK-2EjB;
	Tue, 08 Apr 2025 02:48:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0d-00000002Xtt-1hE4
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 02:48:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E2DE5C0F8E;
	Tue,  8 Apr 2025 02:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB4C4CEEA;
	Tue,  8 Apr 2025 02:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744080497;
	bh=1Rb4770BZe6UINZiraUsNcxu9W3mcvhheoHjXMPHoo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Nwm8mO6rAA4hdQWaByabbC8mTxfpw3xEofTj90UmD3EVLoKJSsStPlc44+XBSN4yo
	 QYVxBH+p8kAdsNulAvATPwcJ9emonNZ+yjnuO4Y9gej0RmkS2g545r54RhcjAnMQiV
	 Y9exA62C05wrmNoHjn8O50aeVxsCNPnzOzt/SWStotPGuSlOvdOsq97/jwdm4CouW3
	 WFYD5YdxvWzGmxaVuWGmyeRMnQHiRAU6x+O6SNTTZncu+/wA83lsjChtC5zQQvSLkJ
	 oKIxam4gnhO8//RJTgm+zNoZo4MvlXyp+6C7pOzu5YSyPYKnHrXQVxvUOD0/Ovjq6R
	 jDedaLznQY7Cg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/3] nvmet: pci-epf: Always fully initialize completion entries
Date: Tue,  8 Apr 2025 11:47:31 +0900
Message-ID: <20250408024733.690966-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408024733.690966-1-dlemoal@kernel.org>
References: <20250408024733.690966-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_194819_505716_173D9B1D 
X-CRM114-Status: GOOD (  12.66  )
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

For a command that is normally processed through the command request
execute() function, the completion entry for the command is initialized
by __nvmet_req_complete() and nvmet_pci_epf_cq_work() only needs to set
the status field and the phase of the completion entry before posting
the entry to the completion queue.

However, for commands that are failed due to an internal error (e.g. the
command data buffer allocation fails), the command request execute()
function is not called and __nvmet_req_complete() is never executed for
the command, leaving the command completion entry uninitialized. For
such command failed before calling req->execute(), the host ends up
seeing completion entries with an invalid submission queue ID and
command ID.

Avoid such issue by always fully initilizing a command completion entry
in nvmet_pci_epf_cq_work(), setting the entry submission queue ID and
command ID.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 51c27b32248d..f6b22ef4c267 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1763,6 +1763,8 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 
 		/* Post the IOD completion entry. */
 		cqe = &iod->cqe;
+		cqe->sq_id = cpu_to_le16(iod->sq->qid);
+		cqe->command_id = iod->cmd.common.command_id;
 		cqe->status = cpu_to_le16((iod->status << 1) | cq->phase);
 
 		dev_dbg(ctrl->dev,
-- 
2.49.0


