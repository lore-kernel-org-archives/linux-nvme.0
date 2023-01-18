Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C9C38159
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zETmNm8UBJpiXzFva6hSDoMUafgnBp3Bwr+dvNbzD08=; b=WkPOomc+/idvJC1WPp4dIl9Pp+
	/+bMz1if/zmDqVfmrzSU0oHrThuncwpfOjm0Qeh8rEoiP67argXWNIeh4280o9kie0cs5ip5uTDXA
	EtvCEYfnndm6I1XCw/T1OuecUzeARKr0sI8v2EGGVWtxPTtfsScTm5T7PtYDILr16hl7NrsNvyvHa
	qa3DRICppf7/UZrOoVU8wwyh5cemE+9vYr75Cc5fbztTlezv1SrZORvPNG4DZC0UOol02fMVjtQRS
	yrbfjjfWyU1wazfxp740yU62BYuTPTOZMxVlcBwcVG3iMT5zfs6eXix5n5dhnTS8HF3fXizWsX0YK
	4Y2w4xvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBY4-001t2K-M7; Wed, 18 Jan 2023 16:44:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIBY2-001t1A-CO
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 16:44:27 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IGT9ZW015412
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jan 2023 08:44:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=zETmNm8UBJpiXzFva6hSDoMUafgnBp3Bwr+dvNbzD08=;
 b=i7ooOn7AJmjd1tjy+m2X4Oc5oS/qrqqh8B1+ZWEOSPQPZL5IeWxzOGMpy3iVFkdKsbYl
 fdg1u3uXLc1TuSUHOF5s0XpSAgmBwepspj8cypRHWUeTczkxIF+qyCj617jjr+PVhvzh
 6jKkDQuUKNJScatN+clyL0UOBInJ2FL6ep5WaaihieQksR1OLwFRspXoArpF/QAaO9gy
 rsl0hcMVDIO6uNJaj1dDKwHLbU+DmOjca81wo0+bELZm7+D6j+Hrgv2S0MHXwWjbnzfn
 5g0keWQCgCXMZTafJOyCpoPZiyNZpGR6NBAhwp9nso7fXbWM8KKfF+Heo9r1EeDOyeyk qQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5ufer506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jan 2023 08:44:23 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 08:44:21 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 605DEF466589; Wed, 18 Jan 2023 08:44:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3] nvme-pci: fix timeout request state check
Date: Wed, 18 Jan 2023 08:44:16 -0800
Message-ID: <20230118164416.1085583-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wQ-r2OAlJ7S7E7ZM3ApBachnH1Wt9-NY
X-Proofpoint-ORIG-GUID: wQ-r2OAlJ7S7E7ZM3ApBachnH1Wt9-NY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230118_084426_461175_1E490E44 
X-CRM114-Status: GOOD (  16.13  )
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

Polling the completion can progress the request state to IDLE, either
inline with the completion, or through softirq. Either way, the state
may not be COMPLETED, so don't check for that. We only care if the state
isn't IN_FLIGHT.

This is fixing an issue where the driver aborts an IO that we just
completed. Seeing the "aborting" message instead of "polled" is very
misleading as to where the timeout problem resides.

Fixes: bf392a5dc02a9b ("nvme-pci: Remove tag from process cq")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3: changed state check to explicitly look for not IN_FLIGHT

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2553b7d9bb8e..1ff8843bc4b36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1362,7 +1362,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	else
 		nvme_poll_irqdisable(nvmeq);
=20
-	if (blk_mq_request_completed(req)) {
+	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
--=20
2.30.2


