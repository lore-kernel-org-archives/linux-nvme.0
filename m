Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 05:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A9060EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 05:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00A9060EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6XEAbG0xrBwQzBwNFpSWRiQJVyW+lUHpHEEFD3M5LU8=; b=yGUndIavyYDH52QB8lGyt32+yI
	fPrAkZa10grpmZYmMVH/AMD8uQ8vhjXUsNGfMROOp+BSM122ItPSk2/r6Cf6ckpon5JB59dEi3vrS
	vjplxh1evKoD6zzr0rNb6GlOuhyOtY+KGtUTxNgv7r4l6pSYHau9fGXzZaj3v3Q4EAyhQmlY7Cx6z
	8R/kpN8bDHD0ZF7+yDZU9/Fi43sKRL4u3XuGiRpjL2umoNmd/GVZjl0ABaX243MhzU8Us7Y8KoCL6
	+yNxjg6rv8gUXj2/AaTsamn6UELHDObpDkCodn3ocdXwOO8j5/4lOEf1ZKVefS3D9T+9d+Xs1/tm5
	PW5h2Jnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1md4d9-003RUO-K7; Wed, 20 Oct 2021 05:59:15 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1md4d6-003RTp-JF
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 05:59:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5F69721A7F;
 Wed, 20 Oct 2021 05:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634709551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6XEAbG0xrBwQzBwNFpSWRiQJVyW+lUHpHEEFD3M5LU8=;
 b=ogW9MclSbqjUa6UCXqGoaw+iFzTJzVq5EzPYXokt2xLwDpz5//DVDze/tvrG4uZwAMx7vL
 oQ2aWSWfjdRFnbDW3f7V1wnWiQwpMEOjSlQvYii4he1iFpuTF0yR2bRX+wdAg7dVB0D+2B
 5C2HNcTwOITkKOIt41n70R1bBqnvwCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634709551;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6XEAbG0xrBwQzBwNFpSWRiQJVyW+lUHpHEEFD3M5LU8=;
 b=usEOak90ZtFPgwD53SLuYLJ80gmJSw5SF4uXjxdnxW9ofLLzakdfAjni3LOCPQP18/qm/Y
 bt5zkWxwa+/kP2DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5828AA3B83;
 Wed, 20 Oct 2021 05:59:11 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 49FCD518FC9A; Wed, 20 Oct 2021 07:59:11 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: drop scan_lock and always kick requeue list when
 removing namespaces
Date: Wed, 20 Oct 2021 07:59:10 +0200
Message-Id: <20211020055910.110695-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_225912_810104_5B0CC843 
X-CRM114-Status: GOOD (  11.92  )
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

When reading the partition table on initial scan hits an I/O error the
I/O will hang with the scan_mutex held:

[<0>] do_read_cache_page+0x49b/0x790
[<0>] read_part_sector+0x39/0xe0
[<0>] read_lba+0xf9/0x1d0
[<0>] efi_partition+0xf1/0x7f0
[<0>] bdev_disk_changed+0x1ee/0x550
[<0>] blkdev_get_whole+0x81/0x90
[<0>] blkdev_get_by_dev+0x128/0x2e0
[<0>] device_add_disk+0x377/0x3c0
[<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
[<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
[<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
[<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
[<0>] nvme_scan_work+0x168/0x310 [nvme_core]
[<0>] process_one_work+0x231/0x420

and trying to delete the controller will deadlock as it tries to grab
the scan mutex:

[<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
[<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
[<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]

As we're now properly ordering the namespace list there is no need to
hold the scan_mutex in nvme_mpath_clear_ctrl_paths() anymore.
And we always need to kick the requeue list as the path will be marked
as unusable and I/O will be requeued _without_ a current path.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fb96e900dd3a..475224ecee8b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,13 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->scan_lock);
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (nvme_mpath_clear_current_path(ns))
-			kblockd_schedule_work(&ns->head->requeue_work);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		nvme_mpath_clear_current_path(ns);
+		kblockd_schedule_work(&ns->head->requeue_work);
+	}
 	up_read(&ctrl->namespaces_rwsem);
-	mutex_unlock(&ctrl->scan_lock);
 }
 
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
-- 
2.29.2


