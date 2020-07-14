Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F8C433E8
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8562240B
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 19:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xm7TgZ/d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULjvrJjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8562240B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iUUIHwk19tg6bfJg7Nd8QP265HbVKyeXJuQu+i4zhQE=; b=Xm7TgZ/diWllz6Tr0ejaUZockb
	lNPiFJganq/SRyQ+BCuKUQ6rAY7SkARWLb34r/bZkaVlxXgi3i4kPXMfP73pSJY24q5/7B4HuoFMT
	lG9Wn4rb8VvPvWXF2/6pGmUBnn69vqKvLp5rnrh9WD/nY4rO56cMMDpoBuSP6GhfNomOtZUVf1MLV
	vnYQKQsWSIvB1OeuwAnz50ueMAz+0x59BVmkXySLNf/p3VgN5nF+U2T6mnsml+yLzKek2OzrTNn8u
	HW6aRB9iFUmVPW4y7WrhfGAhqGVyXbY7qYtZfumSv7o3d6i3flis/zqhMnfjFkFSNHIsAptkNB6Pl
	T1uGx2mw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvQDX-000095-8z; Tue, 14 Jul 2020 19:03:51 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvQDU-00008L-Lu
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 19:03:49 +0000
Received: by mail-wr1-x442.google.com with SMTP id z2so24214878wrp.2
 for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2020 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g66YrilqoD8iyrLUYqt37BTxwOEJnhGPDpF4V7j5jSs=;
 b=ULjvrJjXZTqwiTlN/YjZAqELuSzLkfEjt3/6CenCO5OZLPa71ILZrAIIDSIXsfEid6
 4szXMzjGPw17VMw2Kc0wyHAgarJLh0ZlBfp5Rt3h5C2KkoCGUpG+6cu+aOPPkecjp/v6
 +i3aTyNXnURLHdPQtpdglyjPhcbs5/dMKl1P2Du4j/V+hUSduprz52QO7Xoh6fA7veWW
 RUuXqfWpCp1FshnQOpQ1Ls2JeellNMUOH9ckm6e21OlLMy8QeDluiWKxAr2IBms+lB29
 H2R0PQirPhoxGPxDaFquiWblJCKFv40mIjbTfv5plvtVUIW41xmWhgcrXjwoQ3Hk7CGH
 n9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g66YrilqoD8iyrLUYqt37BTxwOEJnhGPDpF4V7j5jSs=;
 b=US2CfIIrTiclEq47EAMJtV18sv0lC7z50xUOPStc0e+hG2GhWn7TJtbOWxl8Xjmm4G
 RUGm0muqcS5JMOO43klXs2JXMEJWWJX6godF5yWuvoj7ZW8R/Q9+LAGb2CBQ3BCpMoph
 nK2z74Yv5A0soEmI18h1kN5kbq7rKJ7IigD1pFT6uNTXUKzOeUp0Y0vrGHRr4JcP7RBI
 qybmruSeRigMx5Ui8qyS6H0ovObamTCuIqyOcu4fZ+wa/xBFdfXpTE09YrwfVKzcq9nK
 NQ9e79C5qRKwSWuyUhjF4BI4UiUkp88Jpj5eQwLPErHRWnnKo6V4XY7dZnqHNIR3dW7g
 j06g==
X-Gm-Message-State: AOAM531CHpQ3sKFD4Faq38IFBBbZKDBg0J5A/kPlIPEZTUWbZHsweshN
 uIf3PSTtDjaeONFtIhszkYeU9kmE
X-Google-Smtp-Source: ABdhPJy8CwwcUttZXR2RmmQYhyZBdavfw+UdwdF8md7SKPhRTr9sfk7uJZEmnjohPS0YhUBM/KsqpA==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr7982179wra.150.1594753425669; 
 Tue, 14 Jul 2020 12:03:45 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-85-189.oc.oc.cox.net.
 [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id b18sm30453677wrs.46.2020.07.14.12.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 12:03:44 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: set max_segments to lldd max value
Date: Tue, 14 Jul 2020 12:03:36 -0700
Message-Id: <20200714190336.119013-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_150348_736204_9E9E6404 
X-CRM114-Status: GOOD (  10.27  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, James Smart <jsmart2021@gmail.com>,
 "Ewan D . Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently the FC transport is set max_hw_sectors based on the lldds
max sgl segment count. However, the block queue max segments is
set based on the controller's max_segments count, which the transport
does not set.  As such, the lldd is receiving sgl lists that are
exceeding its max segment count.

Set the controller max segment count and derive max_hw_sectors from
the max segment count.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
CC: Max Gurtovoy <maxg@mellanox.com>

---
Looks like the setting of max_segments has been missing from all
fabric transports for a while. Rdma had a fixup (ff13c1b87c97) from
Max last fall that corrected this. But tcp and fc were still lacking.
Copying Max to look at tcp.
---
 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6aa30bb5a762..e57e536546f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3001,8 +3001,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_disconnect_admin_queue;
 
-	ctrl->ctrl.max_hw_sectors =
-		(ctrl->lport->ops->max_sgl_segments - 1) << (PAGE_SHIFT - 9);
+	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
+	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
+						(ilog2(SZ_4K) - 9);
 
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
