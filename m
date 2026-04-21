Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5357EF8FA8D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hY+r6OoTCkl2CK+BlJdXcpiXmfVzDygRwwOasA1rGgw=; b=AR6b7QV1f+d9uwf4Kwq5Gi2+bO
	pYv+seQO73MzaZIoOpOB6k/yRxdZy711j3czKYU2jKQD6Fe9Q/pRYJoDWyi7TuKiuycHLxoWLa7iS
	dv/a6JCSmViXlTnuw4ywyOF3bP8NwutzsrohQUqlvLbv/WLLzTAw9/Pg/o6rRamWng6dwE1MsIdMp
	QACn++/3zb5meKnDTCBBSm20OXV3gJPTfoSC0ETrGpyTtHkLCr0uN4Q1DGwfSIo8QKXZQPicGZsl6
	gwN/f+B3yq/NXsZSg7JrEOMzXaP76Tz4kWsBv97w53F+wljT7ueeSQ6SBEF1VAv0SzZPah4RBXRte
	wvX+pu2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRQ-00000008lmJ-0fgO;
	Tue, 21 Apr 2026 14:51:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRM-00000008lkG-350h
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:51:06 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LC6NqS1536075;
	Tue, 21 Apr 2026 14:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hY+r6OoTCkl2CK+Bl
	JdXcpiXmfVzDygRwwOasA1rGgw=; b=TmHpxfH7WHayvVT766j+tTUqQoB1qWL7U
	9AgWNZyAVXYmNVFbj1iuGBcq5oo/ymdHhPePIawkVWRuJ/GPOJ1y2zVvED9Butjy
	fFfwuDE1/mkxgr42LjI7sTgAHW3CrSNeAanSXOBqicF+TpxGwKbFG8x/PglRV96m
	Lg+3O3bOI/ep31KtTmj8gUZ1XuX4kHilIofTdX5CddUt+nMQx0X9ynjLmFYqRaXO
	Au6fVqysr0d5fdPmU9Rv9pA+ZXZRlcT4yvEHrjlwX1FNvLs5CbmQgDQzR/CBhb0f
	zJ2y5SUIESdzvBQjdhsyUgj19sRHSrRDxIdbG5/YX5R+GobbWHsQA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6m3gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:51:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEgcmn019600;
	Tue, 21 Apr 2026 14:50:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvs7un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEou0X59638212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072BC2004B;
	Tue, 21 Apr 2026 14:50:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6034C20043;
	Tue, 21 Apr 2026 14:50:53 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 4/9] libnvme: add support for retrieving per-path gendisk I/O statistics
Date: Tue, 21 Apr 2026 20:20:25 +0530
Message-ID: <20260421145038.3458987-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421145038.3458987-1-nilay@linux.ibm.com>
References: <20260421145038.3458987-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e78ed4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1AvKEGdgBSwAuF5w29wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX291tPgAws6wf
 kDWeek0ZH2pUtRu/VGCzflC1CarDY0G8PkOzlgVP2AXsyQea3Rns9ag5x+6xnC1WjSG5QhdS8AH
 AprbNdn7K2PERk7gdb58URZiOFJP4s91rwJ2Ozc+p2/TUxdQ2FVWYwgcsxB5k4CI6Pj0cveQt/T
 39ZGq6Uun2ruivwGj/nxQRZhhFhuvJxtR0g0UVEPXsLgDqrHcPbxoEIggo6dZ2fkYzvcQoS74xF
 MUWB66Ow4JaU27t2FcEtuszqvgSWnk9O8pBpaHjG0XB8cyHmGl/f+rin9jF000NnkPDUq1/Vti+
 utjVHgIrD23ElHtTfaNIpLzE3idZ4TnhdGF+psgDBaOqwcEx3JnnKkHF+tv3bEyXJEss9BfmJ+8
 d2wO8bqm6wcI3UJgYzPguYIEyasf0fXBHZrsVDqyMY/BSDcPOz0CBer5cGY5vPZ+WBIm60GGIly
 G3LcNRsRs99cfR10Rwg==
X-Proofpoint-GUID: tQDeXDYQhu1k-aN6iX_YVuDQrsE-pHB5
X-Proofpoint-ORIG-GUID: tQDeXDYQhu1k-aN6iX_YVuDQrsE-pHB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075104_967969_00C2147C 
X-CRM114-Status: GOOD (  21.07  )
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

Add support for retrieving per-path gendisk I/O statistics. Also add
support for computing deltas of these statistics between samples, such
as I/O ticks, number of sectors, and number of serviced I/Os.

These metrics can be used by tools such as nvme-top to display
real-time disk activity. Per-path metrics are particularly useful when
NVMe native multipath is enabled.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 libnvme/src/libnvme.ld     |  11 ++
 libnvme/src/nvme/private.h |  30 ++++
 libnvme/src/nvme/tree.c    | 271 +++++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    |  93 +++++++++++++
 4 files changed, 405 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 1ad02034a..6b7a08cb5 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -141,6 +141,17 @@ LIBNVME_3 {
 		libnvme_path_get_queue_depth;
 		libnvme_path_get_ana_state;
 		libnvme_path_get_numa_nodes;
+		libnvme_path_get_read_ios;
+		libnvme_path_get_write_ios;
+		libnvme_path_get_inflights;
+		libnvme_path_get_stat_interval;
+		libnvme_path_get_io_ticks;
+		libnvme_path_get_read_ticks;
+		libnvme_path_get_write_ticks;
+		libnvme_path_get_read_sectors;
+		libnvme_path_get_write_sectors;
+		libnvme_path_reset_stat;
+		libnvme_path_update_stat;
 		libnvme_random_uuid;
 		libnvme_read_config;
 		libnvme_read_hostid;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 037cde7e2..818303d85 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -15,6 +15,8 @@
 #include "nvme/nvme-types.h"
 #include "nvme/lib-types.h"
 
+#include <nvme/tree.h>
+
 const char *libnvme_subsys_sysfs_dir(void);
 const char *libnvme_ctrl_sysfs_dir(void);
 const char *libnvme_ns_sysfs_dir(void);
@@ -167,10 +169,38 @@ struct libnvme_transport_handle {
 	struct libnvme_log *log;
 };
 
+enum libnvme_stat_group {
+	READ = 0,
+	WRITE,
+	DISCARD,
+	FLUSH,
+
+	NR_STAT_GROUPS
+};
+
+struct libnvme_stat {
+	struct {
+		unsigned long ios;
+		unsigned long merges;
+		unsigned long long sectors;
+		unsigned int ticks;	/* in milliseconds */
+	} group[NR_STAT_GROUPS];
+
+	unsigned int inflights;
+	unsigned int io_ticks;		/* in milliseconds */
+	unsigned int tot_ticks;		/* in milliseconds */
+
+	double ts_ms;			/* timestamp when the stat is updated */
+};
+
 struct libnvme_path { // !generate-accessors
 	struct list_node entry;
 	struct list_node nentry;
 
+	struct libnvme_stat stat[2];	/* gendisk I/O stat */
+	unsigned int curr_idx;		/* current index into the stat[] */
+	bool diffstat; //!accessors:none
+
 	struct libnvme_ctrl *c;
 	struct libnvme_ns *n;
 
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index 9e8c18da4..6a05ae994 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <time.h>
 
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -884,6 +885,276 @@ __public char *libnvme_path_get_numa_nodes(libnvme_path_t p)
 	return p->numa_nodes;
 }
 
+static libnvme_stat_t libnvme_path_get_stat(libnvme_path_t p, unsigned int idx)
+{
+	if (idx > 1)
+		return NULL;
+
+	return &p->stat[idx];
+}
+
+__public void libnvme_path_reset_stat(libnvme_path_t p)
+{
+	libnvme_stat_t stat = &p->stat[0];
+
+	memset(stat, 0, 2 * sizeof(struct libnvme_stat));
+}
+
+static int libnvme_update_stat(const char *sysfs_stat_path, libnvme_stat_t stat)
+{
+	int n;
+	struct timespec ts;
+	unsigned long rd_ios, rd_merges, wr_ios, wr_merges;
+	unsigned long dc_ios, dc_merges, fl_ios;
+	unsigned long long rd_sectors, wr_sectors, dc_sectors;
+	unsigned int rd_ticks, wr_ticks, dc_ticks, fl_ticks;
+	unsigned int io_ticks, tot_ticks, inflights;
+
+	memset(stat, 0, sizeof(struct libnvme_stat));
+
+	n = sscanf(sysfs_stat_path,
+		"%lu %lu %llu %u %lu %lu %llu %u %u %u %u %lu %lu %llu %u %lu %u",
+		&rd_ios, &rd_merges, &rd_sectors, &rd_ticks,
+		&wr_ios, &wr_merges, &wr_sectors, &wr_ticks,
+		&inflights, &io_ticks, &tot_ticks,
+		&dc_ios, &dc_merges, &dc_sectors, &dc_ticks,
+		&fl_ios, &fl_ticks);
+
+	if (n < 17)
+		return -EINVAL;
+
+	/* update read stat */
+	stat->group[READ].ios = rd_ios;
+	stat->group[READ].merges = rd_merges;
+	stat->group[READ].sectors = rd_sectors;
+	stat->group[READ].ticks = rd_ticks;
+
+	/* update write stat */
+	stat->group[WRITE].ios = wr_ios;
+	stat->group[WRITE].merges = wr_merges;
+	stat->group[WRITE].sectors = wr_sectors;
+	stat->group[WRITE].ticks = wr_ticks;
+
+	/* update inflight counters and ticks */
+	stat->inflights = inflights;
+	stat->io_ticks = io_ticks;
+	stat->tot_ticks = tot_ticks;
+
+	/* update discard stat */
+	stat->group[DISCARD].ios = dc_ios;
+	stat->group[DISCARD].merges = dc_merges;
+	stat->group[DISCARD].sectors = dc_sectors;
+	stat->group[DISCARD].ticks = dc_ticks;
+
+	/* update flush stat */
+	stat->group[FLUSH].ios = fl_ios;
+	stat->group[FLUSH].ticks = fl_ticks;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	stat->ts_ms = ts.tv_sec * 1000 + (double)ts.tv_nsec / 1e6;
+
+	return 0;
+}
+
+__public int libnvme_path_update_stat(libnvme_path_t p, bool diffstat)
+{
+	__cleanup_free char *sysfs_stat_path = NULL;
+	libnvme_stat_t stat;
+
+	p->diffstat = diffstat;
+	p->curr_idx ^= 1;
+	stat = libnvme_path_get_stat(p, p->curr_idx);
+	if (!stat)
+		return -EINVAL;
+
+	sysfs_stat_path = libnvme_get_path_attr(p, "stat");
+	if (!sysfs_stat_path)
+		return -EINVAL;
+
+	return libnvme_update_stat(sysfs_stat_path, stat);
+}
+
+static int libnvme_stat_get_inflights(libnvme_stat_t stat)
+{
+	return stat->inflights;
+}
+
+__public unsigned int libnvme_path_get_inflights(libnvme_path_t p)
+{
+	libnvme_stat_t curr;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	if (!curr)
+		return 0;
+
+	return libnvme_stat_get_inflights(curr);
+}
+
+static int libnvme_stat_get_io_ticks(libnvme_stat_t curr, libnvme_stat_t prev,
+		bool diffstat)
+{
+	unsigned int delta = 0;
+
+	if (!diffstat)
+		return curr->io_ticks;
+
+	if (curr->io_ticks > prev->io_ticks)
+		delta = curr->io_ticks - prev->io_ticks;
+
+	return delta;
+}
+
+__public unsigned int libnvme_path_get_io_ticks(libnvme_path_t p)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	prev = libnvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_io_ticks(curr, prev, p->diffstat);
+}
+
+static unsigned int libnvme_stat_get_ticks(libnvme_stat_t curr,
+		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
+{
+	unsigned int delta = 0;
+
+	if (!diffstat)
+		return curr->group[grp].ticks;
+
+	if (curr->group[grp].ticks > prev->group[grp].ticks)
+		delta = curr->group[grp].ticks - prev->group[grp].ticks;
+
+	return delta;
+}
+
+static unsigned int __libnvme_path_get_ticks(libnvme_path_t p,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	prev = libnvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_ticks(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned int libnvme_path_get_read_ticks(libnvme_path_t p)
+{
+	return __libnvme_path_get_ticks(p, READ);
+}
+
+__public unsigned int libnvme_path_get_write_ticks(libnvme_path_t p)
+{
+	return __libnvme_path_get_ticks(p, WRITE);
+}
+
+static double libnvme_stat_get_interval(libnvme_stat_t curr,
+		libnvme_stat_t prev)
+{
+	double delta = 0.0;
+
+	if (prev->ts_ms && curr->ts_ms > prev->ts_ms)
+		delta = curr->ts_ms - prev->ts_ms;
+
+	return delta;
+}
+
+__public double libnvme_path_get_stat_interval(libnvme_path_t p)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	prev = libnvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_interval(curr, prev);
+}
+
+static unsigned long libnvme_stat_get_ios(libnvme_stat_t curr,
+		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
+{
+	unsigned long ios = 0;
+
+	if (!diffstat)
+		return curr->group[grp].ios;
+
+	if (curr->group[grp].ios > prev->group[grp].ios)
+		ios = curr->group[grp].ios - prev->group[grp].ios;
+
+	return ios;
+}
+
+static unsigned long __libnvme_path_get_ios(libnvme_path_t p,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	prev = libnvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_ios(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned long libnvme_path_get_read_ios(libnvme_path_t p)
+{
+	return __libnvme_path_get_ios(p, READ);
+}
+
+__public unsigned long libnvme_path_get_write_ios(libnvme_path_t p)
+{
+	return __libnvme_path_get_ios(p, WRITE);
+}
+
+static unsigned long long libnvme_stat_get_sectors(libnvme_stat_t curr,
+		libnvme_stat_t prev, enum libnvme_stat_group grp, bool diffstat)
+{
+	unsigned long long sec = 0;
+
+	if (!diffstat)
+		return curr->group[grp].sectors;
+
+	if (curr->group[grp].sectors > prev->group[grp].sectors)
+		sec = curr->group[grp].sectors - prev->group[grp].sectors;
+
+	return sec;
+}
+
+static unsigned long long __libnvme_path_get_sectors(libnvme_path_t p,
+		enum libnvme_stat_group grp)
+{
+	libnvme_stat_t curr, prev;
+
+	curr = libnvme_path_get_stat(p, p->curr_idx);
+	prev = libnvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return libnvme_stat_get_sectors(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned long long libnvme_path_get_read_sectors(libnvme_path_t p)
+{
+	return __libnvme_path_get_sectors(p, READ);
+}
+
+__public unsigned long long libnvme_path_get_write_sectors(libnvme_path_t p)
+{
+	return __libnvme_path_get_sectors(p, WRITE);
+}
+
 void nvme_free_path(struct libnvme_path *p)
 {
 	if (!p)
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 93140fcb0..b46c3c4c2 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -23,6 +23,7 @@
 typedef struct libnvme_ns *libnvme_ns_t;
 typedef struct libnvme_ns_head *libnvme_ns_head_t;
 typedef struct libnvme_path *libnvme_path_t;
+typedef struct libnvme_stat *libnvme_stat_t;
 typedef struct libnvme_ctrl *libnvme_ctrl_t;
 typedef struct libnvme_subsystem *libnvme_subsystem_t;
 typedef struct libnvme_host *libnvme_host_t;
@@ -700,6 +701,98 @@ libnvme_ctrl_t libnvme_path_get_ctrl(libnvme_path_t p);
  */
 libnvme_ns_t libnvme_path_get_ns(libnvme_path_t p);
 
+/**
+ * libnvme_path_reset_stat() - Resets namespace path nvme stat
+ * @p:	&libnvme_path_t object
+ */
+void libnvme_path_reset_stat(libnvme_path_t p);
+
+/**
+ * libnvme_path_update_stat() - Update stat of an nvme_path_t object
+ * @p:		&libnvme_path_t object
+ * @diffstat:	If set to true then getters return the diff stat otherwise
+ *		return the current absolute stat
+ *
+ * Return:	0 on success, -1 on error
+ */
+int libnvme_path_update_stat(libnvme_path_t p, bool diffstat);
+
+/**
+ * libnvme_path_get_read_ios() - Calculate and return read IOs
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Num of read IOs processed between two stat samples
+ */
+unsigned long libnvme_path_get_read_ios(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_write_ios() - Get write I/Os
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Num of write I/Os processed between two stat samples
+ */
+unsigned long libnvme_path_get_write_ios(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_read_ticks() - Get read I/O ticks
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing read I/O requests
+ *		between two stat samples
+ */
+unsigned int libnvme_path_get_read_ticks(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_read_sectors() - Get read I/O sectors
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Number of sectors read from the device between two stat samples
+ */
+unsigned long long libnvme_path_get_read_sectors(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_write_sectors() - Get write I/O sectors
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Num of sectors written to the device between two stat samples
+ */
+unsigned long long libnvme_path_get_write_sectors(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_write_ticks() - Get write I/O ticks
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing write I/O requests
+ *		between two stat samples
+ */
+unsigned int libnvme_path_get_write_ticks(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_stat_interval() - Get interval between two stat samples
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Interval, in milliseconds between collection of two consecutive
+ *		stat samples
+ */
+double libnvme_path_get_stat_interval(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_io_ticks() - Get I/O ticks
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Time consumed, in milliseconds, processing I/O requests between
+ *		two stat samples
+ */
+unsigned int libnvme_path_get_io_ticks(libnvme_path_t p);
+
+/**
+ * libnvme_path_get_inflights() - Inflight IOs for nvme_path_t object
+ * @p:		&libnvme_path_t object
+ *
+ * Return:	Inflight number of IOs
+ */
+unsigned int libnvme_path_get_inflights(libnvme_path_t p);
+
 /**
  * libnvme_ctrl_get_transport_handle() - Get associated transport handle
  * @c:	Controller instance
-- 
2.53.0


