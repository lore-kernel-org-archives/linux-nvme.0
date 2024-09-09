Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCDEECE57B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qO3NafvL5Ux/f5pMqOBws++tI1ltO7n0pDeck1Yzj/Y=; b=syI5e7oT71b1U7jJXYnhvPCxi1
	JA/YUMq5WMRsD89Mm8ABLzt8eRbESrq1Hr1NQxE7D2BgGZwCsHM2vFHi+FeZHaNAq/oTSQDyuFnUQ
	Kelv9IwNLYoD9RgTz2PayM50Iis8fV2dZn3HcoEpS6GTJQG0ahzCFskuLwEYNARkJe3F/nMhg9M/7
	VyqmK9KMAE/24oVTtYhijIe5ERhpOfVNFNm2qqG/ubCc8sFuh/R5D9m41Ehl3i0S1oogFcmQLQwG6
	HOVGQB4wX+ZIQFr66EJJZQDRFV/MvpFnDyYYCmGVBaG2qu+xaEjhJCWtvW4EeW7ZfCZxeiZpeHTO8
	GhdqV8oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgf-00000000mgT-2Pjf;
	Mon, 09 Sep 2024 07:19:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snYgc-00000000mem-1riP
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 07:19:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4EECA5C557F;
	Mon,  9 Sep 2024 07:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5E3C4CEC5;
	Mon,  9 Sep 2024 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725866385;
	bh=pipz0yg3utGsI6nRjgxI/x3QhI9vSAJDwaBgGyMpOwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJhWoj3NSngYg1LLQNv7uho2LMK1uMrzA2U+TvV2EGvi2fhCn8w0iPqNmYKdJyH1X
	 N4mzxgPKCffPHSHj3qKlqZVMspyD75/qh4FM6vf9qQ3+9wmHPPeXMCjGgoGziFRqJf
	 TnZdAshE+B2R7N+P5xm3joRtY1atRi9MF600BGE9WoQwLCMDhgl0/nRdZRAm3UD4sy
	 v58jU1qAt44xqMiBDQ1eddJI30A7aN71yrzzZYcVHW5JqECJafUHnxMNZVxJdcAVdg
	 SPH1KVwvmYDQkDWqYvg1v9t1N0ILnIF6GEBBKZfB3mDULre3uMhoKjCN23uemnzgVY
	 6kYLsi29gsUkw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping namespaces
Date: Mon,  9 Sep 2024 09:19:30 +0200
Message-Id: <20240909071930.146343-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240909071930.146343-1-hare@kernel.org>
References: <20240909071930.146343-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_001946_834434_3667E36F 
X-CRM114-Status: GOOD (  13.36  )
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

During repetitive namespace map and unmap operations on the target
(disabling the namespace, changing the UUID, enabling it again)
the initial scan will hang as the target will be returning
PATH_ERROR and the I/O is constantly retried:

[<0>] folio_wait_bit_common+0x12a/0x310
[<0>] filemap_read_folio+0x97/0xd0
[<0>] do_read_cache_folio+0x108/0x390
[<0>] read_part_sector+0x31/0xa0
[<0>] read_lba+0xc5/0x160
[<0>] efi_partition+0xd9/0x8f0
[<0>] bdev_disk_changed+0x23d/0x6d0
[<0>] blkdev_get_whole+0x78/0xc0
[<0>] bdev_open+0x2c6/0x3b0
[<0>] bdev_file_open_by_dev+0xcb/0x120
[<0>] disk_scan_partitions+0x5d/0x100
[<0>] device_add_disk+0x402/0x420
[<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
[<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
[<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
[<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
[<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]

Calling 'nvme disconnect' on controllers with these namespaces
will hang as the disconnect operation tries to flush scan_work:

[<0>] __flush_work+0x389/0x4b0
[<0>] nvme_remove_namespaces+0x4b/0x130 [nvme_core]
[<0>] nvme_do_delete_ctrl+0x72/0x90 [nvme_core]
[<0>] nvme_delete_ctrl_sync+0x2e/0x40 [nvme_core]
[<0>] nvme_sysfs_delete+0x35/0x40 [nvme_core]
[<0>] kernfs_fop_write_iter+0x13d/0x1b0
[<0>] vfs_write+0x404/0x510

before the namespaces are removed, and the controller state
DELETING_NOIO (which would abort any pending I/O) is set only
afterwards.

This patch calls 'nvme_kick_requeue_lists()' when entering
DELETING state for a controller to ensure all pending I/O
is flushed, and also disables failover for any commands which
are completed with an error afterwards, breaking the infinite
retry loop.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 651073280f6f..142babce1963 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -381,6 +381,8 @@ enum nvme_disposition {
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
@@ -393,6 +395,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		return AUTHENTICATE;
 
 	if (req->cmd_flags & REQ_NVME_MPATH) {
+		if (nvme_ctrl_state(ctrl) == NVME_CTRL_DELETING)
+			return COMPLETE;
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
 			return FAILOVER;
@@ -629,7 +633,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	} else if (new_state == NVME_CTRL_CONNECTING &&
 		old_state == NVME_CTRL_RESETTING) {
 		nvme_start_failfast_work(ctrl);
-	}
+	} else if (new_state == NVME_CTRL_DELETING)
+		nvme_kick_requeue_lists(ctrl);
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
-- 
2.35.3


