Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D5C10F05
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvSYVP5KXhw4H9GXrCy9fBLwDKIq4M6LfNq7wXs87U0=; b=19QViGtgmeHo9SK8WJKWNudAnc
	v94OVkCOoGzcGcb37DQk/9giLVYDEvys2jo4JZP4U+ugsouA+3Z3aAlJOm1xuBBHRYZm4k1Nfpv8I
	s4RjdwILReLCEfy0FVPI+h+Uv3xq2w0Q8YDOMJKWQFyL0cZymq0yUnIURvMIRIqMoixgjF60vuNXu
	u2d50WeKiEMbZSzydaW/n6pPpjv2wgT62PG/StYXF7mmP1cSMVoJfCfMjx1tkQkHWvwZLVk+bS3s/
	geV3L3tyGyrpIC0RpJrN1k4/TJQi3EIWvSl5yAfPI0SIf1xaOWze2IDZ5eQ5QvqYwdewKgKV9MSqL
	NplQAZ6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgj1-0051dj-2E;
	Mon, 11 Dec 2023 13:53:35 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgim-0051Ve-2j
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 13:53:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 89F2FB80E5C;
	Mon, 11 Dec 2023 13:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61135C433C8;
	Mon, 11 Dec 2023 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302799;
	bh=bXLk7LPUpePE3Ki598P6UjpqUiZundDKzq3xApB28bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFuA6RBx6av04SAxdysrCLfr6mSHptC2N7F773j/NMayV8rP6oQ3JbaVY0tehmOQg
	 rt85482CMEyiRzuaPwXRzuUXiHmvfXuQaxwMt9LUZXSznMe1Ugzuju3L7XwIEDtbhh
	 vsRFmrtU9PlEwtnSs3kNLhoO37AEwf6L2LcPJNhPqFvgsgclq3Htd6HSZTTn4BUnhB
	 3ziwiy9WwDOMVWsbG+neg1duPqVNbDuJQi2SQENKndhZXNZt81C117GolqKhnMKLep
	 i4VCSKn0b6qXUuEC42LC5MD51tsKqCfPfj8jlEyd8N33wswnkuiyZh3EtUvbQibhCK
	 RcV4gNApRq5hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 32/47] nvme-ioctl: move capable() admin check to the end
Date: Mon, 11 Dec 2023 08:50:33 -0500
Message-ID: <20231211135147.380223-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 7be866b1cf0bf1dfa74480fe8097daeceda68622 ]

This can be an expensive call on some kernel configs. Move it to the end
after checking the cheaper ways to determine if the command is allowed.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 529b9954d2b8c..4939ed35638f1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -18,15 +18,12 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 {
 	u32 effects;
 
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-
 	/*
 	 * Do not allow unprivileged passthrough on partitions, as that allows an
 	 * escape from the containment of the partition.
 	 */
 	if (flags & NVME_IOCTL_PARTITION)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
@@ -34,7 +31,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	if (c->common.opcode >= nvme_cmd_vendor_start ||
 	    c->common.opcode == nvme_fabrics_command)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
@@ -53,7 +50,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 				return true;
 			}
 		}
-		return false;
+		goto admin;
 	}
 
 	/*
@@ -63,7 +60,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		return false;
+		goto admin;
 
 	/*
 	 * Don't allow passthrough for command that have intrusive (or unknown)
@@ -72,16 +69,20 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			NVME_CMD_EFFECTS_UUID_SEL |
 			NVME_CMD_EFFECTS_SCOPE_MASK))
-		return false;
+		goto admin;
 
 	/*
 	 * Only allow I/O commands that transfer data to the controller or that
 	 * change the logical block contents if the file descriptor is open for
 	 * writing.
 	 */
-	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return open_for_write;
+	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
+	    !open_for_write)
+		goto admin;
+
 	return true;
+admin:
+	return capable(CAP_SYS_ADMIN);
 }
 
 /*
-- 
2.42.0


