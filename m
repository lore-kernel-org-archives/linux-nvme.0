Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E126E109B46F
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2026 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fi8t8uIH3UuE+GzXoaTKyMeymvNBtLp/WwK7zOXmaNE=; b=kaTuUQT5rIX1gWdNt1Gaq/goPx
	J0aXdWB8zc4DO41vL3tv7Tzr9yqh8kyf01rJR4zKCI2G74sqPF88AN46CN3FtRzi5hLbksL7DQhKJ
	jEEkrBHIjfOTZ7fk/IwXeKWh6TlL1PJ6ROr71luIAevpQSe495B7CRDclQwH5ktbRmOP0BIYUmfvG
	eUbYWNh9oJ+d0+ddKF5pp6uN3aauTN+yLFuXRMRSNykg48UpOyFoVr7JSHI1GTMBy7JoSnYi1gGXp
	5UBaSjToqd65ZrV9fS1vK/jFryavkYuCn3tNrPw1rRKuZHXecZ6shVB3/cYCpD8y9yS+uAHfaPGy0
	nZl2mgxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpV-0000000D39n-3xC9;
	Tue, 31 Mar 2026 14:12:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ZpS-0000000D38X-0JPV
	for linux-nvme@lists.infradead.org;
	Tue, 31 Mar 2026 14:12:27 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V94OEl458927;
	Tue, 31 Mar 2026 14:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fi8t8uIH3UuE+GzXo
	aTKyMeymvNBtLp/WwK7zOXmaNE=; b=h98wyr4k1Yu2gYETSdilRp1p5HFISXaST
	TicXCK6aiiSUQBKwbp6OUiZn4yLxZhKgPCK1hDy4fGpWpgIKsZYQcL9vBjSA8W1A
	1pO+/SFlMGHMKRuXUtFhZQoLyRjiZIhz1e8tno3PaqyHLgJGt4HsCL9UebOZY0hB
	zFfKzP3qhTNKc4shy7H3/6V+TwICE1X70WRdFaZtS3nTS6CvnOD1VGcznO3C4E5m
	Gzrsuzj0aEuTAGfEsUEAoca2PEc1jHCGSkq/1GN3AQaiaa4AqQ7oxevxLARHwN5x
	rTnfRuhgQz5A9TMpP+hnUH2HHCOQdVxQZ39rMOjLu5Z4D8+kGGHpA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms35c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCO22a031034;
	Tue, 31 Mar 2026 14:12:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjs87d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 14:12:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VECJ7955968244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 14:12:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2D220063;
	Tue, 31 Mar 2026 14:12:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F25920040;
	Tue, 31 Mar 2026 14:12:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.210.45])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 14:12:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, gjoyce@linux.ibm.com
Subject: [PATCH 1/2] nvme-cli: extend show-topology tabular output for non-multipath subsys
Date: Tue, 31 Mar 2026 19:42:08 +0530
Message-ID: <20260331141215.3098243-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331141215.3098243-1-nilay@linux.ibm.com>
References: <20260331141215.3098243-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cbd648 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=fqElqQA3mDRiD3W0JssA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzNCBTYWx0ZWRfX3DVMDrlnMbP8
 piRRFhPqAa0s8B5POPF5JjhUJB+GufwPQDcUvfAaVWgMyx5kEF7tdqGMP2wRPC+E/PfhJ6VphB9
 EAXqTGsp6bFiKbAH1PVz8/gy8Q5M063I/sHL8mrohHnWTMU3h1XNIHMVjLCRQLT2Ixk1+oHKnoY
 JPPE46MwAs1KyBunb4QrsGWLfUCr5JMnvluYrRq2KDxQYWl+1j/cfuyHITtInj2ypeVfpDMg09G
 5qtkWdCCLwn3P29Ol+Lv9qKx0+ONrEykvaqYI1OVWN55jdJr/gTK2gX0T77MWCkz7RzZiEMbIpi
 Xn9QvDFEiC3W+vncn19MiZ89du/Y02oSTqlZKLUJnDALinprKS3jSGa1l5Tj5ebwBZZtqcc3bOz
 dc+0R4dNqz0xqEIjZvGOG5h9Z0BEI93GFrNJ10JeCKP5yAPRvHhc7V3ddoaPfrjTYObjBSR6DZw
 VnALHWkhdo9k+CJ4smw==
X-Proofpoint-GUID: Hp_6gTAq8duDe_5hhHmJViefqPP7IQI8
X-Proofpoint-ORIG-GUID: Hp_6gTAq8duDe_5hhHmJViefqPP7IQI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_071226_236084_884CC67D 
X-CRM114-Status: GOOD (  21.83  )
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

The current tabular output of show-topology command does not display a
controller if it has no associated namespaces. However, it is valid
for a controller within a subsystem to have no namespaces attached.

In such cases, it is still useful to display controller information
such as the controller name, transport type, address, and state, while
leaving the namespace-related fields (e.g., namespace and nsid) as "--".

Update the tabular output of show-topology command to include
controllers and their associated fields regardless of whether any
namespaces are present. While we are at it, also dispaly the error
message using nvme_show_error() instead of using printf().

This change applies to non-multipath subsystems. A subsequent commit
will extend this behavior to multipath subsystems.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 nvme-print-stdout.c | 98 +++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 29 deletions(-)

diff --git a/nvme-print-stdout.c b/nvme-print-stdout.c
index 2e469ea50..769afa695 100644
--- a/nvme-print-stdout.c
+++ b/nvme-print-stdout.c
@@ -6148,11 +6148,48 @@ static void stdout_subsystem_topology_multipath(nvme_subsystem_t s,
 	}
 }
 
+static int subsystem_topology_add_row(struct table *t,
+				      const char *ns,
+				      const char *nsid,
+				      const char *ctrl,
+				      const char *trtype,
+				      const char *address,
+				      const char *state)
+{
+	int row = table_get_row_id(t);
+	if (row < 0) {
+		nvme_show_error("Failed to add subsys topology row");
+		return row;
+	}
+
+	/* col 0: Namespace */
+	table_set_value_str(t, 0, row, ns, CENTERED);
+
+	/* col 1: NSID */
+	table_set_value_str(t, 1, row, nsid, CENTERED);
+
+	/* col 2: Controller */
+	table_set_value_str(t, 2, row, ctrl, CENTERED);
+
+	/* col 3: Trtype */
+	table_set_value_str(t, 3, row, trtype, CENTERED);
+
+	/* col 4: Address */
+	table_set_value_str(t, 4, row, address, CENTERED);
+
+	/* col 5: State */
+	table_set_value_str(t, 5, row, state, CENTERED);
+
+	table_add_row(t, row);
+
+	return 0;
+}
+
 static void stdout_tabular_subsystem_topology(nvme_subsystem_t s)
 {
 	nvme_ctrl_t c;
 	nvme_ns_t n;
-	int row;
+	int ret, num_ns;
 	struct table *t;
 	struct table_column columns[] = {
 		{"Namespace", LEFT, 0},
@@ -6165,45 +6202,48 @@ static void stdout_tabular_subsystem_topology(nvme_subsystem_t s)
 
 	t = table_create();
 	if (!t) {
-		printf("Failed to init table\n");
+		nvme_show_error("Failed to init subsys topology table");
 		return;
 	}
 
 	if (table_add_columns(t, columns, ARRAY_SIZE(columns)) < 0) {
-		printf("Failed to add columns\n");
+		nvme_show_error("Failed to add subsys topology columns");
 		goto free_tbl;
 	}
 
 	nvme_subsystem_for_each_ctrl(s, c) {
-		nvme_ctrl_for_each_ns(c, n) {
-			c = nvme_ns_get_ctrl(n);
-
-			row = table_get_row_id(t);
-			if (row < 0) {
-				printf("Failed to add row\n");
+		num_ns = 0;
+
+		nvme_ctrl_for_each_ns(c, n)
+			num_ns++;
+
+		if (!num_ns) {
+			ret = subsystem_topology_add_row(t,
+					"--",	/* Namespace */
+					"--",	/* NSID */
+					nvme_ctrl_get_name(c),
+					nvme_ctrl_get_transport(c),
+					nvme_ctrl_get_traddr(c),
+					nvme_ctrl_get_state(c));
+			if (ret < 0)
 				goto free_tbl;
-			}
+		} else {
+			nvme_ctrl_for_each_ns(c, n) {
+				char nsid[32];
 
-			/* col 0: Namespace */
-			table_set_value_str(t, 0, row,
-					nvme_ns_get_name(n), LEFT);
-			/* col 1: NSID */
-			table_set_value_int(t, 1, row,
-					nvme_ns_get_nsid(n), CENTERED);
-			/* col 2: Controller */
-			table_set_value_str(t, 2, row,
-					nvme_ctrl_get_name(c), LEFT);
-			/* col 3: Trtype */
-			table_set_value_str(t, 3, row,
-					nvme_ctrl_get_transport(c), LEFT);
-			/* col 4: Address */
-			table_set_value_str(t, 4, row,
-					nvme_ctrl_get_traddr(c), LEFT);
-			/* col 5: State */
-			table_set_value_str(t, 5, row,
-					nvme_ctrl_get_state(c), LEFT);
+				snprintf(nsid, sizeof(nsid), "%u",
+						nvme_ns_get_nsid(n));
 
-			table_add_row(t, row);
+				ret = subsystem_topology_add_row(t,
+						nvme_ns_get_name(n),
+						(const char *)nsid,
+						nvme_ctrl_get_name(c),
+						nvme_ctrl_get_transport(c),
+						nvme_ctrl_get_traddr(c),
+						nvme_ctrl_get_state(c));
+				if (ret < 0)
+					goto free_tbl;
+			}
 		}
 	}
 	table_print(t);
-- 
2.53.0


