Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91566109448A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHc0JXvGSCZR+hHPMSdFUl+Z9nYV1hezdrRYtYgUiu0=; b=CBGTyJ8DGL+BT1vUUbrVS+gJ1w
	T1eTkFd/ztE/QBfzZau9N1jeGV+RKqFJLvYUczt3/InI41ke6gK6VpFDEtjxvGqMpLaqCmHRH/kbW
	hOjvguiLmRbtYLfNHIpwZcJ1LLtWhj8Ds9xTOkVBkwhyr+X1q0ij9UfO4/8zEtV52UMqKHm5csuou
	OoYOE/1OcXYKtD8i/MwGfsOljnMLi0UdVD+NkFdC76t4oED1zT4ghuwc1EIV8SnupUY5daIov4Vhu
	mt+rxgc/E5646L4WgUJ/pO6jg8T5EUwNcdLgGYJAp3uP9K5hjRNh1LUjKJXtrm32k9RHhDioi+rL9
	o10IRoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG8-0000000Ea9U-3MBJ;
	Sat, 21 Mar 2026 15:29:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yG6-0000000Ea7K-2Bmt
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:29:03 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAT61o681558;
	Sat, 21 Mar 2026 15:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nHc0JXvGSCZR+hHPM
	SdFUl+Z9nYV1hezdrRYtYgUiu0=; b=Z0PK2Q8k7bfGysDB3jcYKKwoS9Pj8HWsT
	bO44SDYvIO3sKyWmy5IiWhFUjqG0byiQ7HJcJ4tn5Ow95Zh/uBOMvkpmpXRgA/y+
	VMKxfh/9+UKb0SkhGg04jtY48kdB0hz8d8cG9HOTtvA2l7jUAtYTVlw+TIG8idDd
	pO2KAEGnL9tjs2BmHHp4brojv6aq80LEkXLezIvItQJkYCrDFLuV1Xb6wMRbrII8
	EWVhXTWIsKVjWq88F1loj5ULrI9gOL75dCRCCkRYNbJkUOcRWwC7+fYhwiibGHFV
	jvwxm/tOdQGsSio5ruPo5omyhj+kgu1kmFfLoEt0q8ha+oY5IL0QA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kum96tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LADMR9016729;
	Sat, 21 Mar 2026 15:28:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7kbsp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSsKg26345824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B2A72004B;
	Sat, 21 Mar 2026 15:28:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B01B520040;
	Sat, 21 Mar 2026 15:28:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 5/9] libnvme: add support for retrieving namespace gendisk I/O statistics
Date: Sat, 21 Mar 2026 20:58:04 +0530
Message-ID: <20260321152823.3197870-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321152823.3197870-1-nilay@linux.ibm.com>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZpkzOzH68mXC2-Y31Zh14AEef0IeehD
X-Proofpoint-ORIG-GUID: 4ZpkzOzH68mXC2-Y31Zh14AEef0IeehD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX85+tE4qzABrg
 tpJpa6ZmJUdm1Jp4fbsUymxsxix+fbw8ujNwJyjh5iWC9pWXbfnPr+3+/s6zNwpUfv3Sd3VFoZW
 jUKZSYCQZjyB5qWbF6kCT1mTWjg9bdYV6T0Q8QlBhX6o9f7cUANXWOx5ergyzaJxZ3qa4quvHEO
 lOtIraSm14wEYx/Lzoo7f8sI796adVo2qPY0zZYqmHtwicdMkalKRYqFIqTS9qN9Ta2UeJIgrO7
 b3zQt8huJ9WDs9AidcbFLp2pWoF8yF1fBG1xbtfXNv89HN21HXAAQtJDNx/sRBrObHH0xT1mo8I
 6KIldHMj5dSpWuhGUfXBKMUAKHQ1iDhVAtS5sdMXCTcp758XsWmAjixtBGAQGag7BpFHk2pMzIi
 coa4OA389IyYzewwsbkjYrypLhFKa+8wxBo+KlHREhhCOdR51CoI1rULzea64NB4oYf6tepOSu6
 K1VRZXxNxcQOwlbWynA==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69beb93a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=WQuWWZ3jd7PpZNxpb4gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082902_684419_C08FB981 
X-CRM114-Status: GOOD (  19.24  )
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
 libnvme/src/nvme/private.h |   3 +
 libnvme/src/nvme/tree.c    | 140 +++++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    | 102 +++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index ceb9f9bcb..c9550240d 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -130,6 +130,17 @@ LIBNVME_3 {
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
 		nvme_rescan_ns;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 8e327f1e2..858759a1b 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -184,6 +184,9 @@ struct nvme_ns { /*!generate-accessors*/
 	struct nvme_ns_head *head;
 
 	struct nvme_global_ctx *ctx;
+
+	struct nvme_stat stat[2];
+
 	struct nvme_transport_handle *hdl;
 	__u32 nsid;
 	char *name;
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 94f900307..3ad483557 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -866,6 +866,21 @@ __public void nvme_path_reset_stat(nvme_path_t p)
 	memset(stat, 0, 2 * sizeof(struct nvme_stat));
 }
 
+static nvme_stat_t nvme_ns_get_stat(nvme_ns_t n, int curr)
+{
+	if (curr < 0 || curr > 1)
+		return NULL;
+
+	return &n->stat[curr];
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
@@ -938,6 +953,22 @@ __public int nvme_path_update_stat(nvme_path_t p, int curr)
 	return nvme_update_stat(sysfs_stat_path, stat);
 }
 
+__public int nvme_ns_update_stat(nvme_ns_t n, int curr)
+{
+	_cleanup_free_ char *sysfs_stat_path = NULL;
+	nvme_stat_t stat;
+
+	stat = nvme_ns_get_stat(n, curr);
+	if (!stat)
+		return -1;
+
+	sysfs_stat_path = nvme_get_ns_attr(n, "stat");
+	if (!sysfs_stat_path)
+		return -1;
+
+	return nvme_update_stat(sysfs_stat_path, stat);
+}
+
 static int nvme_stat_get_inflights(nvme_stat_t stat)
 {
 	return stat->inflights;
@@ -954,6 +985,17 @@ __public unsigned int nvme_path_get_inflights(nvme_path_t p, int this)
 	return nvme_stat_get_inflights(curr);
 }
 
+__public unsigned int nvme_ns_get_inflights(nvme_ns_t n, int this)
+{
+	nvme_stat_t curr;
+
+	curr = nvme_ns_get_stat(n, this);
+	if (!curr)
+		return 0;
+
+	return nvme_stat_get_inflights(curr);
+}
+
 static int nvme_stat_get_io_ticks(nvme_stat_t curr, nvme_stat_t prev)
 {
 	unsigned int delta = 0;
@@ -977,6 +1019,19 @@ __public unsigned int nvme_path_get_io_ticks(nvme_path_t p, int this)
 	return nvme_stat_get_io_ticks(curr, prev);
 }
 
+__public unsigned int nvme_ns_get_io_ticks(nvme_ns_t n, int this)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, this);
+	prev = nvme_ns_get_stat(n, !this);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_io_ticks(curr, prev);
+}
+
 static unsigned int nvme_stat_get_ticks(nvme_stat_t curr,
 		nvme_stat_t prev, enum stat_group grp)
 {
@@ -1012,6 +1067,30 @@ __public unsigned int nvme_path_get_write_ticks(nvme_path_t p, int curr)
 	return __nvme_path_get_ticks(p, WRITE, curr);
 }
 
+static unsigned int __nvme_ns_get_ticks(nvme_ns_t n,
+		enum stat_group grp, int this)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, this);
+	prev = nvme_ns_get_stat(n, !this);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ticks(curr, prev, grp);
+}
+
+__public unsigned int nvme_ns_get_read_ticks(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_ticks(n, READ, curr);
+}
+
+__public unsigned int nvme_ns_get_write_ticks(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_ticks(n, WRITE, curr);
+}
+
 static double nvme_stat_get_interval(nvme_stat_t curr, nvme_stat_t prev)
 {
 	double delta = 0.0;
@@ -1035,6 +1114,19 @@ __public double nvme_path_get_stat_interval(nvme_path_t p, int this)
 	return nvme_stat_get_interval(curr, prev);
 }
 
+__public double nvme_ns_get_stat_interval(nvme_ns_t n, int this)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, this);
+	prev = nvme_ns_get_stat(n, !this);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_interval(curr, prev);
+}
+
 static unsigned long nvme_stat_get_ios(nvme_stat_t curr, nvme_stat_t prev,
 		enum stat_group grp)
 {
@@ -1070,6 +1162,30 @@ __public unsigned long nvme_path_get_write_ios(nvme_path_t p, int curr)
 	return __nvme_path_get_ios(p, WRITE, curr);
 }
 
+static unsigned long __nvme_ns_get_ios(nvme_ns_t n, enum stat_group grp,
+		int this)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, this);
+	prev = nvme_ns_get_stat(n, !this);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ios(curr, prev, grp);
+}
+
+__public unsigned long nvme_ns_get_read_ios(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_ios(n, READ, curr);
+}
+
+__public unsigned long nvme_ns_get_write_ios(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_ios(n, WRITE, curr);
+}
+
 static unsigned long long nvme_stat_get_sectors(nvme_stat_t curr,
 		nvme_stat_t prev, enum stat_group grp)
 {
@@ -1105,6 +1221,30 @@ __public unsigned long long nvme_path_get_write_sectors(nvme_path_t p, int curr)
 	return __nvme_path_get_sectors(p, WRITE, curr);
 }
 
+static unsigned long long __nvme_ns_get_sectors(nvme_ns_t n,
+		enum stat_group grp, int this)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_ns_get_stat(n, this);
+	prev = nvme_ns_get_stat(n, !this);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_sectors(curr, prev, grp);
+}
+
+__public unsigned long long nvme_ns_get_read_sectors(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_sectors(n, READ, curr);
+}
+
+__public unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n, int curr)
+{
+	return __nvme_ns_get_sectors(n, WRITE, curr);
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 3924e061a..c69d0c8a0 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -876,6 +876,108 @@ nvme_subsystem_t nvme_ctrl_get_subsystem(nvme_ctrl_t c);
  */
 const char *nvme_ns_head_get_sysfs_dir(nvme_ns_head_t head);
 
+/**
+ * nvme_ns_update_stat() - update the nvme namespace stat
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Returns:	0 on success, -1 on error
+ */
+int nvme_ns_update_stat(nvme_ns_t n, int curr);
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
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Inflight number of IOs
+ */
+unsigned int nvme_ns_get_inflights(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_io_ticks() - Get IO ticks
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Time consumed, in milliseconds, processing I/O requests between
+ *		two stat samples
+ */
+unsigned int nvme_ns_get_io_ticks(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_read_ticks() - Get read I/O ticks
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing read I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_ns_get_read_ticks(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_write_ticks() - Get write I/O ticks
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing write I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_ns_get_write_ticks(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_stat_interval() - Get interval between two stat samples
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Interval, in milliseconds, between collection of two consecutive
+ *		stat samples
+ */
+double nvme_ns_get_stat_interval(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_read_ios() - Get num of read I/Os
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Num of read IOs processed between two stat samples
+ */
+unsigned long nvme_ns_get_read_ios(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_write_ios() - Get num of write I/Os
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Num of write IOs processed between two consecutive stat samples
+ */
+unsigned long nvme_ns_get_write_ios(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_read_sectors() - Get num of read sectors
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Num of sectors read from the device between two stat samples
+ */
+unsigned long long nvme_ns_get_read_sectors(nvme_ns_t n, int curr);
+
+/**
+ * nvme_ns_get_write_sectors() - Get num of write sectors
+ * @n:		&nvme_ns_t object
+ * @curr:	Index in nvme_ns_stat_t object
+ *
+ * Return:	Num of sectors written to the device between two stat samples
+ */
+unsigned long long nvme_ns_get_write_sectors(nvme_ns_t n, int curr);
+
 /**
  * nvme_ctrl_get_config() - Fabrics configuration of a controller
  * @c:	Controller instance
-- 
2.53.0


