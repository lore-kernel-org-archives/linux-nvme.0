Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A65BC5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ziO7i9EZKoScdSQc/jJeUszIvAmtfTTEYYX7vopJ1sA=; b=gy+mPYp7iH6HZWrUC6pK1xJKvc
	qAWxyxud3dPWJeMQSzMXaM0hYmYU+9lLMBAySl1bexNx7PMgQZDa6C9OKSPwktLFkpLeStv+tFLjw
	sJkGrWgtSA7CQBF7GRkzmkK1H2kFGuuomNObIYTPx1DgnUecnJF0JpwkV81gS/3IMJamgkNbzktXD
	IfFL5E3HR7yAwbskTsToW2HCMoMRvSfiSx4XwRBiVaErNZ1+nY+ui9DOYRGYPK2oFPzb9qkwcpeS8
	0irBOsyggBuSLdy3gK1HMoikWL2YVC8L76AOkHeRGeg38kDRazRGV47ZmWnARowQVAEcnFh2QxS1X
	uaGLWXqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxW1M-0000000E3II-1be4;
	Fri, 21 Aug 2026 20:39:24 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxW1H-0000000E3Hk-223M
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 20:39:23 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-38101f85591so2046677a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787344758; x=1787949558; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ziO7i9EZKoScdSQc/jJeUszIvAmtfTTEYYX7vopJ1sA=;
        b=c/C/mLISxxeoREQkGOW4tREaFbwsODQwMRipk6y41gBAzelTFcL/Qc4O+owDtV6evU
         Qo8igx9zik2PpJa2KbIQd4usva+euh8JsOb1Ny1LHFo7xpBAKnaEGiDrcEjVn0Aj9Pn3
         eZriobGYv0TTvFnjCk4+HBkPbtfbxseGqdHFyeauaUE40RyYRI3Z8Qv8xvqHLnHvDgSw
         QXedQN8zKfgwrM4BjU+xjulAYYHjokQd+nrXqWK8adzFSKCBrrR7zaeuP4p6mYP9icPy
         i5CPjameQ9vzb/767KMulsfZoFCd0rv7cRzu28WlARCAtK4FBXd4VS2yl9cHS53PS8iq
         /isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787344758; x=1787949558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ziO7i9EZKoScdSQc/jJeUszIvAmtfTTEYYX7vopJ1sA=;
        b=EuSLFYlB+jzkBvi475Bm2hNpiQCApQwXDeC9hn/4yVknh5Lxt9mfLOHttz5VZSQa/z
         CsxrodjUv/jM7hvcbljlN5gAhrhNliBZxD91ya/KsttP+cqXJCj5upzrrc5irjmXiWkS
         ZksoMfu3HK2eqah+ZsqQsRgPWn5fo5JjDKa8+RXPKFzeCcrG7FBFXlwb67AwhTyf2xAS
         zJfqsj89iJhyQcCy43qxqkLpwEUDcnAmFjSRb94dLKBGAOpnFKCrFWQtd/xHLxlkSOZp
         Yc2CZPbRjKUcpbrE0iN+qT1l7fmPx3lrlmfBeHTpDwKLPYqkPC0wgQyAL7RK53yGn82o
         EN7A==
X-Gm-Message-State: AFuF++krCYA8SYaul6JsGxjvwdDlsUvUfozkBoyxK7HW+uUQSwTgS4DR
	6vWR9oz4bVT5I7/uqT5Qfc9d8aJyrkmH5aGqHFtE78r0OfWPe7ZHNkOOZwkhG6YHz4fogA9s8CT
	OM9ww
X-Gm-Gg: AR+sD13wX23DizAgMAFtKFBWeCjn+6IWZzb1DKrWkCutA0wDYzKRUjhLMJHk0QDg5JI
	Ty2yaqbMCcFkEjB7vDcqRWdU0jQcPmODod1h+ddKSo6N2JCnwvdoWHj6rh0ZJUcgUKVpDZnLxmC
	ex+yLOZvERrruGthtx6S7gMPyyNEs3uaRO8evEe2l8bvDCsGkcfDej5KyWQCWuyKP1YmxBd+C8E
	WElrE/IZ+bdaZoOBgltD5S9xfXvqYGP7o+GCYb3oqxh0LV0JH/AopdVUFVmJTXN/kqbR43zKkx5
	E/Km0W46LXPSCuZMUEj1Z9l3oqjER5QkTNMLMTEADbIbrRjdfgI3VeUvavEYo/DKQJIYVZf5hHP
	5YaWvLeCuzX/fT5X93SCFPhfeO/NhASKw050WkI5tO7k3NwYnrHY1aHkTVB6I/YHMhxqf2fBeUb
	3/JJ8HsBsvkTpMBTr1Wi71sBE3xduaMyTTe3ObBZoviPdw02qiJhn34ylFjv86UxzDgW9ovDrFs
	hcl74Cj4mwE
X-Received: by 2002:a17:90b:4b91:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-395a0634d83mr19134661a91.10.1787344757922;
        Fri, 21 Aug 2026 13:39:17 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm29417618eec.25.2026.08.21.13.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:39:17 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] Subject: [PATCH] nvme: remove stale namespaces by NSID range during scan
Date: Fri, 21 Aug 2026 13:38:54 -0700
Message-ID: <20260821203854.3897938-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_133919_694217_869BFE75 
X-CRM114-Status: GOOD (  17.01  )
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

nvme_scan_ns_list() drops the stale namespaces in each gap in the
reported NSID list one NSID at a time. Every iteration calls
nvme_find_get_ns() to look the namespace up and removes it if it is
present. The loop runs once per NSID in the gap rather than once per
namespace actually present.

NSIDs are 32-bit, so a target with a sparse NSID space can make a
single gap spin the loop billions of times with nothing to remove.

  watchdog: BUG: soft lockup - CPU#4 stuck for 26s!
  Workqueue: nvme-wq nvme_scan_work [nvme_core]
  RIP: 0010:__srcu_read_unlock+0xb/0x20
  Call Trace:
   nvme_find_get_ns+0x7d/0xb0 [nvme_core]
   nvme_scan_ns_list+0xe8/0x280 [nvme_core]
   nvme_scan_work+0x18a/0x280 [nvme_core]
   process_one_work+0x197/0x380
   worker_thread+0x2fe/0x410
   kthread+0xe0/0x100

Rename nvme_remove_invalid_namespaces() to nvme_remove_nsid_range()
and give it an open (start, end) NSID range. ctrl->namespaces is
sorted by NSID, so the whole gap is dropped in a single walk that
stops once end is reached. This bounds the work by the namespaces
that are present instead of by the size of the gap.

Fixes: 540c801c65eb ("NVMe: Implement namespace list scanning")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f2744be7388..cc014cdc72ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -155,8 +155,6 @@ static const struct class nvme_ns_chr_class = {
 };
 
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
-static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
@@ -4513,15 +4511,16 @@ static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
 	nvme_scan_ns(scan_info->ctrl, nsid);
 }
 
-static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-					unsigned nsid)
+static void nvme_remove_nsid_range(struct nvme_ctrl *ctrl, u32 start, u32 end)
 {
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid) {
+		if (ns->head->ns_id >= end)
+			break;
+		if (ns->head->ns_id > start) {
 			list_del_rcu(&ns->list);
 			synchronize_srcu(&ctrl->srcu);
 			list_add_tail_rcu(&ns->list, &rm_list);
@@ -4571,13 +4570,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 				goto out;
 			async_schedule_domain(nvme_scan_ns_async, &scan_info,
 						&domain);
-			while (++prev < nsid)
-				nvme_ns_remove_by_nsid(ctrl, prev);
+			if (prev + 1 < nsid)
+				nvme_remove_nsid_range(ctrl, prev, nsid);
+			prev = max(prev + 1, nsid);
 		}
 		async_synchronize_full_domain(&domain);
 	}
  out:
-	nvme_remove_invalid_namespaces(ctrl, prev);
+	nvme_remove_nsid_range(ctrl, prev, UINT_MAX);
  free:
 	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
@@ -4597,7 +4597,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	for (i = 1; i <= nn; i++)
 		nvme_scan_ns(ctrl, i);
 
-	nvme_remove_invalid_namespaces(ctrl, nn);
+	nvme_remove_nsid_range(ctrl, nn, UINT_MAX);
 }
 
 static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
-- 
2.54.0


