Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E0CD37B9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b97t8NSV7Tv6eRVdqeYauyFyvZ7FD1cZzQv5meK62F4=; b=yfSmD99KvfNbxwrY0FSlYAozh5
	kwO0992355K8E3dE/qtFetd6hFKxBidWK8A6cKHbViybQGYcodXMxV9c9bP+BiykYSwJLVwL/dw8r
	d0O1w+XzEzkFevYtzttwvxYyKEC/Xxuj+wsCag9w7ao6JHuveA6sDpxcLC4szrYuu4kTjws3/5hq/
	5FeZSpA9RWtswo0YvA6iGhf4XVAOLTZ6HqrXkkfzDYA5WBDdUt1UYG41VU3aJB/lNcgC/rDDh01ta
	a03tr0Z3lwdfyvkbV7dQa6DxfpQ3Xjc+XV9O9anQ67cdi/SZUZg8qdElvR4ywwIlgQuFc2GOQWI1E
	Ywm1ymjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFS-0000000DQJg-0b4p;
	Mon, 11 May 2026 11:56:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFN-0000000DQF8-163e
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:56:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=b97t8NSV7Tv6eRVdqeYauyFyvZ7FD1cZzQv5meK62F4=; b=iXTOHlIa+NvVFFv41kwVIoll0g
	di1ZCtR+n+ChIgmn2wKh850n9yKLF8Ypl7B96RZTMoiFfFel99nlLQoFZLym7P+1f7lIniGDx7HHW
	wmbe4tAx4gOncd9HhxoVGfKImRISZb6FyTA17KlzVBogF4/VyxBRuRcLt+/X6avMEDG0y3JLFuuaB
	UcwmYesASsfr+e2v13S99ZxOC7pjjkIJZ2f2rtnv3T2z9JQunlupP9O07QzC0Hor9GPX1nq3AD93P
	Ow7Sz+GQlppo3HrkMx0PO5hjOvttRRJr2UeI1IVTKQdDmHZnZQMklqBF5apn2atIu8KKQ3pRhByhF
	IhegaxRw==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFH-0000000BXkC-1emu
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:27 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B726LA1930649;
	Mon, 11 May 2026 11:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b97t8NSV7Tv6eRVdq
	eYauyFyvZ7FD1cZzQv5meK62F4=; b=catHnpSRABvFIJa6ZD2vNAraNBGqS3jzM
	a0yZi7W9LV8vJpx1ZBSPgQ/a0YQvTqVv0j9i7F1GSyRO7MVN2gg/0x5I+Qtd/XrU
	/SvlePJoQ9DX86fvOi9feunPd2+Kt8c76x3YjOsPqd6hlOMonYlP5EGsGQmxWwF7
	P8oTru4IHMyrjaQCcLbdvIlaExtwMswjevyzhwpa5kyiItfLuc+htwXSS4W+Vg+r
	YkSwH5pqZAK8/p9TN9NY/rpPPxLaa2Q3EqC38AHgDcJXNwPWnRMC9QjNhnkg2Odu
	wvna7FFjXXsYNkJdS7+Es/x4oARSJha4SHZ4IWoLFMuopTcqC9urg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4r241-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsgFM007985;
	Mon, 11 May 2026 11:56:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jw2t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBuCkj51118462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E4420043;
	Mon, 11 May 2026 11:56:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F5B20040;
	Mon, 11 May 2026 11:56:11 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:56:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 7/7] nvme: add nvme top command
Date: Mon, 11 May 2026 17:25:47 +0530
Message-ID: <20260511115555.2638335-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01c3e2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=lIKFFttWC1pl3Fu8ApQA:9
 a=A0VLD9o6xcAkaYU5:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX1lyFtlAhokUG
 Og9cHE4QRllPCDhZrg8U4Z4MPFgxFaYzGzuLuANantdi9nCx/+CXS67XajaxE4NCUFxeeipNY8o
 MbZwWW9w3E/rPFCyPGIdhKE4g3Kdgd7I7EthIHky2jgtUIDIAO/evqxxIM5j1sABD5GEwBAJm1K
 ua4XF+N0OjZUh75ykrimUJVLcWTaoKtdpS8ZaIz25B2MyecIaCKB/sdhTqMzzl3vYWJU85ybXdq
 ILyvatJ78VXNIJ80+K6aQA89GeR+fNPDoQWrUIbJMJn2lqXx5aMoCv+mgUDr+HL5x/HkJEPxPHS
 xWfv61ZLog2m7BAwJZvQOnAC2wVsVnkCN61K2ZtTATkcUxAPp7tYJ8v8Tmu+iSx9kB/oTbAVpEk
 oPOx1ZRfe7BoM5ZOWN1apfs6iDrfos1Y3muSC2dqmTh5umql0S7IyiSV5GqlPOdNDLzy1aT+ZXE
 ZdmJsmebekoZcTW8XTQ==
X-Proofpoint-GUID: tN_3X20p1t9ljAkDZ4qo-rZFgYUFdyR0
X-Proofpoint-ORIG-GUID: tN_3X20p1t9ljAkDZ4qo-rZFgYUFdyR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125624_911963_9898F102 
X-CRM114-Status: GOOD (  21.82  )
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

Add a new "nvme top" CLI command that provides an interactive,
top-like dashboard for real-time monitoring of NVMe devices and
paths.

The dashboard presents continuously updated information about
NVMe fabrics/PCIe paths and devices, similar in spirit to tools
such as top or iotop. It helps administrators observe device
health, detect path degradation, identify multipath imbalances,
and catch transient failures.

The interface consists of two views:

* Subsystem list view
  Displays all NVMe subsystems present on the system. Users can
  navigate the list using arrow keys and select a subsystem for
  detailed inspection.

* Subsystem detail view
  Shows detailed statistics for the selected subsystem. When
  native multipath is enabled, this includes namespace head
  statistics, path statistics, path health, and controller
  summary. Without multipath, it displays namespace statistics
  and controller summary.

Users can switch between views using the ESC/return key, exit with
'q', and navigate using arrow keys.

This command builds on the generic dashboard framework to provide
a flexible and extensible real-time monitoring interface.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 meson.build         |    1 +
 nvme-builtin.h      |    1 +
 nvme-print-stdout.c | 1206 +++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c        |    5 +
 nvme-print.h        |    5 +-
 nvme-top.c          |  345 +++++++++++++
 nvme-top.h          |   30 ++
 nvme.c              |   39 ++
 8 files changed, 1631 insertions(+), 1 deletion(-)
 create mode 100644 nvme-top.c
 create mode 100644 nvme-top.h

diff --git a/meson.build b/meson.build
index adc8ece7f..ceff6a6d1 100644
--- a/meson.build
+++ b/meson.build
@@ -514,6 +514,7 @@ if want_nvme
             'nvme-rpmb.c',
             'nvme.c',
             'plugin.c',
+            'nvme-top.c',
         ]
 
         if json_c_dep.found()
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 2ebf37fc2..ed08de04c 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -8,6 +8,7 @@
 #include "cmd.h"
 
 COMMAND_LIST(
+	ENTRY("top", "nvme top", top)
 	ENTRY("list", "List all NVMe devices and namespaces on machine", list)
 	ENTRY("list-subsys", "List nvme subsystems", list_subsys)
 	ENTRY("id-ctrl", "Send NVMe Identify Controller", id_ctrl)
diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index b48d92947..4e07071a0 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -5,6 +5,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <signal.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 
@@ -23,9 +26,12 @@
 #include "nvme.h"
 #include "nvme-print.h"
 #include "nvme-models.h"
+#include "nvme-top.h"
 #include "util/suffix.h"
 #include "util/types.h"
 #include "util/table.h"
+#include "util/sighdl.h"
+#include "util/dashboard.h"
 #include "logging.h"
 #include "common.h"
 
@@ -6424,6 +6430,1204 @@ static void stdout_topology_multipath(struct libnvme_global_ctx *ctx)
 	stdout_simple_topology(ctx, NVME_CLI_TOPO_MULTIPATH);
 }
 
+static bool stdout_top_nvme_ctrl_is_fabric(libnvme_ctrl_t c)
+{
+	if (strcmp(libnvme_ctrl_get_transport(c), "pcie"))
+		return true;
+	else
+		return false;
+}
+
+static bool stdout_top_print_ctrl_summary_tbl_filter(const char *name,
+		void *arg)
+{
+	libnvme_ctrl_t c;
+	libnvme_subsystem_t s = arg;
+	bool multipath = nvme_is_multipath(s);
+
+	if (!strcmp(name, "Paths")) {
+		if (!multipath)
+			return false;
+	}
+
+	if (!strcmp(name, "Reconnects")) {
+		c = libnvme_subsystem_first_ctrl(s);
+		if (c) {
+			if (stdout_top_nvme_ctrl_is_fabric(c))
+				return true;
+			else
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static int stdout_top_print_path_health(FILE *stream, libnvme_subsystem_t s)
+{
+	int ret = 0;
+	int col, row;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+	struct table *t;
+	struct table_column columns[] = {
+		{"NSPath", LEFT},
+		{"ANAState", LEFT},
+		{"Retries", LEFT},
+		{"Failovers", LEFT},
+		{"Errors", LEFT}
+	};
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init path health table\n");
+		return 1;
+	}
+
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		nvme_show_error("Failed to add columns to path health table\n");
+		ret = 1;
+		goto free_tbl;
+	}
+
+	fprintf(stream, "\n------------ Path Health -------------\n\n");
+	libnvme_subsystem_for_each_ns(s, n) {
+		libnvme_namespace_for_each_path(n, p) {
+
+			row = table_get_row_id(t);
+			if (row < 0) {
+				nvme_show_error("Failed to add row to path health table\n");
+				goto free_tbl;
+			}
+
+			col = -1;
+
+			table_set_value_str(t, ++col, row,
+			    libnvme_path_get_name(p), LEFT);
+			table_set_value_str(t, ++col, row,
+			    libnvme_path_get_ana_state(p), LEFT);
+			table_set_value_long(t, ++col, row,
+			    libnvme_path_get_command_retry_count(p), LEFT);
+			table_set_value_long(t, ++col, row,
+			    libnvme_path_get_multipath_failover_count(p), LEFT);
+			table_set_value_int(t, ++col, row,
+			    libnvme_path_get_command_error_count(p), LEFT);
+
+			table_add_row(t, row);
+		}
+	}
+
+	table_print_stream(stream, t);
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static int stdout_top_print_ctrl_summary(FILE *stream,
+		libnvme_subsystem_t s, bool multipath)
+{
+	int ret = 0;
+	int row, col, npaths;
+	libnvme_ctrl_t c;
+	libnvme_path_t p;
+	libnvme_ns_t n;
+	double max_util, max_rlat, max_wlat;
+	double r_iops, w_iops, r_bw, w_bw;
+	char r_bw_str[16], w_bw_str[16];
+	char r_iops_str[16], w_iops_str[16];
+	char r_clat_str[16], w_clat_str[16];
+	const char *node;
+	struct table *t;
+	bool is_fabric = false;
+	struct table_column columns[] = {
+		{"Ctrl", LEFT},
+		{"Paths", LEFT},
+		{"Node", LEFT},
+		{"Trtype", LEFT},
+		{"Address", LEFT},
+		{"State", LEFT},
+		{"Resets", LEFT},
+		{"Reconnects", LEFT},
+		{"Errors", LEFT},
+		{"r_IOPS", LEFT},
+		{"w_IOPS", LEFT},
+		{"r_clat", LEFT},
+		{"w_clat", LEFT},
+		{"r_bw", LEFT},
+		{"w_bw", LEFT},
+		{"Util%", LEFT},
+	};
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init ctrl summary table");
+		return 1;
+	}
+
+	if (table_add_columns_filter(t, columns, ARRAY_SIZE(columns),
+		stdout_top_print_ctrl_summary_tbl_filter, (void *)s) < 0) {
+		nvme_show_error("Failed to add columns to ctrl summary table");
+		ret = 1;
+		goto free_tbl;
+	}
+
+	c = libnvme_subsystem_first_ctrl(s);
+	if (c)
+		is_fabric = stdout_top_nvme_ctrl_is_fabric(c);
+
+	fprintf(stream, "\n---------- Controller Summary --------\n\n");
+	libnvme_subsystem_for_each_ctrl(s, c) {
+		npaths = 0;
+		r_iops = w_iops = 0;
+		r_bw = w_bw = 0;
+		max_util = max_rlat = max_wlat = 0;
+
+		row = table_get_row_id(t);
+		if (row < 0) {
+			nvme_show_error("Failed to add row to ctrl summary table");
+			ret = 1;
+			goto free_tbl;
+		}
+
+		if (multipath) {
+			libnvme_ctrl_for_each_path(c, p) {
+
+				/* count num of paths per controller */
+				npaths++;
+
+				nvme_path_calc_aggr_stat(p,
+						&r_iops, &w_iops,
+						&r_bw, &w_bw,
+						&max_rlat, &max_wlat,
+						&max_util);
+			}
+		} else {
+			libnvme_ctrl_for_each_ns(c, n) {
+				nvme_ns_calc_aggr_stat(n,
+						&r_iops, &w_iops,
+						&r_bw, &w_bw,
+						&max_rlat, &max_wlat,
+						&max_util);
+			}
+		}
+
+		nvme_format_iops(r_iops, r_iops_str, sizeof(r_iops_str));
+		nvme_format_iops(w_iops, w_iops_str, sizeof(w_iops_str));
+
+		nvme_format_bw(r_bw, r_bw_str, sizeof(r_bw_str));
+		nvme_format_bw(w_bw, w_bw_str, sizeof(w_bw_str));
+
+		nvme_format_lat(max_rlat, r_clat_str, sizeof(r_clat_str));
+		nvme_format_lat(max_wlat, w_clat_str, sizeof(w_clat_str));
+
+		node = libnvme_ctrl_get_numa_node(c);
+		if (!strcmp(node, "-1"))
+			node = "NUMA_NO_NODE";
+
+		col = -1;
+
+		table_set_value_str(t, ++col, row,
+				libnvme_ctrl_get_name(c), LEFT);
+		if (multipath)
+			table_set_value_int(t, ++col, row, npaths, LEFT);
+
+		table_set_value_str(t, ++col, row, node, LEFT);
+		table_set_value_str(t, ++col, row,
+				libnvme_ctrl_get_transport(c), LEFT);
+		table_set_value_str(t, ++col, row,
+				libnvme_ctrl_get_traddr(c), LEFT);
+		table_set_value_str(t, ++col, row,
+				libnvme_ctrl_get_state(c), LEFT);
+		table_set_value_long(t, ++col, row,
+				libnvme_ctrl_get_reset_count(c), LEFT);
+		if (is_fabric)
+			table_set_value_long(t, ++col, row,
+				libnvme_ctrl_get_reconnect_count(c), LEFT);
+
+		table_set_value_long(t, ++col, row,
+				libnvme_ctrl_get_command_error_count(c), LEFT);
+		table_set_value_str(t, ++col, row, r_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, w_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, r_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, w_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, r_bw_str, LEFT);
+		table_set_value_str(t, ++col, row, w_bw_str, LEFT);
+		table_set_value_double(t, ++col, row, max_util, LEFT);
+
+		table_add_row(t, row);
+	}
+
+	table_print_stream(stream, t);
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static int stdout_top_print_ns_stat(FILE *stream, libnvme_subsystem_t s)
+{
+	int ret = 0;
+	libnvme_ns_t n;
+	libnvme_ctrl_t c;
+	int col, row;
+	unsigned int inflights;
+	double r_iops, w_iops, r_lat, w_lat, r_bw, w_bw, util;
+	char r_bw_str[16], w_bw_str[16];
+	char r_iops_str[16], w_iops_str[16];
+	char r_clat_str[16], w_clat_str[16];
+	struct table *t;
+	struct table_column columns[] = {
+		{"Namespace", LEFT},
+		{"NSID", LEFT},
+		{"Ctrl", LEFT},
+		{"Retries", LEFT},
+		{"Errors", LEFT},
+		{"r_IOPS", LEFT},
+		{"w_IOPS", LEFT},
+		{"r_clat", LEFT},
+		{"w_clat", LEFT},
+		{"r_bw", LEFT},
+		{"w_bw", LEFT},
+		{"Inflights", LEFT},
+		{"Util%", LEFT},
+	};
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init ns stat table\n");
+		return 1;
+	}
+
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		nvme_show_error("Failed to add columns to ns stat table\n");
+		ret = 1;
+		goto free_tbl;
+	}
+
+	fprintf(stream, "----------- Namespace Stat -----------\n\n");
+	libnvme_subsystem_for_each_ctrl(s, c) {
+		libnvme_ctrl_for_each_ns(c, n) {
+			r_iops = r_lat = r_bw = 0;
+			w_iops = w_lat = w_bw = 0;
+			util = inflights = 0;
+
+			nvme_ns_calc_stat(n,
+					&r_iops, &w_iops,
+					&r_lat, &w_lat,
+					&r_bw, &w_bw,
+					&util, &inflights);
+
+			nvme_format_iops(r_iops, r_iops_str,
+					sizeof(r_iops_str));
+			nvme_format_iops(w_iops, w_iops_str,
+					sizeof(w_iops_str));
+
+			nvme_format_bw(r_bw, r_bw_str, sizeof(r_bw_str));
+			nvme_format_bw(w_bw, w_bw_str, sizeof(w_bw_str));
+
+			nvme_format_lat(r_lat, r_clat_str, sizeof(r_clat_str));
+			nvme_format_lat(w_lat, w_clat_str, sizeof(w_clat_str));
+
+			row = table_get_row_id(t);
+			if (row < 0) {
+				nvme_show_error("Failed to add row to ns stat table\n");
+				ret = 1;
+				goto free_tbl;
+			}
+
+			col = -1;
+
+			table_set_value_str(t, ++col, row,
+					libnvme_ns_get_name(n), LEFT);
+			table_set_value_int(t, ++col, row,
+					libnvme_ns_get_nsid(n), LEFT);
+			table_set_value_str(t, ++col, row,
+					libnvme_ctrl_get_name(c), LEFT);
+			table_set_value_long(t, ++col, row,
+				libnvme_ns_get_command_retry_count(n), LEFT);
+			table_set_value_long(t, ++col, row,
+				libnvme_ns_get_command_error_count(n), LEFT);
+			table_set_value_str(t, ++col, row, r_iops_str, LEFT);
+			table_set_value_str(t, ++col, row, w_iops_str, LEFT);
+			table_set_value_str(t, ++col, row, r_clat_str, LEFT);
+			table_set_value_str(t, ++col, row, w_clat_str, LEFT);
+			table_set_value_str(t, ++col, row, r_bw_str, LEFT);
+			table_set_value_str(t, ++col, row, w_bw_str, LEFT);
+			table_set_value_unsigned(t, ++col, row, inflights,
+					LEFT);
+			table_set_value_double(t, ++col, row, util, LEFT);
+
+			table_add_row(t, row);
+		}
+	}
+
+	table_print_stream(stream, t);
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static int stdout_top_print_nshead_stat(FILE *stream, libnvme_subsystem_t s)
+{
+	int ret = 0;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+	double r_iops, w_iops, r_lat, w_lat, r_bw, w_bw, util;
+	unsigned int inflights;
+	int col, row, npaths;
+	char r_iops_str[16], w_iops_str[16];
+	char r_clat_str[16], w_clat_str[16];
+	char r_bw_str[16], w_bw_str[16];
+	struct table *t;
+	struct table_column columns[] = {
+			{"NSHead", LEFT},
+			{"NSID", LEFT},
+			{"Paths", LEFT},
+			{"Requeue-IO", LEFT},
+			{"Fail-IO", LEFT},
+			{"r_IOPS", LEFT},
+			{"w_IOPS", LEFT},
+			{"r_clat", LEFT},
+			{"w_clat", LEFT},
+			{"r_bw", LEFT},
+			{"w_bw", LEFT},
+			{"Inflights", LEFT},
+			{"Util%", LEFT},
+	};
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init nshead stat table\n");
+		return 1;
+	}
+
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		nvme_show_error("Failed to add columns to shead stat table\n");
+		ret = 1;
+		goto free_tbl;
+	}
+
+	fprintf(stream, "------------ NSHead Stat -------------\n\n");
+	libnvme_subsystem_for_each_ns(s, n) {
+		npaths = 0;
+		r_iops = r_lat = r_bw = 0;
+		w_iops = w_lat = w_bw = 0;
+		util = inflights = 0;
+
+		nvme_ns_calc_stat(n,
+				&r_iops, &w_iops,
+				&r_lat, &w_lat,
+				&r_bw, &w_bw,
+				&util, &inflights);
+
+		nvme_format_iops(r_iops, r_iops_str, sizeof(r_iops_str));
+		nvme_format_iops(w_iops, w_iops_str, sizeof(w_iops_str));
+
+		nvme_format_bw(r_bw, r_bw_str, sizeof(r_bw_str));
+		nvme_format_bw(w_bw, w_bw_str, sizeof(w_bw_str));
+
+		nvme_format_lat(r_lat, r_clat_str, sizeof(r_clat_str));
+		nvme_format_lat(w_lat, w_clat_str, sizeof(w_clat_str));
+
+		libnvme_namespace_for_each_path(n, p)
+			npaths++;
+
+		row = table_get_row_id(t);
+		if (row < 0) {
+			nvme_show_error("Failed to add row to nshead stat table\n");
+			ret = 1;
+			goto free_tbl;
+		}
+
+		col = -1;
+
+		table_set_value_str(t, ++col, row, libnvme_ns_get_name(n),
+				LEFT);
+		table_set_value_int(t, ++col, row, libnvme_ns_get_nsid(n),
+				LEFT);
+		table_set_value_int(t, ++col, row, npaths, LEFT);
+		table_set_value_long(t, ++col, row,
+			libnvme_ns_get_requeue_no_usable_path_count(n), LEFT);
+		table_set_value_long(t, ++col, row,
+			libnvme_ns_get_fail_no_available_path_count(n), LEFT);
+		table_set_value_str(t, ++col, row, r_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, w_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, r_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, w_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, r_bw_str, LEFT);
+		table_set_value_str(t, ++col, row, w_bw_str, LEFT);
+		table_set_value_unsigned(t, ++col, row, inflights, LEFT);
+		table_set_value_double(t, ++col, row, util, LEFT);
+
+		table_add_row(t, row);
+	}
+
+	table_print_stream(stream, t);
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static int stdout_top_print_path_perf(FILE *stream, libnvme_subsystem_t s)
+{
+	int ret = 0;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+	libnvme_ctrl_t c;
+	unsigned int inflights;
+	int row, col;
+	double util, r_iops, w_iops, r_lat, w_lat, r_bw, w_bw;
+	char r_iops_str[16], w_iops_str[16];
+	char r_clat_str[16], w_clat_str[16];
+	char r_bw_str[16], w_bw_str[16];
+	bool first;
+	struct table *t;
+	const char *iopolicy = libnvme_subsystem_get_iopolicy(s);
+	struct table_column columns[] = {
+		{"NSHead", LEFT},
+		{"NSID", LEFT},
+		{"NSPath", LEFT},
+		{"Nodes", LEFT},
+		{"Qdepth", LEFT},
+		{"Ctrl", LEFT},
+		{"r_IOPS", LEFT},
+		{"w_IOPS", LEFT},
+		{"r_clat", LEFT},
+		{"w_clat", LEFT},
+		{"r_bw", LEFT},
+		{"w_bw", LEFT},
+		{"Inflights", LEFT},
+		{"Util%", LEFT},
+	};
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init path perf table");
+		return 1;
+	}
+
+	if (table_add_columns_filter(t, columns, ARRAY_SIZE(columns),
+			subsystem_iopolicy_filter, (void *)s) < 0) {
+		nvme_show_error("Failed to add columns to path perf table");
+		ret = 1;
+		goto free_tbl;
+	}
+
+	fprintf(stream, "\n---------- Path Performance ----------\n\n");
+	libnvme_subsystem_for_each_ns(s, n) {
+		first = true;
+		libnvme_namespace_for_each_path(n, p) {
+			r_iops = r_lat = r_bw = 0;
+			w_iops = w_lat = w_bw = 0;
+			util = inflights = 0;
+
+			nvme_path_calc_stat(p,
+					&r_iops, &w_iops,
+					&r_lat, &w_lat,
+					&r_bw, &w_bw,
+					&util, &inflights);
+
+			nvme_format_iops(r_iops, r_iops_str,
+					sizeof(r_iops_str));
+			nvme_format_iops(w_iops, w_iops_str,
+					sizeof(w_iops_str));
+
+			nvme_format_bw(r_bw, r_bw_str, sizeof(r_bw_str));
+			nvme_format_bw(w_bw, w_bw_str, sizeof(w_bw_str));
+
+			nvme_format_lat(r_lat, r_clat_str, sizeof(r_clat_str));
+			nvme_format_lat(w_lat, w_clat_str, sizeof(w_clat_str));
+
+			/* get controller associated with the path */
+			c = libnvme_path_get_ctrl(p);
+
+			row = table_get_row_id(t);
+			if (row < 0) {
+				nvme_show_error("Failed to add row to path perf table");
+				ret = 1;
+				goto free_tbl;
+			}
+
+			/*
+			 * For the first row we print actual NSHead name,
+			 * however, for the subsequent rows we print "arrow"
+			 * ("-->") symbol for NSHead. This "arrow" style makes
+			 * it visually obvious that susequenet entries (if
+			 * present) are a path under the first NSHead.
+			 */
+			col = -1;
+
+			if (first) {
+				table_set_value_str(t, ++col, row,
+						libnvme_ns_get_name(n), LEFT);
+				first = false;
+			} else
+				table_set_value_str(t, ++col, row,
+						"-->", CENTERED);
+
+			table_set_value_int(t, ++col, row,
+					libnvme_ns_get_nsid(n), CENTERED);
+			table_set_value_str(t, ++col, row,
+					libnvme_path_get_name(p), LEFT);
+
+			if (!strcmp(iopolicy, "numa"))
+				table_set_value_str(t, ++col, row,
+				    libnvme_path_get_numa_nodes(p), CENTERED);
+			else if (!strcmp(iopolicy, "queue-depth"))
+				table_set_value_int(t, ++col, row,
+				    libnvme_path_get_queue_depth(p), CENTERED);
+
+			table_set_value_str(t, ++col, row,
+					libnvme_ctrl_get_name(c), LEFT);
+			table_set_value_str(t, ++col, row, r_iops_str, LEFT);
+			table_set_value_str(t, ++col, row, w_iops_str, LEFT);
+			table_set_value_str(t, ++col, row, r_clat_str, LEFT);
+			table_set_value_str(t, ++col, row, w_clat_str, LEFT);
+			table_set_value_str(t, ++col, row, r_bw_str, LEFT);
+			table_set_value_str(t, ++col, row, w_bw_str, LEFT);
+			table_set_value_unsigned(t, ++col, row,
+					inflights, LEFT);
+			table_set_value_double(t, ++col, row, util, LEFT);
+
+			table_add_row(t, row);
+		}
+	}
+	table_print_stream(stream, t);
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static void  stdout_top_print_subsys_topology_config(FILE *stream,
+		libnvme_subsystem_t s)
+{
+	int len = strlen(libnvme_subsystem_get_name(s));
+
+	fprintf(stream, "%s - NQN=%s\n", libnvme_subsystem_get_name(s),
+		libnvme_subsystem_get_subsysnqn(s));
+	fprintf(stream, "%*s   hostnqn=%s\n", len, " ",
+		libnvme_host_get_hostnqn(libnvme_subsystem_get_host(s)));
+	fprintf(stream, "%*s   iopolicy=%s\n", len, " ",
+		libnvme_subsystem_get_iopolicy(s));
+
+	fprintf(stream, "%*s   model=%s\n", len, " ",
+		libnvme_subsystem_get_model(s));
+	fprintf(stream, "%*s   serial=%s\n", len, " ",
+		libnvme_subsystem_get_serial(s));
+	fprintf(stream, "%*s   firmware=%s\n", len, " ",
+		libnvme_subsystem_get_firmware(s));
+	fprintf(stream, "%*s   type=%s\n", len, " ",
+		libnvme_subsystem_get_subsystype(s));
+
+	fprintf(stream, "\n");
+}
+
+static int stdout_top_update_stat(libnvme_subsystem_t s)
+{
+	libnvme_ctrl_t c;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+	int ret;
+
+	if (nvme_is_multipath(s)) {
+		libnvme_subsystem_for_each_ns(s, n) {
+			ret = libnvme_ns_update_stat(n, true);
+			if (ret < 0) {
+				nvme_show_error("Failed to update namespace stat");
+				return ret;
+			}
+
+			libnvme_namespace_for_each_path(n, p) {
+				ret = libnvme_path_update_stat(p, true);
+				if (ret < 0) {
+					nvme_show_error("Failed to update path stat");
+					return ret;
+				}
+			}
+		}
+	} else {
+		libnvme_subsystem_for_each_ctrl(s, c) {
+			libnvme_ctrl_for_each_ns(c, n) {
+				ret = libnvme_ns_update_stat(n, true);
+				if (ret < 0) {
+					nvme_show_error("Failed to update namespace stat");
+					return ret;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void stdout_top_reset_stat(libnvme_subsystem_t s)
+{
+	libnvme_ctrl_t c;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+
+	if (nvme_is_multipath(s)) {
+		libnvme_subsystem_for_each_ns(s, n) {
+			libnvme_ns_reset_stat(n);
+
+			libnvme_namespace_for_each_path(n, p)
+				libnvme_path_reset_stat(p);
+		}
+	} else {
+		libnvme_subsystem_for_each_ctrl(s, c) {
+
+			libnvme_ctrl_for_each_ns(c, n)
+				libnvme_ns_reset_stat(n);
+		}
+	}
+}
+
+static int stdout_top_print_subsys_topology(struct dashboard_ctx *db_ctx,
+		FILE *stream, libnvme_subsystem_t s)
+{
+	int ret = 0;
+	bool multipath = nvme_is_multipath(s);
+
+	ret = stdout_top_update_stat(s);
+	if (ret)
+		return ret;
+
+	stdout_top_print_subsys_topology_config(stream, s);
+
+	if (multipath) {
+		ret = stdout_top_print_nshead_stat(stream, s);
+		if (ret)
+			return ret;
+
+		ret = stdout_top_print_path_perf(stream, s);
+		if (ret)
+			return ret;
+
+		ret = stdout_top_print_path_health(stream, s);
+		if (ret)
+			return ret;
+	} else {
+		ret = stdout_top_print_ns_stat(stream, s);
+		if (ret)
+			return ret;
+	}
+
+	ret = stdout_top_print_ctrl_summary(stream, s, multipath);
+
+	return ret;
+}
+
+static void stdout_top_print_subsys_topology_header(
+		struct dashboard_ctx *db_ctx, FILE *stream)
+{
+	fprintf(stream, "---- nvme-top - Refresh: %d Second ----\n",
+			dashboard_get_interval(db_ctx));
+
+	dashboard_set_header_rows(db_ctx, 1);
+
+	/* highlight the header row */
+	dashboard_set_header_raw_reverse(db_ctx, 0);
+}
+
+static void stdout_top_print_subsys_topology_footer(
+		struct dashboard_ctx *db_ctx, FILE *stream)
+{
+	fprintf(stream, "\n--------------------------------------\n");
+	fprintf(stream, "[ESC to go back to the previous screen, q to quit]\n");
+
+	dashboard_set_footer_rows(db_ctx, 3);
+
+	/* hightligh the last footer row */
+	dashboard_set_footer_raw_reverse(db_ctx, 2);
+}
+
+static struct libnvme_global_ctx *stdout_top_rescan_topology(void)
+{
+	struct libnvme_global_ctx *ctx;
+
+	ctx = libnvme_create_global_ctx(stdout, log_level);
+	if (!ctx) {
+		nvme_show_error("Failed to create global context");
+		return NULL;
+	}
+
+	if (libnvme_scan_topology(ctx, NULL, NULL)) {
+		libnvme_free_global_ctx(ctx);
+		nvme_show_error("Failed to scan topology");
+		return NULL;
+	}
+
+	return ctx;
+}
+
+static libnvme_subsystem_t stdout_top_search_subsystem(
+		struct libnvme_global_ctx *ctx, const char *subsys_name)
+{
+	libnvme_host_t h;
+	libnvme_subsystem_t s;
+
+	libnvme_for_each_host(ctx, h) {
+		libnvme_for_each_subsystem(h, s) {
+			if (!strcmp(libnvme_subsystem_get_name(s), subsys_name))
+				return s;
+		}
+	}
+
+	return NULL;
+}
+
+static libnvme_subsystem_t *stdout_top_build_subsys_arr(
+		struct libnvme_global_ctx *ctx, int *num_subsys)
+{
+	libnvme_host_t h;
+	libnvme_subsystem_t s;
+	libnvme_subsystem_t *subsys_arr;
+	int subsys_idx = 0;
+	int n = 0;
+
+	libnvme_for_each_host(ctx, h)
+		libnvme_for_each_subsystem(h, s)
+			n++;
+	if (!n) {
+		nvme_show_error("Can't find any NVMe subsystem on the host\n");
+		return NULL;
+	}
+
+	subsys_arr = calloc(n, sizeof(libnvme_subsystem_t));
+	if (!subsys_arr) {
+		nvme_show_error("Failed to allocate memory for subsys array\n");
+		return NULL;
+	}
+
+	libnvme_for_each_host(ctx, h) {
+		libnvme_for_each_subsystem(h, s)
+			subsys_arr[subsys_idx++] = s;
+	}
+
+	*num_subsys = n;
+	return subsys_arr;
+}
+
+/*
+ * Draws subsys topology screen of susbystem @s
+ * Returns: 0 if ESC key is pressed or needs to draw subsystem selection screen
+ *          1 if 'q' is pressed or in case of error
+ */
+static int stdout_top_draw_subsys_topology_screen(struct dashboard_ctx *db_ctx,
+			FILE *stream, libnvme_subsystem_t _s)
+{
+	struct libnvme_global_ctx *ctx;
+	enum event_type event;
+	int ret, scroll = 0;
+	int data_start, data_rows;
+	libnvme_subsystem_t s = NULL;
+
+	ctx = stdout_top_rescan_topology();
+	if (!ctx)
+		return 1; /* force quit */
+
+	s = stdout_top_search_subsystem(ctx, libnvme_subsystem_get_name(_s));
+	if (!s) {
+		libnvme_free_global_ctx(ctx);
+		return 0; /* draw subsys selection screen */
+	}
+
+	while (1) {
+		stdout_top_print_subsys_topology_header(db_ctx, stream);
+		ret = stdout_top_print_subsys_topology(db_ctx, stream, s);
+		if (ret)
+			break;
+		stdout_top_print_subsys_topology_footer(db_ctx, stream);
+
+draw:
+		ret = dashboard_draw_frame(db_ctx, scroll);
+		if (ret)
+			break;
+wait_for_event:
+		event = dashboard_wait_for_event(db_ctx);
+		if (event == EVENT_TYPE_KEY_ESC) {
+			ret = 0;
+			dashboard_reset(db_ctx);
+			libnvme_free_global_ctx(ctx);
+			break;
+		} else if (event == EVENT_TYPE_KEY_UP) {
+			data_start = dashboard_get_data_start(db_ctx);
+			/*
+			 * If we don't move past the first data row by shifting
+			 * one data row up then do so, otherwise ignore the key
+			 * press.
+			 */
+			if (data_start - 1 >= 0) {
+				dashboard_set_data_start(db_ctx,
+						data_start - 1);
+				scroll = 1;
+				goto draw;
+			}
+			goto wait_for_event;
+		} else if (event == EVENT_TYPE_KEY_DOWN) {
+			data_start = dashboard_get_data_start(db_ctx);
+			data_rows = dashboard_get_data_rows(db_ctx);
+			/*
+			 * If we don't move past the max data rows shifting one
+			 * row down then do so, otherwise ignore the key press.
+			 */
+			if (data_start + 1 < data_rows) {
+				dashboard_set_data_start(db_ctx,
+						data_start + 1);
+				scroll = 1;
+				goto draw;
+			}
+			goto wait_for_event;
+		} else if (event == EVENT_TYPE_TIMEOUT) { /* screen timed out */
+			scroll = 0;
+		} else if (event == EVENT_TYPE_KEY_QUIT ||
+				event == EVENT_TYPE_ERROR) {
+			ret = 1;
+			break;
+		} else if (event == EVENT_TYPE_NVME_UEVENT) {
+			/* free old ctx */
+			libnvme_free_global_ctx(ctx);
+			ctx = stdout_top_rescan_topology();
+			if (!ctx) {
+				ret = 1; /* force quit */
+				break;
+			}
+
+			s = stdout_top_search_subsystem(ctx,
+					libnvme_subsystem_get_name(_s));
+			if (!s) {
+				libnvme_free_global_ctx(ctx);
+				ret = 0; /* draw subsys selection screen */
+				break;
+			}
+			scroll = 0;
+		} else if (event == EVENT_TYPE_SIGWINCH) {
+			/*
+			 * Window size would have changed so re-draw the subsys
+			 * topology screen.
+			 */
+			scroll = 0;
+		} /* else unknown event, ignore */
+	}
+
+	return ret;
+}
+
+static int stdout_top_draw_subsys_screen(struct dashboard_ctx *db_ctx,
+		FILE *stream, libnvme_subsystem_t *subsys_arr, int num_subsys)
+{
+	int ret = 0;
+	libnvme_subsystem_t s;
+	libnvme_ctrl_t c;
+	libnvme_ns_t n;
+	libnvme_path_t p;
+	int i, row, col, num_ns, num_path, num_ctrl;
+	double r_iops, w_iops;
+	double r_bw, w_bw;
+	double max_rlat, max_wlat, max_util;
+	char r_bw_str[16], w_bw_str[16];
+	char r_iops_str[16], w_iops_str[16];
+	char r_clat_str[16], w_clat_str[16];
+	struct table *t;
+	struct table_column columns[] = {
+		{"Subsystem", LEFT},
+		{"Namespaces", LEFT},
+		{"Paths", LEFT},
+		{"Ctrls", LEFT},
+		{"IOPolicy", LEFT},
+		{"r_IOPS", LEFT},
+		{"w_IOPS", LEFT},
+		{"r_clat", LEFT},
+		{"w_clat", LEFT},
+		{"r_bw", LEFT},
+		{"w_bw", LEFT},
+		{"Util%", LEFT},
+	};
+
+	fprintf(stream, "---- nvme-top - Refresh: %d Second ----\n",
+			dashboard_get_interval(db_ctx));
+	fprintf(stream, "\n--------- Subsystem Summary ----------\n\n");
+
+	t = table_create();
+	if (!t) {
+		nvme_show_error("Failed to init subsys screen table\n");
+		return -1;
+	}
+
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		nvme_show_error("Failed to add columns to subsys screen table\n");
+		ret = -1;
+		goto free_tbl;
+	}
+	/*
+	 * Header row count is calculated manually. The first row displays the
+	 * refresh interval, followed by an empty row. The third row displays
+	 * the heading followed by another empty row. The fifth row is for
+	 * displaying table columns and then another row for dashes underneath
+	 * the table columns.
+	 */
+	dashboard_set_header_rows(db_ctx, 6);
+
+	/* highlight the first header row */
+	dashboard_set_header_raw_reverse(db_ctx, 0);
+
+	for (i = 0; i < num_subsys; i++) {
+		s = subsys_arr[i];
+		num_ctrl = num_ns = num_path = 0;
+		r_iops = w_iops = 0;
+		r_bw = w_bw = 0;
+		max_rlat = max_wlat = 0;
+		max_util = 0;
+
+		libnvme_subsystem_for_each_ctrl(s, c)
+			num_ctrl++;
+
+		if (!num_ctrl)
+			continue;
+
+		ret = stdout_top_update_stat(s);
+		if (ret)
+			goto free_tbl;
+
+		if (nvme_is_multipath(s)) {
+			libnvme_subsystem_for_each_ns(s, n) {
+				num_ns++;
+
+				libnvme_namespace_for_each_path(n, p)
+					num_path++;
+
+				nvme_ns_calc_aggr_stat(n,
+						&r_iops, &w_iops,
+						&r_bw, &w_bw,
+						&max_rlat, &max_wlat,
+						&max_util);
+			}
+		} else {
+			libnvme_subsystem_for_each_ctrl(s, c) {
+				libnvme_ctrl_for_each_ns(c, n) {
+					num_ns++;
+
+					nvme_ns_calc_aggr_stat(n,
+							&r_iops, &w_iops,
+							&r_bw, &w_bw,
+							&max_rlat, &max_wlat,
+							&max_util);
+				}
+			}
+		}
+
+		nvme_format_iops(r_iops, r_iops_str, sizeof(r_iops_str));
+		nvme_format_iops(w_iops, w_iops_str, sizeof(w_iops_str));
+
+		nvme_format_bw(r_bw, r_bw_str, sizeof(r_bw_str));
+		nvme_format_bw(w_bw, w_bw_str, sizeof(w_bw_str));
+
+		nvme_format_lat(max_rlat, r_clat_str, sizeof(r_clat_str));
+		nvme_format_lat(max_wlat, w_clat_str, sizeof(w_clat_str));
+
+		row = table_get_row_id(t);
+		if (row < 0) {
+			nvme_show_error("Failed to add row to subsys screen table\n");
+			ret = -1;
+			goto free_tbl;
+		}
+
+		col = -1;
+
+		table_set_value_str(t, ++col, row,
+				libnvme_subsystem_get_name(s), LEFT);
+		table_set_value_int(t, ++col, row, num_ns, LEFT);
+		table_set_value_int(t, ++col, row, num_path, LEFT);
+		table_set_value_int(t, ++col, row, num_ctrl, LEFT);
+		table_set_value_str(t, ++col, row,
+				libnvme_subsystem_get_iopolicy(s), LEFT);
+		table_set_value_str(t, ++col, row, r_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, w_iops_str, LEFT);
+		table_set_value_str(t, ++col, row, r_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, w_clat_str, LEFT);
+		table_set_value_str(t, ++col, row, r_bw_str, LEFT);
+		table_set_value_str(t, ++col, row, w_bw_str, LEFT);
+		table_set_value_double(t, ++col, row, max_util, LEFT);
+
+		table_add_row(t, row);
+	}
+
+	table_print_stream(stream, t);
+
+	fprintf(stream, "\n--------------------------------------\n");
+	fprintf(stream, "[up/down arrow keys to navigate, Enter to view, q to quit]\n");
+
+	/*
+	 * Footer rows are calculated manually.
+	 * The first row is empty (adds spaces) followed by another row for
+	 * dashes and the last row adds footer string.
+	 */
+	dashboard_set_footer_rows(db_ctx, 3);
+
+	/* highlight the last footer row */
+	dashboard_set_footer_raw_reverse(db_ctx, 2);
+
+free_tbl:
+	table_free(t);
+	return ret;
+}
+
+static void stdout_top(int refresh_interval)
+{
+	FILE *stream;
+	enum event_type event;
+	struct dashboard_ctx *db_ctx;
+	libnvme_host_t h;
+	libnvme_subsystem_t s;
+	struct libnvme_global_ctx *ctx;
+	libnvme_subsystem_t *subsys_arr = NULL;
+	int data_start, frame_rows, quit = 0, scroll = 0;
+	int num_subsys = 0, subsys_idx = 0;
+
+	ctx = stdout_top_rescan_topology();
+	if (!ctx)
+		return;
+	subsys_arr = stdout_top_build_subsys_arr(ctx, &num_subsys);
+	if (!subsys_arr) {
+		libnvme_free_global_ctx(ctx);
+		return;
+	}
+
+	stream = dashboard_init(&db_ctx, refresh_interval);
+	if (!stream)
+		goto out;
+
+	libnvme_for_each_host(ctx, h) {
+		libnvme_for_each_subsystem(h, s)
+			stdout_top_reset_stat(s);
+	}
+
+	/*
+	 * We start with first subsystem highlited, so set subsystem index to 0.
+	 */
+	subsys_idx = 0;
+	while (!quit) {
+		if (stdout_top_draw_subsys_screen(db_ctx, stream, subsys_arr,
+				num_subsys) < 0)
+			break;
+draw:
+		/* highlight the selected @subsys_idx row */
+		dashboard_set_data_raw_reverse(db_ctx, subsys_idx);
+		if (dashboard_draw_frame(db_ctx, scroll) < 0)
+			break;
+wait_for_event:
+		event = dashboard_wait_for_event(db_ctx);
+		switch (event) {
+		case EVENT_TYPE_KEY_QUIT:
+		case EVENT_TYPE_ERROR:
+			quit = 1;
+			break;
+		case EVENT_TYPE_KEY_RETURN:
+			dashboard_reset(db_ctx);
+
+			s = subsys_arr[subsys_idx];
+			quit = stdout_top_draw_subsys_topology_screen(db_ctx,
+					stream, s);
+			scroll = 0;
+			if (quit)
+				break;
+			fallthrough;
+		case EVENT_TYPE_NVME_UEVENT:
+			libnvme_free_global_ctx(ctx);
+			free(subsys_arr);
+			subsys_arr = NULL;
+			ctx = stdout_top_rescan_topology();
+			if (!ctx) {
+				quit = 1;
+				break;
+			}
+			subsys_arr = stdout_top_build_subsys_arr(ctx,
+					&num_subsys);
+			if (!subsys_arr) {
+				libnvme_free_global_ctx(ctx);
+				quit = 1;
+			}
+			subsys_idx = 0;
+			break;
+		case EVENT_TYPE_KEY_DOWN:
+			/*
+			 * The @num_subsys should be equal to @data_rows, so we
+			 * evaluate here that we don't move pass the last data
+			 * row (or the last subsys) if we were to shift (focus)
+			 * one row down. In case it's not possible to shift
+			 * because we are already down to the last row then
+			 * ignore key press.
+			 */
+			if (subsys_idx + 1 < num_subsys) {
+				subsys_idx++; /* we'll highlight this row */
+
+				data_start = dashboard_get_data_start(db_ctx);
+				frame_rows = dashboard_get_frame_data_rows(
+						db_ctx);
+				/*
+				 * If moving to next row requires shifting the
+				 * window frame buffer by one position down then
+				 * do so.
+				 */
+				if (subsys_idx >= data_start + frame_rows) {
+					dashboard_set_data_start(db_ctx,
+							data_start + 1);
+				}
+				/*
+				 * As we are scrolling one row down, we need to
+				 * re-draw the frame.
+				 */
+				scroll = 1;
+				goto draw;
+			}
+			goto wait_for_event;
+		case EVENT_TYPE_KEY_UP:
+			/*
+			 * If it's possible to move one row above the current
+			 * subsys (higlighted) row then decrease the subsys_idx
+			 * by one.
+			 */
+			if (subsys_idx - 1 >= 0) {
+				subsys_idx--;
+				/*
+				 * If moving one row up requires us to shift
+				 * the window frame buffer by one position up
+				 * then do so.
+				 */
+				data_start = dashboard_get_data_start(db_ctx);
+				if (subsys_idx < data_start) {
+					dashboard_set_data_start(db_ctx,
+						data_start - 1);
+				}
+				/*
+				 * As we are scrolling one row up, we need to
+				 * re-draw the frame.
+				 */
+				scroll = 1;
+				goto draw;
+			}
+			goto wait_for_event;
+		case EVENT_TYPE_TIMEOUT:
+			/* subsys screen timed out */
+			scroll = 0;
+			break;
+		case EVENT_TYPE_SIGWINCH:
+			/*
+			 * Window size would have changed so re-draw the subsys
+			 * selection screen.
+			 */
+			scroll = 0;
+			break;
+		default: /* unknown event, ignore */
+			continue;
+		}
+	}
+
+	dashboard_exit(db_ctx);
+	libnvme_free_global_ctx(ctx);
+out:
+	free(subsys_arr);
+}
+
 static void stdout_message(bool error, const char *msg, va_list ap)
 {
 	vfprintf(error ? stderr : stdout, msg, ap);
@@ -7092,6 +8296,8 @@ static struct print_ops stdout_print_ops = {
 	.topology_multipath		= stdout_topology_multipath,
 	.topology_tabular		= stdout_topology_tabular,
 
+	/* nvme top */
+	.top				= stdout_top,
 	/* status and error messages */
 	.connect_msg			= stdout_connect_msg,
 	.show_message			= stdout_message,
diff --git a/nvme-print.c b/nvme-print.c
index 545854f30..8a116db5a 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1679,6 +1679,11 @@ void nvme_show_list_items(struct libnvme_global_ctx *ctx, nvme_print_flags_t fla
 	nvme_print(list_items, flags, ctx);
 }
 
+void nvme_show_top(nvme_print_flags_t flags, int refresh_interval)
+{
+	nvme_print(top, flags, refresh_interval);
+}
+
 void nvme_show_topology(struct libnvme_global_ctx *ctx,
 			enum nvme_cli_topo_ranking ranking,
 			nvme_print_flags_t flags)
diff --git a/nvme-print.h b/nvme-print.h
index bd88410d1..cca77e7a1 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -114,6 +114,9 @@ struct print_ops {
 	void (*topology_multipath)(struct libnvme_global_ctx *ctx);
 	void (*topology_tabular)(struct libnvme_global_ctx *ctx);
 
+	/* nvme top */
+	void (*top)(int refresh_interval);
+
 	/* status and error messages */
 	void (*connect_msg)(libnvme_ctrl_t c);
 	void (*show_message)(bool error, const char *msg, va_list ap);
@@ -263,9 +266,9 @@ void nvme_show_topology(struct libnvme_global_ctx *ctx,
 			enum nvme_cli_topo_ranking ranking,
 			nvme_print_flags_t flags);
 void nvme_show_topology_tabular(struct libnvme_global_ctx *ctx, nvme_print_flags_t flags);
-
 void nvme_show_feature(enum nvme_features_id fid, int sel, unsigned int result,
 		       void *buf, __u32 data_len, nvme_print_flags_t flags);
+void nvme_show_top(nvme_print_flags_t flags, int refresh_interval);
 void nvme_feature_show_fields(enum nvme_features_id fid, unsigned int result, unsigned char *buf);
 void nvme_directive_show(__u8 type, __u8 oper, __u16 spec, __u32 nsid, __u64 result,
 	void *buf, __u32 len, nvme_print_flags_t flags);
diff --git a/nvme-top.c b/nvme-top.c
new file mode 100644
index 000000000..a60c752ed
--- /dev/null
+++ b/nvme-top.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Helpers for nvme top dashboard
+ *
+ * Copyright (c) 2026 Nilay Shroff, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define IOPS_UNIT_NONE		""
+#define IOPS_UNIT_KB		"k"
+
+#define BW_UNIT_BYTES_PER_SEC	"B/s"
+#define BW_UNIT_KIB_PER_SEC	"KiB/s"
+#define BW_UNIT_MIB_PER_SEC	"MiB/s"
+
+#define BW_KIB	1024
+#define BW_MIB	(BW_KIB * 1024)
+
+#include <libnvme.h>
+#include "nvme-top.h"
+
+static double nvme_calc_util_percent(unsigned int ticks, double interval_ms)
+{
+	if (!interval_ms)
+		return 0;
+
+	return (ticks / interval_ms) * 100;
+}
+
+static double nvme_path_calc_util_percent(libnvme_path_t p, double interval_ms)
+{
+	unsigned int ticks;
+
+	ticks = libnvme_path_get_io_ticks(p);
+	return nvme_calc_util_percent(ticks, interval_ms);
+}
+
+static double nvme_ns_calc_util_percent(libnvme_ns_t n, double interval_ms)
+{
+	unsigned int ticks;
+
+	ticks = libnvme_ns_get_io_ticks(n);
+	return nvme_calc_util_percent(ticks, interval_ms);
+}
+
+static double nvme_calc_iops(unsigned long ios, double interval_ms)
+{
+	double interval_sec;
+
+	if (interval_ms < 1000)
+		return 0;
+
+	interval_sec = interval_ms / 1000;
+	return (ios / interval_sec);
+}
+
+static double nvme_path_calc_read_iops(libnvme_path_t p, double interval_ms)
+{
+	unsigned long read_ios;
+
+	read_ios = libnvme_path_get_read_ios(p);
+	return nvme_calc_iops(read_ios, interval_ms);
+}
+
+static double nvme_path_calc_write_iops(libnvme_path_t p, double interval_ms)
+{
+	unsigned long write_ios;
+
+	write_ios = libnvme_path_get_write_ios(p);
+	return nvme_calc_iops(write_ios, interval_ms);
+}
+
+static double nvme_ns_calc_read_iops(libnvme_ns_t n, double interval_ms)
+{
+	unsigned long read_ios;
+
+	read_ios = libnvme_ns_get_read_ios(n);
+	return nvme_calc_iops(read_ios, interval_ms);
+}
+
+static double nvme_ns_calc_write_iops(libnvme_ns_t n, double interval_ms)
+{
+	unsigned long write_ios;
+
+	write_ios = libnvme_ns_get_write_ios(n);
+	return nvme_calc_iops(write_ios, interval_ms);
+}
+
+static double nvme_calc_latency(unsigned long ticks, unsigned long ios)
+{
+	if (!ios)
+		return 0;
+
+	return ((double)ticks/ios);
+}
+
+static double nvme_path_calc_read_latency(libnvme_path_t p)
+{
+	unsigned int ticks;
+	unsigned long ios;
+
+	ticks = libnvme_path_get_read_ticks(p);
+	ios = libnvme_path_get_read_ios(p);
+
+	return nvme_calc_latency(ticks, ios);
+}
+
+static double nvme_path_calc_write_latency(libnvme_path_t p)
+{
+	unsigned int ticks;
+	unsigned long ios;
+
+	ticks = libnvme_path_get_write_ticks(p);
+	ios = libnvme_path_get_write_ios(p);
+
+	return nvme_calc_latency(ticks, ios);
+}
+
+static double nvme_ns_calc_read_latency(libnvme_ns_t n)
+{
+	unsigned int ticks;
+	unsigned long ios;
+
+	ticks = libnvme_ns_get_read_ticks(n);
+	ios = libnvme_ns_get_read_ios(n);
+
+	return nvme_calc_latency(ticks, ios);
+}
+
+static double nvme_ns_calc_write_latency(libnvme_ns_t n)
+{
+	unsigned int ticks;
+	unsigned long ios;
+
+	ticks = libnvme_ns_get_write_ticks(n);
+	ios = libnvme_ns_get_write_ios(n);
+
+	return nvme_calc_latency(ticks, ios);
+}
+
+static double nvme_calc_bandwidth(unsigned long long sectors,
+			double interval_ms)
+{
+	double bytes;
+	double sec;
+
+	if (interval_ms < 1000)
+		return 0;
+
+	sec = interval_ms / 1000;
+	bytes = sectors * 512;
+	return (bytes / sec);
+}
+
+static double nvme_path_calc_read_bw(libnvme_path_t p, double interval_ms)
+{
+	unsigned long long sectors;
+
+	sectors = libnvme_path_get_read_sectors(p);
+	return nvme_calc_bandwidth(sectors, interval_ms);
+}
+
+static double nvme_path_calc_write_bw(libnvme_path_t p, double interval_ms)
+{
+	unsigned long long sectors;
+
+	sectors = libnvme_path_get_write_sectors(p);
+	return nvme_calc_bandwidth(sectors, interval_ms);
+}
+
+static double nvme_ns_calc_read_bw(libnvme_ns_t n, double interval_ms)
+{
+	unsigned long long sectors;
+
+	sectors = libnvme_ns_get_read_sectors(n);
+	return nvme_calc_bandwidth(sectors, interval_ms);
+}
+
+static double nvme_ns_calc_write_bw(libnvme_ns_t n, double interval_ms)
+{
+	unsigned long long sectors;
+
+	sectors = libnvme_ns_get_write_sectors(n);
+	return nvme_calc_bandwidth(sectors, interval_ms);
+}
+
+int nvme_format_iops(double iops, char *buf, size_t size)
+{
+	char *unit;
+
+	if (iops < 1000)
+		unit = IOPS_UNIT_NONE;
+	else {
+		iops /= 1000;
+		unit = IOPS_UNIT_KB;
+	}
+
+	return snprintf(buf, size, "%.2f%s", iops, unit);
+}
+
+int nvme_format_bw(double bw, char *buf, size_t size)
+{
+	char *unit = "";
+
+	if (!bw)
+		goto out;
+
+	if (bw < BW_KIB)
+		unit = BW_UNIT_BYTES_PER_SEC;
+	else if (bw < BW_MIB) {
+		bw /= BW_KIB;
+		unit = BW_UNIT_KIB_PER_SEC;
+	} else {
+		bw /= BW_MIB;
+		unit = BW_UNIT_MIB_PER_SEC;
+	}
+
+out:
+	return snprintf(buf, size, "%.2f%s", bw, unit);
+}
+
+void nvme_ns_calc_aggr_stat(libnvme_ns_t n, double *r_iops, double *w_iops,
+		double *r_bw, double *w_bw, double *max_rlat, double *max_wlat,
+		double *max_util)
+{
+	double interval_ms, rlat, wlat, util;
+
+	interval_ms = libnvme_ns_get_stat_interval(n);
+	if (!interval_ms)
+		return;
+
+	*r_iops += nvme_ns_calc_read_iops(n, interval_ms);
+	*w_iops += nvme_ns_calc_write_iops(n, interval_ms);
+
+	*r_bw += nvme_ns_calc_read_bw(n, interval_ms);
+	*w_bw += nvme_ns_calc_write_bw(n, interval_ms);
+
+	rlat = nvme_ns_calc_read_latency(n);
+	if (rlat > *max_rlat)
+		*max_rlat = rlat;
+
+	wlat = nvme_ns_calc_write_latency(n);
+	if (wlat > *max_wlat)
+		*max_wlat = wlat;
+
+	util = nvme_ns_calc_util_percent(n, interval_ms);
+	if (util > *max_util)
+		*max_util = util;
+}
+
+void nvme_path_calc_aggr_stat(libnvme_path_t p, double *r_iops, double *w_iops,
+		double *r_bw, double *w_bw, double *max_rlat, double *max_wlat,
+		double *max_util)
+{
+	double interval_ms, rlat, wlat, util;
+
+	interval_ms = libnvme_path_get_stat_interval(p);
+	if (!interval_ms)
+		return;
+
+	*r_iops += nvme_path_calc_read_iops(p, interval_ms);
+	*w_iops += nvme_path_calc_write_iops(p, interval_ms);
+
+	*r_bw += nvme_path_calc_read_bw(p, interval_ms);
+	*w_bw += nvme_path_calc_write_bw(p, interval_ms);
+
+	rlat = nvme_path_calc_read_latency(p);
+	if (rlat > *max_rlat)
+		*max_rlat = rlat;
+
+	wlat = nvme_path_calc_write_latency(p);
+	if (wlat > *max_wlat)
+		*max_wlat = wlat;
+
+	util = nvme_path_calc_util_percent(p, interval_ms);
+	if (util > *max_util)
+		*max_util = util;
+}
+
+void nvme_ns_calc_stat(libnvme_ns_t n, double *r_iops, double *w_iops,
+		double *r_lat, double *w_lat, double *r_bw, double *w_bw,
+		double *util, unsigned int *inflights)
+{
+	double interval_ms;
+
+	interval_ms = libnvme_ns_get_stat_interval(n);
+	if (!interval_ms)
+		return;
+
+	/* calculate R/W IOPS */
+	*r_iops = nvme_ns_calc_read_iops(n, interval_ms);
+	*w_iops = nvme_ns_calc_write_iops(n, interval_ms);
+
+	/* calculate R/W latency */
+	*r_lat = nvme_ns_calc_read_latency(n);
+	*w_lat = nvme_ns_calc_write_latency(n);
+
+	/* calculate R/W bandwidth */
+	*r_bw = nvme_ns_calc_read_bw(n, interval_ms);
+	*w_bw = nvme_ns_calc_write_bw(n, interval_ms);
+
+	/* get inflights counter */
+	*inflights = libnvme_ns_get_inflights(n);
+
+	/* calculate util percent */
+	*util = nvme_ns_calc_util_percent(n, interval_ms);
+}
+
+void nvme_path_calc_stat(libnvme_path_t p, double *r_iops, double *w_iops,
+		double *r_lat, double *w_lat, double *r_bw, double *w_bw,
+		double *util, unsigned int *inflights)
+{
+	double interval_ms;
+
+	interval_ms = libnvme_path_get_stat_interval(p);
+	if (!interval_ms)
+		return;
+
+	/* calculate R/W IOPS */
+	*r_iops = nvme_path_calc_read_iops(p, interval_ms);
+	*w_iops = nvme_path_calc_write_iops(p, interval_ms);
+
+	/* calculate R/W latency */
+	*r_lat = nvme_path_calc_read_latency(p);
+	*w_lat = nvme_path_calc_write_latency(p);
+
+	/* calculate R/W bandwidth */
+	*r_bw = nvme_path_calc_read_bw(p, interval_ms);
+	*w_bw = nvme_path_calc_write_bw(p, interval_ms);
+
+	/* get inflights counter */
+	*inflights = libnvme_path_get_inflights(p);
+
+	/* calculate util percent */
+	*util = nvme_path_calc_util_percent(p, interval_ms);
+}
diff --git a/nvme-top.h b/nvme-top.h
new file mode 100644
index 000000000..9ce4905cb
--- /dev/null
+++ b/nvme-top.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef NVME_TOP_H
+#define NVME_TOP_H
+
+#include <stdio.h>
+#include <stddef.h>
+#include <libnvme.h>
+
+int nvme_format_iops(double iops, char *buf, size_t size);
+int nvme_format_bw(double bw, char *buf, size_t size);
+
+void nvme_ns_calc_aggr_stat(libnvme_ns_t n, double *r_iops, double *w_iops,
+		double *r_bw, double *w_bw, double *max_rlat, double *max_wlat,
+		double *max_util);
+void nvme_path_calc_aggr_stat(libnvme_path_t p, double *r_iops, double *w_iops,
+		double *r_bw, double *w_bw, double *max_rlat, double *max_wlat,
+		double *max_util);
+void nvme_ns_calc_stat(libnvme_ns_t n, double *r_iops, double *w_iops,
+		double *r_lat, double *w_lat, double *r_bw, double *w_bw,
+		double *util, unsigned int *inflights);
+void nvme_path_calc_stat(libnvme_path_t p, double *r_iops, double *w_iops,
+		double *r_lat, double *w_lat, double *r_bw, double *w_bw,
+		double *util, unsigned int *inflights);
+
+static inline int nvme_format_lat(double lat, char *buf, size_t size)
+{
+	return snprintf(buf, size, "%.2f", lat);
+}
+
+#endif /* NVME_TOP_H */
diff --git a/nvme.c b/nvme.c
index d723170ea..ac4451cee 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3550,6 +3550,45 @@ static int list_subsys(int argc, char **argv, struct command *acmd,
 	return 0;
 }
 
+static int top(int argc, char **argv, struct command *acmd,
+		struct plugin *plugin)
+{
+	int err;
+	nvme_print_flags_t flags = 0;
+	const char *desc = "show nvme top output";
+	const char *delay = "refresh interval in seconds";
+
+	struct config {
+		int delay;
+	};
+
+	struct config cfg = {
+		.delay = 1,
+	};
+
+	NVME_ARGS(opts,
+		  OPT_INT("delay", 'd', &cfg.delay, delay));
+
+	err = parse_args(argc, argv, desc, opts);
+	if (err)
+		return err;
+
+	err = validate_output_format(nvme_args.output_format, &flags);
+	if (err < 0 || flags != NORMAL) {
+		nvme_show_error("Invalid output format");
+		return -EINVAL;
+	}
+
+	if (cfg.delay < 1) {
+		nvme_show_error("delay must be greater than or equal to 1");
+		return -EINVAL;
+	}
+
+	nvme_show_top(flags, cfg.delay);
+
+	return err;
+}
+
 static int list(int argc, char **argv, struct command *acmd, struct plugin *plugin)
 {
 	const char *desc = "Retrieve basic information for all NVMe namespaces";
-- 
2.53.0


