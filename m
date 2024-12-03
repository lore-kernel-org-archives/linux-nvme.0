Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A225E64A8B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+nE565GqzRL6WWgNdxtEAQrAfSiQvojCfoGbG5n+oyk=; b=rQO+9DvLI9d8gyi/RTydu/TkHB
	X6T7pLT1K9iwbsWveOCrRNiFNq8DcwvMdknicqN4mD/J86c3VbIrDjrtuYDFOnio0qJLjLcb+J1kQ
	1+fiw/9ezStlUZ7xBH3x9LBNvfJAsAHor85HiA6oVBMWsM2XqMBvmat6ZF37fSPzanN86D58pso8p
	W58vAIPO9LhAJXJGLg98MrAIgQTk8qVXSFF1UIyYJIvGlC8SpRItbU4IZuHRgFF3pF3nJCGWZsySr
	Mg57elLoDSXQoNbKRxQE2lhOCTJXPj5tFvF72kuKlRBzK5sRm/nmORlMesidIwWaIBe70fSGt36f6
	N1QK93OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tISku-00000009Zly-17Zv;
	Tue, 03 Dec 2024 13:15:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tISTI-00000009WFh-18Fl
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 12:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733230663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+nE565GqzRL6WWgNdxtEAQrAfSiQvojCfoGbG5n+oyk=;
	b=SIOC/OUrk9cZJGbtCPq21x3XT+OXXH2nrShtLncvioq7ika8zxveQBsue4UTnDpVwreDiI
	dqAoWn1M8/kud5ERvLVuU2SqnoaONYsLzgz7h1Q7y8/uAeSqKwgfZidROuTcEuzoE2FsmC
	7FJSbWhyvPCxPuRAQhS57TgsIlzWZ0E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-SGJHOumAPjSC6ne3GndAvg-1; Tue,
 03 Dec 2024 07:57:40 -0500
X-MC-Unique: SGJHOumAPjSC6ne3GndAvg-1
X-Mimecast-MFC-AGG-ID: SGJHOumAPjSC6ne3GndAvg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7827319560A3;
	Tue,  3 Dec 2024 12:57:38 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.225.184])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3BB81956089;
	Tue,  3 Dec 2024 12:57:33 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	kanie@linux.alibaba.com,
	kch@nvidia.com,
	loberman@redhat.com,
	emilne@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH V2] nvme-fabrics: handle zero MAXCMD without closing the connection
Date: Tue,  3 Dec 2024 13:57:32 +0100
Message-ID: <20241203125732.393992-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vwoHjvgNyCnzwH1PZJIlDI-O5quTKUCqvYMb5EG_Ag0_1733230659
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_045744_385704_A19D8287 
X-CRM114-Status: GOOD (  13.86  )
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

The NVMe specification states that MAXCMD is mandatory
for NVMe-over-Fabrics implementations. However, some NVMe/TCP
and NVMe/FC arrays from major vendors have buggy firmware
that reports MAXCMD as zero in the Identify Controller data structure.

Currently, the host implementation returns an error in such cases,
completely preventing the host from connecting to the target.

Fix the issue by printing a clear warning message about the firmware bug
and allowing the connection to proceed. It assumes that the
target supports a MAXCMD value of SQSIZE + 1. If any issues arise,
the user can manually adjust SQSIZE to mitigate them.

Fixes: 4999568184e5 ("nvme-fabrics: check max outstanding commands")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V2: replace dev_err() with dev_warn()

 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 52b01a15aad1..30327e3b2662 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3260,8 +3260,9 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 	}
 
 	if (!ctrl->maxcmd) {
-		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
-		return -EINVAL;
+		dev_warn(ctrl->device,
+			"Firmware bug: maximum outstanding commands is 0\n");
+		ctrl->maxcmd = ctrl->sqsize + 1;
 	}
 
 	return 0;
-- 
2.43.5


