Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA45CA600D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 18:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uS+z6/GeScTTMwJ5Y/yWHE9FFDbTsCi+ZCiX5IUD5AY=; b=QmVpuSet7z04+I5KLEZzpP4CEg
	aNNRkdv7P7KALkMX7X6lE1AfqGDb0+mTVIqqSQo2M1cJKfhIDvyaN82n2+iLYm+o+NpyC8E1Q9n2L
	TJHBWm2+Ox92MOCEVMeGjYvxndWCqazBC/O3kywB0TEODNstWQ9doMYVwbshLcamci4hfVMR9cTEf
	8wb7Dr/1tuMdKKmJyUhxht/UFNomE2McGPpGM0WBqoXLemYZCL68vhqQlb0EMCnhMDLqp0/tKCrcj
	6rBPV7tAPJFxGP8WS8IGwF6SzH+b93yqWWnZVfYEhUVAnY4VHcCLdulbq5cgFrhBmJShlSwvHRqGL
	HA9VWoCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEsny-00000004rQz-3QfR;
	Thu, 08 Oct 2026 18:25:22 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEsnv-00000004rQJ-0ySg
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 18:25:21 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-34bb8b31647so8677398eec.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2026 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791483918; x=1792088718; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uS+z6/GeScTTMwJ5Y/yWHE9FFDbTsCi+ZCiX5IUD5AY=;
        b=SEv/+bk/JSZi0yAquO2st8k/U7WuFFN5BS/9/3zMlMvCC2LbDIJVIelgiisjnI4yCE
         S3efKCHjDpZZgAlx+Z//8F4oHT9j0sxQ7RKEqWpRn5d5HEia1zyG1DSRzuB794MEWNHc
         kgfTkreDVGLi85WZS04Fr9GtXfZpTLsPcPQ1U1fgV53hqwgJUb7JdU6yHkNrFI8UxWh7
         GWLsiksJyTdZwkTm0bRwwCh9itWVpMIopdoct+//eAM81HqsJD1vHwBciIR5DFR4c83n
         +0+VbrFWxCsx8i3vt6PwpAdYACOm/tMp/fdGrvCVbQY9wa11RTAZ4GFQAXY90ZRixLjA
         SCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791483918; x=1792088718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uS+z6/GeScTTMwJ5Y/yWHE9FFDbTsCi+ZCiX5IUD5AY=;
        b=LZm3T/7Hdlv7lH7u2RXuF6Oy3CCZFq8KeqClPVZq0hhYz7EWMRpUWqUv0U/BJw0DeY
         q1eqoUV9wz4a+VR4OzNkvvXyNOySX+lur3csewYeeRFid+sFjk88lGP+OI7zs+mYczcv
         xlJIZeW/rdYaYSfN+P2WiFZwpbsldoOu73ytnjbD11Yvoufc3PY3HUVlvvDduc5GKksQ
         rkAi0CC0mebuv72TzUSjI4bRMpV2uA8r5PmW+7xL7kCTcmuEvZX1fj3GyHpv1dHhJcHw
         ruLfXfk3FceufxDplBsYKOoqogpJL1KQjYcb6WsAfvkZTGSM6l5J9wkNpRFgLde0ujg8
         R8AQ==
X-Forwarded-Encrypted: i=1; AKwUvByp3omd/ZtgLzVyk7bH2pbPigtuoVedPLTIvcqnUKIrFD05gjFsPEegNT+feb/igBBxTQ9cUWqGTwfI@lists.infradead.org
X-Gm-Message-State: AFuF++nCGIHsqk8DIdJeIA6lTGAaHzSTCLMn9k5pX+azDOgsAF4YE3GG
	uUaWdejSy1lamW/GCYYKiEAoDjPguHz4owrWw4vXaMFf51I32ihmihAdxDV2J0u4ZlU=
X-Gm-Gg: AYBFou2Qjp8MQvclE1oBSo14MZLBZhSZ88YQRuAZ/jZ6h4i/rNyFN8X2B8Sa+iAXCW1
	absbybCTrgLOHfrow6HKrCVFgtLwSWgzjzWQlBeQYxRvCmE/ssDmE0iJCYGspq5E/L7NgGoqJIx
	dO5AQJ7OD8ENXo1ti3jAoP368H5Pr7S+WcN+xCCM8uLrszg2pvWZzGL1Tnowm4rhJqbAShjetEv
	ciWXYgej578Afxs01NcGyd1MDBy/MGgWTUnsxKQECvG4NIsV6FJBN46uZvno9gkd6zztnuItiJO
	qaOX0NfqgYg7LEHgrcVw5ntiM0H2bSADVF2ThxHiYN1YVa0Akz5uE8VQLjNeF3LS9SamDcV9WwS
	fyzIoVZC0yltFqxyRsuBmXH1s9Kl91Rfy01jDBpr4hWYFItfTpy6DglrzWfkHUJZfeijZXq3hki
	IslmyJFQjgPs+UNIgesxAbbQmfHSdevEtrpFBhbW1lAp8FqPl/2VdJqJLSxLDBafm9kifpBOc5E
	VgayrgEAQX7zCu1TLkz
X-Received: by 2002:a05:7300:b088:b0:34c:b75a:ac1e with SMTP id 5a478bee46e88-3515df70a46mr7832220eec.33.1791483917873;
        Thu, 08 Oct 2026 11:25:17 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:af47:f737:9040:a59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b3b2c09sm305743eec.6.2026.10.08.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:25:17 -0700 (PDT)
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
Subject: [PATCH v3] nvme: bound FDP config log reads to the received buffer
Date: Fri,  9 Oct 2026 03:24:53 +0900
Message-ID: <20261008182453.1262733-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_112519_549340_4FDB437C 
X-CRM114-Status: GOOD (  22.07  )
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

Reject a log smaller than its header, zero the buffer so a short transfer
leaves no uninitialized tail to parse, check that a descriptor fits the
buffer before each access, and read the descriptor fields with the
unaligned accessors.

Fixes: 30b5f20bb2dda ("nvme: register fdp parameters with the block layer")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v3: read the descriptor fields with get_unaligned_le*() since a device-supplied
dsze can leave subsequent descriptors unaligned, which could fault on
architectures without efficient unaligned access.
v2: allocate the log buffer with kvzalloc() so that if the controller completes
the Get Log Page with a short transfer, the uninitialized tail reads as zero
and is rejected by the existing dsze check instead of being parsed (hardening).
v1: https://lore.kernel.org/linux-nvme/20261008132604.1168105-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/host/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bcab3dc4c118..094df0e6ed326 100644
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
+		dsze = get_unaligned_le16(&desc->dsze);
 		if (!dsze || log + dsze > end) {
 			dev_warn(ctrl->device,
 				 "FDP invalid config descriptor at index %d\n", i);
@@ -2316,16 +2324,24 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 		desc = log;
 	}
 
-	if (le32_to_cpu(desc->nrg) > 1) {
+	if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
+		goto short_desc;
+
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
+
+short_desc:
+	dev_warn(ctrl->device, "FDP config descriptor runs past the log\n");
+	kvfree(h);
+	return 0;
 }
 
 static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
-- 
2.43.0


