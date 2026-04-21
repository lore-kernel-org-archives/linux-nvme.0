Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36BDF8FA8C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BUApLUA/OSPrnNGoi4bpvkoR5ExvdH4Q+XcxoGI8m7Y=; b=B0O1kwscYAypczQYORyKDJz6IP
	J+w3B1Mgbm2ShSleNQ2apYQiSInnwznIZ/toZ3vNTUJNxL/u28ot0iALJh+DMKHydtJAmgtnUSv2S
	nV4F6uuW2TRleBJaq2pOXnV/fCyhhBds0vfNN1UCrFef/r5LfCoI6odRPHgASAjogcdZZzetbUUrE
	RTBZPdnL5+KvQi+O8llG16Nlr8EJtXe68MYzbLm0matyd1Y0TOXNQj7rCrbCcg41MfFAxPG1XFoK5
	eX2/xOrVpYAIOmscVtYJK0CPWXa3sG6JIQlu9rOjTK8ZeRX3fqAKlgjZ6MIOHSR9pgHkqLNdZeM6c
	ZquFZgHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRR-00000008lo5-466f;
	Tue, 21 Apr 2026 14:51:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRP-00000008lmG-2o0K
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LC6kwr1685005;
	Tue, 21 Apr 2026 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BUApLUA/OSPrnNGoi
	4bpvkoR5ExvdH4Q+XcxoGI8m7Y=; b=dNVAS75ukK2Rd9VGZQhn2Am8FT7/1UvYw
	SVSQ5tO/9pAecTs5TrrQRBYDXxtxLlEzm7tNIi7Mk1QkkXkrKUFxBqWcJ4weN4Df
	4bjAS1abpWDHrp3eGVC3y1u99KZsHwZnQuNMtC2CZKX5AyaZ0Jos5pUq8DuyiavB
	8aUsNEOAu7qE3rPEdsw1RAqCPihhrbC5JZg9svI1zILeAGwtvnrLFt+jfplsZLWc
	wQFN2rnJzDF7LF5msz+izQ+w8l2sOXKA36vt0B/+jRz0doVleTps9a0ZcHN+AS55
	ASB8/8Z7Pa8zYzhaux5oE+Xo7wq/aGC8L/EG7byW/LM1tQpwAhbpg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6mty8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoPwN022769;
	Tue, 21 Apr 2026 14:51:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k1395-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEowLt31064548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D99CE2004D;
	Tue, 21 Apr 2026 14:50:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C6E320043;
	Tue, 21 Apr 2026 14:50:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 5/9] libnvme: add support for retrieving namespace gendisk I/O statistics
Date: Tue, 21 Apr 2026 20:20:26 +0530
Message-ID: <20260421145038.3458987-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfXwHQ41tOKQWDF
 bSDxP3vmo6LVh0iMIEHK0RKzAnnOvr7QqvHwz+SzNLwePW5TKfWnLp9e6x4B7AoYDrp1wqawqdr
 FZdpFJ+rdpxdnTcBHTVUnWOPQXrRN//oAUDVhqsrApOfyD/Fe1IQSXfTfpSKQxVXcTQOrc3WcY1
 PZW1ecfJsbShaLyJy1Dwy/kA0c3o+nDWHAHTzTYXX4botxEq8sDC4HomTpNnSb2+8GMIxDIYzcK
 zExZ7hbzNa/aE9vCSn1d/YhMsksReYoxhtlWRx42PSfjBPVX0VRp7TTQtzbuwz64rzXGECnVgfR
 5eAQ/q7nht9h7E7jLsZ1yX3F+PyeW5gs6Auq9y4fkgJlmHU/3H4E+Wg+w8iPFIiYMlGqvKqnrq+
 uBLBgXF9RBbf2eRiunxAqpyWRDpQrWbIj7h2zNeTskAhbeoACT5XgfN9E2uHp9WWQTxiQdF1tSC
 QS7WnNmKqkYKc2Gcr9Q==
X-Proofpoint-GUID: ZdVvGzxzCRs24_wE5e-Dcv8lQoIbm-Wj
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e78ed8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OM1K0kNfJ9UEpnq4wSoA:9
X-Proofpoint-ORIG-GUID: ZdVvGzxzCRs24_wE5e-Dcv8lQoIbm-Wj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075107_810459_A696E02A 
X-CRM114-Status: GOOD (  19.82  )
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
 libnvme/src/nvme/tree.c    | 142 +++++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    |  93 ++++++++++++++++++++++++
 4 files changed, 251 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 6b7a08cb5..ce85c960e 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -129,6 +129,17 @@ LIBNVME_3 {
 		libnvme_ns_get_serial;
 		libnvme_ns_get_subsystem;
 		libnvme_ns_get_uuid;
+		libnvme_ns_reset_stat;
+		libnvme_ns_update_stat;
+		libnvme_ns_get_stat_interval;
+		libnvme_ns_get_read_ios;
+		libnvme_ns_get_write_ios;
+		libnvme_ns_get_read_ticks;
+		libnvme_ns_get_write_ticks;
+		libnvme_ns_get_read_sectors;
+		libnvme_ns_get_write_sectors;
+		libnvme_ns_get_inflights;
+		libnvme_ns_get_io_ticks;
 		libnvme_ns_identify;
 		libnvme_ns_read;
 		libnvme_ns_verify;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 818303d85..08b35e002 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -227,6 +227,11 @@ struct libnvme_ns { // !generate-accessors
 	struct libnvme_ns_head *head;
 
 	struct libnvme_global_ctx *ctx;
+
+	struct libnvme_stat stat[2];	/* gendisk I/O stat */
+	unsigned int curr_idx;		/* current index into the stat[] */
+	bool diffstat; //!accessors:none
+
 	struct libnvme_transport_handle *hdl;
 	__u32 nsid;
 	char *name;
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 6a05ae994..ca716bde7 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -900,6 +900,21 @@ __public void libnvme_path_reset_stat(libnvme_path_t p)
 	memset(stat, 0, 2 * sizeof(struct libnvme_stat));
 }
 
+static libnvme_stat_t libnvme_ns_get_stat(libnvme_ns_t n, unsigned int idx)
+{
+	if (idx > 1)
+		return NULL;
+
+	return &n->stat[idx];
+}
+
+__public void libnvme_ns_reset_stat(libnvme_ns_t n)
+{
+	libnvme_stat_t stat = &n->stat[0];
+
+	memset(stat, 0, 2 * sizeof(struct libnvme_stat));
+}
+
 static int libnvme_update_stat(const char *sysfs_stat_path, libnvme_stat_t stat)
 {
 	int n;
@@ -974,6 +989,24 @@ __public int libnvme_path_update_stat(libnvme_path_t p, bool diffstat)
 	return libnvme_update_stat(sysfs_stat_path, stat);
 }
 
+__public int libnvme_ns_update_stat(libnvme_ns_t n, bool diffstat)
+{
+	__cleanup_free char *sysfs_stat_path = NULL;
+	libnvme_stat_t stat;
+
+	n->diffstat = diffstat;
+	n->curr_idx ^= 1;
+	stat = libnvme_ns_get_stat(n, n->curr_idx);
+	if (!stat)
+		return -EINVAL;
+
+	sysfs_stat_path = libnvme_get_ns_attr(n, "stat");
+	if (!sysfs_stat_path)
+		return -EINVAL;
+
+	return libnvme_update_stat(sysfs_stat_path, stat);
+}
+
 static int libnvme_stat_get_inflights(libnvme_stat_t stat)
 {
 	return stat->inflights;
@@ -990,6 +1023,17 @@ __public unsigned int libnvme_path_get_inflights(libnvme_path_t p)
 	return libnvme_stat_get_inflights(curr);
 }
 
+__public unsigned int libnvme_ns_get_inflights(libnvme_ns_t n)
+{
+	libnvme_stat_t curr;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	if (!curr)
+		return 0;
+
+	return libnvme_stat_get_inflights(curr);
+}
+
 static int libnvme_stat_get_io_ticks(libnvme_stat_t curr, libnvme_stat_t prev,
 		bool diffstat)
 {
@@ -1017,6 +1061,19 @@ __public unsigned int libnvme_path_get_io_ticks(libnvme_path_t p)
 	return libnvme_stat_get_io_ticks(curr, prev, p->diffstat);
 }
 
+__public unsigned int libnvme_ns_get_io_ticks(libnvme_ns_t n)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	prev = libnvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_io_ticks(curr, prev, n->diffstat);
+}
+
 static unsigned int libnvme_stat_get_ticks(libnvme_stat_t curr,
 		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
 {
@@ -1055,6 +1112,30 @@ __public unsigned int libnvme_path_get_write_ticks(libnvme_path_t p)
 	return __libnvme_path_get_ticks(p, WRITE);
 }
 
+static unsigned int __libnvme_ns_get_ticks(libnvme_ns_t n,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	prev = libnvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_ticks(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned int libnvme_ns_get_read_ticks(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_ticks(n, READ);
+}
+
+__public unsigned int libnvme_ns_get_write_ticks(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_ticks(n, WRITE);
+}
+
 static double libnvme_stat_get_interval(libnvme_stat_t curr,
 		libnvme_stat_t prev)
 {
@@ -1079,6 +1160,19 @@ __public double libnvme_path_get_stat_interval(libnvme_path_t p)
 	return libnvme_stat_get_interval(curr, prev);
 }
 
+__public double libnvme_ns_get_stat_interval(libnvme_ns_t n)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	prev = libnvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_interval(curr, prev);
+}
+
 static unsigned long libnvme_stat_get_ios(libnvme_stat_t curr,
 		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
 {
@@ -1117,6 +1211,30 @@ __public unsigned long libnvme_path_get_write_ios(libnvme_path_t p)
 	return __libnvme_path_get_ios(p, WRITE);
 }
 
+static unsigned long __libnvme_ns_get_ios(libnvme_ns_t n,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	prev = libnvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_ios(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned long libnvme_ns_get_read_ios(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_ios(n, READ);
+}
+
+__public unsigned long libnvme_ns_get_write_ios(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_ios(n, WRITE);
+}
+
 static unsigned long long libnvme_stat_get_sectors(libnvme_stat_t curr,
 		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
 {
@@ -1155,6 +1273,30 @@ __public unsigned long long libnvme_path_get_write_sectors(libnvme_path_t p)
 	return __libnvme_path_get_sectors(p, WRITE);
 }
 
+static unsigned long long __libnvme_ns_get_sectors(libnvme_ns_t n,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_ns_get_stat(n, n->curr_idx);
+	prev = libnvme_ns_get_stat(n, !n->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_sectors(curr, prev, grp, n->diffstat);
+}
+
+__public unsigned long long libnvme_ns_get_read_sectors(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_sectors(n, READ);
+}
+
+__public unsigned long long libnvme_ns_get_write_sectors(libnvme_ns_t n)
+{
+	return __libnvme_ns_get_sectors(n, WRITE);
+}
+
 void nvme_free_path(struct libnvme_path *p)
 {
 	if (!p)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index b46c3c4c2..a166d9df6 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -853,6 +853,99 @@ libnvme_subsystem_t libnvme_ctrl_get_subsystem(libnvme_ctrl_t c);
  */
 const char *libnvme_ns_head_get_sysfs_dir(libnvme_ns_head_t head);
 
+/**
+ * libnvme_ns_update_stat() - update the nvme namespace stat
+ * @n:		&libnvme_ns_t object
+ * @diffstat:	If set to true then getters return the diff stat otherwise
+ *		return the current absolute stat
+ *
+ * Returns:	0 on success, -1 on error
+ */
+int libnvme_ns_update_stat(libnvme_ns_t n, bool diffstat);
+
+/**
+ * libnvme_ns_reset_stat() - Resets nvme namespace stat
+ * @n:	&libnvme_ns_t object
+ *
+ */
+void libnvme_ns_reset_stat(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_inflights() - Inflight IOs for nvme_ns_t object
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Inflight number of IOs
+ */
+unsigned int libnvme_ns_get_inflights(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_io_ticks() - Get IO ticks
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Time consumed, in milliseconds, processing I/O requests between
+ *		two stat samples
+ */
+unsigned int libnvme_ns_get_io_ticks(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_read_ticks() - Get read I/O ticks
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing read I/O requests
+ *		between two stat samples
+ */
+unsigned int libnvme_ns_get_read_ticks(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_write_ticks() - Get write I/O ticks
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing write I/O requests
+ *		between two stat samples
+ */
+unsigned int libnvme_ns_get_write_ticks(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_stat_interval() - Get interval between two stat samples
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Interval, in milliseconds, between collection of two consecutive
+ *		stat samples
+ */
+double libnvme_ns_get_stat_interval(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_read_ios() - Get num of read I/Os
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Num of read IOs processed between two stat samples
+ */
+unsigned long libnvme_ns_get_read_ios(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_write_ios() - Get num of write I/Os
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Num of write IOs processed between two consecutive stat samples
+ */
+unsigned long libnvme_ns_get_write_ios(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_read_sectors() - Get num of read sectors
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Num of sectors read from the device between two stat samples
+ */
+unsigned long long libnvme_ns_get_read_sectors(libnvme_ns_t n);
+
+/**
+ * libnvme_ns_get_write_sectors() - Get num of write sectors
+ * @n:		&libnvme_ns_t object
+ *
+ * Return:	Num of sectors written to the device between two stat samples
+ */
+unsigned long long libnvme_ns_get_write_sectors(libnvme_ns_t n);
+
 /**
  * libnvme_ctrl_identify() - Issues an 'identify controller' command
  * @c:	Controller instance
-- 
2.53.0


