Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44CE88D98
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQd/7iiTu7Kx9S+dfyUW7gXyOvrHQMnK2yvIxhPYYvM=; b=FmoC5r2OJAs//OWczR84YU0I+c
	sec93hR4oR0uIWEu2Opq75svaKiaP2teEyBAaTA4eNB8jMAdNWk1ReZQHqT/+WwOkOE+CIryZ3Vco
	6A1A7NINTJSGxTB6T2n0nPVgJvrtLZqAWJ5LxOpG27Bxcue1RDUo9bPFT/rMawzGGquttc6Op4TjQ
	WBH1dzYNPmJB44sbQ9CByeKYybIH0n16SrllVMRnEH6+nAZOZhkD83xZEdB6b5lak9Xd/Bt/46va0
	0bVJOB0uPQAs8DZ4rkw5bDnxuo7M/P9nMy7ieF1RzIwYMbILNntpsttQ2u+IEnFUjP/5vJh+cqWeM
	VEgpsnVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2Y-00000003MPm-44UV;
	Sat, 04 Apr 2026 10:15:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2W-00000003MMs-1FW3
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:41 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63470AqP3509800;
	Sat, 4 Apr 2026 10:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PQd/7iiTu7Kx9S+df
	yUW7gXyOvrHQMnK2yvIxhPYYvM=; b=ngByBm/SX5wXq9L1gCUjSdaSaB0Slmn4U
	5SVs2dyuYtbnw4LiIM/WmYkiq7nZZt+PI9T23X/jbL5ar+gO1kpC3GfiRTQwUH2M
	l1ZzYFtkuwnJD4AUUM6QOcSaA1NfC/pNsA+61kO5wdcRkU5AoRHOt3R6jc1aaNXQ
	2HNaldX3Fbr4D/hEnl+bgTOdJgMqzyzG4F5IDgwuU6YqwUNALBkyxbBP2I8SzzEZ
	zcUBrfxfjJnmm2AA8b2wHZkA6GUoru3cJSp3KelqIPqaidRuyaORgBXO4fx6iEAv
	WE/NKbn3h/3G8YwYryv0PKYWJ5i+7lqgV9+56c8tWwJs5dZsl4npA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2gqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6348M2PL022271;
	Sat, 4 Apr 2026 10:15:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanh3qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFX8Z54985072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03AFB2004F;
	Sat,  4 Apr 2026 10:15:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29412004E;
	Sat,  4 Apr 2026 10:15:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 5/9] libnvme: add support for retrieving namespace gendisk I/O statistics
Date: Sat,  4 Apr 2026 15:44:55 +0530
Message-ID: <20260404101504.44539-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX1cX6gOujEqgb
 6YjquiN15Ho9UugSb5ERZGtu54kosIkwXJ6C4B0N6YWOYzaj7LESQYgO/79edrDF/Tl2T581pFg
 VWEXymE2p8i8FpltF5YtjPyJLmoAYi4VvaLXYFrQDfsCoxNE9eGzXGVP3wIbpAvBVs4yP0va7Kg
 lYJx1MN78U5ogTOghQatV+r4W0lx25x3tZQ5DCOInuk8L5cBA+dafzm5R5livBEo6Abicxb1UyI
 fRN92DvOQJ5ZwkZJpKD8mYzmYSZ+GKtxhbm5TL5mA2b+6fBCqo8K9F4m8DIjGek1ABlrQ8aG47M
 s/wH1G5iuyAkHIfVCrtE59+q7elUgXT8QMmCFXlcvhwZ62SQl88BCJdpT/3TWfE+xCwF569Mlla
 CyoUnv1oVDRVvPw5fbF/vmT6ellIIsB8R01shOZ6JDaYZZ6m3rvbERW0OMvN1trfNykf/1FXIT7
 y289noYazOU9zZw2eZQ==
X-Proofpoint-GUID: MdqmT4BD1L0vlCpB7ucvtIs3XCHXdEe-
X-Proofpoint-ORIG-GUID: MdqmT4BD1L0vlCpB7ucvtIs3XCHXdEe-
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d0e4ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hNCiM5CSYZ-UNQICLXkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031540_342992_F6792A3E 
X-CRM114-Status: GOOD (  19.22  )
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

Gendisk I/O statistics provide useful insight into disk activity,
including read/write/discard/flush operations, as well as information
about in-flight I/Os and I/O timing.

Parsing these statistics allows users to determine the number of I/Os
processed, time spent servicing I/O, number of sectors accessed, and
the count of in-flight requests.

Add support for retrieving namespace gendisk I/O statistics. Also add
support for computing deltas of these statistics between samples, such
as I/O ticks, number of sectors, and number of serviced I/Os.

These metrics can be used by tools such as nvme-top to display real-time
disk activity.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  11 +++
 libnvme/src/nvme/private.h |   5 ++
 libnvme/src/nvme/tree.c    | 140 +++++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    |  94 +++++++++++++++++++++++++
 4 files changed, 250 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 53b5f90e5..c32198324 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -131,6 +131,17 @@ LIBNVME_3 {
 		nvme_ns_get_serial;
 		nvme_ns_get_subsystem;
 		nvme_ns_get_uuid;
+		nvme_ns_reset_stat;
+		nvme_ns_update_stat;
+		nvme_ns_get_stat_interval;
+		nvme_ns_get_read_ios;
+		nvme_ns_get_write_ios;
+		nvme_ns_get_read_ticks;
+		nvme_ns_get_write_ticks;
+		nvme_ns_get_read_sectors;
+		nvme_ns_get_write_sectors;
+		nvme_ns_get_inflights;
+		nvme_ns_get_io_ticks;
 		nvme_ns_identify;
 		nvme_ns_read;
 		nvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 2e8e792b9..f09c0d83f 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -187,6 +187,11 @@ struct nvme_ns { /*!generate-accessors*/
 	struct nvme_ns_head *head;
 
 	struct nvme_global_ctx *ctx;
+
+	struct nvme_stat stat[2];	/* gendisk I/O stat */
+	unsigned int curr_idx;		/* current index into the stat[] */
+	bool diffstat;
+
 	struct nvme_transport_handle *hdl;
 	__u32 nsid;
 	char *name;
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index b5f8c219d..2949b5cf8 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -867,6 +867,21 @@ __public void nvme_path_reset_stat(nvme_path_t p)
 	memset(stat, 0, 2 * sizeof(struct nvme_stat));
 }
 
+static nvme_stat_t nvme_ns_get_stat(nvme_ns_t n, unsigned int idx)
+{
+	if (idx > 1)
+		return NULL;
+
+	return &n->stat[idx];
+}
+
+__public void nvme_ns_reset_stat(nvme_ns_t n)
+{
+	nvme_stat_t stat = &n->stat[0];
+
+	memset(stat, 0, 2 * sizeof(struct nvme_stat));
+}
+
 static int nvme_update_stat(const char *sysfs_stat_path, nvme_stat_t stat)
 {
 	int n;
@@ -941,6 +956,24 @@ __public int nvme_path_update_stat(nvme_path_t p, bool diffstat)
 	return nvme_update_stat(sysfs_stat_path, stat);
 }
 
+__public int nvme_ns_update_stat(nvme_ns_t n, bool diffstat)
+{
+	_cleanup_free_ char *sysfs_stat_path = NULL;
+	nvme_stat_t stat;
+
+	n->diffstat = diffstat;
+	n->curr_idx ^= 1;
+	stat = nvme_ns_get_stat(n, n->curr_idx);
+	if (!stat)
+		return -EINVAL;
+
+	sysfs_stat_path = nvme_get_ns_attr(n, "stat");
+	if (!sysfs_stat_path)
+		return -EINVAL;
+
+	return nvme_update_stat(sysfs_stat_path, stat);
+}
+
 static int nvme_stat_get_inflights(nvme_stat_t stat)
 {
 	return stat->inflights;
@@ -957,6 +990,17 @@ __public unsigned int nvme_path_get_inflights(nvme_path_t p)
 	return nvme_stat_get_inflights(curr);
 }
 
+__public unsigned int nvme_ns_get_inflights(nvme_ns_t n)
+{
+	nvme_stat_t curr;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	if (!curr)
+		return 0;
+
+	return nvme_stat_get_inflights(curr);
+}
+
 static int nvme_stat_get_io_ticks(nvme_stat_t curr, nvme_stat_t prev,
 		bool diffstat)
 {
@@ -984,6 +1028,19 @@ __public unsigned int nvme_path_get_io_ticks(nvme_path_t p)
 	return nvme_stat_get_io_ticks(curr, prev, p->diffstat);
 }
 
+__public unsigned int nvme_ns_get_io_ticks(nvme_ns_t n)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	prev = nvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_io_ticks(curr, prev, n->diffstat);
+}
+
 static unsigned int nvme_stat_get_ticks(nvme_stat_t curr,
 		nvme_stat_t prev, enum stat_group grp, bool diffstat)
 {
@@ -1021,6 +1078,29 @@ __public unsigned int nvme_path_get_write_ticks(nvme_path_t p)
 	return __nvme_path_get_ticks(p, WRITE);
 }
 
+static unsigned int __nvme_ns_get_ticks(nvme_ns_t n, enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	prev = nvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ticks(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned int nvme_ns_get_read_ticks(nvme_ns_t n)
+{
+	return __nvme_ns_get_ticks(n, READ);
+}
+
+__public unsigned int nvme_ns_get_write_ticks(nvme_ns_t n)
+{
+	return __nvme_ns_get_ticks(n, WRITE);
+}
+
 static double nvme_stat_get_interval(nvme_stat_t curr, nvme_stat_t prev)
 {
 	double delta = 0.0;
@@ -1044,6 +1124,19 @@ __public double nvme_path_get_stat_interval(nvme_path_t p)
 	return nvme_stat_get_interval(curr, prev);
 }
 
+__public double nvme_ns_get_stat_interval(nvme_ns_t n)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	prev = nvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_interval(curr, prev);
+}
+
 static unsigned long nvme_stat_get_ios(nvme_stat_t curr, nvme_stat_t prev,
 		enum stat_group grp, bool diffstat)
 {
@@ -1081,6 +1174,29 @@ __public unsigned long nvme_path_get_write_ios(nvme_path_t p)
 	return __nvme_path_get_ios(p, WRITE);
 }
 
+static unsigned long __nvme_ns_get_ios(nvme_ns_t n, enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	prev = nvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ios(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned long nvme_ns_get_read_ios(nvme_ns_t n)
+{
+	return __nvme_ns_get_ios(n, READ);
+}
+
+__public unsigned long nvme_ns_get_write_ios(nvme_ns_t n)
+{
+	return __nvme_ns_get_ios(n, WRITE);
+}
+
 static unsigned long long nvme_stat_get_sectors(nvme_stat_t curr,
 		nvme_stat_t prev, enum stat_group grp, bool diffstat)
 {
@@ -1119,6 +1235,30 @@ __public unsigned long long nvme_path_get_write_sectors(nvme_path_t p)
 	return __nvme_path_get_sectors(p, WRITE);
 }
 
+static unsigned long long __nvme_ns_get_sectors(nvme_ns_t n,
+		enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, n->curr_idx);
+	prev = nvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_sectors(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned long long nvme_ns_get_read_sectors(nvme_ns_t n)
+{
+	return __nvme_ns_get_sectors(n, READ);
+}
+
+__public unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n)
+{
+	return __nvme_ns_get_sectors(n, WRITE);
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 8c42edd71..01f7fda86 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -867,6 +867,100 @@ nvme_subsystem_t nvme_ctrl_get_subsystem(nvme_ctrl_t c);
  */
 const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head);
 
+/**
+ * nvme_ns_update_stat() - update the nvme namespace stat
+ * @n:		&nvme_ns_t object
+ * @diffstat:	If set to true then getters return the diff stat otherwise
+ *		return the current absolute stat
+ *
+ * Returns:	0 on success, -1 on error
+ */
+int nvme_ns_update_stat(nvme_ns_t n, bool diffstat);
+
+/**
+ * nvme_ns_reset_stat() - Resets nvme namespace stat
+ * @n:	&nvme_ns_t object
+ *
+ */
+void nvme_ns_reset_stat(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_inflights() - Inflight IOs for nvme_ns_t object
+ *
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Inflight number of IOs
+ */
+unsigned int nvme_ns_get_inflights(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_io_ticks() - Get IO ticks
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Time consumed, in milliseconds, processing I/O requests between
+ *		two stat samples
+ */
+unsigned int nvme_ns_get_io_ticks(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_read_ticks() - Get read I/O ticks
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing read I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_ns_get_read_ticks(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_write_ticks() - Get write I/O ticks
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing write I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_ns_get_write_ticks(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_stat_interval() - Get interval between two stat samples
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Interval, in milliseconds, between collection of two consecutive
+ *		stat samples
+ */
+double nvme_ns_get_stat_interval(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_read_ios() - Get num of read I/Os
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Num of read IOs processed between two stat samples
+ */
+unsigned long nvme_ns_get_read_ios(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_write_ios() - Get num of write I/Os
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Num of write IOs processed between two consecutive stat samples
+ */
+unsigned long nvme_ns_get_write_ios(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_read_sectors() - Get num of read sectors
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Num of sectors read from the device between two stat samples
+ */
+unsigned long long nvme_ns_get_read_sectors(nvme_ns_t n);
+
+/**
+ * nvme_ns_get_write_sectors() - Get num of write sectors
+ * @n:		&nvme_ns_t object
+ *
+ * Return:	Num of sectors written to the device between two stat samples
+ */
+unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n);
+
 /**
  * nvme_ctrl_get_config() - Fabrics configuration of a controller
  * @c:	Controller instance
-- 
2.53.0


