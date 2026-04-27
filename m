Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB2FF885D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 00:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+zpjgxAVJgKXc24LXLllrzJ6IfhGOraTuvZ7a74jdg=; b=HdmuDMU41bXf7xFll8AeMv3de5
	7LRbRI8s+UZKL9ZJHzxNF91g2VSOC+wU16Bo+ev9+wCd5f0VdzoEXIE84hzcL/gKGrzvmBuYbcUAv
	ltRhJpv6Cwuamnq+WjGb3tZ4PoNRi+Tik6Nbc0/hk2hv9IQEK0OljC/cOqtpRNiELqAUBioGDFwav
	jO8CCEc8awke8SO+rkPX9VFPSKlFMZANfc7nriLKhQx1m9wtfu3K+vS4XH8vT2fn+cFEPVHXGq6Cn
	VtZf0Z4IA2o9uiL8AMc8vnW3zHwZURK61Lwm5p8CUpyq2nPQXh8YQdKy84YqozZ7x42KJx4m9Gm/S
	hWAVQFqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9wZ-0000000FyKM-39hM;
	Mon, 27 Apr 2026 00:35:23 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH9wW-0000000FyJY-2gUy
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 00:35:22 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-56a9076813bso3840356e0c.3
        for <linux-nvme@lists.infradead.org>; Sun, 26 Apr 2026 17:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777250119; x=1777854919; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+zpjgxAVJgKXc24LXLllrzJ6IfhGOraTuvZ7a74jdg=;
        b=KXrf25ciai3yThLw8gc5AoRDn7opg2cNVU66gIeAdjWUSMQTKDhrldlDCVwlqxK4fn
         KLltvnhpk3h4MxTQ3LqNcjx0ztHeL2R88ZOr1vRkVDrLl0wYA0SU9AgswzTWmts8d0kW
         3/PssLmEvAqZotDLaya40OGE8lNWOKjeNvWDg+6b/oFo+6kq+85OQdLpG9uINMNw6OFo
         0FDRvIPqwhP43++SHzShDlV/61hAnQbLSg7A8r0WcA7otUUOTEiJVOUu6kGhK+vMsDL4
         gi0gKwJLg2mM5CCwo3mhBjBP3LOAX1UjKcEiYhiGi1TlhRsO2uNPIRtAy4vVNvwKEldj
         oBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777250119; x=1777854919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+zpjgxAVJgKXc24LXLllrzJ6IfhGOraTuvZ7a74jdg=;
        b=bkTXWt6k3Fq71OoouelzDSWQIHyVfy1b/gJT4fo7yFXcKKlSgHZsnznOo1yIdswj2l
         D6rqRF/6/EDp94gZchq4vu69cFV666Q6Ygxt7QKUgP50dVkZi0GuzCmzqo6UMJI4bc7E
         m4Sh/9GWwUHhaasY4cAtno177qTtTBXb3cievC5AbNHtwYAZ3ImK9pmaBGXjCCofuKKl
         OGMj/raQId3RO2RPGx6yMhGBmEPwZqIhuX3cYh/LktqSgmtBbVtyszfZnj2DVOoJ9w6h
         qPkn7BKLK0V/kbUNT59G91ypzrrI/ofk91YuFTb50DpzWj8uRZn6Os5YF975hWL8eZ27
         QHVA==
X-Gm-Message-State: AOJu0YwC27yXVOPcTkq8ybMylNJbj5156dHx482ONqAfFNxX01xtyKdK
	nPXWf2grbwFgDdZ5tplcs3ifrm9IiDvWameVPbCp5TF/L9KJf2AXG/POKBr0ZcawpPI=
X-Gm-Gg: AeBDiesm3NBMegxzM2vy0aXnr8Tyw5XhusNW2ZDTF/LvDJ8FpSdNAyRUqij0YVQuTMy
	l1XIds/+lyHnCTai8dod8CtRPxqzv5C3aROki/iszcneJ+AmLZdZmYwy23SMcknD16i/P+MYgOs
	u/1ZWlWZxz4qEALZp9jOsa3SccZsf3BSEvC3NHRHaBbDU/Jt3AjsVHlY+pwaM3DtGYHman2YNRL
	g6iFe+ABIYjzqaxwaf9hupZ8FQ5wznq7l93ooHy8W/asR8L7yECtF085Quyl8K0Zjy0dtuSUxRk
	LrpqhvqHAP7Sf94IP1QyU2KTCNuKZzbVExkekKD3pdrRxjfGV9sPuMEooFnVvN+AUC9wuD/LGgC
	lTQsJkyvheQRhMm/ztowhOfxmgZYY5XRgunt1/98N6Dnn/bUNbHQThigt7CL1BgDk2M+UJpy39W
	q10noLcFBcU/kyj+BpXSQ3jx9SR9Ugi72QBPv7uJ2l0VecYCtwbie0
X-Received: by 2002:a05:6122:f84:b0:56c:db8b:504e with SMTP id 71dfb90a1353d-56fa59fbc9fmr22750523e0c.13.1777250118829;
        Sun, 26 Apr 2026 17:35:18 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa9351ca8sm16854880e0c.18.2026.04.26.17.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:35:17 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS non-PI namespace
Date: Sun, 26 Apr 2026 20:34:57 -0400
Message-ID: <20260427003457.1264511-2-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427003457.1264511-1-coshi036@gmail.com>
References: <20260427003457.1264511-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260426_173520_725780_B4197A86 
X-CRM114-Status: GOOD (  16.02  )
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

This patch is an alternative to patch 1/2: instead of downgrading the
assertion in nvme_setup_rw(), it addresses the root cause at the
integrity-profile level so that the assertion is never reached.

For PCIe namespaces with extended LBAs (NVME_NS_EXT_LBAS set, flbas
bit 4) but without PI and without NVME_NS_METADATA_SUPPORTED, the early-
exit branch of nvme_init_integrity() at core.c:1834 returns false
without populating bi->metadata_size.  As a result blk_get_integrity()
returns NULL (it checks q->limits.integrity.metadata_size via
blk_integrity_queue_supports_integrity()), bio_integrity_action() returns
0, bio_integrity_prep() is never called, and REQ_INTEGRITY is never set
on bios dispatched to the namespace.  Any such bio that reaches
nvme_setup_rw() triggers WARN_ON_ONCE because head->ms != 0 but
blk_integrity_rq() returns false.

Populate bi->metadata_size = head->ms in the early-exit path for the
EXT_LBAS non-PI case.  This is sufficient to make blk_get_integrity()
return non-NULL, which causes bio_integrity_action() to return non-zero,
which causes bio_integrity_prep() to run and set REQ_INTEGRITY on any
bio submitted to the namespace.  Requests that reach nvme_setup_rw()
then satisfy blk_integrity_rq() and the assertion is not reached.

blk_validate_integrity_limits() accepts this configuration: with
csum_type=BLK_INTEGRITY_CSUM_NONE, pi_tuple_size=0, and pi_offset=0,
all checks pass (pi_offset + pi_tuple_size <= metadata_size, pi_tuple_size
must be 0 for CSUM_NONE), and interval_exp is auto-filled to
ilog2(logical_block_size).  No generate/verify callbacks are configured,
so no actual integrity computation occurs; only the blk_integrity_rq()
predicate is satisfied.  Capacity is still forced to 0 by
set_capacity_and_notify(), so new bios are rejected by bio_check_eod()
before queue entry.

Tested: Compiled on linux-kcov-debug (6.19.0+, KASAN/DEBUG_LIST).
Boot-tested under FEMU with NVME_SEMANTIC_DATA_MUTATOR=1; ran 4
concurrent dd processes plus 500 rescan_controller cycles with no WARN,
BUG, or Oops.  The EXT_LBAS + ms!=0 + !PI combination was not triggered
during testing (FEMU's mutator varies flbas and lbaf[0].ms independently;
flbas=0x10 with lbaf_idx=0 was not produced in this run).  The
bi->metadata_size assignment path was not exercised in testing;
correctness of blk_validate_integrity_limits() for this configuration
was verified by code inspection.  Provided as RFC.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e20c8f08e4..76fb788024f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1836,8 +1836,29 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	 * insert/strip it, which is not possible for other kinds of metadata.
 	 */
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
-	    !(head->features & NVME_NS_METADATA_SUPPORTED))
-		return nvme_ns_has_pi(head);
+	    !(head->features & NVME_NS_METADATA_SUPPORTED)) {
+		bool has_pi = nvme_ns_has_pi(head);
+
+		/*
+		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
+		 * capacity to 0 (we return false) to prevent block I/O, but a
+		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
+		 * and reach nvme_setup_rw() with head->ms != 0 and no
+		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
+		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
+		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
+		 * at nvme_setup_rw() (addressed by patch 1/2).
+		 *
+		 * NOTE: only metadata_size is populated; no csum or PI profile is
+		 * configured.  Actual data integrity for EXT_LBAS non-PI workloads
+		 * is untested; this patch is RFC for direction discussion.
+		 */
+		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
+		    (head->features & NVME_NS_EXT_LBAS) &&
+		    head->ms && !has_pi)
+			bi->metadata_size = head->ms;
+		return has_pi;
+	}
 
 	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-- 
2.43.0


