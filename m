Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE34CC6B03
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AFB74tPON6fMev98Hd7HE9xGO0Iu+BsnVCNgiYERqag=; b=YFyoX6gGXtxwgvXUtSpGW5OVoR
	w0JEZL1cuMR/koafnis3QlkqM87fqdm0cG+xoa3LhCpN/we5soLHx6EKAOTiUEwZGeebqFPvrywSE
	ZMglvaiEyJd+u8T77BdkvQ33NBCc2SXc2bLexGW0IxUPWSqNl4EkxnTVML/xgp5BBI2MgRTwGFmmt
	OUNLxTmdvA0ZLJA8HdIooPna/hlpda//9f0KB55NI/HchFBY1z9KTzigEWyB9tz/fEpsRjW1EOsiD
	jzSxTqbxW+rGLiC7LTs4kK3F9SFnoOBbK0UOw9iA24vqSmjksfyBmybYMD8sHcyPXQ8DC88j7CzzB
	RQ+PRXGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZkA-0000000CZJN-39j4;
	Tue, 13 Oct 2026 10:28:26 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZk5-0000000CZFi-2weD
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 10:28:25 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1300208a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791887300; x=1792492100; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AFB74tPON6fMev98Hd7HE9xGO0Iu+BsnVCNgiYERqag=;
        b=lhcCmceNLTeORKOB06/K9pXDHqQsJI3Bfn2GvsbCXgehP+idKYqpR9O0BgeLx1ckkv
         rvUOMudbQYX28BJESLyyXEF5slD4nvPvWS3DXyhJmV7gQ3my5534VkEdIXp3/v46mKo4
         Hr++lU733TUcOC3QJqYwXLHni/uYd+HkdsURKo50dZWSiNzvulgOE6hqiYeN2VA0LrP8
         ETlnwuaaP+Q3R1wjxSrkjhKqXcFq2piLY7f9YyXC1ymWACvjLjMXVGCsJeVJzp8D6Y5h
         L2soVGFjByUpvHyl7GMe+oH4s1j0OWkQn2aSJHQwFVbVLMQoKGYVHs/b8qgj1GnLBIB4
         cahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887300; x=1792492100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AFB74tPON6fMev98Hd7HE9xGO0Iu+BsnVCNgiYERqag=;
        b=QBiFoxeResgMcpDWQ4hGOSDB3+K7R3CRSLugEd0mvDuW63W10Jtii+62RLjbvglQwM
         HE37k5L7jX48ZQvGr2jx4dwuw8r0CVG7lSYshMt/gO9WF00kankxfmFRlsKzcX5dYoEg
         YKUazEw+EeUD3rzW0SrIr/r5pCneTTy0d465EUiZncXdyeSZ+FoBGltV4XZdN+nQ/joC
         sfGn1b03fs5pV3dE0ywmowXgjg0UXJwV2/QdY7mzLtJxNWCjyq896mHMo/r7x3ZcfO6M
         K+SDmysc9VvEteepUj2YnvnefLdxgNI1tsiRCfw81pSjm6p24DcI33phcX+ax6tIvAzh
         Tpjg==
X-Forwarded-Encrypted: i=1; AKwUvBxmMjVASByv5SyOsxxq7W6sl6Yw08ZdPVvDu1eGBB4XHS0xgMwSVlAI8Flvdtx/4ITUlDKV8KLVJPPS@lists.infradead.org
X-Gm-Message-State: AFq9FYKBlgCtaNoJUulBEQVVUL9P2BYmNXWFXOylFMSlnAYTlKWtuOJh
	UKIJBa01OYUVXVZHp9P7IfyJE2gINlQ6G6psXJuBwheId4xFnDfaVwhGF6pC4QU6IBk=
X-Gm-Gg: AYBFou2aSH2eGbYx4dj7rL/0E8S7ZChcRtS/P1R/zQXc7TlVA+Z4KTDC13bo/7aBLDJ
	GxEgiGVxmVZVoBiKO2RHllicS/3FXv+9xL+/KCp6gpU+L2vkHVEKg3thHLCBwjtTx3qI38Bt12d
	H2tvkPw3zv2d2dcY0FEHKsh7ANDUrEM2EXjI/w5vPQkX55R9CsyXGGiqQOUbrLiKLJ9vi/vVMyv
	jkqBLIprZfoQDcogSfWrX/sLVZ6Aj9DZfV05Y68ZgbUVY0bP039wYA2uXK3X0pDaxkyn7Y1UrWV
	w3o0yyRINvg/aRFfhBZW5cNjzWQ6LTFBmzqAPfVpOpKxgggDHywx2n0xUA/6ZHSO4KjWRfhX11t
	lILyGXfh2IGsVnRED5/TdTZbq/DjJkmv4yOPihCbWVzCJMv9l1ut5Drqeu2pZPcU0qx54TBIkhR
	cA8IMDIr3aMSG9CYQWYmaFQZYPL7GXoUsc/98Nt3tghsMGJKNZs5QJf4jN1CEmXBdQcA+MlWqf1
	fEQiw==
X-Received: by 2002:a17:90a:b90:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3ab3ac578d2mr6950807a91.10.1791887299793;
        Tue, 13 Oct 2026 03:28:19 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ca1e04sm21494095a91.1.2026.10.13.03.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:28:19 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v4] nvme: bound FDP config log reads to the received buffer
Date: Tue, 13 Oct 2026 19:28:12 +0900
Message-ID: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_032822_266873_2CCE4FD4 
X-CRM114-Status: GOOD (  22.37  )
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

A device-supplied dsze that is not a multiple of eight also leaves the
following descriptors unaligned, and the structure is not packed, so
reading nrg and runs from one can fault on architectures without
efficient unaligned access.

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

Reject a log smaller than its header plus one configuration descriptor,
zero the buffer so a short transfer leaves no uninitialized tail to parse,
require each descriptor's declared size to be at least a descriptor and to
leave room for the next one before walking it, and read the descriptor
fields with the unaligned accessors.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Suggested-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v4: per Kanchan's review - require header plus one descriptor, fold the
    per-descriptor bounds check into the walk (reject dsze < sizeof(desc),
    covering the 1..63 values the old !dsze test allowed, and require the
    next descriptor to fit).
v3: read the descriptor fields with get_unaligned_le() (strict-align
    hardening; verified via codegen, not on strict-align HW).
v2: allocate the log buffer with kvzalloc() so a short Get Log Page
    transfer leaves a zeroed, rejected tail.
v1: https://lore.kernel.org/linux-nvme/20261008132604.1168105-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/host/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..389ef1ae53f17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2272,13 +2272,18 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	}
 
 	size = le32_to_cpu(hdr.sze);
+	if (size < sizeof(*h) + sizeof(*desc)) {
+		dev_warn(ctrl->device, "FDP config size too small:%zu\n",
+			 size);
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
 
@@ -2304,9 +2309,9 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		u16 dsze = le16_to_cpu(desc->dsze);
+		u16 dsze = get_unaligned_le16(&desc->dsze);
 
-		if (!dsze || log + dsze > end) {
+		if (dsze < sizeof(*desc) || log + dsze + sizeof(*desc) > end) {
 			dev_warn(ctrl->device,
 				 "FDP invalid config descriptor at index %d\n", i);
 			ret = 0;
@@ -2316,13 +2321,13 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		desc = log;
 	}
 
-	if (le32_to_cpu(desc->nrg) > 1) {
+	if (get_unaligned_le32(&desc->nrg) > 1) {
 		dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
 		ret = 0;
 		goto out;
 	}
 
-	info->runs = le64_to_cpu(desc->runs);
+	info->runs = get_unaligned_le64(&desc->runs);
 out:
 	kvfree(h);
 	return ret;

base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
-- 
2.43.0


