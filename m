Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD5CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 13:21:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D7E60FC3
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55D7E60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wnt7mFLAjVnxm6agU/pUDd8KQgF9aKwvQATvhFbENRE=; b=OmfuCetsuHTqnhI74daNKBXpre
	jP8tD9uaqKfgw39s30qMNIkUh4N9xllOX2Rwh1o461Ko1BsWklqJeZlrsBcAetl2fI5OrSZ0O1nZU
	QQr5QGDXlrpsWsUJ5zx1vPCMIQowzgNqGzqrKUefQKf/JkM9o/5SSj0JmKpQqoPQRc4jOiD9Rjcjz
	3eEk7KZslduPxWnOraos97bCC7NWLzQNrf6p6oQ0KEtIzJTdHUkBryYVPswsXlIdT+pL77lR77hR5
	94k/rl6W4boUU3zsUzUn24IcyQGFRK6/1nWRy6sbVIpvf4vxb2eC9oluG0j+6wG/AerbLXzwT0dqh
	3s5ITOFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlA1O-007xc9-8j; Thu, 11 Nov 2021 13:21:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlA1K-007xbg-Av
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 13:21:39 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 03E0F21B38
 for <linux-nvme@lists.infradead.org>; Thu, 11 Nov 2021 13:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636636897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnt7mFLAjVnxm6agU/pUDd8KQgF9aKwvQATvhFbENRE=;
 b=UpFvU64Cmo3/6+j4FTl1Ea7Vj4FLeRMGkM1OMFV7AlVnI9s7GM1GFMQjjPUKFOokNenwk3
 OqOXQJ9PJQAL5AxBbOY0+Fyg1bldT6TETthP22+oMHnYC0qUI2tzepiHgp67y6UNOAS1bB
 i+qdWMJ4NBR0dEW1QCK+iVb1n//D83M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636636897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wnt7mFLAjVnxm6agU/pUDd8KQgF9aKwvQATvhFbENRE=;
 b=P05u/1P2UvRCcYcmbujDfTHb8RW7fvGBkJAizNkJJHRMwdFHIdJq+0GrAReS7CWLHJHquw
 Dp6yB2L8wrZ4DQBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id F2606A3BB8;
 Thu, 11 Nov 2021 13:21:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id E65A451911CC; Thu, 11 Nov 2021 14:21:36 +0100 (CET)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme: Add sibling to list after full initialization
Date: Thu, 11 Nov 2021 14:21:35 +0100
Message-Id: <20211111132135.19216-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_052138_550042_1CDCC19B 
X-CRM114-Status: GOOD (  14.84  )
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

Adding the newly created namespace before the object is fully
initialized is opening a race with nvme_mpath_revalidate_paths() which
tries to access ns->disk. ns->disk can still be NULL when iterating
over the sibling list.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2: use list_add_tail_rcu instead of list_add_tail

I got a few bug reports from our customer hitting this
quite often:

 RIP: 0010:nvme_mpath_revalidate_paths+0x27/0xb0 [nvme_core]
 Code: 44 00 00 0f 1f 44 00 00 55 53 48 8b 6f 50 48 8b 55 00 48 8b 85 10 c5 00 00 48 39 d5 48 8b 48 40 74 20 48 8d 42 d0 48 8b 50 20 <48> 3b 4a 40 74 05 f0 80 60 78 ef 48 8b 50 30 48 39 d5 48 8d 42 d0
 RSP: 0018:ffffaf1303fffcc0 EFLAGS: 00010283
 RAX: ffff95f75ef5c400 RBX: ffff95f71f63aa00 RCX: 0000000000200000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff95f71f63aa00
 RBP: ffff95f71b1d0000 R08: 0000000800000000 R09: 00000008ffffffff
 R10: 00000000000007be R11: 0000000000000384 R12: 0000000000000000
 R13: ffff95f71b1d0000 R14: ffff95f721d79338 R15: ffff95f71f63aa00
 FS:  0000000000000000(0000) GS:ffff95f77f9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000040 CR3: 000000033940a005 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  nvme_update_ns_info+0x15b/0x2f0 [nvme_core]
  nvme_alloc_ns+0x27f/0x810 [nvme_core]
  nvme_validate_or_alloc_ns+0xbb/0x190 [nvme_core]
  nvme_scan_work+0x155/0x2d0 [nvme_core]
  process_one_work+0x1f4/0x3e0
  worker_thread+0x24c/0x3e0
  ? process_one_work+0x3e0/0x3e0
  kthread+0x10d/0x130
  ? kthread_park+0xa0/0xa0
  ret_from_fork+0x35/0x40

This patch fixes the problem reported. I am not totally sure why this
suddenly happens but I guess it is related to 041bd1a1fc73 ("nvme:
only call synchronize_srcu when clearing current path").

 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a2610e147ce..7e43cb31d41e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3776,7 +3776,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		}
 	}
 
-	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
 	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
@@ -3873,6 +3872,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (nvme_update_ns_info(ns, id))
 		goto out_unlink_ns;
 
+	mutex_lock(&ctrl->subsys->lock);
+	list_add_tail_rcu(&ns->siblings, &ns->head->list);
+	mutex_unlock(&ctrl->subsys->lock);
+
 	down_write(&ctrl->namespaces_rwsem);
 	nvme_ns_add_to_ctrl_list(ns);
 	up_write(&ctrl->namespaces_rwsem);
-- 
2.29.2


