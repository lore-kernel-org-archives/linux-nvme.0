Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACAEC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YGyw1Chf+CzlvQmRpPRS1IkhqjIVhrfaXSVtaZLYOr4=; b=qdG7E2sZqYt5XM4j9GNVWIf+md
	1Xcf1WRZOuCYXcplKzmuFvtgw7qww4WMZyu/Xvv7I9p4ph0GOdlGAlqrx6oUds6eZKA535vhsJNUP
	p6LfWuM0p9rfk5giDFSlCzYnNxfouaL/lfwdABU0Yp3J7y2FLEcyViyi2KNnvtW1uw7Z+V9+08A//
	dCik7709DOBhb+xSOrxDs3D/Io0g7GIbh/gS7Hg85x0WCKqqCOrp7IARsPh6/RP1ZZGgZ3IEmM8Cl
	AZUOEdWstvdK8WGAv512fA6GqOenQsN2xGefTd5B9EuuQhi8Yy/GGNSruINaTfCQhwN2Fs53csbZ/
	3FMvbUsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onjsK-00AIPG-7j; Wed, 26 Oct 2022 17:07:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onjsH-00AIO4-LG
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 17:07:31 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QFxWOw014384
	for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 10:07:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=YGyw1Chf+CzlvQmRpPRS1IkhqjIVhrfaXSVtaZLYOr4=;
 b=Qh0WBvtuoFbUYn9wJsJQjp+wre5EYiIVjMsEB/ExOyzxO9sH3UPD3ZtlG/nIwdiF8Kp2
 edNqsfavk2QyzD0o3RvzzHRiTQ8FkoaClvfOx5ArTLBixVVmQH9pe4WZcbP+UkJXEZj+
 NmdYVrqNJsiuvw+EPczm4modZ0+JianVYAKpoodaXQpGmIRN8uVXnzRJL90Mhk4t0hBJ
 qkYj0UOK8F1NeiRW2OdDMoHiWjlXkcYYaU8K7rkSNvOlcldq/2MkJBitZnkSABqceAD9
 BwTFTmvbNePDkXSUrvAT2RUF0YgozJjB5bVdGQWCOX453//hI8qi2/hW7y4L/Mh031Ei /w== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kf7kds0nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 10:07:24 -0700
Received: from twshared9269.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 10:07:23 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 1589DA4B452B; Wed, 26 Oct 2022 10:07:16 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Daniel
 Wagner <dwagner@suse.de>,
        Alan Adamson <alan.adamson@oracle.com>
Subject: [PATCH] nvme: quiet user passthrough command errors
Date: Wed, 26 Oct 2022 10:07:15 -0700
Message-ID: <20221026170715.2657664-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: czhxECwquGVDqSEb1FdirZT9OOX3FNLn
X-Proofpoint-ORIG-GUID: czhxECwquGVDqSEb1FdirZT9OOX3FNLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_07,2022-10-26_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_100729_849975_8AA921B3 
X-CRM114-Status: GOOD (  14.80  )
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

From: Keith Busch <kbusch@kernel.org>

The driver is spamming the kernel logs for entirely harmless errors from
user space submitting unsupported commmands. Just silence the errors.
The application has direct access to command status, so there's no need
to log these.

Cc: Daniel Wagner <dwagner@suse.de>
Cc: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 686c55cb5d1a..da874172a31d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1156,6 +1156,7 @@ int nvme_execute_passthru_rq(struct request *rq, u3=
2 *effects)
 	struct nvme_ns *ns =3D rq->q->queuedata;
=20
 	*effects =3D nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	rq->rq_flags |=3D RQF_QUIET;
 	return nvme_execute_rq(rq, false);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
--=20
2.30.2


