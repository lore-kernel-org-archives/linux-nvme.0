Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A339AC47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 07:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hZY0vCaWBRZNfTZPt9Esl4JRmqGEc38wC4+l1KpeTLI=; b=DV9cIGEBkXy2cgGriHaVWCyIIY
	lvHVTLwIZYighB2Fzky+R3JxHKBQrpjyt1r6DKnJWtTHQ72luSBqdBUAbDncFa3sgV9ExtId0nKtQ
	OmlM4djEdEAWne5az+NxHlPXAxjVrvBsk7UWKxndG035I+QrU6sJTfizX7NVvdgkSpTd8CwXdu/qI
	6j0nxaVJ0GNvRoaVRd0F9Ux9skuv1UxzMHsuBk5ZKHBIK2mXnFEGwP5wqXQU+VcbBb2J8pOGPKGGV
	tjPZOHq+35Yu8XL0NBTOzYa1WpacTreZcdCXVO1TI4hCf4GS16f0m0s1i+km1xOjLb+lOQh0lu9m+
	QuH4eWnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNpVY-00GIL1-26;
	Thu, 11 Jan 2024 07:29:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNpVW-00GIIN-10
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 07:29:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6D649CE1E60;
	Thu, 11 Jan 2024 07:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15204C433C7;
	Thu, 11 Jan 2024 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704958173;
	bh=pEDSgn260B5DLthgs/jDngB5s8mzTes9/0oHQWgNEcs=;
	h=From:To:Cc:Subject:Date:From;
	b=Fon6j0rHn667QUj/f5/+/sC81A24Lms+23MdSWmKnGuC8sF1kEofsNS4o9gScqxKS
	 PBDmQ/HBF5wcsG5Pk03vSNNMzgr9sUnCa8iCvozj8qAkdF0FSyIOqXWHHqg78iXMq3
	 X9TVZyypG9N0H8N5UvuPKEx/aRpIn2NdZyeVzOvpuowblcuvW/8wHbO3/gbsXzxewu
	 V8ehSbNtPolFN+Jx58LmPQ7//7YFMQT+KiP8zPwknh0zmyYmIAB2ML7ENNeu+QM9rQ
	 EzbvjZBhJIzDnOuhPACLaegz8wvzuVDmvEuwf144oth4AnGrXgObdhU8vS908s9Mho
	 1w1+mZWulGBAw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: Do not terminate commands when in RESETTING
Date: Thu, 11 Jan 2024 08:29:29 +0100
Message-Id: <20240111072929.29381-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_232942_542107_B39E26D4 
X-CRM114-Status: GOOD (  12.32  )
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

From: Hannes Reinecke <hare@suse.de>

Terminating commands from the timeout handler might lead
to a data corruption as the timeout might trigger before
KATO expired.
This is the case when several commands have been started
before the keep-alive command and the command timeouts
trigger just after the keep-alive command has been sent.
Then the first command will trigger an error recovery,
but all the other commands will be aborted directly
and immediately retried.
So return BLK_EH_RESET_TIMER for I/O commands when
error recovery has been started to ensure that the
commands will be retried only after the KATO interval.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b234f0674aeb..b9ec121b3fc6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2429,6 +2429,18 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, opc,
 		 nvme_opcode_str(qid, opc, fctype), qid);
 
+	/*
+	 * If the error recovery is started we should ignore all
+	 * I/O commands as they'll be aborted once error recovery starts.
+	 * Otherwise they'll be failed over immediately and might
+	 * cause data corruption.
+	 */
+	if (ctrl->state == NVME_CTRL_RESETTING && qid > 0) {
+		/* Avoid interfering with firmware download */
+		if (!WARN_ON(work_pending(&ctrl->fw_act_work)))
+			return BLK_EH_RESET_TIMER;
+	}
+
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
-- 
2.35.3


