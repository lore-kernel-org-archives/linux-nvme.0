Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B0C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8ug9Et3HqRFe3N0G+eeisLxaTEy55ZyWgWF052eE4U=; b=3ROvnCUMwnv4H1N6snDHOjb4dI
	l4oHkDwCgeI8nRjmO4fg3LZCgwjTF359RP2atOk+9JFNF6Hl7C65SwYyTwzjUnNFPb3sJLptoqK19
	r6bzRuPAD0uYngM2OdOKadGxUMPrUbiSBz3accDISkCLWAd53wo7Ukq8EoigXbsoNBcLabeFvkKBH
	x6p2WdnqtzukZg+7cxKtoqNoOjIQ0oU5kabXnOnCckcp7QCqKJ/rxGCY3/ESx/uyoi9WRdWlTKi3A
	4lP69OS8aBj1sl9895PZvVTqtn8Vog1vOT8POpzbjM+j59oJICpUFqRMA3E8pXeqHHTNBtxKF4GqE
	/R3T+8bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7e-0000000CiWp-3tfV;
	Mon, 06 Jul 2026 14:16:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7d-0000000CiTc-0IUf
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 14:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=B8ug9Et3HqRFe3N0G+eeisLxaTEy55ZyWgWF052eE4U=; b=kz04iI8vBajGfbxSmLBVGiIq4C
	Mocr01eSCCenAEUV6iGLdw7DopVISueRWgameAvOabS7d+2lNT17/3M9QHcbmecHj9owQ7Uz81bjK
	I/JgDoeMJ8zNun3pZwas4QBBZtAesxYksBpvfTTSlGCsjPW9CR1q0j+B/VnM702vE5RdApXdAOvlw
	E1+nnKIZImsl3+RRiSwSZ3d3REcxwLC0nglREHWHWR60IDxBEyelJaIzhiJaj33yyr62hfB92E9en
	5xjiz6nXgxd8E5EJ3T3YP6gQGPffd3y5QiViz9V6ed9WJxsucJqekQolUEdaLQSzMeFv42pq489nP
	6/zWQkRg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgk7Y-00000006doE-0VUj
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIM0B007664;
	Mon, 6 Jul 2026 14:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8ug9Et3HqRFe3N0G
	+eeisLxaTEy55ZyWgWF052eE4U=; b=WWeRqjn/QCk6teHPd3hgb/B67qmTZIcLX
	caSUoLj8rYIDlR8ckc4QgmoDkPSRufM/87qQkY5lqcrd3TdIDXrOlq2uZpTVIo8b
	EetzBzSU9kLPacb1TN2t5eLRaRcw+f7DSQW+V4jRtlH4BtVZpuQc64ki1NZrMrxY
	82dUe/Rxn/P5pEGmpFgO24DQpqCL370jrJRavJl3B64dwJSzxTWKqcl1goqrGQ41
	6Zn6PMpgxmgBcueUzNo/jKjq/khB91jGDINefcxoaDHHJCQaPpnSi7hHqF9Jr8u7
	xj6h2ye0oYdlWnVuTLMijOSgpvRXhyOZ/0Pss4xlyvxJsD2gWqwkA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3husb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4dj7022427;
	Mon, 6 Jul 2026 14:16:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjwx1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EGGWr51118472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E34AE20043;
	Mon,  6 Jul 2026 14:16:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F9720040;
	Mon,  6 Jul 2026 14:16:13 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 16/18] nvme: add context annotations in tcp.c
Date: Mon,  6 Jul 2026 19:44:18 +0530
Message-ID: <20260706141452.3008233-17-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bb8b5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TfvOO_zgRogsC6GeyRwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8dEpq6hhh9mn
 Kh7B9QOx3VUstzeEkLIQJtdOWGsiJ501pA9FpJ1CDmr8D3pf6GASDLXAEW95iDJwsmohQVI5+UV
 V6u1FfCdjf2L96DY9C0QE6aBZrggo1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX31saKNlM7ASu
 LiFIfRC0Z3/1PoswM2ju1yDU7k8n7USzqtkg24nPZohQtkUfrtOAet4G933Ha8m4l6L7ITE6hhx
 HSyFho0zy72x3flXwZM/CNwspuNEv2ClW7Fwcti1LI2JTSdx9fn6MHl6N8OSEQkhYRXYjNs3M46
 U1v/a5KBS4rFEzldC3RWQFytoUvSXjdqgZa5zlxjoaZbKDPayageWQ4qyaqyJzmC19ob1m6pN7m
 absvFZoIdPKyE3hefnVjHvDVdF8+9vRWMmWpIYcauBRBLpjUy4fgXAqi2UVvf4aZ4D6YMDI8lbg
 F3gnY8jNqJybGNkuC17fAf12eS9qeKZYVL2FFOINqDgYsDkTjKDHw0whyHgvyrEf2B8szMoznK1
 rQKoPg7iv7AppeogCHc8wzEiOGL7mC4t4i/10L1zE565fPNUog4/8s8lqV5arjjx7M2G9ocpVgy
 wN7EDkdHWALr6o4U3bA==
X-Proofpoint-ORIG-GUID: fbd9cuMIv3JtrKn-sAQr-pqH5cx-Mggd
X-Proofpoint-GUID: 0lVtPKzrNs7H1Z-GioB8dj2CIpaYTzqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_151628_521209_9D2435BD 
X-CRM114-Status: GOOD (  18.85  )
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


