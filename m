Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE36CF3195
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 04:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BxJYHASk0joit/denqMf/VlIPDl0wa5488pXBNCBlRM=; b=TZlUWJfZ5QyqcIv24Zx2zw8M7E
	PcPM1EcwaLS0NrLqAez/fH6CxenUz97G0w4bi0o7erhF/q62fV+XwFbTL1/K7BhDFgpJbxQ1Atd/y
	XXSTC9ycDa5owQUcdkbBJD0rqCVwylSmWvn2ez9a71iHeG+7EeK33hc4p+KAN0BxiosCUELJNtwhB
	dph/dm5YtJdgFxsPdRa+eOLBKOjgWhYPvfcmzpvPYsVZD9pf0flrA4KuA3xXEFj6h1GVTTNT69h0/
	emrrkfQNScb7EYNRctB9Bv/2IRjPLiJ9YhZqSOF+q6ASGaXBhoaHdrP7hg2WvixXLrV3AEND0RUFp
	LXNpMs7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svrL4-00000004ntZ-3D2R;
	Wed, 02 Oct 2024 04:51:50 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svrL1-00000004nsg-2UmK
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 04:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727844707; x=1759380707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z4PTngsCOPd8bkbcrT+RnP8uZ/eayEDnxlSuP2MNf/s=;
  b=XHP41TIrau0UWpAwcMKs3q/mwauE9TdwuCQDlxCVWrEsD7W5gurvXxsZ
   L6ngKXgNa9VIuBuyi1GakUZ7IY6JIdjLRLuAn6lg7rvsU9By2SuePplRS
   4rnGrjQ7slCa2Ra4UGJF8fUqUl7rkIJ52XZJIbSVVPLypnbcN/tonlBPa
   63gbWldSDkrAQ6gc0jmGSLVr/QeAv1A8/QJJtyES1cjlP15kLcpGIOyAL
   6x0UA1FhdDjdEOAQCNpc7glfqsONIdE7DuGG841sGxvZnmgWkniibRQP3
   ExlPWf8BPzAaEhWYXcl3XFdbkEUz57qSQIkgsfI+wdr9HVwe36U0z/pfZ
   A==;
X-CSE-ConnectionGUID: Q81TmirDQiGN5/mCvhoFiA==
X-CSE-MsgGUID: jv4s+LC4RJW+w7nS5rU/Ig==
X-IronPort-AV: E=Sophos;i="6.11,170,1725292800"; 
   d="scan'208";a="28469127"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2024 12:51:43 +0800
IronPort-SDR: 66fcc467_m1nVmnjKOiNvJcRqM2XdCbLwZb5aYeHALKMFsrUB5oiKaYk
 U5rMX3krRvLmdpLvU593B6uruabyiGaH6x+c/4g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 20:56:23 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2024 21:51:43 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvme: tcp: avoid race between queue_lock lock and destroy
Date: Wed,  2 Oct 2024 13:51:41 +0900
Message-ID: <20241002045141.1975881-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_215147_700355_E2A744A7 
X-CRM114-Status: GOOD (  16.82  )
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

Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
error recovery") added a mutex_lock() call for the queue->queue_lock
in nvme_tcp_get_address(). However, the mutex_lock() races with
mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 34077 at kernel/locking/mutex.c:587 __mutex_lock+0xcf0/0x1220
Modules linked in: nvmet_tcp nvmet nvme_tcp nvme_fabrics iw_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet pcspkr netfs parport_pc parport e1000 i2c_piix4 i2c_smbus loop fuse nfnetlink zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs drm sym53c8xx floppy nvme scsi_transport_spi nvme_core nvme_auth serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg [last unloaded: ib_uverbs]
CPU: 3 UID: 0 PID: 34077 Comm: udisksd Not tainted 6.11.0-rc7 #319
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:__mutex_lock+0xcf0/0x1220
Code: 08 84 d2 0f 85 c8 04 00 00 8b 15 ef b6 c8 01 85 d2 0f 85 78 f4 ff ff 48 c7 c6 20 93 ee af 48 c7 c7 60 91 ee af e8 f0 a7 6d fd <0f> 0b e9 5e f4 ff ff 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1
RSP: 0018:ffff88811305f760 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88812c652058 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88811305f8b0 R08: 0000000000000001 R09: ffffed1075c36341
R10: ffff8883ae1b1a0b R11: 0000000000010498 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88812c652058
FS:  00007f9713ae4980(0000) GS:ffff8883ae180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcd78483c7c CR3: 0000000122c38000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn.cold+0x5b/0x1af
 ? __mutex_lock+0xcf0/0x1220
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? __mutex_lock+0xcf0/0x1220
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx___mutex_lock+0x10/0x10
 ? __lock_acquire+0xd6a/0x59e0
 ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
 ? __pfx_nvme_tcp_get_address+0x10/0x10 [nvme_tcp]
 nvme_sysfs_show_address+0x81/0xc0 [nvme_core]
 dev_attr_show+0x42/0x80
 ? __asan_memset+0x1f/0x40
 sysfs_kf_seq_show+0x1f0/0x370
 seq_read_iter+0x2cb/0x1130
 ? rw_verify_area+0x3b1/0x590
 ? __mutex_lock+0x433/0x1220
 vfs_read+0x6a6/0xa20
 ? lockdep_hardirqs_on+0x78/0x100
 ? __pfx_vfs_read+0x10/0x10
 ksys_read+0xf7/0x1d0
 ? __pfx_ksys_read+0x10/0x10
 ? __x64_sys_openat+0x105/0x1d0
 do_syscall_64+0x93/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? __pfx_ksys_read+0x10/0x10
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on_prepare+0x16d/0x400
 ? do_syscall_64+0x9f/0x180
 ? lockdep_hardirqs_on+0x78/0x100
 ? do_syscall_64+0x9f/0x180
 ? do_syscall_64+0x9f/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f9713f55cfa
Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 e8 74 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 42 75 f8 ff 48 8b
RSP: 002b:00007ffd7f512e70 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055c38f316859 RCX: 00007f9713f55cfa
RDX: 0000000000000fff RSI: 00007ffd7f512eb0 RDI: 0000000000000011
RBP: 00007ffd7f512e90 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 000055c38f317148
R13: 0000000000000000 R14: 00007f96f4004f30 R15: 000055c3b6b623c0
 </TASK>

The WARN is observed when the blktests test case nvme/014 is repeated
with tcp transport. It is rare, and 200 times repeat is required to
recreate in some test environments.

To avoid the WARN, check the NVME_TCP_Q_LIVE flag before locking
queue->queue_lock. The flag is cleared long time before the lock gets
destroyed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Simplified the fix based on the code by Hannes
* Added authorship by Hannes and his Signed-off-by tag

Link to v1 discussion:
  https://lore.kernel.org/linux-nvme/0a699cf1-66a1-4793-874d-05902149f727@suse.de/

 drivers/nvme/host/tcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89c44413c593..3e416af2659f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2644,10 +2644,11 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return len;
+
 	mutex_lock(&queue->queue_lock);
 
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		goto done;
 	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
 	if (ret > 0) {
 		if (len > 0)
@@ -2655,7 +2656,7 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
 				(len) ? "," : "", &src_addr);
 	}
-done:
+
 	mutex_unlock(&queue->queue_lock);
 
 	return len;
-- 
2.45.2


