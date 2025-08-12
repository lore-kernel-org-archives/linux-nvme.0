Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00431CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvqqtrruS9+oDvvqJZbDgE2UnwAaiGOhi07aq/Vbex4=; b=GxrtQeu5F3Uh/ZO1u721JulcjM
	t3yIGAIasRSj1xGkNF1j//3ZAORns24G3ILvnWXij/KCOt36HMh0iOdw2QaQxbiDeBR/xiiMj/Si9
	lh2m/fjTJRgVb2A2tTTZpF+RbBGwkg8ON8nZ3vrcKbynpu+H3EPeJM00nQggc0bJ1TR41w8O6jKhn
	0q7EIst874hfeNbtK7gvrkrIcgU5xt3BtzIwGU3kNXAdT88kzi9YAr/m75rYTiUcy1n+0gC85CSGk
	ortIJ2ZgRBAfbp/5Liv7GMbNZMqUTG06neTtcfqISkO7QtUMPpfQtSLLzpRUkAKMf0WQGqd2CkDzf
	RbcP/izw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsqT-0000000Ba2G-08sM;
	Tue, 12 Aug 2025 17:31:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYp-0000000AqpE-3ZHd
	for linux-nvme@bombadil.infradead.org;
	Tue, 12 Aug 2025 12:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JvqqtrruS9+oDvvqJZbDgE2UnwAaiGOhi07aq/Vbex4=; b=K7V1QK+U3+639+a0z0gEkn23cB
	ITRg6mugtV2YVJa5ApzQtf8PelRwBi+vYIZk+mJXTPX2ZGt0F3iGsQ2eM8UPv/jLhtAI5OlvPZPam
	ZPJc2vph49MVBUalN6Z/v+oMLft43rt9sCor1epm5f8RReOEkkmaxV/YmDccenY7Ecb7pI8zgCDXs
	XSy7axfVCbpGahD5Mr63Lxqa5k+P06DTNJLS1w7Hicufd0JvqL+WmBSi6s5W8F8a3efX6y7V9jBIJ
	SNv9pLXGmg07ljKv8BGefmtefA7RnOdzA35Q4Shph96t5/anrESgW2N7xIircsfcfV2gskIwtf0RD
	jsjGmU9g==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYm-0000000FoGf-0bmi
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 12:57:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C8s121003903;
	Tue, 12 Aug 2025 12:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JvqqtrruS9+oDvvqJ
	ZbDgE2UnwAaiGOhi07aq/Vbex4=; b=FFQLDBttTAdyEzzlRWnUHOD/GW4cWEpEn
	GtvBEJkWXwniIYM3b1euLoSBIITYwi8RxW50ZNSqMUIIOljcYeKvCUv3Sh9ER5/J
	p6QnGvAoKualbZZBLiPecIOTtETOEbrjuGP6lc3lbehEs24pZ6lFCslYeGvL78ce
	gf4Y58sMd5+wEKSb12AO//fSy2IJBFka/JW/ne8eEMPJakye6B+BkDYDa7hPQS4w
	2iLyT7vGk6EmrNkwh63dixbY+NyeR/0DOp2oUF00+kRiIliBNlfXgv3ROpeM5i/e
	FmQeN+Bioi3PIf75d/DbPa4VxhKkYRSqkzGSWt+OUI8wepikQIGgA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cxfbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C9cOg9020752;
	Tue, 12 Aug 2025 12:56:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnptecf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CCuXh435848914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 12:56:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61CCD2004B;
	Tue, 12 Aug 2025 12:56:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E6F20040;
	Tue, 12 Aug 2025 12:56:30 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.161.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 12:56:30 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 4/4] nvme: add support for printing show-topology in tabular form
Date: Tue, 12 Aug 2025 18:26:05 +0530
Message-ID: <20250812125614.164445-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812125614.164445-1-nilay@linux.ibm.com>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyMyBTYWx0ZWRfX1oJcXI21iuO0
 1Henn2OAwOUW9x4dE1gReO+YmPZXz8iQblnZX5vHhdLrybMbQGfJKe/1p8+Y6qOqPqTyO41J4Z7
 cejl7cHSXENhxdQ6tb+sa5fxKQIyNVjQ/hh3LuBF1kNkNVwja7y289s0hHPa7Mm4zY/yDdiYbvz
 aeanoUMqFK4ykEGBHjrafhvMFLRMX16dZQbbwgeVYw62xEiBzL8T53ypB7SDtnCTDoHU6d6u8AP
 olEWg5W5YFCL61a+aSKo22otBfwPipwxjYEx8oKt32BqUh8l20pQdD5pV7R0w+lLxto6Khq9py+
 cOgoudpc6CuZSgtnQM2sOWQcVKPV3l8q7LJIspcc9uzYrZlzEjEe0qBWVxIJUAaFYxrwB/KJKcs
 YILJeRWDaJTK1bhcmTg/A34uCb80i/wvhbFPp1q9uqD5w2hRoxeKzeyuBRcXa8b5kXez1PpU
X-Proofpoint-GUID: u-IaPz8gNZVpafkYZe8RWoqQt1DoVZiD
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689b3a04 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=2_Gxc_UBzTSXwJ_BC2kA:9
X-Proofpoint-ORIG-GUID: u-IaPz8gNZVpafkYZe8RWoqQt1DoVZiD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_135700_599023_65143E85 
X-CRM114-Status: GOOD (  28.17  )
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

The nvme CLI command show-topology currently prints the topology
output in a tree format. However, in some cases it is more convenient
and easier to read or interpret the output when displayed in a tabular
form.

This patch adds support for printing the show-topology output in a
tabular format. To achieve this, the --output-format option, which
previously supported only normal and json formats, is extended to
include a new tabular format.

With this change, the user can now choose to print the topology in any
of the following formats: normal, json, or tabular. The new tabular
output leverages the recently introduced table APIs to produce well-
aligned, easy-to-read output.

Suggested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c | 172 ++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c        |   5 ++
 nvme-print.h        |   2 +
 nvme.c              |   8 ++-
 nvme.h              |   1 +
 5 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index ef9ee881..fef688a3 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -20,6 +20,7 @@
 #include "nvme-models.h"
 #include "util/suffix.h"
 #include "util/types.h"
+#include "util/table.h"
 #include "logging.h"
 #include "common.h"
 
@@ -5589,6 +5590,88 @@ static void stdout_list_items(nvme_root_t r)
 		stdout_simple_list(r);
 }
 
+static void stdout_tabular_subsystem_topology_multipath(nvme_subsystem_t s)
+{
+	nvme_ns_t n;
+	nvme_path_t p;
+	nvme_ctrl_t c;
+	int row;
+	bool first;
+	struct table *t;
+	struct table_column columns[] = {
+		{"NSHead", LEFT, 0},
+		{"NSID", LEFT, 0},
+		{"NSPath", LEFT, 0},
+		{"ANAState", LEFT, 0},
+		{"Nodes", LEFT, 0},
+		{"Qdepth", LEFT, 0},
+		{"Controller", LEFT, 0},
+		{"TrType", LEFT, 0},
+		{"Address", LEFT, 0},
+		{"State", LEFT, 0},
+	};
+
+	t = table_init();
+	if (!t) {
+		printf("Failed to init table\n");
+		return;
+	}
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		printf("Failed to add columns\n");
+		goto free_tbl;
+	}
+
+	nvme_subsystem_for_each_ns(s, n) {
+		first = true;
+		nvme_namespace_for_each_path(n, p) {
+			c = nvme_path_get_ctrl(p);
+
+			row = table_get_row_id(t);
+			if (row < 0) {
+				printf("Failed to add row\n");
+				goto free_tbl;
+			}
+			/* For the first row we print actual NSHead name,
+			 * however, for the subsequent rows we print "arrow"
+			 * ("-->") symbol for NSHead. This "arrow" style makes
+			 * it visually obvious that susequenet entries (if
+			 * present) are a path under the first NSHead.
+			 */
+			if (first)
+				table_set_value_str(t, 0, row,
+						nvme_ns_get_name(n), LEFT);
+			else
+				table_set_value_str(t, 0, row,
+						"-->", CENTERED);
+
+			table_set_value_int(t, 1, row,
+					nvme_ns_get_nsid(n), CENTERED);
+			table_set_value_str(t, 2, row,
+					nvme_path_get_name(p), LEFT);
+			table_set_value_str(t, 3, row,
+					nvme_path_get_ana_state(p), LEFT);
+			table_set_value_str(t, 4, row,
+					nvme_path_get_numa_nodes(p), CENTERED);
+			table_set_value_int(t, 5, row,
+					nvme_path_get_queue_depth(p), CENTERED);
+			table_set_value_str(t, 6, row,
+					nvme_ctrl_get_name(c), LEFT);
+			table_set_value_str(t, 7, row,
+					nvme_ctrl_get_transport(c), LEFT);
+			table_set_value_str(t, 8, row,
+					nvme_ctrl_get_address(c), LEFT);
+			table_set_value_str(t, 9, row,
+					nvme_ctrl_get_state(c), LEFT);
+
+			table_add_row(t, row);
+			first = false;
+		}
+	}
+	table_print(t);
+free_tbl:
+	table_free(t);
+}
+
 static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 						     enum nvme_cli_topo_ranking ranking)
 {
@@ -5660,6 +5743,62 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 	}
 }
 
+static void stdout_tabular_subsystem_topology(nvme_subsystem_t s)
+{
+	nvme_ctrl_t c;
+	nvme_ns_t n;
+	int row;
+	struct table *t;
+	struct table_column columns[] = {
+		{"Namespace", LEFT, 0},
+		{"NSID", LEFT, 0},
+		{"Controller", LEFT, 0},
+		{"Trtype", LEFT, 0},
+		{"Address", LEFT, 0},
+		{"State", LEFT, 0},
+	};
+
+	t = table_init();
+	if (!t) {
+		printf("Failed to init table\n");
+		return;
+	}
+
+	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
+		printf("Failed to add columns\n");
+		goto free_tbl;
+	}
+
+	nvme_subsystem_for_each_ctrl(s, c) {
+		nvme_ctrl_for_each_ns(c, n) {
+			c = nvme_ns_get_ctrl(n);
+
+			row = table_get_row_id(t);
+			if (row < 0) {
+				printf("Failed to add row\n");
+				goto free_tbl;
+			}
+			table_set_value_str(t, 0, row,
+					nvme_ns_get_name(n), LEFT);
+			table_set_value_int(t, 1, row,
+					nvme_ns_get_nsid(n), CENTERED);
+			table_set_value_str(t, 2, row,
+					nvme_ctrl_get_name(c), LEFT);
+			table_set_value_str(t, 3, row,
+					nvme_ctrl_get_transport(c), LEFT);
+			table_set_value_str(t, 4, row,
+					nvme_ctrl_get_address(c), LEFT);
+			table_set_value_str(t, 5, row,
+					nvme_ctrl_get_state(c), LEFT);
+
+			table_add_row(t, row);
+		}
+	}
+	table_print(t);
+free_tbl:
+	table_free(t);
+}
+
 static void stdout_subsystem_topology(nvme_subsystem_t s,
 					   enum nvme_cli_topo_ranking ranking)
 {
@@ -5712,6 +5851,38 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
 	}
 }
 
+static void stdout_topology_tabular(nvme_root_t r)
+{
+	nvme_host_t h;
+	nvme_subsystem_t s;
+	bool first = true;
+
+	nvme_for_each_host(r, h) {
+		nvme_for_each_subsystem(h, s) {
+			bool no_ctrl = true;
+			nvme_ctrl_t c;
+
+			nvme_subsystem_for_each_ctrl(s, c)
+				no_ctrl = false;
+
+			if (no_ctrl)
+				continue;
+
+			if (!first)
+				printf("\n");
+			first = false;
+
+			stdout_subsys_config(s);
+			printf("\n");
+
+			if (nvme_is_multipath(s))
+				stdout_tabular_subsystem_topology_multipath(s);
+			else
+				stdout_tabular_subsystem_topology(s);
+		}
+	}
+}
+
 static void stdout_simple_topology(nvme_root_t r,
 				   enum nvme_cli_topo_ranking ranking)
 {
@@ -6330,6 +6501,7 @@ static struct print_ops stdout_print_ops = {
 	.topology_ctrl			= stdout_topology_ctrl,
 	.topology_namespace		= stdout_topology_namespace,
 	.topology_multipath		= stdout_topology_multipath,
+	.topology_tabular		= stdout_topology_tabular,
 
 	/* status and error messages */
 	.connect_msg			= stdout_connect_msg,
diff --git a/nvme-print.c b/nvme-print.c
index 473a6814..d1af8284 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1557,6 +1557,11 @@ void nvme_show_topology(nvme_root_t r,
 		nvme_print(topology_multipath, flags, r);
 }
 
+void nvme_show_topology_tabular(nvme_root_t r, nvme_print_flags_t flags)
+{
+	nvme_print(topology_tabular, flags, r);
+}
+
 void nvme_show_message(bool error, const char *msg, ...)
 {
 	struct print_ops *ops = nvme_print_ops(NORMAL);
diff --git a/nvme-print.h b/nvme-print.h
index 0f23b711..a7982566 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -107,6 +107,7 @@ struct print_ops {
 	void (*topology_ctrl)(nvme_root_t r);
 	void (*topology_namespace)(nvme_root_t r);
 	void (*topology_multipath)(nvme_root_t r);
+	void (*topology_tabular)(nvme_root_t r);
 
 	/* status and error messages */
 	void (*connect_msg)(nvme_ctrl_t c);
@@ -251,6 +252,7 @@ void nvme_show_list_ns(struct nvme_ns_list *ns_list,
 void nvme_show_topology(nvme_root_t t,
 			enum nvme_cli_topo_ranking ranking,
 			nvme_print_flags_t flags);
+void nvme_show_topology_tabular(nvme_root_t t, nvme_print_flags_t flags);
 
 void nvme_feature_show(enum nvme_features_id fid, int sel, unsigned int result);
 void nvme_feature_show_fields(enum nvme_features_id fid, unsigned int result, unsigned char *buf);
diff --git a/nvme.c b/nvme.c
index 86fb1d4b..c221bf24 100644
--- a/nvme.c
+++ b/nvme.c
@@ -544,6 +544,8 @@ int validate_output_format(const char *format, nvme_print_flags_t *flags)
 #endif /* CONFIG_JSONC */
 	else if (!strcmp(format, "binary"))
 		f = BINARY;
+	else if (!strcmp(format, "tabular"))
+		f = TABULAR;
 	else
 		return -EINVAL;
 
@@ -10152,6 +10154,7 @@ static int tls_key(int argc, char **argv, struct command *command, struct plugin
 static int show_topology_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Show the topology\n";
+	const char *output_format = "Output format: normal|json|binary|tabular";
 	const char *ranking = "Ranking order: namespace|ctrl|multipath";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
@@ -10220,7 +10223,10 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
 		return err;
 	}
 
-	nvme_show_topology(r, rank, flags);
+	if (flags & TABULAR)
+		nvme_show_topology_tabular(r, flags);
+	else
+		nvme_show_topology(r, rank, flags);
 
 	return err;
 }
diff --git a/nvme.h b/nvme.h
index f02f39ca..c4f0f0cf 100644
--- a/nvme.h
+++ b/nvme.h
@@ -39,6 +39,7 @@ enum nvme_print_flags {
 	JSON		= 1 << 1,	/* display in json format */
 	VS		= 1 << 2,	/* hex dump vendor specific data areas */
 	BINARY		= 1 << 3,	/* binary dump raw bytes */
+	TABULAR		= 1 << 4,	/* prints aligned columns for easy reading */
 };
 
 typedef uint32_t nvme_print_flags_t;
-- 
2.50.1


