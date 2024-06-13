Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C17CC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WPBF8jRqn94Tc8VINQlN77/pcMOT4uoIDE98z+RhGSw=; b=EBK9etb8tTCI3H6/wxetQLLW2B
	Z19D7110pMyjeeW6N0ToTYMXxgh6DtXDbqRyqnTQtE0XbaRlfFYAkk41TuaeRoLsr1aQMaVvdV0D/
	F/OV7qLI/LizB5l400OpRJbmugzb/LUPW9zqemLkH71ISemvKxR0/+8JocScM6gP5YyeUWuGMk2zU
	YS9z5SRbGImYKFMzCOuUnd57uGMcuHmxE2OWhhfUHWBKb1xdrS6aI3m2VerG9K15vyM0BtHI7kA8t
	ZRxZBXI51FlgtqJ6iGYK70Q6TZDIHMn9XpjbHEjWuRmVf9JSX15Yd3jP9QfMHfhIvhfnC02WFZ+Ub
	6NcNTBCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHkn8-0000000GoGk-2G80;
	Thu, 13 Jun 2024 13:47:02 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHkn5-0000000GoFb-0OJK
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 13:47:00 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DDWpfZ005374;
	Thu, 13 Jun 2024 13:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=WPBF8jRqn94Tc8VINQlN77/pcM
	OT4uoIDE98z+RhGSw=; b=qb3WVKjGlUgJpZm5SsQ5msAVnq58q7WIbQ1p29zcKs
	ZaA4RwBsGzS/gCtnr5e8XBPvWy5mmrGtjh/v/AL0RKRMvU55JNszmNYAqs0KJNtg
	GKnIVZfx9ZVzzLWysDJKSubJwtudXYfK5yLutIQJ09e7bqA8bfbUfYoyx6GM7dSB
	Eg85HK6WFLmRYwciTAtvP+i0L6WqRkhr7VCj0HlG+ENHy0jHF9Z7041ycZrMzc+L
	bOmWUmOhTXYxnZxQ/Vsi5E+BK+Qoqn1jq/V1fSXkKPqAyOkfP4scWJokfYRQsyHQ
	oGJi3aAAEX/ntEpXiX7RKaFqU14pzV4sqarhc2Rs/Ttg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yr1rbg1es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 13:46:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45DDdRu9020069;
	Thu, 13 Jun 2024 13:46:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34nfwp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 13:46:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45DDkma152888008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 13:46:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84A420043;
	Thu, 13 Jun 2024 13:46:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED7642005A;
	Thu, 13 Jun 2024 13:46:46 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.180])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Jun 2024 13:46:46 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, gjoyce@ibm.com,
        axboe@fb.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/1] nvme-tcp: Set correct numa-node id for host controller
Date: Thu, 13 Jun 2024 19:16:14 +0530
Message-ID: <20240613134626.2252963-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sxR_Lm0pob5rFJrwPoQVFjePy-gmfJWi
X-Proofpoint-GUID: sxR_Lm0pob5rFJrwPoQVFjePy-gmfJWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_05,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_064659_271686_FE4C70E3 
X-CRM114-Status: GOOD (  18.41  )
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

In the current implementation we always set numa-node id of the nvme
tcp host controller to NUMA_NO_NODE(-1). So on a multi-node numa
aware system when the iopolicy is set to NUMA, NVMe multipath code
can't calculate the accurate node distance and hence it can't select
the optimal path for IO.

This patch ensures that we set the correct numa-node id for the tcp host
controller and thus it would help ensure that for multipath scenario
the optimal path is selected for performing IO operations when iopolicy
is set to NUMA.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83..d96a9b0c7c1a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1924,6 +1924,10 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 {
 	int ret;
 	key_serial_t pskid = 0;
+	struct nvme_tcp_queue *queue;
+	struct sock *sk;
+	struct dst_entry *dst;
+	struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
 
 	if (nvme_tcp_tls(ctrl)) {
 		if (ctrl->opts->tls_key)
@@ -1942,10 +1946,21 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
+	ret = nvme_tcp_alloc_async_req(tctrl);
 	if (ret)
 		goto out_free_queue;
 
+	/* socket is already connected */
+	queue =  &tctrl->queues[0];
+	sk = queue->sock->sk;
+	dst = sk_dst_get(sk);
+	if (likely(dst)) {
+		struct net_device *netdev;
+
+		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
+		ctrl->numa_node = dev_to_node(&netdev->dev);
+		dst_release(dst);
+	}
 	return 0;
 
 out_free_queue:
-- 
2.45.1


