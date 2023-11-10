Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A26C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uZGjmS+sMvLNdWhJ4DQKQWcIXB+jZtkds07mJ8cy31M=; b=cEOXkFOnaYwOiI
	DrywGu+T4uNB72Z4bsioUjiXMKGF1FdQaYWi58JvMKrmo1Zwpopzmwe/SQrpLP7NgH/q4l43nXZDE
	kI9Y1cANSaRqnlrqiBwimb518Ix5dijC5CJIdq4MR8z1rt815cAoxT3s9oihalvb06/jkMTMWlfYu
	IxmEaaSXpcUzruvBAvtB8bVnKBQxiRX9JkGbLADzdclkQPr3IJZK0jNqFYdzHoS3IL8vaA5AzmEu3
	hyPgcuwAu+mACAjp/H2GZOch5tmZLjBy4xevkqnfuXzVWGloQkvrpEqHMPwT2OJx2m9DGEXbWBLuU
	ryWLwhev6E9DekoOndZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UVc-0095cv-2P;
	Fri, 10 Nov 2023 16:37:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UVa-0095cW-15
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 16:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699634244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZGjmS+sMvLNdWhJ4DQKQWcIXB+jZtkds07mJ8cy31M=;
	b=YGo0gcrezaqKgK6I/bVhMnrL4OJYASO90Ok6dvoyUGmiM609egj5Pmpt4fmxz0k2Ialedi
	vpvDdRazTjM7ja4Qc4aePP/LTDuQsHJr0kAYn2eEiF1YSdKBEYEKH3MvDuA180/zwaQnPH
	gxPJc0iXBRSxx6GNMth8iPbkZG/BaOA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-H5gdnGgqMYKzF1ynGzHFPA-1; Fri,
 10 Nov 2023 11:37:21 -0500
X-MC-Unique: H5gdnGgqMYKzF1ynGzHFPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67D5E38C6161
	for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 16:37:21 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5498D492BFA
	for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 16:37:21 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: check for valid data from from nvme_identify_ns() before using it
Date: Fri, 10 Nov 2023 11:37:21 -0500
Message-Id: <20231110163721.15292-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_083726_467000_851E95DC 
X-CRM114-Status: GOOD (  11.85  )
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

When scanning namespaces, it is possible to get valid data from the first
call to nvme_identify_ns() in nvme_alloc_ns(), but not from the second
call in nvme_update_ns_info_block().  In particular, if the NSID becomes
inactive between the two commands, a storage device may return a buffer
filled with zero as per 4.1.5.1.  In this case, we can get a kernel crash
due to a divide-by-zero in blk_stack_limits() because ns->lba_shift will
be set to zero.

PID: 326      TASK: ffff95fec3cd8000  CPU: 29   COMMAND: "kworker/u98:10"
 #0 [ffffad8f8702f9e0] machine_kexec at ffffffff91c76ec7
 #1 [ffffad8f8702fa38] __crash_kexec at ffffffff91dea4fa
 #2 [ffffad8f8702faf8] crash_kexec at ffffffff91deb788
 #3 [ffffad8f8702fb00] oops_end at ffffffff91c2e4bb
 #4 [ffffad8f8702fb20] do_trap at ffffffff91c2a4ce
 #5 [ffffad8f8702fb70] do_error_trap at ffffffff91c2a595
 #6 [ffffad8f8702fbb0] exc_divide_error at ffffffff928506e6
 #7 [ffffad8f8702fbd0] asm_exc_divide_error at ffffffff92a00926
    [exception RIP: blk_stack_limits+434]
    RIP: ffffffff92191872  RSP: ffffad8f8702fc80  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff95efa0c91800  RCX: 0000000000000001
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: 0000000000000001
    RBP: 00000000ffffffff   R8: ffff95fec7df35a8   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff95fed33c09a8
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffad8f8702fce0] nvme_update_ns_info_block at ffffffffc06d3533 [nvme_core]
 #9 [ffffad8f8702fd18] nvme_scan_ns at ffffffffc06d6fa7 [nvme_core]

This happened when the check for valid data was moved out of nvme_identify_ns()
into one of the callers.  Fix this by checking in both callers.

Fixes: 0dd6fff2aad4 ("nvme: bring back auto-removal of deleted namespaces during sequential scan")
Cc: stable@vger.kernel.org
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..ae35b19cd562 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2027,6 +2027,12 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+	if (id->ncap == 0) {
+		/* namespace not allocated or attached */
+		info->is_removed = true;
+		return -ENODEV;
+	}
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
-- 
2.20.1


