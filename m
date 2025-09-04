Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AEDCAC581
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHL7mWpI6j7rHhnWR6Gs5ZAJTteWl5wQ9ql2RZ/ZJk4=; b=jzNs3SqYLOpO12Kgu5R5enZ7AW
	alVKeaGYjWHZ2JljgV0oFtxEZRwoQrZaTyKBfrTzldEG+KGvrXR8QgGvyQxYwuwrtKzVNrTfFIr8/
	UKOt4tt7MRV5EB1VHVppb+c00Eq6wuw+sOOqZ7cBTi2zE8lnGPdKd/m8U7rWCXYL5gQG074grIEJC
	pWax+DXRgLIR3YgV2g9wWqVuZPNlVe/qFeg4FlUTQC1Qs+CKJFg8x4mIG2dm9y42fyMC1wbFMOT2v
	UZAB16zqGD8Oichym0LBdVV6FJLX+P/ksiPKlu81Kaw3/bGNlQwE+uWUafPYCaf94n9Aj7f253zYg
	nhR1mAbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuGc1-0000000EGd2-1lKc;
	Thu, 04 Sep 2025 20:31:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuECu-0000000DPVq-0IZT
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 17:57:13 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584HcFNM000683;
	Thu, 4 Sep 2025 17:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IHL7mWpI6j7rHhnWR
	6Gs5ZAJTteWl5wQ9ql2RZ/ZJk4=; b=Dz5NWAVvDjz1McrcOoOOdAsbjhqEpDs17
	jnpVAxfaKkL5VqqpdtepA46DDD66ZFmFYxMn5BmjyQtb/2eUcL9LlrmnKIhXfx+k
	iav7dyyLJbHCxsUgQp/eD2ZS5RcNwj9OhYr/855HOo4XcFNOavaOZt1YY/PeCu1X
	rEDPzvWfJpAZME0N8tF3/kEgzvrNa5Zc9QhSf+D4YnDmmLdDhSbAj0Fq/IvWD7UQ
	wQPXwOwffzLESBTNoIxhPcMxQHSdPZWBWoOct2Tl7mh8QYcW/ce6rpu41lFvVL9k
	ucFQ6GfQC/6k/Bo9051jgH5aYyPc0nzx6ynANIpwH+rE9oeEcbmOg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf7hw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584FiOAM019363;
	Thu, 4 Sep 2025 17:57:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n5n2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 17:57:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584Hv7Oo15139158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 17:57:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2A3C20040;
	Thu,  4 Sep 2025 17:57:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F162004B;
	Thu,  4 Sep 2025 17:57:05 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.24.25])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 17:57:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 4/4] nvme: add support for printing show-topology in tabular form
Date: Thu,  4 Sep 2025 23:26:51 +0530
Message-ID: <20250904175654.1183750-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175654.1183750-1-nilay@linux.ibm.com>
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ftXvyxjwjIAFm4aa3TfTJxwQ-FaMXuZh
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b9d2f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=p4JkK8WjJz4Is7kFgFgA:9
 a=2vx6RKudLRU5ZigS:21
X-Proofpoint-ORIG-GUID: ftXvyxjwjIAFm4aa3TfTJxwQ-FaMXuZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfXxEgMCCCRwSw9
 DfwHZe8yPxzrf2avYer8meJ3IuNsJy3YiNJq31oHfXT8cGN+dWFIV07sRyAoL3PeMnyYyq2XrAJ
 O5qY1NI6YB6NzpDH6IKMwIHHqKa5QtXfMO/+q3U61pRZwVZn376unkykAIXfgsq5NfKYtyA/2Pz
 VpfgI/3iu7MY6LeqnA1Dfh9jEwGg3/hqSOukw9jsjoRZJJ6QeRkYN8cUPUIiofan11Hl+Ex5abl
 qOkzqL98Z7Em7CzeStLkk/3lYshYm/50dER4n8ktxcHqOZfQKeo3GHBPr7yVXge76tnyJ0trFQd
 Lcd4+SavONZJSrxwhHz0rtsITQK1UbLNmRAzRh6G+xwOc4V0yRInSEqcNgD7NSSBp1uUvUNXXlK
 i35wkaI/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_105712_227670_867AF845 
X-CRM114-Status: GOOD (  29.65  )
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
 nvme-print-stdout.c | 218 ++++++++++++++++++++++++++++++++++++++++++++
 nvme-print.c        |   5 +
 nvme-print.h        |   2 +
 nvme.c              |   8 +-
 nvme.h              |   1 +
 5 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 204c8d9d..8b32eb7a 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -20,6 +20,7 @@
 #include "nvme-models.h"
 #include "util/suffix.h"
 #include "util/types.h"
+#include "util/table.h"
 #include "logging.h"
 #include "common.h"
 
@@ -5589,6 +5590,127 @@ static void stdout_list_items(nvme_root_t r)
 		stdout_simple_list(r);
 }
 
+static bool subsystem_iopolicy_filter(const char *name, void *arg)
+{
+	nvme_subsystem_t s = arg;
+	const char *iopolicy = nvme_subsystem_get_iopolicy(s);
+
+	if (!strcmp(iopolicy, "queue-depth")) {
+		/* exclude "Nodes" for iopolicy queue-depth */
+		if (!strcmp(name, "Nodes"))
+			return false;
+	} else if (!strcmp(iopolicy, "numa")) {
+		/* exclude "Qdepth" for iopolicy numa */
+		if (!strcmp(name, "Qdepth"))
+			return false;
+	} else { /* round-robin */
+		/* exclude "Nodes" and "Qdepth" for iopolicy round-robin */
+		if (!strcmp(name, "Nodes") || !strcmp(name, "Qdepth"))
+			return false;
+	}
+
+	return true;
+}
+
+static void stdout_tabular_subsystem_topology_multipath(nvme_subsystem_t s)
+{
+	nvme_ns_t n;
+	nvme_path_t p;
+	nvme_ctrl_t c;
+	int row, col;
+	bool first;
+	struct table *t;
+	const char *iopolicy = nvme_subsystem_get_iopolicy(s);
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
+
+	if (table_add_columns_filter(t, columns, ARRAY_SIZE(columns),
+			subsystem_iopolicy_filter, (void *)s) < 0) {
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
+			col = -1;
+			/* col 0: NSHead */
+			if (first) {
+				table_set_value_str(t, ++col, row,
+						nvme_ns_get_name(n), LEFT);
+				first = false;
+			} else
+				table_set_value_str(t, ++col, row,
+						"-->", CENTERED);
+			/* col 1: NSID */
+			table_set_value_int(t, ++col, row,
+					nvme_ns_get_nsid(n), CENTERED);
+			/* col 2: NSPath */
+			table_set_value_str(t, ++col, row,
+					nvme_path_get_name(p), LEFT);
+			/* col 3: ANAState */
+			table_set_value_str(t, ++col, row,
+					nvme_path_get_ana_state(p), LEFT);
+
+			if (!strcmp(iopolicy, "numa"))
+				/* col 4: Nodes */
+				table_set_value_str(t, ++col, row,
+					nvme_path_get_numa_nodes(p), CENTERED);
+			else if (!strcmp(iopolicy, "queue-depth"))
+				/* col 4 : Qdepth */
+				table_set_value_int(t, ++col, row,
+					nvme_path_get_queue_depth(p), CENTERED);
+
+			/* col 5: Controller */
+			table_set_value_str(t, ++col, row,
+					nvme_ctrl_get_name(c), LEFT);
+			/* col 6: TrType */
+			table_set_value_str(t, ++col, row,
+					nvme_ctrl_get_transport(c), LEFT);
+			/* col 7: Address */
+			table_set_value_str(t, ++col, row,
+					nvme_ctrl_get_address(c), LEFT);
+			/* col 8: State */
+			table_set_value_str(t, ++col, row,
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
 static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 						     enum nvme_cli_topo_ranking ranking)
 {
@@ -5693,6 +5815,69 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
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
+
+			/* col 0: Namespace */
+			table_set_value_str(t, 0, row,
+					nvme_ns_get_name(n), LEFT);
+			/* col 1: NSID */
+			table_set_value_int(t, 1, row,
+					nvme_ns_get_nsid(n), CENTERED);
+			/* col 2: Controller */
+			table_set_value_str(t, 2, row,
+					nvme_ctrl_get_name(c), LEFT);
+			/* col 3: Trtype */
+			table_set_value_str(t, 3, row,
+					nvme_ctrl_get_transport(c), LEFT);
+			/* col 4: Address */
+			table_set_value_str(t, 4, row,
+					nvme_ctrl_get_address(c), LEFT);
+			/* col 5: State */
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
@@ -5745,6 +5930,38 @@ static void stdout_subsystem_topology(nvme_subsystem_t s,
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
@@ -6363,6 +6580,7 @@ static struct print_ops stdout_print_ops = {
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
index 41d98a78..1cfac699 100644
--- a/nvme.c
+++ b/nvme.c
@@ -545,6 +545,8 @@ int validate_output_format(const char *format, nvme_print_flags_t *flags)
 #endif /* CONFIG_JSONC */
 	else if (!strcmp(format, "binary"))
 		f = BINARY;
+	else if (!strcmp(format, "tabular"))
+		f = TABULAR;
 	else
 		return -EINVAL;
 
@@ -10179,6 +10181,7 @@ static int tls_key(int argc, char **argv, struct command *command, struct plugin
 static int show_topology_cmd(int argc, char **argv, struct command *command, struct plugin *plugin)
 {
 	const char *desc = "Show the topology\n";
+	const char *output_format = "Output format: normal|json|binary|tabular";
 	const char *ranking = "Ranking order: namespace|ctrl|multipath";
 	nvme_print_flags_t flags;
 	_cleanup_nvme_root_ nvme_root_t r = NULL;
@@ -10247,7 +10250,10 @@ static int show_topology_cmd(int argc, char **argv, struct command *command, str
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
2.51.0


