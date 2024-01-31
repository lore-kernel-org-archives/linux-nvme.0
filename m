Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6022C4828C
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBNXoOE0KRglmarkLkBdEE6rtjZ9/+Loqo9/lslPuCU=; b=rdQIWtoHT8Lafe0Z31MuKcKXt7
	U8Pl78PcK/MZ09n+swqzJkb391Fil81vCg5bIOPs+X/rpC3CyVx8mo7EramNF+sZ4EA78wFF93prG
	r0H/QYoPzy7n2SPTDpXtcGYByV5K8r5BW/7eLdLo6c67J7sBnxL+oCE/XsfjnNMdjyLp/YOqYOdag
	Q+qn34Zl2KElPYR6JRlAu5pEw1IwPeC6YueNpTeHgOC+zrZ78MGdynwpM6fUTBdhzNf8lKTzO2C9x
	GFnMx/jdhSZ1NVWi5kQ3+0z44vWAmzvqsFR+TsKgO2hNXB6XePWlIJgzaQRUHF561qPqpOvk9LJTP
	xOLQ6zVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDgh-00000004aoc-0GZQ;
	Wed, 31 Jan 2024 16:43:47 +0000
Received: from mail-yw1-x1162.google.com ([2607:f8b0:4864:20::1162])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVDgc-00000004amf-08k5
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 16:43:43 +0000
Received: by mail-yw1-x1162.google.com with SMTP id 00721157ae682-5edfcba97e3so59944897b3.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1706719420; x=1707324220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBNXoOE0KRglmarkLkBdEE6rtjZ9/+Loqo9/lslPuCU=;
        b=TJYA2TbW9JfzxgPxwm0R5kvGVHcNd9/e/jmv0LNIXFyv41LfFVoNLSI/fmvq/3Zw9p
         Ws0Dwu3dwNKLOmUGzKfc/aKk/nQfvjgFau3akDDxxQqAwqEOk/rS/Z5vB5Z6s5N0aiCg
         w/jiLPeVLe5M5BFK7lvrpd3Pbaby1NxP+w8suC5OovpFHnlSmNjFDeWSaROM0uoUQSOf
         TvdM4hJDCzx2Uf4YZdPh12F07Q47QQKvrXdwDQZJjbg9/PV5cwShrfPxTpVrwzUR8db1
         MdZg+XdBhagMXy9WMUW1MnVqj/1dfg1ZIfPnIzJwGuHzjVXZIG3/4IjafeAFys11c3b7
         74Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719420; x=1707324220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBNXoOE0KRglmarkLkBdEE6rtjZ9/+Loqo9/lslPuCU=;
        b=aWmC8+l3ofTiMoWwytSA6phSu6MQhf19kY9MHwD9Njd5MdU6aYSvFbRNQDGujat3vS
         L/mPjkn8wOFhrQdExLGrOg1/XCxjYRp3Y0A9Jf+DaaHdQEXUkWX/jGetzSPzD+UbZCXN
         WxNiJ1Q/Cm+c7VB3RS1BedDOqEYHahwckKluApc7s/sITgNuHM8yhyI0XowYbd5T4hIU
         4kZ5hcwyMxIkUTgy++glJrtruopIA+jjiHmjDSMxQ+WM1pTfKfOB0jBgmmnful9/H8AV
         MaJROXo9M/y6FzKmjAhRTCPhdTTYfdXIqFegphb1a1gRrj1ida8Kn1gt68Ln1QeYP1x4
         bmUw==
X-Gm-Message-State: AOJu0Yyt22rf1klqhmLoc4vmxenOmz21wzi/W3sA1ThvbKWHqWnZxdjm
	2eV8nm27jHnowCjmEoXmU/A8GAPRnMYMOI+RIekfyJdNZ+Gxq6ioFNzMqdi3Bl8iIKnh/NUSiz6
	q3IO2a2AH5E3V3aiqVenU8ioGYMWdykHsYnvz5HnSUPdkrhR9
X-Google-Smtp-Source: AGHT+IG10a3JT9aGSWDH55IqQKxfbUal14Eh0dpswB0UiC5sN7cFOvyifjAmsylqjIfcIYCrTsLrGl2/aRz4
X-Received: by 2002:a0d:d486:0:b0:5ff:4e3b:dc89 with SMTP id w128-20020a0dd486000000b005ff4e3bdc89mr2201175ywd.11.1706719420722;
        Wed, 31 Jan 2024 08:43:40 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id c67-20020a0df346000000b005e78a0dc8ddsm830405ywf.29.2024.01.31.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 08:43:40 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CE6E434071F;
	Wed, 31 Jan 2024 09:43:39 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CA646E4FE76; Wed, 31 Jan 2024 09:43:39 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Cc: Caleb Sander <csander@purestorage.com>
Subject: [PATCH 5/5] nvme-fc: log human-readable opcode on timeout
Date: Wed, 31 Jan 2024 09:43:15 -0700
Message-Id: <20240131164315.160042-5-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131164315.160042-1-csander@purestorage.com>
References: <20240131164315.160042-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_084342_095505_CCF56299 
X-CRM114-Status: GOOD (  14.35  )
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

The fc transport logs the opcode and fctype on command timeout.
This is sufficient information to identify the command issued,
but not very human-readable. Use the nvme_fabrics_opcode_str()
helper to also log the name of the command, as rdma and tcp already do.

Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/fc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e2308119f8f0..63a2e2839a78 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2572,22 +2572,24 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 
 static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
+	u16 qnum = op->queue->qnum;
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 
 	/*
 	 * Attempt to abort the offending command. Command completion
 	 * will detect the aborted io and will fail the connection.
 	 */
 	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d w10/11: "
+		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
 		"x%08x/x%08x\n",
-		ctrl->cnum, op->queue->qnum, sqe->common.opcode,
-		sqe->connect.fctype, sqe->common.cdw10, sqe->common.cdw11);
+		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
+		nvme_fabrics_opcode_str(qnum, sqe),
+		sqe->common.cdw10, sqe->common.cdw11);
 	if (__nvme_fc_abort_op(ctrl, op))
 		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
 
 	/*
 	 * the io abort has been initiated. Have the reset timer
-- 
2.25.1


