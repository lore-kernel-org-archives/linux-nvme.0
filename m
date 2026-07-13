Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21259C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8ug9Et3HqRFe3N0G+eeisLxaTEy55ZyWgWF052eE4U=; b=VQa77tnu2ID9bg+zA9E7WYcchv
	rNGIFv7BAVhANvE7UoCPxF5thXJe7Acdhdso1I0yzH5o5auxmEwwFpyA6GPPubOMtUwUESoatrKdO
	5j+PUge8r7ry7woJNUKyeeqikGDOJbDxCxiMZqp54bDrlzSsLRtzMvvXUE0K2ZYLDXtFwbJ6i3cpy
	hdFzVuyISTgj2E3RBdkEMCYX4mwc3jdt1VX6JQO9AApDFJ4Tk+uA9hpYq+r20HJzHs44dBtOAnBco
	MIpRPN6S5b5zE3/hdZaQkMdRAqer7NwEhzGZuDLRIkADukwpWxk3FEH6zMoIjFuNDI7EOfBrVwtGC
	qSkIZcNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGL-000000095Dn-2nW2;
	Mon, 13 Jul 2026 11:55:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGG-0000000954X-3RQV
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:51 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7vTWq006795;
	Mon, 13 Jul 2026 11:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8ug9Et3HqRFe3N0G
	+eeisLxaTEy55ZyWgWF052eE4U=; b=AzSmilwnr+WivmdGjQdLq6rHfCpOGBxfG
	pEqF1mw0vDU2qPGMh/cEBPKtyshXbPllDRFt3ryaoQ7owVLjabJD/IHjbifELkdH
	7bRZT4ryBb6FLPTKYd9FoG9cLUH32PJQUheqZMsElKvucYu4vBRtQt8I1X/C/ZzN
	9oleoa3pReB3bqnKDFw6q2Euvtym3yShrVQYhHlZv/tUexFkiVj60vh+0jD0JXQF
	mUrSIncS93o1p9sSAK7YLCgNBaRZFtnX/1Z31NXT6MPNVHGbJDqpwDpDs4opqfye
	zCPi/4vtSwDT46bLP+NczcPFLTJviL/0xbJGr+wdPeXVo1y1xx/VA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv330xyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnmaZ023657;
	Mon, 13 Jul 2026 11:55:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtaCI48824586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05B8420040;
	Mon, 13 Jul 2026 11:55:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3FFF20043;
	Mon, 13 Jul 2026 11:55:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 18/20] nvme: add context annotations in tcp.c
Date: Mon, 13 Jul 2026 17:24:19 +0530
Message-ID: <20260713115444.465704-19-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX0sEScOfTPZu8
 HFm1TUQn/RgrwIbpOI6xbJL53i4ocpVINRydwBCKnaX3uuh1cz92hEbMA4NPd0L15Hp6ICM4gpf
 ti4kgYVe2wpWgaXB3ilDBNGYGNbFeE0=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54d23d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TfvOO_zgRogsC6GeyRwA:9
X-Proofpoint-GUID: uOsSCATg7Q8ji4Z6xGEHnPuNxDBMkDg9
X-Proofpoint-ORIG-GUID: _zA-TdQiJ0xgBOJN1InFRycTkX1Jq3Pk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX+hr7vVj1FYTA
 oGM12C3yhOiOqYApX7/10g278RIz7kb9gDiQZ5AJrAFmwzDC8UcpdtFBbEtVJdjIq6wUpVshquN
 eRaBs7zN5tgs2LmNDgKH3Pd5cBMltf4W7xinnBm7Hb16olgEAXwnxmL5K6u9kO3HLcpsO4YYlDC
 xlCXFSanbFMJaXnmljZES0NERE8P7lz0N3AsDxhRxfkCzZzbvd7ckzwArou9rj9bTDHi4rVBrrY
 57mLwVGFriol1+ZI+jC6KJEZwHUqD51Az5L18TdQBWfeel3VLuJP4zygGAkytowbyMoIPG/R764
 lvfs5pyVb1TNlw2Oe62fbABh5kpARFPMyczHdR8ImIwyEH29EXW8dOtokapHEk4C/yfICMnDdXu
 Lj8NQTzip/Ok1sXu3sk0iAFENURk7H2efrnwzKg8aTdY9D5EeeGTc5cxkyrF0tdG/Uqs+HfurKo
 7wQSLTqGzzmDZF73yMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045548_895333_FB49A1CB 
X-CRM114-Status: GOOD (  18.70  )
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

The nvme_tcp_ctrl_list and nvme_tcp_ctrl::list are protected by
nvme_tcp_ctrl_mutex. Define nvme_tcp_ctrl_list using
LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex) and
annotate nvme_tcp_ctrl::list using
__guarded_by(&nvme_tcp_ctrl_mutex) so that Clang's context analysis
can validate accesses against the corresponding locking requirements.

It is safe to initialize nvme_tcp_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_tcp_ctrl_list. Annotate the initialization with context_unsafe()
to suppress the corresponding Clang warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..8d2fbfc7cd8d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -149,13 +149,17 @@ struct nvme_tcp_queue {
 #endif
 };
 
+static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
 	struct blk_mq_tag_set	tag_set;
 
 	/* other member variables */
-	struct list_head	list;
+	struct list_head	list
+		__guarded_by(&nvme_tcp_ctrl_mutex);
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
@@ -167,8 +171,6 @@ struct nvme_tcp_ctrl {
 	u32			io_queues[HCTX_MAX_TYPES];
 };
 
-static LIST_HEAD(nvme_tcp_ctrl_list);
-static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -2919,7 +2921,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&ctrl->list);
+	/*
+	 * Safe to init list while allocating ctrl object.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
-- 
2.53.0


