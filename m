Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66A3E88D66
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xp0N5Z8CFexC0NeBIipm67E8NBrfoDiNeuOEM5O00UY=; b=COKApC3afqcJrdblqhhGDgNlN8
	D1jviL5V0riLVqDatuJ583BQdOqds+w9a6tFLOuAlXE1hzqrWtvPvOXeoPMlqO0Gjo/cvn5aV2XCg
	a2UcqCYnh1b+96ZjUIVbYV6GDDviJoq++gdhdCqJrZT/0xj6r8rdEjJAJKxgNE4O4XkbFCPgmmZI1
	7TAn9HmYFD+WYjAG0WLtVTRmvPPEQs73OPicoVP3n28mk6WkWqHna5HGjNAPs67f4DOycJBtlhQcy
	1II7+bZLzAvclQJX8ZJL9tCcC8Cq5kaUsJQILW1M87E9EGvKYy1q2V6T9n+5DmzAil9Oon8yj0iyt
	2+hRExjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2W-00000003MNM-2gVL;
	Sat, 04 Apr 2026 10:15:40 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2U-00000003MLa-2Vfa
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6345StRN3328302;
	Sat, 4 Apr 2026 10:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xp0N5Z8CFexC0NeBI
	ipm67E8NBrfoDiNeuOEM5O00UY=; b=hB8E/R4J5r+/nUOt5+pc4WrKRSD01Bmrc
	WpB7653m7UJ/Tq+SIC9wC2iw95Idpg3KfIkDNTKHGjMVBTqhrkS/h1Ew61kq0uZN
	Uq19O0oGjMSlE1YPlRIx66CSWhNDMfa39unEtyyktAr9KAC5RjzC59pk94zkMbmv
	Ala1SnEFDh15P1b6rKXiPWIAU6WX9HefZ0b4XnLjmPY5TOTGsam7YeQTvSaagzUh
	+tj22evn9KXhcdN1KUwkxRuaQQsGhHv0EQXqbhJNe5fbpzJ55p8E5ZOgqhllgc03
	EXHL3mIgqWPjzc88a8zYxxMZS2l05/RmawlLTk+oO1/bO9rcia8+Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat9r8p6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6348VBDU022165;
	Sat, 4 Apr 2026 10:15:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tanh3qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFTiM22216960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64DFA2004F;
	Sat,  4 Apr 2026 10:15:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 473732004E;
	Sat,  4 Apr 2026 10:15:24 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 4/9] libnvme: add support for retrieving per-path gendisk I/O statistics
Date: Sat,  4 Apr 2026 15:44:54 +0530
Message-ID: <20260404101504.44539-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404101504.44539-1-nilay@linux.ibm.com>
References: <20260404101504.44539-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VlTM_w_XiJcOntHY2zUaLjzyf5yHMRPC
X-Proofpoint-ORIG-GUID: VlTM_w_XiJcOntHY2zUaLjzyf5yHMRPC
X-Authority-Analysis: v=2.4 cv=bLYb4f+Z c=1 sm=1 tr=0 ts=69d0e4c6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VKqWyX67P3A8dFzQtQoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfXxjqk0PVXwi1i
 l3wweGroWhY7Nsml3xxMHEPT7PUyE5v4FhC6wxmiKQ7+SppY/tOZcmoOMjSjog5xwoZIee1JTWq
 7rUN8C6FFCnVz3oWzh/SrgjQ96CkRC9LM3V5GVM+OXhvsKWduCLnppRqgjD4951Dx0SQ2JatNXj
 7SkLPfeSTkFkSKwFfRPBbMJSTNxPDmi5Uxj6B0WrGjiE2KiXyXAT2ihSWBwm/n3NQea0tb0WAqv
 +TD12NYvcKc/EVL2ePmogeO6BgAqudDmYt3dWS9DDHS9qSr+nQ/qslTK53YRtj+WL2k2XvxWrCj
 PaqPARg3qawn09VuKV5xASgzo06/aWPAuLRB9sAIPLlG9BuxrQOSfl5vex35ikhYBlQB+8WSq3B
 bHJPAkCv9CQIZSj2L3Hilfj3DG5IrgZNaALlYjgeGikZB8JCXmx4AKIn21Rz5ZQxlQ/+CLOdZlg
 X/kMkj5+tsg8gGppHYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031538_761765_65214540 
X-CRM114-Status: GOOD (  20.17  )
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
 libnvme/src/libnvme.ld     |  12 ++
 libnvme/src/nvme/private.h |  29 ++++
 libnvme/src/nvme/tree.c    | 268 +++++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h    |  93 +++++++++++++
 4 files changed, 402 insertions(+)

diff --git a/libnvme/src/libnvme.ld b/libnvme/src/libnvme.ld
index 1ff451d3d..53b5f90e5 100644
--- a/libnvme/src/libnvme.ld
+++ b/libnvme/src/libnvme.ld
@@ -144,6 +144,18 @@ LIBNVME_3 {
 		nvme_path_get_queue_depth;
 		nvme_path_get_ana_state;
 		nvme_path_get_numa_nodes;
+		nvme_path_get_stat;
+		nvme_path_get_read_ios;
+		nvme_path_get_write_ios;
+		nvme_path_get_inflights;
+		nvme_path_get_stat_interval;
+		nvme_path_get_io_ticks;
+		nvme_path_get_read_ticks;
+		nvme_path_get_write_ticks;
+		nvme_path_get_read_sectors;
+		nvme_path_get_write_sectors;
+		nvme_path_reset_stat;
+		nvme_path_update_stat;
 		nvme_random_uuid;
 		nvme_read_config;
 		nvme_read_hostid;
diff --git a/libnvme/src/nvme/private.h b/libnvme/src/nvme/private.h
index 0b8dec81e..2e8e792b9 100644
--- a/libnvme/src/nvme/private.h
+++ b/libnvme/src/nvme/private.h
@@ -20,6 +20,7 @@
 
 #include <nvme/fabrics.h>
 #include <nvme/mi.h>
+#include <nvme/tree.h>
 
 const char *nvme_subsys_sysfs_dir(void);
 const char *nvme_ctrl_sysfs_dir(void);
@@ -128,10 +129,38 @@ struct nvme_transport_handle {
 	struct nvme_log *log;
 };
 
+enum stat_group {
+	READ = 0,
+	WRITE,
+	DISCARD,
+	FLUSH,
+
+	NR_STAT_GROUPS
+};
+
+struct nvme_stat {
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
 struct nvme_path { /*!generate-accessors*/
 	struct list_node entry;
 	struct list_node nentry;
 
+	struct nvme_stat stat[2];	/* gendisk I/O stat */
+	unsigned int curr_idx;		/* current index into the stat[] */
+	bool diffstat;
+
 	struct nvme_ctrl *c;
 	struct nvme_ns *n;
 
diff --git a/libnvme/src/nvme/tree.c b/libnvme/src/nvme/tree.c
index ac3779dca..b5f8c219d 100644
--- a/libnvme/src/nvme/tree.c
+++ b/libnvme/src/nvme/tree.c
@@ -16,6 +16,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <time.h>
 
 #include <arpa/inet.h>
 #include <netdb.h>
@@ -851,6 +852,273 @@ __public char *nvme_path_get_numa_nodes(nvme_path_t p)
 	return p->numa_nodes;
 }
 
+static nvme_stat_t nvme_path_get_stat(nvme_path_t p, unsigned int idx)
+{
+	if (idx > 1)
+		return NULL;
+
+	return &p->stat[idx];
+}
+
+__public void nvme_path_reset_stat(nvme_path_t p)
+{
+	nvme_stat_t stat = &p->stat[0];
+
+	memset(stat, 0, 2 * sizeof(struct nvme_stat));
+}
+
+static int nvme_update_stat(const char *sysfs_stat_path, nvme_stat_t stat)
+{
+	int n;
+	struct timespec ts;
+	unsigned long rd_ios, rd_merges, wr_ios, wr_merges;
+	unsigned long dc_ios, dc_merges, fl_ios;
+	unsigned long long rd_sectors, wr_sectors, dc_sectors;
+	unsigned int rd_ticks, wr_ticks, dc_ticks, fl_ticks;
+	unsigned int io_ticks, tot_ticks, inflights;
+
+	memset(stat, 0, sizeof(struct nvme_stat));
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
+__public int nvme_path_update_stat(nvme_path_t p, bool diffstat)
+{
+	_cleanup_free_ char *sysfs_stat_path = NULL;
+	nvme_stat_t stat;
+
+	p->diffstat = diffstat;
+	p->curr_idx ^= 1;
+	stat = nvme_path_get_stat(p, p->curr_idx);
+	if (!stat)
+		return -EINVAL;
+
+	sysfs_stat_path = nvme_get_path_attr(p, "stat");
+	if (!sysfs_stat_path)
+		return -EINVAL;
+
+	return nvme_update_stat(sysfs_stat_path, stat);
+}
+
+static int nvme_stat_get_inflights(nvme_stat_t stat)
+{
+	return stat->inflights;
+}
+
+__public unsigned int nvme_path_get_inflights(nvme_path_t p)
+{
+	nvme_stat_t curr;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	if (!curr)
+		return 0;
+
+	return nvme_stat_get_inflights(curr);
+}
+
+static int nvme_stat_get_io_ticks(nvme_stat_t curr, nvme_stat_t prev,
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
+__public unsigned int nvme_path_get_io_ticks(nvme_path_t p)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	prev = nvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_io_ticks(curr, prev, p->diffstat);
+}
+
+static unsigned int nvme_stat_get_ticks(nvme_stat_t curr,
+		nvme_stat_t prev, enum stat_group grp, bool diffstat)
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
+static unsigned int __nvme_path_get_ticks(nvme_path_t p, enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	prev = nvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ticks(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned int nvme_path_get_read_ticks(nvme_path_t p)
+{
+	return __nvme_path_get_ticks(p, READ);
+}
+
+__public unsigned int nvme_path_get_write_ticks(nvme_path_t p)
+{
+	return __nvme_path_get_ticks(p, WRITE);
+}
+
+static double nvme_stat_get_interval(nvme_stat_t curr, nvme_stat_t prev)
+{
+	double delta = 0.0;
+
+	if (prev->ts_ms && curr->ts_ms > prev->ts_ms)
+		delta = curr->ts_ms - prev->ts_ms;
+
+	return delta;
+}
+
+__public double nvme_path_get_stat_interval(nvme_path_t p)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	prev = nvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_interval(curr, prev);
+}
+
+static unsigned long nvme_stat_get_ios(nvme_stat_t curr, nvme_stat_t prev,
+		enum stat_group grp, bool diffstat)
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
+static unsigned long __nvme_path_get_ios(nvme_path_t p, enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	prev = nvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_ios(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned long nvme_path_get_read_ios(nvme_path_t p)
+{
+	return __nvme_path_get_ios(p, READ);
+}
+
+__public unsigned long nvme_path_get_write_ios(nvme_path_t p)
+{
+	return __nvme_path_get_ios(p, WRITE);
+}
+
+static unsigned long long nvme_stat_get_sectors(nvme_stat_t curr,
+		nvme_stat_t prev, enum stat_group grp, bool diffstat)
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
+static unsigned long long __nvme_path_get_sectors(nvme_path_t p,
+		enum stat_group grp)
+{
+	nvme_stat_t curr, prev;
+
+	curr = nvme_path_get_stat(p, p->curr_idx);
+	prev = nvme_path_get_stat(p, !p->curr_idx);
+
+	if (!curr || !prev)
+		return 0;
+
+	return nvme_stat_get_sectors(curr, prev, grp, p->diffstat);
+}
+
+__public unsigned long long nvme_path_get_read_sectors(nvme_path_t p)
+{
+	return __nvme_path_get_sectors(p, READ);
+}
+
+__public unsigned long long nvme_path_get_write_sectors(nvme_path_t p)
+{
+	return __nvme_path_get_sectors(p, WRITE);
+}
+
 void nvme_free_path(struct nvme_path *p)
 {
 	list_del_init(&p->entry);
diff --git a/libnvme/src/nvme/tree.h b/libnvme/src/nvme/tree.h
index 39d715508..8c42edd71 100644
--- a/libnvme/src/nvme/tree.h
+++ b/libnvme/src/nvme/tree.h
@@ -23,6 +23,7 @@
 typedef struct nvme_ns *nvme_ns_t;
 typedef struct nvme_ns_head *nvme_ns_head_t;
 typedef struct nvme_path *nvme_path_t;
+typedef struct nvme_stat *nvme_stat_t;
 typedef struct nvme_ctrl *nvme_ctrl_t;
 typedef struct nvme_subsystem *nvme_subsystem_t;
 typedef struct nvme_host *nvme_host_t;
@@ -719,6 +720,98 @@ nvme_ctrl_t nvme_path_get_ctrl(nvme_path_t p);
  */
 nvme_ns_t nvme_path_get_ns(nvme_path_t p);
 
+/**
+ * nvme_path_reset_stat() - Resets namespace path nvme stat
+ * @p:	&nvme_path_t object
+ */
+void nvme_path_reset_stat(nvme_path_t p);
+
+/**
+ * nvme_path_update_stat() - Update stat of an nvme_path_t object
+ * @p:		&nvme_path_t object
+ * @diffstat:	If set to true then getters return the diff stat otherwise
+ *		return the current absolute stat
+ *
+ * Return:	0 on success, -1 on error
+ */
+int nvme_path_update_stat(nvme_path_t p, bool diffstat);
+
+/**
+ * nvme_path_get_read_ios() - Calculate and return read IOs
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Num of read IOs processed between two stat samples
+ */
+unsigned long nvme_path_get_read_ios(nvme_path_t p);
+
+/**
+ * nvme_path_get_write_ios() - Get write I/Os
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Num of write I/Os processed between two stat samples
+ */
+unsigned long nvme_path_get_write_ios(nvme_path_t p);
+
+/**
+ * nvme_path_get_read_ticks() - Get read I/O ticks
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing read I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_path_get_read_ticks(nvme_path_t p);
+
+/**
+ * nvme_path_get_read_sectors() - Get read I/O sectors
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Number of sectors read from the device between two stat samples
+ */
+unsigned long long nvme_path_get_read_sectors(nvme_path_t p);
+
+/**
+ * nvme_path_get_write_sectors() - Get write I/O sectors
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Num of sectors written to the device between two stat samples
+ */
+unsigned long long nvme_path_get_write_sectors(nvme_path_t p);
+
+/**
+ * nvme_path_get_write_ticks() - Get write I/O ticks
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Time, in milliseconds, sepnt processing write I/O requests
+ *		between two stat samples
+ */
+unsigned int nvme_path_get_write_ticks(nvme_path_t p);
+
+/**
+ * nvme_path_get_stat_interval() - Get interval between two stat samples
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Interval, in milliseconds between collection of two consecutive
+ *		stat samples
+ */
+double nvme_path_get_stat_interval(nvme_path_t p);
+
+/**
+ * nvme_path_get_io_ticks() - Get I/O ticks
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Time consumed, in milliseconds, processing I/O requests between
+ *		two stat samples
+ */
+unsigned int nvme_path_get_io_ticks(nvme_path_t p);
+
+/**
+ * nvme_path_get_inflights() - Inflight IOs for nvme_path_t object
+ * @p:		&nvme_path_t object
+ *
+ * Return:	Inflight number of IOs
+ */
+unsigned int nvme_path_get_inflights(nvme_path_t p);
+
 /**
  * nvme_ctrl_get_transport_handle() - Get associated transport handle
  * @c:	Controller instance
-- 
2.53.0


