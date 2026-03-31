Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84BB109B473
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ia5Ty/oeq3gcUumq6RGAjuJk6QDvjeGX5TrmLFMEHgU=; b=AnlqgUo8ouJ9ZQ24hc3BWYBrGB
	B43vuV1cbO+pbz4nR7kiJV1Nj/XLRhJWNUC0ZiHgQDnq3wXHmCeW1DNZaEGsoqHuaH50diZZf0tEu
	mVXVaf0xQ8HS89q+2c1DqkFy/NxTKErEweFa8MPDUOw9vzUFlQFETilqis/e/Xahl1ccRfj1ifKo8
	o1RozEFbSYuEhS5B8cPOQxhUsRMsx71KFMiR537eIg9GPVcnbvujioOaYmAIYNcORDGP/yMQ8VP10
	d4je2T7PLua3U3DFx4CecejiuEXkV/sYPHV7xc5E+Tv87WayCShWpLC66oteiEAAMo+kEc/oks3Xv
	YOxX62lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpW-0000000D3AJ-115f;
	Tue, 31 Mar 2026 14:12:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpT-0000000D38u-0btm
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 14:12:28 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V892t4184140;
	Tue, 31 Mar 2026 14:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ia5Ty/oeq3gcUumq6
	RGAjuJk6QDvjeGX5TrmLFMEHgU=; b=LfvbkkCuDvewztK+Xflwx2BepFkI6K/cj
	Cwgksv9uFAtz+ap7FX6tuhvg9bvXqJxc0WJw5S0fBm89zveOuFIX3tpMdEoNppQn
	pHWz2cXbIlhrEWb/cvi+mFujWw/RLqlI376XimmyeZuFEiSTNYaVU5B8GdfGATlZ
	Cow88wkUESUIOS291O1vRtEuD5cbVeR1m6jTeIXux9mxhvTaJZdQs4e73EHOXayY
	GbYliUvSIsfUhjEV1WJoU1FFBNcBkEnPSbT4ymlmJc+GYnzJdT4+KYXb7ygVuHp/
	d5h0HI/u+8udlyEB78tL7U6OoHY/ZcleA2y1gmIVTQnhyXA9maoGg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnknmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCcIZo031007;
	Tue, 31 Mar 2026 14:12:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjs87h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VECLVG51577094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 14:12:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A5920040;
	Tue, 31 Mar 2026 14:12:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4775920043;
	Tue, 31 Mar 2026 14:12:20 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.210.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 14:12:20 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, gjoyce@linux.ibm.com
Subject: [PATCH 2/2] nvme-cli: extend show-topology tabular output for multipath subsys
Date: Tue, 31 Mar 2026 19:42:09 +0530
Message-ID: <20260331141215.3098243-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331141215.3098243-1-nilay@linux.ibm.com>
References: <20260331141215.3098243-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YlOXCcWJ4AqmvgJymzRu1GkSrgCldBJZ
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cbd64a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Er-MWHBOWmKJwVl43MEA:9
 a=LriSsk45NUu7uO0n:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNCBTYWx0ZWRfX3EwI1KmAGR1+
 UwDjoAFv8qHGWZsQLASC9DsL5NiIQ0gDGqXn3tgCk0osEkUSo8OoLtiZQiCOKtKLSPDJHMoQmtT
 D5fgWZIn1RoRg+DVYH7tbr/muti89IKbRFL+tNM5ENycR87iLJRlAoPmFiHHHhkegc+WNgDAaXG
 iL3MgbOF+nW2Oi4OMTetI4K5fi67RU9O7nTwWB7YNLOE6L7RRNC+EUiPCDIWR9tza7WTG5Z15Ul
 +HWR1aX9G6+TdOAM4wLf87layqKlNfp0EvDEj6j5Tp/uqM+TCvrSBjfReEw+XxBW2R1euYpDmn8
 Y2FeZgoTpzFMSDpR7mWYPSMDJDDy7cH9LVzTc8RRd/4DyXpmrgHlJeCOXAoV2MCa5iqRwqHca8u
 BtbAJ2FkTvQ8Q2Nn1FtSu1jCi+sV1040lWwTP6vMiC6+WrMLSS1JETMcNNAo6LGrc4ZwTyvZtfv
 Q/Itc4hi48jjkHADDFw==
X-Proofpoint-ORIG-GUID: YlOXCcWJ4AqmvgJymzRu1GkSrgCldBJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_071227_190162_FC0835B6 
X-CRM114-Status: GOOD (  23.33  )
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

The current tabular output of the show-topology command does not
display a controller if it has no associated nvme path or namespaces.
However, it is valid for a controller within a subsystem to have no
namespaces or paths attached.

In such cases, it is still useful to display controller information
such as the controller name, transport type, address, and state, while
leaving NVMe path and namespace-related fields (e.g., nsid, nshead,
nspath, anastate etc.) as "--".

Update the tabular output of the show-topology command to include
controllers and their associated fields regardless of whether any
namespaces are present. While we are at it, also dispaly the error
message using nvme_show_error() instead of using printf().

This change applies to NVMe multipath subsystems.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c | 156 +++++++++++++++++++++++++++++++-------------
 1 file changed, 111 insertions(+), 45 deletions(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 769afa695..064956138 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -5945,13 +5945,69 @@ static bool subsystem_iopolicy_filter(const char *name, void *arg)
 	return true;
 }
 
+static int subsystem_topology_multipath_add_row(struct table *t,
+						const char *iopolicy,
+						const char *nshead,
+						const char *nsid,
+						const char *nspath,
+						const char *anastate,
+						const char *iopolicy_info,
+						const char *ctrl,
+						const char *trtype,
+						const char *address,
+						const char *state)
+{
+	int row;
+	int col = -1;
+
+	row = table_get_row_id(t);
+	if (row < 0) {
+		nvme_show_error("Failed to add subsys topology multipath row");
+		return row;
+	}
+
+	/* col 0: NSHead */
+	table_set_value_str(t, ++col, row, nshead, CENTERED);
+
+	/* col 1: NSID */
+	table_set_value_str(t, ++col, row, nsid, CENTERED);
+
+	/* col 2: NSPath */
+	table_set_value_str(t, ++col, row, nspath, CENTERED);
+
+	/* col 3: ANAState */
+	table_set_value_str(t, ++col, row, anastate, CENTERED);
+
+	/* col 4: Nodes/Qdepth */
+	if (!strcmp(iopolicy, "numa") || !strcmp(iopolicy, "queue-depth"))
+		table_set_value_str(t, ++col, row, iopolicy_info, CENTERED);
+
+	/* col 5: Controller */
+	table_set_value_str(t, ++col, row, ctrl, CENTERED);
+
+	/* col 6: TrType */
+	table_set_value_str(t, ++col, row, trtype, CENTERED);
+
+	/* col 7: Address */
+	table_set_value_str(t, ++col, row, address, CENTERED);
+
+	/* col 8: State */
+	table_set_value_str(t, ++col, row, state, CENTERED);
+
+	table_add_row(t, row);
+
+	return 0;
+}
+
 static void stdout_tabular_subsystem_topology_multipath(nvme_subsystem_t s)
 {
 	nvme_ns_t n;
 	nvme_path_t p;
 	nvme_ctrl_t c;
-	int row, col;
 	bool first;
+	char nshead[32], nsid[32];
+	char iopolicy_info[256];
+	int ret, num_path;
 	struct table *t;
 	const char *iopolicy = nvme_subsystem_get_iopolicy(s);
 	struct table_column columns[] = {
@@ -5969,13 +6025,13 @@ static void stdout_tabular_subsystem_topology_multipath(nvme_subsystem_t s)
 
 	t = table_create();
 	if (!t) {
-		printf("Failed to init table\n");
+		nvme_show_error("Failed to init subsys topology multipath table");
 		return;
 	}
 
 	if (table_add_columns_filter(t, columns, ARRAY_SIZE(columns),
 			subsystem_iopolicy_filter, (void *)s) < 0) {
-		printf("Failed to add columns\n");
+		nvme_show_error("Failed to add subsys topology multipath columns");
 		goto free_tbl;
 	}
 
@@ -5984,61 +6040,71 @@ static void stdout_tabular_subsystem_topology_multipath(nvme_subsystem_t s)
 		nvme_namespace_for_each_path(n, p) {
 			c = nvme_path_get_ctrl(p);
 
-			row = table_get_row_id(t);
-			if (row < 0) {
-				printf("Failed to add row\n");
-				goto free_tbl;
-			}
-			/* For the first row we print actual NSHead name,
+			/*
+			 * For the first row we print actual NSHead name,
 			 * however, for the subsequent rows we print "arrow"
 			 * ("-->") symbol for NSHead. This "arrow" style makes
 			 * it visually obvious that susequenet entries (if
 			 * present) are a path under the first NSHead.
 			 */
-			col = -1;
-			/* col 0: NSHead */
 			if (first) {
-				table_set_value_str(t, ++col, row,
-						nvme_ns_get_name(n), LEFT);
+				snprintf(nshead, sizeof(nshead), "%s",
+						nvme_ns_get_name(n));
 				first = false;
 			} else
-				table_set_value_str(t, ++col, row,
-						"-->", CENTERED);
-			/* col 1: NSID */
-			table_set_value_int(t, ++col, row,
-					nvme_ns_get_nsid(n), CENTERED);
-			/* col 2: NSPath */
-			table_set_value_str(t, ++col, row,
-					nvme_path_get_name(p), LEFT);
-			/* col 3: ANAState */
-			table_set_value_str(t, ++col, row,
-					nvme_path_get_ana_state(p), LEFT);
+				snprintf(nshead, sizeof(nshead), "%s", "-->");
+
+			snprintf(nsid, sizeof(nsid), "%u", nvme_ns_get_nsid(n));
 
 			if (!strcmp(iopolicy, "numa"))
-				/* col 4: Nodes */
-				table_set_value_str(t, ++col, row,
-					nvme_path_get_numa_nodes(p), CENTERED);
+				snprintf(iopolicy_info, sizeof(iopolicy_info),
+					"%s", nvme_path_get_numa_nodes(p));
 			else if (!strcmp(iopolicy, "queue-depth"))
-				/* col 4 : Qdepth */
-				table_set_value_int(t, ++col, row,
-					nvme_path_get_queue_depth(p), CENTERED);
-
-			/* col 5: Controller */
-			table_set_value_str(t, ++col, row,
-					nvme_ctrl_get_name(c), LEFT);
-			/* col 6: TrType */
-			table_set_value_str(t, ++col, row,
-					nvme_ctrl_get_transport(c), LEFT);
-			/* col 7: Address */
-			table_set_value_str(t, ++col, row,
-					nvme_ctrl_get_traddr(c), LEFT);
-			/* col 8: State */
-			table_set_value_str(t, ++col, row,
-					nvme_ctrl_get_state(c), LEFT);
-
-			table_add_row(t, row);
+				snprintf(iopolicy_info, sizeof(iopolicy_info),
+					"%d", nvme_path_get_queue_depth(p));
+
+			ret = subsystem_topology_multipath_add_row(t,
+						    iopolicy,
+						    nshead,
+						    nsid,
+						    nvme_path_get_name(p),
+						    nvme_path_get_ana_state(p),
+						    iopolicy_info,
+						    nvme_ctrl_get_name(c),
+						    nvme_ctrl_get_transport(c),
+						    nvme_ctrl_get_traddr(c),
+						    nvme_ctrl_get_state(c));
+			if (ret < 0)
+				goto free_tbl;
 		}
 	}
+
+	/*
+	 * Next we print controller in the subsystem which may not have any
+	 * nvme path associated to it.
+	 */
+	nvme_subsystem_for_each_ctrl(s, c) {
+		num_path = 0;
+		nvme_ctrl_for_each_path(c, p)
+			num_path++;
+
+		if (!num_path) {
+			ret = subsystem_topology_multipath_add_row(t,
+					iopolicy,
+					"--", 	/* NSHead */
+					"--", 	/* NSID */
+					"--", 	/* NSPath */
+					"--", 	/* ANAState */
+					"--", 	/* Nodes/Qdepth */
+					nvme_ctrl_get_name(c),
+					nvme_ctrl_get_transport(c),
+					nvme_ctrl_get_traddr(c),
+					nvme_ctrl_get_state(c));
+			if (ret < 0)
+				goto free_tbl;
+		}
+	}
+
 	table_print(t);
 free_tbl:
 	table_free(t);
-- 
2.53.0


