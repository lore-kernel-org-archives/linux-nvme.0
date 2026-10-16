Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3F6CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 17:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sn5pUeRtWfPOpCuFfuoGwkYCHpgCjYDIi8W/OVQtl1E=; b=S9LoayXdhy+djQfsFAfY6QoxhN
	CdT7Hv9V951gncqYUn70AqDsi2q9q0VI2TJkoW347dSdRBYAOlUVbdPqIMGDHbsjbKh/saV2tkS1G
	EzhTw461N7mt5pyixQ68irr7v3xQY3zUId6Zob2KbHhFMcExm3LDOQlWtKC8Kqo4WSOoll+TYUH4G
	qTd//oxB3YF9fDFKQkzB671n5LXzEePz3qDvV8n46s36QBaD2gev9OyzPtxGLfyN81HnTMhmxkaED
	oAcEkAV7p45ibfNL1UTl78KWhESq/nFsxONuDDqAHJuyIQ+Hj3Ql7Gme4/SnEW38tO+gL8zQzbbR6
	gxAAei1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlfP-00000003YHp-3w9g;
	Fri, 16 Oct 2026 17:24:27 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHlfO-00000003YHL-0pja
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 17:24:27 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-3550c917fd3so142496eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171465; x=1792776265; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sn5pUeRtWfPOpCuFfuoGwkYCHpgCjYDIi8W/OVQtl1E=;
        b=nJBc+sJQHl3q0P8oothhciJb4Luhl3BlMRi5OqDtlzwI4hB8OPzSk7OQ3E5J7hPG8q
         34WjjN0IkCuKuHGxoeyFLoJVu9H5r+8DFLelW9unCBnfN++CxvpwZxQf+i0NvR0yWPH1
         4oJdmYLXLLGpE7BrDLsANHSpd4XktLqNbAlSqYk3MhdCB2P3En0Z6zuvL22l4j3GI6ch
         QzvtD6Yw2tijphJZ6qb0XZVGStcb41N2gg5ar+mBCLoOvHS4jbBqgc5hgt60+QTJsR/3
         APSQVq1I0lkPatGFaTGMb8pwxwifHW2zCr5Sg3V4+tcno3EucKFfQXA7KJJ//rYmM9Wy
         H+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171465; x=1792776265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sn5pUeRtWfPOpCuFfuoGwkYCHpgCjYDIi8W/OVQtl1E=;
        b=BOD91kP0jQApjEuT87ldyRJ3EITaeaIYP3laoHGWcegp0GMo/UA3kztKgfxXxrAv0q
         JzAtkqnnUl4ycm2r8jqJg4u4MLz/zQrhratIwKLutBGPQLW3DLObPLALElEEkDnRO3pE
         3UgZ4mWcLb2pSIGOakXtl0wU5C1WqfNELL6NWr4C8xHU8Lc7pMCpLDByIPsf1chVZDOb
         fdCiwgksFxYYN0+zLwlUx8u65lHGmE5RNlde4+iPULaMyI71RWg7HG9I5ig1kN0R35A+
         Hon/90OpOlObqswoLsAl6gydI/kl2qvykP2a+tn85vSfEKAYgkofXAbq3gfA20NCT5r0
         Mx5g==
X-Forwarded-Encrypted: i=1; AKwUvBzMa7TTpH0oJpOCZXxcExdPe1PuGOCkJUxYRWlJRzmAP3ocUfFshp2RSysICRFKXBBJY47bXSK3M6Qf@lists.infradead.org
X-Gm-Message-State: AFq9FYLlrR7bVI5Dtp0n/jGSPxKyDWCt36y2bKkb6F/odNtfX/oAXnWw
	YHqZ/5SMJLYk7Ibu3fRWGK2kN7grnAaAGgCRp/UjB772LznjQjjnkmR4
X-Gm-Gg: AYBFou3U3qyhRDYBTuXyLcE8H8B8LBFSBLxYazXFWiJnFujV5wCtZaiX0I22Qi34zKO
	7Y0cxjlnTsh4oVaRB3kYgSIVeiHHGrMx/zedaJVD2vZ3w21kjlLR8IqfXb7/Ip3rkbqvxG012fC
	6czzZr7SI3XZbpmNrnQEont0t270TaEF+FIL13iBwsdSafJGB2gFnwdF9y8sOy9pZTmU1B9yiyJ
	UGpFC3Ivy32ttrzDUJqijQC4N5lm4/hwJF9o/ugLK1eLyoitiGVZAr5v0WklEqt1VqPqfphyRg8
	HY7E/F2aq1IrU3Tm2wmV4cTiJ2AiXIpyhDQHbBTtTzi9VFEMi+xFpKs8rniYvTGwz3nP6vXujhp
	sVrgcH4KT7tynrC+jimdXEuT63xaB5eDxOo+1INb4zXb3KSb8R9FB5w/3vm0wfP19eo+r8iVtAc
	yfWA78ezn16II1uZT6nmyu04LENhtH1PKldRh5qigLvOal4dGb0OswMXJQs3bmzRkSMdMK02zZ/
	IQAu5Pt5Sns20CQiz+TUTJwztTF7P+WsKwu7HiVxRI+7gE=
X-Received: by 2002:a05:693c:20cc:20b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3619ed0f886mr566943eec.5.1792171465044;
        Fri, 16 Oct 2026 10:24:25 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm8675575eec.7.2026.10.16.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:24:23 -0700 (PDT)
From: bestswngs@gmail.com
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+e015e82956da641b@bugs.sh
Subject: [PATCH nvme] nvmet-rdma: reject short connection requests
Date: Fri, 16 Oct 2026 10:23:38 -0700
Message-ID: <20261016172336.286341-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_102426_245238_5254EDA7 
X-CRM114-Status: GOOD (  11.63  )
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

From: Weiming Shi <bestswngs@gmail.com>

nvmet_rdma_parse_cm_connect_req() treats RDMA-CM private data as a
struct nvme_rdma_cm_req but accepts any nonzero private_data_len.  The
iWARP path allocates exactly the peer-provided length, so a six-byte MPA
request reaches the parser and the hsqsize load reads two bytes past the
allocation.

Require the complete request structure before reading any of its fields.
The decoded KASAN report is:

  BUG: KASAN: slab-out-of-bounds in nvmet_rdma_cm_handler
    (drivers/nvme/target/rdma.c:1427 drivers/nvme/target/rdma.c:1475
     drivers/nvme/target/rdma.c:1614 drivers/nvme/target/rdma.c:1814)
  Read of size 2 at addr ff1100010459d366 by task kworker/u16:1/41
  Workqueue: iw_cm_wq cm_work_handler
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   nvmet_rdma_cm_handler
    (drivers/nvme/target/rdma.c:1427 drivers/nvme/target/rdma.c:1475
     drivers/nvme/target/rdma.c:1614 drivers/nvme/target/rdma.c:1814)
   cma_cm_event_handler (drivers/infiniband/core/cma.c:2181)
   iw_conn_req_handler (drivers/infiniband/core/cma.c:2640)
   cm_work_handler
    (drivers/infiniband/core/cm.c:2502
     drivers/infiniband/core/cm.c:3858)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   </TASK>

  Allocated by task 12:
   __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
   __kmalloc_node_track_caller_noprof
    (mm/slub.c:5414 mm/slub.c:5545)
   kmemdup_noprof (mm/util.c:138)
   cm_event_handler
    (drivers/infiniband/core/iwcm.c:194
     drivers/infiniband/core/iwcm.c:1076)
   siw_cm_upcall (drivers/infiniband/sw/siw/siw_cm.c:408)
   siw_proc_mpareq (drivers/infiniband/sw/siw/siw_cm.c:750)
   siw_cm_work_handler (drivers/infiniband/sw/siw/siw_cm.c:1086)

  The buggy address is located 0 bytes to the right of
  allocated 6-byte region [ff1100010459d360, ff1100010459d366)

Cc: stable@vger.kernel.org
Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Reported-by: <co+e015e82956da641b@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ffa1e172c..075ab58d8 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1412,7 +1412,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	struct nvme_rdma_cm_req *req;
 
 	req = (struct nvme_rdma_cm_req *)conn->private_data;
-	if (!req || conn->private_data_len == 0)
+	if (!req || conn->private_data_len < sizeof(*req))
 		return NVME_RDMA_CM_INVALID_LEN;
 
 	if (le16_to_cpu(req->recfmt) != NVME_RDMA_CM_FMT_1_0)
-- 
2.55.0


