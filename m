Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DBAC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:00:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6605622254
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o8luiolu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="KWPJbAFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605622254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ekb5zbIS5UgPgQ6y/EkpvPhuDHpNlRP5yhTMyOinQFE=; b=o8luioluVl/FzV0SpNgA3EExum
	Jz3kvSj3OFYXCGR3aZOkaGUmIBYPrnZ137PT41YHkuBk3Dw5IQODs16ZxBVXzT9Vdkt+1+vYPRT01
	i/SCHptIxynMgLwRjxTSDK/IiVaF7LvkuaK4GCv9q+biU3b6gcjQj6A9Rw8aBKZ06eTUjPWlfjoBM
	Cewdw91VDzHKsn0VTfzdWoa68PZk0Z/w14BNu4li2yJbbjCdTbInyrMC5Olrt3PM4uNCwxVIVHYk9
	YChlF1v57DHY/kZ61xI1ey6h6R7FElP0Md/4skCOZnEhaSb8fihGs2ChZzOK+p5rSoULNVm+KBJ03
	jkZCLBeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVr47-00089l-5p; Fri, 23 Oct 2020 07:00:43 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVr3z-00088q-BC
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 07:00:38 +0000
Received: by mail-pl1-x642.google.com with SMTP id t22so360164plr.9
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=gVvp5GTF6tEYF1l4MyLe+EEACPzCJh/rTLhZ25K7Yus=;
 b=KWPJbAFMvmpj3OAzC7C9dIn2g7wa3y2PZbYxCq7caZotONOVMgoXy8ZqkhAHrJUTSJ
 ds68D0aFcyb8vTkMBMfaRF5rduNxICRu4bABQKpWk5TRzbPUcaLMnPeXNn6J9WUdmge/
 Zwg+e50jvhe0RtX4j6BcUzxnTK2SUU+zIsF7psfkuC0aqOAJRCKlz1tY88KbKg3oWDoZ
 ZxoDyY3j8K7k5TZXwMRDcUZviq6w2gV4rDjvhK1PLEdnrcq2A95liY19s/dcTuW8Igcm
 9i8FpsMUPQBkQkPH+IRowt6GVsQSiEIqWPp6ZKYPmxkX8+buhBqcj85d6XINiIjUl+wk
 TjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gVvp5GTF6tEYF1l4MyLe+EEACPzCJh/rTLhZ25K7Yus=;
 b=SZOKwnL7f94rdtOMTgyllByZO3oN0OOU1XOHQKNWwV/3QK1fqXCjm5mXcXCMQnpExi
 4R9IsNZiQKb7vjU7XN1x9vtN3myuMGZlbTneqQ4DPtm69RMb6vUBZPwPXEVbR9uR+RLu
 GbEjZokpnPDjfMYq0RISAzui5HrnQn7waM8McmhBfml12jyNpiSNKgMfros56PL6ofJl
 I9geU7lcm1aSjJaIN26/lGG00xRWx0g+i8/d3knUpAWZyxYs3exphiqmrNvg/5jGcogz
 RiVl2N98sKIW3Z/jGa8wrvDbGd3f68/uDQP5oA6HbG9S2mK46P0YGi4mdEQdMsRQl7k0
 2zXw==
X-Gm-Message-State: AOAM5304P+jTF2bDZa2BwIC55HYwsaMLN9D6Wdl/hPwElyTk9Xx57z6J
 wVZmr1meTLRp8M1dHmnC2VfJMg==
X-Google-Smtp-Source: ABdhPJyM1RekPYb05cSt8HvXzUhVRJa3OqIUptCqYP36bORzn5wOfny7OcuR9gEWaEs3/69n6p/s/w==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id
 d10-20020a170902b70ab02900d26391a80fmr1186265pls.0.1603436432573; 
 Fri, 23 Oct 2020 00:00:32 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id h4sm795139pgc.13.2020.10.23.00.00.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2020 00:00:31 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@fb.com
Subject: [PATCH v2] nvme-rdma: handle nvme completion data length
Date: Fri, 23 Oct 2020 14:59:10 +0800
Message-Id: <20201023065910.1358586-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_030035_632599_1B39EA0D 
X-CRM114-Status: GOOD (  14.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: pizhenwei@bytedance.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hit a kernel warning:
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28

RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Call Trace:
 <IRQ>
 nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
 __ib_process_cq+0x76/0x150 [ib_core]
 ...

The reason is that a zero bytes message received from target, and the
host side continues to process without length checking, then the
previous CQE is processed twice.

Handle data length, ignore zero bytes message, and try to recovery for
corrupted CQE case.

Thanks to Chao Leng for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..2ecadd309f4a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* received data length checking */
+	if (unlikely(wc->byte_len < len)) {
+		/* zero bytes message could be ignored */
+		if (!wc->byte_len) {
+			nvme_rdma_post_recv(queue, qe);
+			return;
+		}
+
+		/* corrupted completion, try to recovry */
+		dev_err(queue->ctrl->ctrl.device,
+			"Unexpected nvme completion length(%d)\n", wc->byte_len);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 	/*
 	 * AEN requests are special as they don't time out and can
-- 
2.11.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
