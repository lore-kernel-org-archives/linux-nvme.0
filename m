Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2768ACA600B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M1+oFp0gxdXfQLvRPA6qqYXrymxpx83eWWBEaMxgtbM=; b=YCZmUfc3sXeOj9DS+euWbsUPsj
	/r1dXzhkcynhmuF2Y3hv07RnPmpARABzkwUJ4gQOyK2LTPkgEJ47HJkDbyprOkOZk6emHzDN0rOOL
	KXBs+QLxy6X96ul28pWEV/swzy0rdaxjmyTtCixilyDBNfQmPHI4fyPGu5VZH9L0JUvieAzMN+IkF
	dHcHrGrABt+3PgVQsDtLHh8UtibAFstF9Dc7CkKuJ4LoCRiz560JIT8t0q1IRdemv3lMtM5GKjXPK
	+HLkmk8+ewcY8HYkj0kSkCOnfGpZVHH96wtK6ieYXnsQpTftrvV4qGrGhHbIjCYXs5XPESoKvQOl2
	NhN+yizg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEo8j-00000004SWJ-1RjH;
	Thu, 08 Oct 2026 13:26:29 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEo8f-00000004SVy-11Db
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 13:26:27 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-88834d30002so1525231b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791465984; x=1792070784; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1+oFp0gxdXfQLvRPA6qqYXrymxpx83eWWBEaMxgtbM=;
        b=cN0Bc4Hq1a4Ebli/oTDT6i6QN+nRggqgVDrwPbmtzKLVfqOQgez261fwWqSjaC1Qop
         0PSPzx6kiup5b1pUPVkVtVqQSKXyjqpTpYyLORP5xjos4QHnZSVm/2RVB5pAKXE35XeG
         Tw3ZHiV3hO/sZnTtQ0Yp/iG96slpMURsN5ytxKl+0GB19OqGx3vu4skNJlF9L85W48f2
         xkmmR8QArw1VnhboAIA2vl+gVPDydjG0IduifAUXmFagZ2BzFzv7qodrOmbUJdNt0Hy2
         kOeLgK7dfz/EDrjHJOR5JgHgRyujSnlTZLmIvJj9wGdqyPvWdBUWU50y1rqY/ps6QkGB
         CNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465984; x=1792070784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1+oFp0gxdXfQLvRPA6qqYXrymxpx83eWWBEaMxgtbM=;
        b=pb0l5Eki1e1sVfbbypZHax54131x/L17k+lnl564kvXTQRpHWaF3UuV651GnAZCL87
         3IEquNl8/LIZ5RKoUjaz5po4AshvGrsJXDIgNzc69pfdI4xlHc4wK9X7b1PXz9xdXp9w
         NnQxd/E3dYHSJGXbxWs519Yw3yN/BF9I/9+1zJXB2NbgaFD5unVjLAr3C6xqeJgxoyVz
         rK5/HNJD8DzN+XWPgMEzzv51CY+oRuy9l7e3tBMk/u3uRXJZuFcTPphdx9ByOp1ZxZWm
         yOdhYP/0NHExCVLftZAjzK05RFywsfdEfG2njdBKcgON2BQ8AafyWCgXqOh/36Nph7FU
         X8pw==
X-Forwarded-Encrypted: i=1; AKwUvBy+fdqEfyUgQ5AxVtL59i+x8VPKy/AYnUTVphB9guRtSjI31Ulrh/tR7bRRdGZjR/5zQnGaKrYEFTKf@lists.infradead.org
X-Gm-Message-State: AFuF++lyOCgqxMYmlI+ZHaMvib05CvAVHPrG7Vxb5KEsvP18+jshVHVr
	QF+a6tSDrnuvTcJQHrcG9AO4ukyxJPbF/dZZojUE1cp4DzusrOPVBGEnUjv8MdHcAKY=
X-Gm-Gg: AYBFou2UJVALSdBatRw04KYT7TjT7sutkqKnqazEUQQ3L4hf4c+vIE5LKsBbT+0GbeE
	7ywZD2T9uqPxpbl5O4ofiDeCTtYa3hXITP0SD/CKt/msR5TRFgUhY4MD39xfAOdSSnwBWUkv8q8
	dmFC178HQyDjSO4Lj/x7fTHn5ms8f6IoelDmdLYEwPHoNoSTpPi3+niZ1vNagobPc/2pLJox9zC
	qdwEAC2Bl4sPiPTCuGSc11l1Dpa3fPckTPeupgmt/h7TwOpUfoYnzWF8Hru7Hx69tN8Bk3xPhhK
	r109CAwdlI91XrzTYhNxB/1lUyecoXuOM1E8XEozsCvT+wBbOj43+ZVqaj5xrUtpO4IrFZBYDl2
	2roAGKE+bx4Faob/ZtapNlSZJa5NjPBvPxYRDnMZpodvZT4S0tGH8WixCh8ivEm35rCDtUoGQGM
	7zDVPWaWpnaSYKSNhUJmmFp0w8Ef26kFc5+zyrQ5ynmGc75Uln9k212BHx9r8tLbFQ0BHyB5CEh
	URYxZfMyMmhzAKAUwxt
X-Received: by 2002:a05:6a21:3995:b0:3de:61f3:3403 with SMTP id adf61e73a8af0-3e1340e0c7bmr4281826637.54.1791465983550;
        Thu, 08 Oct 2026 06:26:23 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:af47:f737:9040:a59])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd34f318ce0sm17289a12.4.2026.10.08.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:26:23 -0700 (PDT)
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
Subject: [PATCH] nvme: bound FDP config log reads to the received buffer
Date: Thu,  8 Oct 2026 22:26:04 +0900
Message-ID: <20261008132604.1168105-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_062625_587236_58810413 
X-CRM114-Status: GOOD (  20.55  )
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

Reject a log smaller than its header, and check that a descriptor fits the
buffer before each access.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..2618b4889f1d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2272,6 +2272,10 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	size = le32_to_cpu(hdr.sze);
+	if (size < sizeof(*h)) {
+		dev_warn(ctrl->device, "FDP config log too small\n");
+		return 0;
+	}
 	if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
 		dev_warn(ctrl->device, "FDP config size too large:%zu\n",
 			 size);
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


