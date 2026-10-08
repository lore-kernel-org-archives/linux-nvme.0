Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C865CA600C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TU0SO4g5tDv/VF6Elax/PFIxpq1suhcXGP/z8OAP+qg=; b=S2e1G5hCoUhBI2xxjP3PeVMaUD
	8ZXZ4MEZRaj2+GFRxdUEodYN3fYZBYcR/PaDjxTQg0AJirLIDe+G4WTRShUwvOMWktYCN1XHBWq1T
	wiGN23NzWM6ulGtfT9Z/qJGxknW2v6deL/bNUgd8ZW90mWSky+9z7tzqJ/casYtOmmhwRw8rtmhD1
	pb9eTkSA391/EFRKlkeri6n79MEEzUiOI72STIMVhwlu7cXP5akaFSnho3e12n1u9wUUdshukhtRT
	b7D1JPSHJD5OJKT+SxzSsnaUNdVcFVPuMFFGfhfenlT134LooN43FW+j9+CWRmavcfMjyN3fevcug
	IGExJmWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEox9-00000004Wh6-1DtK;
	Thu, 08 Oct 2026 14:18:35 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEox7-00000004Wgl-0kXB
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 14:18:34 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8819033dbadso2080943b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791469112; x=1792073912; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TU0SO4g5tDv/VF6Elax/PFIxpq1suhcXGP/z8OAP+qg=;
        b=OG3lecV5lOb4m6oovTzjOCKhvjgQmhysW/nXgDx1vqodKw7eRwbQ/wRe+Vdvmvput+
         k7+ZwrFR6fzfJ3nRcDPcZB9QSft/kfoy17Hl4563mabknBkwY6E9nSqXbW4F/7QQgoWX
         OA3I0PoVUgYHZYA5OxBvVHbzU2g3Fu5xDZFk1rCJNxistslBqkuPRhro4O1qnap8Dezk
         myIMUcr6OttRD0UBgfX2uQePrHlFtFp5mCNkkHWKLuda4QLG4tDOITHaS0BioaG4kFVM
         z7Co0SYqmkoUE+tGnqP6bUgIIesaAoXVhNLas+fAlNFkNaD/zz5c4MzwjiOXU719sJ8Y
         OVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791469112; x=1792073912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TU0SO4g5tDv/VF6Elax/PFIxpq1suhcXGP/z8OAP+qg=;
        b=11vyk83tTnfRFmH62rNP70WMNZrWxH1RrR4/dZpuGJ852Lc++QjD58rLZJJrTB9uAG
         aiqWqKeCsLrNR+nM5YvI46NB3CHChqUInPkihvQv8r0vun+29ZP6tM+gv4K1JvWS++5t
         1Gvwf6h/QbP3HmQwhulFrr7On9VwyHf65l65orzkDE8nkl+JOTBV2fKMv/LkiY5f4Cdi
         hanCnmhOxOQonLnFilS5ai5acjda+vdhNInR1MwrYL1PIkqnPtqGs7Cq+E3X/edY9gOO
         Vn4+LYHjE574K3k10nxD9tApjsgqNjv/vLIJ7JG6saWD/Ch19mCByULKi1NuVmaPPhVe
         ZrLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOgtOcp/ewKeH5eML2MD/4TIo5SXKo/CVZdYV2oWc+MLBw3aLanSNNWeDbxh1J5Qswjse6PlbdliZw@lists.infradead.org
X-Gm-Message-State: AFuF++k6s45kM4kQcfGqzDkWnbEA/fKeePrf1g4UbxsIe4TD1tkOu5xt
	YEKOZWgUoTn7T6B+rGadSz0bZdbBCYlcZFdARh5a22G0g5B9Wh11P5epKb+ZZtPY7xI=
X-Gm-Gg: AYBFou1OqN8vjvM6cMo/m56aAiODmpoYaDJHxPABi9LZKwUOM44c8qKn0QJ+3Noy4K1
	wCA6ZK5Adm/a8e7FAcs8dIyKg0ezlItKLAU9kQjozsQNnrl0XwvHgkZLik20N5P2BTDLoHfa1mK
	yFts8yJyODvHrLWMjTIYRAhE6WjThlcvT6eLCJ347VezYzdMnm9HsmkrP5QGbsO2Evh8Febtw/P
	faFc+ehqmfdI9mNyHmFL2FKObnKuLuF4a0dFoFA47W9NOxmC3SDqqL/MMds4de3OQduzvxGQcv0
	7y2Bs/1OxAdfT02lgtRdD2tymrG1zYCN2sQVHaTrykAKhzdnT2KFAoqFCBQPjwJpqvWxJzE19kN
	JNNzqT3nyMi1pxQzWRXsV+KhVE+drn5ZbdR7Vb+cSor1pNS1flQTxeuWcPz/3yzqPR61w8+6iFp
	+o0k5e+xXQhyv6Fhl2w8QyWH8rMEqcR7eTQeUhxIf8n/YF1xgPB8vI82vwOwLEkX60mIuDrxzXE
	V28c+kuxkre9P0chdcz
X-Received: by 2002:a05:6a00:3313:b0:882:d8c4:17c9 with SMTP id d2e1a72fcca58-891b0f8f99dmr5329742b3a.23.1791469111022;
        Thu, 08 Oct 2026 07:18:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:af47:f737:9040:a59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb2a5ba8sm1751275b3a.30.2026.10.08.07.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:18:30 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme: bound FDP config log reads to the received buffer
Date: Thu,  8 Oct 2026 23:18:16 +0900
Message-ID: <20261008141816.1174578-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_071833_231384_88B25FCA 
X-CRM114-Status: GOOD (  21.66  )
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

nvme_query_fdp_granularity() parses the FDP Configurations log using
sizes the controller returns, without checking that they fit the buffer
it was given.  The log size is only bounded from above before
kvmalloc(), so a size below the log header makes
le16_to_cpu(h->numfdpc) read past the allocation, and a size of zero
yields ZERO_SIZE_PTR and faults.  Each configuration descriptor is then
dereferenced (dsze while walking, and nrg and runs on the selected one)
without checking that the whole descriptor lies within the buffer, so a
descriptor at or past the end is read out of bounds.  The out-of-bounds
runs value is then exposed to userspace through
/sys/block/nvmeXnY/queue/write_stream_granularity.

A malicious or buggy controller triggers this during namespace scan with a
short FDP Configurations log:

[    1.104828] BUG: KASAN: slab-out-of-bounds in nvme_alloc_ns+0x39a6/0x4480
[    1.104848] Read of size 8 at addr ffff888009fd8fe0 by task kworker/u8:3/52
[    1.104852]
[    1.104857] CPU: 1 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 7.3.0-rc6-00063-g0c2669a9f4a1 #1 PREEMPT(lazy)
[    1.104862] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    1.104866] Workqueue: async async_run_entry_fn
[    1.104873] Call Trace:
[    1.104876]  <TASK>
[    1.104878]  dump_stack_lvl+0x66/0xa0
[    1.104886]  print_report+0xd0/0x630
[    1.104893]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104897]  ? __virt_addr_valid+0x209/0x3f0
[    1.104903]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104907]  kasan_report+0xe4/0x120
[    1.104913]  ? nvme_alloc_ns+0x39a6/0x4480
[    1.104919]  nvme_alloc_ns+0x39a6/0x4480
[    1.104926]  ? __pfx_nvme_alloc_ns+0x10/0x10
[    1.104931]  ? check_prev_add+0xfd/0xe80
[    1.104942]  ? lock_acquire+0x18d/0x300
[    1.104948]  ? nvme_find_get_ns+0xbb/0x2e0
[    1.104952]  ? find_held_lock+0x2b/0x80
[    1.104956]  ? nvme_find_get_ns+0x221/0x2e0
[    1.104962]  ? nvme_find_get_ns+0x231/0x2e0
[    1.104967]  ? nvme_scan_ns+0x2e1/0x8d0
[    1.104971]  ? kfree+0x2e5/0x510
[    1.104976]  ? __lock_acquire+0x570/0x1b00
[    1.104982]  nvme_scan_ns+0x56a/0x8d0
[    1.104987]  ? __pfx_nvme_scan_ns+0x10/0x10
[    1.104994]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[    1.104999]  ? trace_hardirqs_on+0x18/0x160
[    1.105005]  ? kvm_clock_get_cycles+0x19/0x40
[    1.105011]  ? __pfx_nvme_scan_ns_async+0x10/0x10
[    1.105015]  async_run_entry_fn+0x8d/0x290
[    1.105020]  process_one_work+0x8ac/0x1b00
[    1.105029]  ? __pfx_process_one_work+0x10/0x10
[    1.105034]  ? lock_acquire+0x18d/0x300
[    1.105040]  ? lock_is_held_type+0x8f/0x100
[    1.105046]  ? __pfx_async_run_entry_fn+0x10/0x10
[    1.105050]  worker_thread+0x4ee/0xe70
[    1.105056]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[    1.105061]  ? trace_hardirqs_on+0x18/0x160
[    1.105066]  ? __pfx_worker_thread+0x10/0x10
[    1.105071]  ? __pfx_worker_thread+0x10/0x10
[    1.105076]  kthread+0x2ce/0x3b0
[    1.105080]  ? __pfx_kthread+0x10/0x10
[    1.105085]  ret_from_fork+0x52e/0x780
[    1.105090]  ? __pfx_ret_from_fork+0x10/0x10
[    1.105094]  ? __switch_to+0x572/0xde0
[    1.105101]  ? __pfx_kthread+0x10/0x10
[    1.105105]  ret_from_fork_asm+0x1a/0x30
[    1.105114]  </TASK>
[    1.105116]
[    1.105117] Allocated by task 52:
[    1.105119]  kasan_save_stack+0x33/0x60
[    1.105123]  kasan_save_track+0x14/0x30
[    1.105126]  __kasan_kmalloc+0x8f/0xa0
[    1.105129]  __kvmalloc_node_noprof+0x2e1/0x820
[    1.105134]  nvme_alloc_ns+0x1097/0x4480
[    1.105138]  nvme_scan_ns+0x56a/0x8d0
[    1.105142]  async_run_entry_fn+0x8d/0x290
[    1.105145]  process_one_work+0x8ac/0x1b00
[    1.105148]  worker_thread+0x4ee/0xe70
[    1.105152]  kthread+0x2ce/0x3b0
[    1.105155]  ret_from_fork+0x52e/0x780
[    1.105159]  ret_from_fork_asm+0x1a/0x30
[    1.105163]
[    1.105164] The buggy address belongs to the object at ffff888009fd8fc0
[    1.105164]  which belongs to the cache kmalloc-32 of size 32
[    1.105167] The buggy address is located 8 bytes to the right of
[    1.105167]  allocated 24-byte region [ffff888009fd8fc0, ffff888009fd8fd8)
[    1.105171]
[    1.105172] The buggy address belongs to the physical page:
[    1.105175] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9fd8
[    1.105179] flags: 0x100000000000000(node=0|zone=1)
[    1.105183] page_type: f5(slab)
[    1.105188] raw: 0100000000000000 ffff888008c41780 dead000000000100 dead000000000122
[    1.105192] raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
[    1.105194] page dumped because: kasan: bad access detected
[    1.105195]
[    1.105196] Memory state around the buggy address:
[    1.105198]  ffff888009fd8e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    1.105201]  ffff888009fd8f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    1.105203] >ffff888009fd8f80: fc fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
[    1.105205]                                                        ^
[    1.105207]  ffff888009fd9000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
[    1.105210]  ffff888009fd9080: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
[    1.105212] ==================================================================

Reject a log smaller than its header, zero the buffer so a short transfer
leaves no uninitialized tail to parse, and check that a descriptor fits
the buffer before each access.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: allocate the log buffer with kvzalloc() so that if the controller
 completes the Get Log Page with a short transfer, the uninitialized
 tail reads as zero and is rejected by the existing dsze check instead
 of being parsed (hardening).
v1: https://lore.kernel.org/linux-nvme/20261008132604.1168105-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..30e7b1d93447a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2272,13 +2272,17 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	size = le32_to_cpu(hdr.sze);
+	if (size < sizeof(*h)) {
+		dev_warn(ctrl->device, "FDP config log too small\n");
+		return 0;
+	}
 	if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
 		dev_warn(ctrl->device, "FDP config size too large:%zu\n",
 			 size);
 		return 0;
 	}
 
-	h = kvmalloc(size, GFP_KERNEL);
+	h = kvzalloc(size, GFP_KERNEL);
 	if (!h)
 		return -ENOMEM;
 
@@ -2304,8 +2308,12 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		u16 dsze = le16_to_cpu(desc->dsze);
+		u16 dsze;
 
+		if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
+			goto short_desc;
+
+		dsze = le16_to_cpu(desc->dsze);
 		if (!dsze || log + dsze > end) {
 			dev_warn(ctrl->device,
 				 "FDP invalid config descriptor at index %d\n", i);
@@ -2316,6 +2324,9 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		desc = log;
 	}
 
+	if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
+		goto short_desc;
+
 	if (le32_to_cpu(desc->nrg) > 1) {
 		dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
 		ret = 0;
@@ -2326,6 +2337,11 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 out:
 	kvfree(h);
 	return ret;
+
+short_desc:
+	dev_warn(ctrl->device, "FDP config descriptor runs past the log\n");
+	kvfree(h);
+	return 0;
 }
 
 static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
-- 
2.43.0


