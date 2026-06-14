Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B97CD98D2
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SyIkWn9ZHdWjQhvzEPSyQoBjfcKniLJ6PgSqLuvATXA=; b=b9OfQI5G0/5+u5XlCoDo7v1GOL
	f7Arhg4+mOs1tHPg9dEciPVb3NDFggQv5jTXnpHPv+ZgVHFAUF895/YfmoymAKVPp+IZYhB6S+D4Q
	7l3nnOdDdIepoUJYWcPewFnyp7UN2spaGxD0A4IEiAkuCx4fr7cYq3bJ1BuGAfoP/xauja7xbYlOs
	xlT8EbhaJSL9nfMSeB8MLCdFJeYq7jTk0n4P7AhZWAjCyTlgeJlmdZODTO5jwG7P0t5Ez+wrR8Fxl
	tcVtMWY1kUf9/JvSMaY6AX4AOW7m1/mbXG/Ea1dT6wiNCqXUMTXJH7ruQTwGRV1yKJ/H+mTefkhsC
	Fmbsc+bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhV-0000000D0t9-40u5;
	Sun, 14 Jun 2026 13:16:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhS-0000000D0qY-42i0
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:32 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECma4a3478334;
	Sun, 14 Jun 2026 13:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SyIkWn9ZHdWjQhvzE
	PSyQoBjfcKniLJ6PgSqLuvATXA=; b=gx1hSBZEeBIa55tdPBcEscfnVWxq1cfaB
	wtCJdBVzS7JEd26qAG/9XLufW/e1on4A4KVcmqo6XLCA23Qc/tcQDCrM4QM+LRHA
	ECUPmA0/AhDLlDHhe+Jg78k1mpAWQhKAm5IKClzOcr9KAfyi39bpWwDMyl8eOvxO
	hk3ZUI4xOZlBIutlfkPuCGLRSwlOktRzPdCRmiZ6AGLgN1W7yYUWT9v3H1Vs202s
	n5BsM6Uv9mfuyNZKId5QHaieBR9J6vhh28Exw1aYMQOGF57MH2trg2qRg8P2S+D1
	ZuXz6HfC2jxmQ0soF11mDyvrEL+9xi0tmO1mBsM3ecW0PI82+EeNw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nbm67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4dHX013157;
	Sun, 14 Jun 2026 13:16:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7xsdm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDG2gw55574868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14A320043;
	Sun, 14 Jun 2026 13:16:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B38E20040;
	Sun, 14 Jun 2026 13:16:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:15:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 04/17] nvme: add Clang context annotations for nvme_ns_head::requeue_list
Date: Sun, 14 Jun 2026 18:45:19 +0530
Message-ID: <20260614131541.2017845-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ea997 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=gCGRpEvQKZDurPVkv08A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX9ibHZeWe5s5V
 1auAQJ3fQpSAmpFhcCBw6c6m9pZlJoWEgSr6R3KA3huB/yF8/v9DNV5vJbcAxj5KLPFhmfaCxqY
 Qf8m2fqNSXamz2DBVYyAXgokHMcm0IRI4hHlmuSxcJDdG0dp3UGEeZVwHivUIY4YC6x1C2KJSjk
 k1TJWfqvbUb+yk6nARrEyhLUwrQUkZ760V7l8Yj3v+hvVKgbTBVo3M8ALVt+8r2dc3L2NWv8KGf
 94pfD9qr78RLe7zyUofQEMRcb7gxuj/n/PeUDPg8zRiotb8hGF/RAYcJoCXsoDA6sFHXa7TlhkC
 5lqQgnpTwP3ZS/DW/os3VZs6T+YDQWUjZLM+sy5ZzKsH5s+RDLgVxCurSMBU/m3OrCyzMp8krm8
 /eRC4vpgTtAqhQ1WbICf9rSw05jIW7MiAPvmKDeo/kFQKwsMKgOV9fCN9VOj5ai19kit0dwfDmA
 +4PTNSZ55ioaGJV0/Rw==
X-Proofpoint-GUID: DiAgxiaMkO8PU6-9Swcz9YHor2vUQdbL
X-Proofpoint-ORIG-GUID: etQOb6o1JQzs1sVHRmEfAyW60-LdVnuz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX59e5mBWWb+ng
 ep4x9XoziKuaKpxnR9BFMkrCM1ljRTpSGCQ+7Jw+FgtJUF9yaYNx4ij/lLZ16jzWaJOH6ZA2zs7
 n/QKhKvs+srRyb68zwNY5ieLONTgPUc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061631_010981_DBB70877 
X-CRM114-Status: GOOD (  12.83  )
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

nvme_ns_head::requeue_list is protected by
nvme_ns_head::requeue_lock. Annotate requeue_list with
__guarded_by(&requeue_lock) so that Clang's context analysis can
validate accesses to the list.

Replace spin_lock_init(&head->requeue_lock) with
scoped_guard(spinlock_init)(&head->requeue_lock). The guard-based
initialization generates synthetic lock acquire and release events
visible to Clang's context analysis, allowing initialization of the
guarded nvme_ns_head::requeue_list in nvme_mpath_alloc_disk() without
triggering context analysis warnings.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 4 ++--
 drivers/nvme/host/nvme.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a275c03e7c59..9e7f12fe8cd6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	struct queue_limits lim;
 
 	mutex_init(&head->lock);
-	bio_list_init(&head->requeue_list);
-	spin_lock_init(&head->requeue_lock);
+	scoped_guard(spinlock_init, &head->requeue_lock)
+		bio_list_init(&head->requeue_list);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bea0947eeb0..f60852944709 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -555,7 +555,7 @@ struct nvme_ns_head {
 	u16			nr_plids;
 	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
-	struct bio_list		requeue_list;
+	struct bio_list		requeue_list __guarded_by(&requeue_lock);
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
 	struct work_struct	partition_scan_work;
-- 
2.53.0


