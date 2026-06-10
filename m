Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A9CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i3XjgFaw1MBt0K6WP5RzFBXO2Favf1Oexe04H7mOKYk=; b=hNxawRKbzT1tQRNp1riBfSFR1q
	Q3/JKt9kjiwEtA+cBwkdt6pXrj8MSnPca3ITBYhVncoGKYe/vTPIz/jkggBiVSzgCt5FRbA4eyPwp
	6T2lwryb2QvwCz8Z0plnh//HdXEsOxlnRUueTYQzVbNdaXSjzjErQ02HRD9azXXQo6AFua1B7cMs7
	P3U3+tkrjk+iZM+1pDzPTb2AA7IS0SHnODYJHUWf3bMGV6i+xRwHd1IBXdhQEBCVmYLrUsznSxa2a
	WXzN8pBiKxCcyK3/4RjsCfqYdstS3lg/oRCgbFGr4jKiknFq7WSm1QgXQng5g8dtST16A14BlfTFt
	M5qr138w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvQ-00000007t4l-0GUN;
	Wed, 10 Jun 2026 14:29:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvM-00000007szX-2w08
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ABs0YE1266651;
	Wed, 10 Jun 2026 14:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i3XjgFaw1MBt0K6WP
	5RzFBXO2Favf1Oexe04H7mOKYk=; b=swgbrF2mGkuIAm+lZfofyXtO9nmt25ipl
	rocE8kVhtc3xWR6ViC9Es7TKsVzrtjBGCIsciUig5YYsaUDc4IZYCiOesfeLpGso
	7csEQIOvzSE4jdZGgaQHvJa/Rv9zIxhc2Odkn/Jma2Le2I1wotxgTgncye+bi9uV
	mwPszxZhf3MURlVLQ9cT3OIdmJQtn3niXdpC+zELKtf2AS+ynR2gIROsAXJCJW4t
	/1eW5q8ChHuFaaizfYpyfy4NKIkjsw8I7re8SJARhh5b/q/qNFUxsyEaIiWAzJ0V
	cZRyMcYcgp4apvNwbHjHs5k4grYYZu6MkMDCk5NsorGwuNtE9veYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye9641-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEK3w3011481;
	Wed, 10 Jun 2026 14:28:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyeryq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESi4P48628174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9293E20049;
	Wed, 10 Jun 2026 14:28:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3858C20040;
	Wed, 10 Jun 2026 14:28:42 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:42 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 14/15] nvme: add Clang context annotations in tcp.c
Date: Wed, 10 Jun 2026 19:57:34 +0530
Message-ID: <20260610142743.115898-15-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX5BNoI/Ya411K
 mKgtgYw+cuE33Ay1D3ti/b4HHd4bYc7x6F8Ns7h9/cn+P45Kmu5v1UEzmBDD+ZlKLn5oHEI1NaJ
 g2mz6TV/vW0iiPLm5XkYOVVWVVOqZqYGNIj/BMvISQ6louOie7otz2cN81Fd8oHex/RUcGnSdov
 K/NaqZitvZxA2djRGn/vtYClSn1M4SxaFljnzj2rk7gzbNweu3dc/UtLGKQ6EJgPLW6DmVRtjR/
 6f/kaLH5RAN3hDw0PAE1Y0BEkypic554A5K7gzLE3i9uv4PpFwJuGg3e41jn0Wwfj0i2YXNupxG
 Rzwyt95c7dxzBl7aXhzpK1ySjiD2Zp8BxYk++1nEbBhrV+ud6VY+VWkyBrSQqzwqjfGmbpWz1CZ
 3gyI9q8SUPn0jQl6wdoiNU56VXWtPw8YfNJE8K7y6DVJdFanM53jjwplxmRpIR65vqAcnqmjqfJ
 zEVMJcMaqUsMLgNApqg==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a2974a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=TfvOO_zgRogsC6GeyRwA:9
X-Proofpoint-GUID: NSkDqfUh1obP_RfJqueavzXCQYfoEWay
X-Proofpoint-ORIG-GUID: BOlnfSJJc5DkDSt0HG0wIrbiryQtApJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072856_921078_EC121C5F 
X-CRM114-Status: GOOD (  20.05  )
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
nvme_tcp_ctrl_mutex. Annotate both with
__guarded_by(&nvme_tcp_ctrl_mutex) so that Clang's context analysis
can validate accesses against the corresponding locking requirements.

It is safe to initialize nvme_tcp_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_tcp_ctrl_list. Annotate the initialization with context_unsafe()
to suppress the corresponding Clang warning.

After adding the above annotations, Clang reports the following
warning:
    drivers/nvme/host/tcp.c:2572:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_tcp_ctrl_mutex'
          [-Wthread-safety-pointer]
     2572 |         if (list_empty(&ctrl->list))
          |                               ^

Fix the warning by performing the list_empty() check while holding
nvme_tcp_ctrl_mutex.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68a1d7640494..86ef98aefeb4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -182,13 +182,16 @@ struct nvme_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static __guarded_by(&nvme_tcp_ctrl_mutex) LIST_HEAD(nvme_tcp_ctrl_list);
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
 	struct blk_mq_tag_set	tag_set;
 
 	/* other member variables */
-	struct list_head	list;
+	struct list_head	list __guarded_by(&nvme_tcp_ctrl_mutex);
 	struct blk_mq_tag_set	admin_tag_set;
 	struct sockaddr_storage addr;
 	struct sockaddr_storage src_addr;
@@ -200,8 +203,6 @@ struct nvme_tcp_ctrl {
 	u32			io_queues[HCTX_MAX_TYPES];
 };
 
-static LIST_HEAD(nvme_tcp_ctrl_list);
-static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -2568,10 +2569,11 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_tcp_ctrl_mutex);
+	if (list_empty(&ctrl->list)) {
+		mutex_unlock(&nvme_tcp_ctrl_mutex);
+		goto free_ctrl;
+	}
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
 
@@ -2910,7 +2912,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
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


