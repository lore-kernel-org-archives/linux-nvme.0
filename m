Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A79CD37AC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2026 05:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0E7jjUk3MC5+CVl+LevXCEF8IwXtzIWnXoqor7xZUmU=; b=FI1URftk8DXyL9T9m91vU8G80b
	DAbo0NW1JkEpF2X2JWMVZ53oQtyMjtYazbB/RZjCshh70o940CqB0u6tlziH8S8xNlFgc90fSMMB9
	KxqaRRP8d5ZUs5ykP5QENr6Hy0HsV1jvufuIPvhHafYgGKfsGU16DqktAIZdz8JqMPBNCmhebfWq/
	MdleJ7STamRY5x/2my2IhHE5uYUlO1FFMHEp7XV/Y/fqxre/XfevLF0Q+MIn372Ruga+rYIKfl56Z
	/4xKc0f6MeoOZZ2S7/V3C7GWEzH8Y9o2G1x5aAog+a83dadALJcA0c2rYU1PhlgebUBHtwlwE+qZv
	AIA4e6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOUBL-0000000CA4V-1mN6;
	Sun, 17 May 2026 05:36:55 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOUBH-0000000CA3w-1ZNA
	for linux-nvme@lists.infradead.org;
	Sun, 17 May 2026 05:36:53 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-95fa7cd1392so1045812241.2
        for <linux-nvme@lists.infradead.org>; Sat, 16 May 2026 22:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778996209; x=1779601009; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0E7jjUk3MC5+CVl+LevXCEF8IwXtzIWnXoqor7xZUmU=;
        b=CY+odju+XnZ0DFJPdRgKOICClwFoPEHbVBtcN6X2qGfYark+V/nUwGSEcJRC0knuVV
         AmhPGahBN5T73boVteewxMuaMGjfCfyPgSdQwzeqYYWfGb6ZXQ0ubLRD+rOVqaI925e/
         Aegt0BXIbIfUAIJ2WRiOdrohPpBjS5g+wW04OHPwuGmBqc7dxjqFMLHq5QyhRe3QhBBv
         cPc0WWB4xiYCJjsZgmky4cvnrhME0lR2JfbWwx0CUtWXzuuV6vxfzRtB1XEZJz1iuRo3
         6qOk8v1JHhhC9G3tT4Rzt9cMnlfRO3eAxGkmyqK3c6/uLfa/xcqZL7YZzgz92iPE3k59
         Lf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778996209; x=1779601009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E7jjUk3MC5+CVl+LevXCEF8IwXtzIWnXoqor7xZUmU=;
        b=DBHF6y0kFtVV24AhQbhloFdetmJ5ji1ibhU7Jvwl91QrPbO05X8KA5IvLTBcbmNVIc
         2NjJhxSOUXl6ilIGh8xOk1RVOqaWReOoV0hDZJce53yqx3AYv+nqcPGjx6l1SLVXUn5W
         EMSXyg0GppoqmqCTlOV7curGKPiZPtoPEpz20yyIyivjy9w8mDnGLdpvZV8sdxGEzpMc
         voO4xHZYozHP6xZYaNdFd1uKKVamPHe+yN2DAxgLl7/suK8/kbPAyUf13p+KG3ZYZ17l
         QwTle/5eYijZTksD+XekNiQ/Mo4GOc1UGz8+v4iFVsAHwCFcH5X/hMO7PsrMk5AHPLed
         8SxA==
X-Gm-Message-State: AOJu0YzQHYnJOp8XjtMpJIURr4iGQqtPGm+qYcmCoQ/nyeSlqwgC6XHK
	PK9l4SjtoZy2Sn5aOZML7ZdWEPdgpkcidlVUiQL1oIZp7i1hMHx2O11w/d4OyFW3mwk=
X-Gm-Gg: Acq92OEXVzIz4v/CTyx6jikOOynuJbtyvuM3jzlBDdw26ICNrsgi20OE9IVViSqa1xb
	qRpiwLBhcZz8nWwklYVjaV0OVsKrJEI2iVSRWtGpnCENPysesLXqrCPlalgUXw7fQTXlDxzc30k
	HrK1O/HfctrJqO3r1MMZx9GlTTvvRAwyWa7TdGxsDWYEuYcMbVQPoSWQMZKkVUZXaO+cpRyNxZj
	enyHxOPPfoTc54KzvVTkx4Fcv7HbBTr81Y9LsZmmFPdciCjJi2EaXOkG1VsKWyJC3+fPIxRjk+o
	cwgfmrmQPTsxC28kx3wKkIWhW/eV2zM8/MUdG9/4QXIDEB4OTOdTiwKLUUQFsy5MsNE/uukYhuT
	WEL9FirfAOR/mY/Icj8RcGo6xqeaQarewfOQBtSLUh/8XnT2M2Qhi3CdsS2B2zM9NdyoMT1eU5g
	BkieAgZRIaRuMDLbBmGpWxii6mTsL5HnWFs43w1WCLhw==
X-Received: by 2002:a05:6102:3053:b0:633:7d88:c77d with SMTP id ada2fe7eead31-63a3fe9f462mr5371583137.29.1778996209295;
        Sat, 16 May 2026 22:36:49 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2c99f63sm3347932241.1.2026.05.16.22.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 22:36:48 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	iam@sung-woo.kim,
	daveti@purdue.edu,
	weizhu@fiu.edu,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH v2] nvme: don't WARN on I/O to a namespace revalidated to unusable metadata
Date: Sun, 17 May 2026 01:36:35 -0400
Message-ID: <20260517053635.2282446-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_223651_427504_9270C174 
X-CRM114-Status: GOOD (  15.51  )
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

nvme_setup_rw() fires WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)) for a
namespace with head->ms != 0 but no PI and no REQ_INTEGRITY.  This
occurs when Identify Namespace reports flbas META_EXT, lbaf[].ms != 0
and dps == 0: on PCIe nvme_configure_metadata() sets EXT_LBAS without
METADATA_SUPPORTED, nvme_init_integrity() registers no profile, and
capacity is forced to 0.  It is the host-unaware geometry change Keith
described -- an out-of-band format on a shared namespace, or a
non-compliant device seen on rescan -- not the host's own Format NVM,
which freezes first.

The freeze in nvme_update_ns_info_block() is not defeated; the WARN
just does not depend on q->limits.  It depends on ns->head->ms (read
live at dispatch, set inside the freeze window) and on REQ_INTEGRITY,
never set for this geometry.  capacity == 0 only gates submission
(bio_check_eod()), not dispatch: a writeback bio that passed
bio_check_eod() under the old capacity sits on the task plug holding
no q_usage_counter reference and is flushed by blk_finish_plug() after
the update committed head->ms != 0 (dmesg confirms: the capacity-change
line prints before the WARN).

The I/O is already rejected correctly (BLK_STS_NOTSUPP, capacity 0).
The assertion fires on a device-reachable, already-handled condition
-- a panic under panic_on_warn -- and its premise does not hold:
metadata without PI or a registrable profile is a legitimate, unusable
state.  Add that explicit case and emit one dev_warn_once() instead.
Fully fencing already-submitted bios over a revalidation is larger,
TP-level work and is out of scope here.

Tested: built on linux-kcov-debug (6.19.0+, KASAN); boot-tested under
FEMU, 4x dd + 500 rescans, no splat; reject path verified by code
inspection.

Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).

Link: https://lore.kernel.org/linux-nvme/20260427003457.1264511-1-coshi036@gmail.com/
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
v2: drop 2/2 (faking an integrity profile); supersede 1/2 with an
    explicit unusable-metadata case + one dev_warn_once() instead of
    downgrading the WARN; rewrite the log with the requested mechanism.
RFC v1: https://lore.kernel.org/linux-nvme/20260427003457.1264511-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1711ef59fb8..32ccb56c4aaf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1039,8 +1039,23 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
+			/*
+			 * A namespace with metadata but neither PI nor a block
+			 * layer integrity profile is unusable: nvme_init_integrity()
+			 * registers no profile, blk_get_integrity() is NULL, no bio
+			 * ever gets REQ_INTEGRITY, and the capacity is forced to 0.
+			 * A bio that passed bio_check_eod() under the old capacity
+			 * and was batched on a plug before the namespace revalidated
+			 * can still be dispatched here afterwards.  Reject it; this
+			 * is the expected terminal handling of I/O to a namespace
+			 * that revalidated to an unusable geometry, not a bug.
+			 */
+			if (!nvme_ns_has_pi(ns->head)) {
+				dev_warn_once(ns->ctrl->device,
+					"%s: I/O to namespace with metadata but no usable integrity profile (ms=%u), rejecting\n",
+					ns->disk->disk_name, ns->head->ms);
 				return BLK_STS_NOTSUPP;
+			}
 			control |= NVME_RW_PRINFO_PRACT;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
-- 
2.43.0


