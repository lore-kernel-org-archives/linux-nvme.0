Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5C7C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LFB6g7yiLuvx3NhpyDgWqfkH3Hk/ESxpR7n1iIPvsg8=; b=NBSMpA0eFEm/lLGiIgO1/B4kRi
	g7kzgmrzBudkKpS1nVkdgq8WLmXqacfOGcEDcGNGsCHhP+LQgbDaRXZJ+/Xy3RVwE3WlbiDziiKFt
	2dOr2dyHa3QaMFHH4EXyMeM6tqk2Dq9P38UEQAm1f916Q291gWs+OLnLkZ5dmAewJlu04xZRXkjGk
	7BkW6qbGKeXkpejXpaI++7z0MRkhSLHVbw5YGIrlsalKn0ePfMTKCWPm+VzWVi7NdM1K7P7cTKyBS
	BxbUePv4QfsBHzI1ctdCt+8XTyx5aM6Y967KEkFIgkTDArAGgVJc1m4xzXIimBSXXEEfE5mGv9bhU
	9DM3YXaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbS-00HNSJ-2V;
	Thu, 25 May 2023 18:22:22 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbP-00HNQc-03
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:22:21 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-1afa6afcf4fso16329405ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFB6g7yiLuvx3NhpyDgWqfkH3Hk/ESxpR7n1iIPvsg8=;
        b=cmIWhPDNX92AbN2sUTY09TvcshdPbAyjz+zAq9oAfHmq52erplk2fxehsIh4X1OfUK
         ywmo/BkH21xMCnSui43fgK8zeKFqkV7zEKeh8ojszHic9qtSn2i96oc2ieVttQx4SDeP
         geNWOfnVEbrmCqjvsbMPtFlH1XJ3GcSN+hxY/mQlT3+uKURwTWGtn1hFByvesjji+Zjj
         FIAM1MZmbxhlzSJFpbahnnpb/W5qcDFYP3FtbvxkW5TL/bKlMV+jPMQyIKvrIDQrlttw
         1hKnYjsjkjYY2OJNmMRtknR9Km6/kPyeopFke6yq50XuoCHxlYbNjmkxfcJKIxbDDi6L
         Uo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFB6g7yiLuvx3NhpyDgWqfkH3Hk/ESxpR7n1iIPvsg8=;
        b=ZE1sHo0UUWBjiQ5eYN75XWLXm9u7IZlkYyXvnfzS3iye93ACziwXFlaI9Me/8yFzDD
         3u+ccvNkifDEZxV0oFux4SKimXuvaT2aiw0t1bpns32CdGvtS49E2ImXbkbJhyB/Nko4
         4Elg7vluevxacNB2mB1iVM62BliEjG5Gnl+VZ/NuS9D1IQwpAnv8RJjDstsnGRdkiANs
         0ufZKW/h7smka4SAggxrk2+BPoreULlsTRqHhjf0yWoaRjDlCW+CB3DfVmR03rcXp0fF
         YM32O+yS7DMxh5Yjz8CNKHeGNsV2Llr7UZ0umxL/CYvH7G80+uM1CjvnbedGPm7pP/ZB
         70+A==
X-Gm-Message-State: AC+VfDwws4sUf6sdj90vFDmFfmdynSoGgFVgpB6GR73zMHpavjVEcHfb
	9ffLzECKRDxzJO8dA66QWr8g/YjsbLJMZIbSHQgjk9t04mgFMTKC06zRFDVIzXNWSQ==
X-Google-Smtp-Source: ACHHUZ4TDkxTWXlJPsNaZJcmEOLgVu9QoWy3qp1vtdsR/QRdnhI6r3chU+yESpSs9OMatxswkiIZrIaKOG8y
X-Received: by 2002:a17:903:452:b0:1af:9b8a:9c75 with SMTP id iw18-20020a170903045200b001af9b8a9c75mr2743669plb.7.1685038937051;
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id y16-20020a17090264d000b001a219ac11dcsm141280pli.77.2023.05.25.11.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id CCEED221A5;
	Thu, 25 May 2023 12:22:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C821DE44A27; Thu, 25 May 2023 12:22:15 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v6 1/3] nvme: double KA polling frequency to avoid KATO with TBKAS on
Date: Thu, 25 May 2023 12:22:02 -0600
Message-Id: <20230525182204.1954429-2-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525182204.1954429-1-ushankar@purestorage.com>
References: <20230525182204.1954429-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_112219_276304_467E51C9 
X-CRM114-Status: GOOD (  16.69  )
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

With TBKAS on, the completion of one command can defer sending a
keep alive for up to twice the delay between successive runs of
nvme_keep_alive_work. The current delay of KATO / 2 thus makes it
possible for one command to defer sending a keep alive for up to
KATO, which can result in the controller detecting a KATO. The following
trace demonstrates the issue, taking KATO = 8 for simplicity:

1. t = 0: run nvme_keep_alive_work, no keep-alive sent
2. t = ε: I/O completion seen, set comp_seen = true
3. t = 4: run nvme_keep_alive_work, see comp_seen == true,
          skip sending keep-alive, set comp_seen = false
4. t = 8: run nvme_keep_alive_work, see comp_seen == false,
          send a keep-alive command.

Here, there is a delay of 8 - ε between receiving a command completion
and sending the next command. With ε small, the controller is likely to
detect a keep alive timeout.

Fix this by running nvme_keep_alive_work with a delay of KATO / 4
whenever TBKAS is on. Going through the above trace now gives us a
worst-case delay of 4 - ε, which is in line with the recommendation of
sending a command every KATO / 2 in the NVMe specification.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f586a4808e6e..5ad2b9b0d3b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1161,9 +1161,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-- 
2.25.1


