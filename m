Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F3C004D4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 05:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ldu9E7oPQb/k24oVYRPeIAkULOtiU2kMOW+8uGn5m7o=; b=nHV2+kF8SuV+iOYsJe4NYJ4mZ1
	BQi5ihKtaD6R6ut1ppvRxUPcO2377OUgXDZyYa5doHXS+yH52WqAr4iY7ViVnUIm6K77/1ibQytRN
	LQnwxXP8EuCYFzY930noC7TBwgQ4KrcWanqYHLLm64ENaeUO3tjpZ8V5eQpWEhX6mwzLPVSX9NVwf
	nLzFKDb+ey0RLE1+RMWld9gMeBQMT4VyoYu+d2yyrweD5fqoJMLhRrvQvoKQheufGcNf+ASJzk6Gm
	8zzknczTb6werv9lrIS7pryYdPkUjjZxjs1B7LN+wcfjKk+yOOY5lSekh/l/s0oHwQkiCAR9nJiYG
	zrmQxqUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI0uZ-00GxKe-3d; Wed, 18 Jan 2023 05:22:59 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI0uW-00GxKF-In
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 05:22:57 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I4KTMf022769
	for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 21:22:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ldu9E7oPQb/k24oVYRPeIAkULOtiU2kMOW+8uGn5m7o=;
 b=Zn5Vdn5HHBNlrq5GzfcoR76j/Sh3ggwYoNGQgfvyb77YG7/ROGdiyxVK5NANKzQODKfi
 8a2kMBPQF/gxUMx1ZNJ6bwtSmEsHMhib2k26zbLoLMR1SIwkayHhhv93sW+I+U/jpnzG
 BrF6y3xJtnoEkBz/CuwtlLv7wjndtE5oAObnKf9Qvr0qzz5FiBeJTWV7ITz22SOSa99s
 jl+7iylLEwpwYJo58cem1Y9kYPyMMjOsD5CPHbj/0dOmV5PXltEORYkHb+Jud1OQTI9j
 xXymmNWRKf2vA+xIIpcMVF2ME1M2Xj8QMTiW9kCPAzoQE6vqgBymWjJBFilbOuC4QqQz qQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5jdx7m2k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 21:22:55 -0800
Received: from twshared3750.06.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 17 Jan 2023 21:22:54 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 450ADF3DB419; Tue, 17 Jan 2023 21:22:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
        Jens
 Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: fix timeout request state check
Date: Tue, 17 Jan 2023 21:22:44 -0800
Message-ID: <20230118052244.741505-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8NmlfbjUJPuFzdt1v7DNlozj-sHWdzKY
X-Proofpoint-GUID: 8NmlfbjUJPuFzdt1v7DNlozj-sHWdzKY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_212256_646695_B868E45D 
X-CRM114-Status: GOOD (  16.11  )
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
isn't STARTED.

This is fixing an issue where the driver aborts an IO that we just
completed. Seeing the "aborting" message instead of "polled" is very
misleading as to where the timeout problem resides.

Fixes: bf392a5dc02a9b ("nvme-pci: Remove tag from process cq")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: Fixed spelling mistake in subject

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2553b7d9bb8e..c92840333230b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1362,7 +1362,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	else
 		nvme_poll_irqdisable(nvmeq);
=20
-	if (blk_mq_request_completed(req)) {
+	if (!blk_mq_request_started(req)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
--=20
2.30.2


