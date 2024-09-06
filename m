Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB26CE7AFE
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 10:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Um+AFR1d9RiNcWKhEgT1ZlzHI53dVnBzGEQOucoiPpI=; b=cH4Vby3T7dRK170+O1dGo99inT
	OXSNpPVkPC42h8hZuKJRXfGWFuzlmyWpBDyBzMLUIzJN00f0aPxS+9X+GqGIRZ7w8SdgU4QsdKxjC
	kHvSOjug4Oar1M8R0fKXGzWiaF+lKrV/HcpuRsIoXx63k1TX9zIf6qTNz2eIgkE5MkQ52V4lTRtwG
	Z+7DlaE/Eh3POjd8sROFzrc60Guc0/gKIi+5z/xkErUYY29EL4tUYXSgQVWJULo2qNG7CuDhomVNJ
	8wgS5T0jcNkfIILdFD20kyQaEqNIKdfJfwAz9YOiaswT+ZuNKZX6B+S1PSvEsfwaCk/+uYP63OM+W
	W7xQunlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smWAq-0000000BkbX-13dM;
	Fri, 06 Sep 2024 10:26:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smW1Z-0000000BiH7-2xYB
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 10:17:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6679EA44DF7;
	Fri,  6 Sep 2024 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB75C4CEC5;
	Fri,  6 Sep 2024 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725617824;
	bh=IZ5tpC5E4w1fV2lV03/VUju5CXXmD0bSsrgjuqJtTQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgvcsaoYQkeid+hsOqLGl9daSGkhpO99VhxcjeNle9vbMBiOU5TrFBcll5T/aJ1ey
	 bdWusyvWRgZJDBsj+bhbshSp6rBLFRwEYEGcle0GCTKqnGdp655rFoNL8eYTHUbURq
	 JT377n4Crf2T5plsUC5jGiyDGukX5hU4LF8mUqJdtpUfBy1o6bGwIdgqJWmfmslZrx
	 z2si85zWkZpa8LnTyBK9QruJk5GyMfVAPc1UJSNwNQHfst8buVdPHjp2BGb3hBf7JR
	 Q4ItTfuyFvztnWFUwOoPeeSbVxYC7b7tDHkPt+KTfGN4uJa56j0gEs2+tRKfthhTDj
	 3upc2/8HizbHw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/3] nvme: 'nvme disconnect' hangs after remapping namespaces
Date: Fri,  6 Sep 2024 12:16:40 +0200
Message-Id: <20240906101640.44417-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240906101640.44417-1-hare@kernel.org>
References: <20240906101640.44417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_031705_829365_8396A908 
X-CRM114-Status: GOOD (  10.93  )
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

before the namespaces are removed.

This patch sets the 'failfast_expired' bit for the controller
to cause all pending I/O to be failed, and the disconnect process
to complete.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 651073280f6f..b968b672dcf8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4222,6 +4222,13 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	nvme_mpath_clear_ctrl_paths(ctrl);
 
+	/*
+	 * Mark the controller as 'failfast' to ensure all pending I/O
+	 * is killed.
+	 */
+	set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
+	nvme_kick_requeue_lists(ctrl);
+
 	/*
 	 * Unquiesce io queues so any pending IO won't hang, especially
 	 * those submitted from scan work
-- 
2.35.3


