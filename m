Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6D7CD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VtekpR6cey4CtTWV4xkrXalV8L8MRvhbyb3+vKP/acc=; b=4punlZ3UXcwgN23+Gu4F+AD1Gy
	bp+gpu8vHVxiZywKQyziqT5pE6SsaxzhZatk2RGS6ZThPYkT5xrNltWFjUrzNaeKNafhLnxuTP8st
	qGI3OY0h91lWMK0p0ZKfMeKTeX9oyAHnnUkApXYdlcpP7ZTbe2Hh0+a5nJxVNKwODIeIoIDBPaySM
	oc8jieLi0kb0Yc2o/0b9N1KborLk8mGG0UjIkj9LtaHww+3DTTTs+tX9ZQY+TPrEq30TBBvyKqlmJ
	TMf+ZDO/ktDXxDB7w96Xg4Gln3NQWfaHj9mifpJqUXuZEiSCb5uEKOKk4X/VvkdPkhu1RFUyKWEoc
	JsIBqxNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRpg-0000000BG5Q-0XHe;
	Fri, 22 May 2026 15:30:40 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRpd-0000000BG4t-2lo1
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:30:38 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-63270abd14fso2468267137.1
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779463836; x=1780068636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VtekpR6cey4CtTWV4xkrXalV8L8MRvhbyb3+vKP/acc=;
        b=CXutb9zKKs4dS94Q4g4LjAKJV+NDLot18DKD5M9SRsoscDqIJ9hwT9fidz0fVA0uYi
         K/RUeNRw87LBKng5QzI8BH1nhN86zLXg8vf6KmJ3zy4zIIqaUG8D4bPmNEn12Jv8Y0Xf
         akgAG1n3Y3LuO1P0kIEcfagONWzX4hT1LJbj8jhyu9oBIiqfX2SXbyJ7RhLHNY9W089i
         hYCQVO/e0jS5qm1uxQnmMmplXIrj2IdjwJm8F5WjTVLwuXqsHkir6hIeUAltO8lmRS3+
         0hrv0yQIJp3v8IejZCBS0PgnhKKR/gE4SE1pF3iVFARM+wgxQ5dACfLbjLTViQYQZzCQ
         dhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463836; x=1780068636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtekpR6cey4CtTWV4xkrXalV8L8MRvhbyb3+vKP/acc=;
        b=MBR0tmHlY8gJkIY/sl9isuI7SEnqEBIy1SXfkAXKF6qrpw+yLYnHqXaCHo7PaDshGe
         WaJcnIwE9+10DtBmBal88Rkb4hZtLoZv82mfcJv1GZ0y8HgchG4GazPqYbfwtjcw3xGq
         y5oQN2Vq+DeE67ZgIbNI90OXfAR/6d9++Azr8nNJgLqJF95kuhLlAFFigvEDXXMU4Vba
         vFlj6/CnIyg5VdEYqj0kgToheH7VfeST+JyBpC2tuXZhdbMpfJVDlwkxcXVmhP2IjgFE
         jsMgy/LP5EpiQnyPEvQT2KYQ0X+V6LiKAv3KiZgOmvRl37rwxNxmhk/owyNWrO4XJfff
         Ycuw==
X-Gm-Message-State: AOJu0YwjH9vYm7KcHuYhqljZ7bbTwzi9vXNRC4rXWA8Tm6uaL0oH7x1m
	E/nhmDJ7aaCvPSg6FVbF53lgFbWFTbKX2XltErIkhoOsfd09iWneCxNLp7ySUev86Rc=
X-Gm-Gg: Acq92OEejOpXJ8gt+TSRyaESgJm/pVZ4JVw8Qxs9mlYknKD2gmQUgL+YxhTJa3LHPZs
	J9T+nHgnm2fFiydxjagBRUgqgmnsc0Ee8B6u0OSArhnWnQwkVPmFZ8veBlJac1FXXRtR4rBPRsC
	QbEWi7t5xebFx+telgJSPCEtrmpC2/n6oKK9MJwBEwUX5Vs6SPxaAzTFA/6qmlrU5DmD4cwKNuv
	BjVEO3kJPTdboUgNtfMiqyz9Wu0Wpu8BIjphvxnDFGyiSvZG253+HhdHbMFIoy9ptr/FPREnyBh
	bpJL4/p1eiJ96h/9xOWfgG3NOk9lc/TaZmjbKoKQ/Ixmyk8DJUeCxkkBb+qFpiDybWbV33bWdNU
	5V4AZYxaC9U+Yh6JSx9TO4qhmc93yWXffoABa5Si5k0EfAWylG3Y7He133tPogiTUtyMcuQYVu9
	2pzXx0tSpb5bquD23gvKzmL3S7sEOUITi7krfxXkDoJQ==
X-Received: by 2002:a05:6102:4bc2:b0:634:a573:c097 with SMTP id ada2fe7eead31-67c79ebaac5mr2242680137.13.1779463836252;
        Fri, 22 May 2026 08:30:36 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96177c1a9e4sm1585228241.0.2026.05.22.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:30:35 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH] nvme: reject completions for requests that are not in flight
Date: Fri, 22 May 2026 11:30:34 -0400
Message-ID: <20260522153034.2168862-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_083037_712317_FEF74F8B 
X-CRM114-Status: GOOD (  13.70  )
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

nvme_find_rq() resolves a device-supplied command id to a request with
blk_mq_tag_to_rq(), which returns whatever request last used that tag -
possibly one that is no longer in flight (freed, or never dispatched and
thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
command_id with a genctr for use-after-free validation") guards against
this, but its generation counter is only 4 bits wide and can be matched
by a malfunctioning or malicious device replaying command ids.  The
driver then completes a request that is not outstanding, dereferencing a
NULL rq->mq_hctx or double-completing a command:

  Oops: general protection fault ... KASAN: null-ptr-deref
  RIP: blk_mq_complete_request_remote+0xe5/0xa80 block/blk-mq.c:1319
   nvme_handle_cqe drivers/nvme/host/pci.c:1418 [inline]
   nvme_poll_cq drivers/nvme/host/pci.c:1449
   nvme_irq drivers/nvme/host/pci.c:1463

Require the request to be in flight before completing it.  The check uses
the request state, so it also covers controllers with
NVME_QUIRK_SKIP_CID_GEN.

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/nvme.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..3a525c1dc818 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -615,6 +615,17 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 			tag);
 		return NULL;
 	}
+	/*
+	 * blk_mq_tag_to_rq() returns whatever request last used this tag, which
+	 * may no longer be in flight if the device reports a bogus command id.
+	 * Completing it would deref a NULL rq->mq_hctx or double-complete a
+	 * command; the 4-bit genctr below only narrows the window.
+	 */
+	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
+		dev_err(nvme_req(rq)->ctrl->device,
+			"completion for request %#x not in flight\n", tag);
+		return NULL;
+	}
 	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
 		dev_err(nvme_req(rq)->ctrl->device,
 			"request %#x genctr mismatch (got %#x expected %#x)\n",
-- 
2.43.0


