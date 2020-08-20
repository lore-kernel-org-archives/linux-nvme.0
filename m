Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B7C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C712072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FHWOL3uR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C712072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJOOWMAnj1/XqKnAq8ACF9h28w6ztv7P3r7j3eMNIe4=; b=FHWOL3uRC0JWStPafJEvBijwKq
	gHX+zVTK2rr+eJ6FWBJbFWbNBtl3Yx5V7PCFnHv8rgvVhHcA1kqjuuVvwQm1HYg59NOSyJTH7XADd
	wB8SJJfNdiIswutHTQbDt2EC0f2hprmgzeIwt4bjqrvWOBOyTgLp/XlCLN1DyIZNaDS6IZC5qOgeM
	cNjM/bvQPimiHxX3utAq+JZd/K6YlWovdVTcGiFw7FCoQ2xSn8WA46wksjfsq615Gsd77vzH83TTv
	jBi6kibCu6RLxJoJFSA3lQRwlByG3JW1NG2P1AsRB07r8QTYeo0zdvgEztEl1+21elSrCvvAknLa3
	Av5ygwiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8dGR-0000jy-MA; Thu, 20 Aug 2020 05:37:27 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8dGO-0000i6-V1
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:37:25 +0000
Received: by mail-wm1-f67.google.com with SMTP id o21so518383wmc.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 22:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u89qJ/RdtuB2yKv52mEoCW6IYJcrneM4kYwPhrM2gTg=;
 b=fSutmzlPNYvnh8k5Xjd1HvKw4esOPvuyhGw7l8yG76YZxMr4lWmh2ITejUt76Kn0AV
 ykSvF6f8KGcLviFVR3MT6tUjmzO13YmJsIx5Ac33qXisxLJxlRPfuwVCSrlUkGlVa4dr
 LUK6XlHvcsGqNQSp+ig4RYpq/7Vd/gHVfIyjEg21PxkmSXq+kxjzU094JBJpyyQmYG9J
 EAYEIZeK4rhZS96Ooy2huHDFc8euPb5CljSF6HrIxc9N8ccIfYlKsmEROGRKSvCogR9V
 Y85aVnLpNSFxdBAW1u1h9/5guO5XTJ3DVriaG9FgpV+l3P3IZ/88JUyZgkQzhsprZt4O
 XtSQ==
X-Gm-Message-State: AOAM533klu9FhrpWGeKLi+rmshvB0PM8VSf+t7SoVjpt8aGs+zqVN/c+
 WBGb3PiW4d24M9Nbiz1FfVIuZb0SpHHc0w==
X-Google-Smtp-Source: ABdhPJyG1AO84GXnKz/3Rt7uS7puKbwuoeZDm17ObtSYHnu+LwcANfqvxhvrfQICbJFmospQMizcMw==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr1687524wmz.8.1597901843837;
 Wed, 19 Aug 2020 22:37:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id a10sm1900353wro.35.2020.08.19.22.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 22:37:23 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v3 6/9] nvme-tcp: fix reset hang if controller died in the
 middle of a reset
Date: Wed, 19 Aug 2020 22:36:48 -0700
Message-Id: <20200820053651.197057-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820053651.197057-1-sagi@grimberg.me>
References: <20200820053651.197057-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_013725_042703_1F768DC5 
X-CRM114-Status: GOOD (  16.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the controller becomes unresponsive in the middle of a reset, we will
hang because we are waiting for the freeze to complete, but that cannot
happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to proceed
(either schedule a reconnect of remove the controller).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dbb661b899ef..873d6afcbc9e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1783,7 +1783,15 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	if (!new) {
 		nvme_start_queues(ctrl);
-		nvme_wait_freeze(ctrl);
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
 		nvme_unfreeze(ctrl);
@@ -1791,6 +1799,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 
 	return 0;
 
+out_wait_freeze_timed_out:
+	nvme_stop_queues(ctrl);
+	nvme_tcp_stop_io_queues(ctrl);
 out_cleanup_connect_q:
 	if (new)
 		blk_cleanup_queue(ctrl->connect_q);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
