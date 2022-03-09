Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S2MRezVPElQ5ukQwoAw0QbTNZFzogFkt36Xv2AEwy5c=; b=U94VDvVTLRZpwHAubaFFbW9Wpv
	gj1GL2IF4AAzDQaX1IstHUVCYI22yDlhisX0iPL5Q7xdQtcpFXPhX0DXVtEVcLCiPqCjNQtiCfMh1
	gBGPJDLtQGGAYxWlQ4cP5SIBzT2q02spLJmkBzUg6V3ZFRWLbAoWzzLS052G57kX3V5cVL2TFMud+
	3yi516Q2UyRE0I5SpLThY9PEV1Bjfsq0m8JWJyCl9oN4Wz6nhCLnzyVa8jpDTvUhgH+9KYP96hwG3
	2Hp4dTh2XB/KjIKOAHByAoHr6Tg9llfCI2V0igsC9brajYcBg7elVMYdZymHGVUN00RA9hmFdOIPc
	w/c0bTXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRwNL-008lZl-6e; Wed, 09 Mar 2022 13:29:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRwNH-008lXH-Qk
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 13:29:09 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C86AC1F381
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646832544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S2MRezVPElQ5ukQwoAw0QbTNZFzogFkt36Xv2AEwy5c=;
 b=geD/mdI5PplUhx2SJGskPW0I6SSTnZcKy8bDfwQeZqoOu/SNqn++P24Ya9/CkBJ5vTsW7e
 xaldNdjBPTqMZJp/LyDZQRIsO+bvB4FCn+5nHS13A7zcpPdr5dOCLtk+uAvT8a/bb6cBi6
 NCaBFRfjSumKGsykuqTq+dRs+ZJsHG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646832544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=S2MRezVPElQ5ukQwoAw0QbTNZFzogFkt36Xv2AEwy5c=;
 b=AousLmWRqcni5kNcwJ1czunnN7SYdIGScgU/tuEzP3ugXh1lJQsekJfZEdQcfYfvSKrOCG
 gaJ95eFhYfY3X+BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A46E1A3BA0;
 Wed,  9 Mar 2022 13:28:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id B667B51935D7; Wed,  9 Mar 2022 14:29:04 +0100 (CET)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Date: Wed,  9 Mar 2022 14:29:00 +0100
Message-Id: <20220309132900.1171-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_052908_042296_F97056F4 
X-CRM114-Status: GOOD (  12.93  )
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

The ANA log buffer can get really large, as it depends on the
controller configuration. So to avoid an out-of-memory issue
during scanning use kvmalloc() instead of the kmalloc().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

As discussed in [1] switch the ana buffer memory type to
kvmalloc. I've done some simple testing but also got positive feedback
from our partner who observerd order 7 allocation with kmalloc.

This patch is cut against nvme-5.18. Let me know, if it should be
again something else.

[1] https://lore.kernel.org/linux-nvme/20220207100005.34404-1-hare@suse.de/

 drivers/nvme/host/multipath.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f8bf6606eb2f..3ddc1ba66f0d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -5,6 +5,7 @@
 
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
+#include <linux/vmalloc.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -898,7 +899,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	if (ana_log_size > ctrl->ana_log_size) {
 		nvme_mpath_stop(ctrl);
 		nvme_mpath_uninit(ctrl);
-		ctrl->ana_log_buf = kmalloc(ana_log_size, GFP_KERNEL);
+		ctrl->ana_log_buf = kvmalloc(ana_log_size, GFP_KERNEL);
 		if (!ctrl->ana_log_buf)
 			return -ENOMEM;
 	}
@@ -915,7 +916,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
-	kfree(ctrl->ana_log_buf);
+	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;
 }
-- 
2.29.2


