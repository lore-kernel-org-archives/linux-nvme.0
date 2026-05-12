Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0969FCD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULt2gR3Nffbhefzqe2RElkUibwUCCk9figU6Hj5594c=; b=FLlg6XrZryn++G2iXvXkaOjDAJ
	lJA6sfBKBsi8beCjNAzy+0/NBZqhQflQXOJWoXOTlOGG++OufvraDVUJ+RT+BIRXBCklRAvJ6FDEx
	GyM4IVsYOkQ/a/X+ZMSjwAZ675JeJIoLXtKK4nheI2Sgid0MlHIotb6KmBlUowvmfAYFDtPmhqnTl
	fVET+tPOq8MhQY+gOQdMgaDrTf808rYsw0o8kmTmQRB92RLTc04Hboq3dw1KQ/3EUNy5GMrDHuHaQ
	nGLkg2kinTWErkgsVoPzTMf45mUObHZgy628nbyhb1Hb5eY6smXBwj6CErZX6Ads6sPF5fesLh0GH
	sj4igA1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWo-00000000JFb-3Wkm;
	Tue, 12 May 2026 20:16:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWm-00000000JEE-1uSi
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:29 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CC3PNH3773917;
	Tue, 12 May 2026 20:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ULt2gR3Nffbhefzqe
	2RElkUibwUCCk9figU6Hj5594c=; b=GadiL7UlY54Wx5hFEO6SEsexSFScKGbO9
	JHcHzCsPX93T5pADL+0wMyF9s+fbz6aUlaetWkGD/yrgv2LDOpSdARGxS689UjfT
	0c/nRlpu8WJD0ewGnkhQiD3tyALlNmUsoi6pFnGqP0QuHM4d+Wct757ILUScJb6P
	GGkuRZmhW3igkVKGksBSkHAYwtAOYQp+T5TwqVvYmhgJMxgaZOv8VfVYxo12PrNV
	MtPFhjwFCcgT+LRyHzfYkGmQf3hOAkUBvXeT4IwuoI7N4gI4Oim/qczDYxpA5Na7
	9ozbFlLYBE0YwvjO9ojYzRkqsGXblxxNqIt+FTmSnPVKlUrgsSjyg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6mm4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9x6Y021725;
	Tue, 12 May 2026 20:16:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgmqnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKGHM736634942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7EF820043;
	Tue, 12 May 2026 20:16:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE63420040;
	Tue, 12 May 2026 20:16:14 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 4/7] nvme: allow table output to be directed to a FILE stream
Date: Wed, 13 May 2026 01:45:49 +0530
Message-ID: <20260512201559.3057514-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a038a96 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QpZY1N37boQIoDvs5TcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfX4Zsp1HCWhJm/
 ie3J9kR2gnBwtSzf3NvGOQSsIHFkRd19ZU8MUS2d3OIkbweL8Bgr1RhbsQQijcK1X8mkis5c83P
 pva93GCxDJMKyrhBUijfHH8kOI9CmrFlr8YG45STKLPBSoY2JZGoYcg6WJTZUfWYNS10Bj4Lasc
 pEBAXoEdlc836K6KLIQOZjpWYlZpkFhNz4AZ+3wQLmaZRX0AvfFWEcVceHcWw3E3/NNfSiWJS0B
 saqEy32IlpPRd8r8LrDgJvK0MRH9oxZUyfPMtjOJdbzrx3CbHHrwX2jnvso5jeERGLAOgKVASek
 F80c3rL+DBX+il9bRjVHk3X6alvlmgNo1JPs7Lw/jPALUDyyc23uSNolXVD/KVeZvyRxilJG/9x
 NZuyzDhrSgddNLXODftbM+lHkFf/8Nf8W469r8E4t8DpFwQmRFG6Lb2/KdU9osY1iY8loMettzq
 JN9CiJRUkDxUcIYZwsQ==
X-Proofpoint-GUID: X3353FmzoGn1K0Q2xSHgtNMr3weQ6TS8
X-Proofpoint-ORIG-GUID: X3353FmzoGn1K0Q2xSHgtNMr3weQ6TS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131628_610294_F0EB849E 
X-CRM114-Status: GOOD (  17.83  )
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

The table APIs currently print output only to stdout. However, callers
may need to direct output to other destinations such as stderr, a file,
or an in-memory buffer.

Add support for passing a FILE * stream so callers can choose where the
table output is written.

This will be used by the nvme top dashboard to control how statistics
are displayed.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/table.c | 75 +++++++++++++++++++++++++++++-----------------------
 util/table.h |  2 ++
 2 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/util/table.c b/util/table.c
index 60302fff7..5f19a7aa1 100644
--- a/util/table.c
+++ b/util/table.c
@@ -57,7 +57,7 @@ static int table_get_value_width(struct value *v)
 	return len;
 }
 
-static void table_print_centered(struct value *val, int width, enum fmt_type type)
+static void table_print_centered(FILE *stream, struct value *val, int width)
 {
 	int i, len, left_pad, right_pad;
 
@@ -70,29 +70,30 @@ static void table_print_centered(struct value *val, int width, enum fmt_type typ
 
 	/* add left padding */
 	for (i = 0; i < left_pad; i++)
-		putchar(' ');
+		fputc(' ', stream);
 
 	/* print value */
 	switch (val->type) {
 	case FMT_STRING:
-		printf("%s", val->s);
+		fprintf(stream, "%s", val->s);
 		break;
 	case FMT_INT:
-		printf("%d", val->i);
+		fprintf(stream, "%d", val->i);
 		break;
 	case FMT_UNSIGNED:
-		printf("%u", val->u);
+		fprintf(stream, "%u", val->u);
 		break;
 	case FMT_LONG:
-		printf("%ld", val->ld);
+		fprintf(stream, "%ld", val->ld);
 		break;
 	case FMT_UNSIGNED_LONG:
-		printf("%lu", val->lu);
+		fprintf(stream, "%lu", val->lu);
+		break;
 	case FMT_FLOAT:
-		printf("%.2f", val->f);
+		fprintf(stream, "%.2f", val->f);
 		break;
 	case FMT_DOUBLE:
-		printf("%.2f", val->d);
+		fprintf(stream, "%.2f", val->d);
 		break;
 	default:
 		nvme_show_error("Invalid print format!\n");
@@ -101,10 +102,10 @@ static void table_print_centered(struct value *val, int width, enum fmt_type typ
 
 	/* add right padding */
 	for (i = 0; i < right_pad; i++)
-		putchar(' ');
+		fputc(' ', stream);
 }
 
-static void table_print_columns(const struct table *t)
+static void table_print_columns(FILE *stream, const struct table *t)
 {
 	int col, j, width;
 	struct table_column *c;
@@ -117,32 +118,33 @@ static void table_print_columns(const struct table *t)
 		case CENTERED:
 			v.s = c->name;
 			v.align = c->align;
-			table_print_centered(&v, width, FMT_STRING);
+			v.type = FMT_STRING;
+			table_print_centered(stream, &v, width);
 			break;
 		case LEFT:
 			width *= -1;
 			fallthrough;
 		default:
-			printf("%*s", width, c->name);
+			fprintf(stream, "%*s", width, c->name);
 			break;
 		}
 		if (col + 1 != t->num_columns)
-			putchar(' ');
+			fputc(' ', stream);
 	}
 
-	printf("\n");
+	fprintf(stream, "\n");
 
 	for (col = 0; col < t->num_columns; col++) {
 		for (j = 0; j < t->columns[col].width; j++)
-			putchar('-');
+			fputc('-', stream);
 		if (col + 1 != t->num_columns)
-			putchar(' ');
+			fputc(' ', stream);
 	}
 
-	printf("\n");
+	fprintf(stream, "\n");
 }
 
-static void table_print_rows(const struct table *t)
+static void table_print_rows(FILE *stream, const struct table *t)
 {
 	int row, col;
 	struct table_column *c;
@@ -151,15 +153,15 @@ static void table_print_rows(const struct table *t)
 	struct value *v;
 
 	for (row = 0; row < t->num_rows; row++) {
+		r = &t->rows[row];
 		for (col = 0; col < t->num_columns; col++) {
 			c = &t->columns[col];
-			r = &t->rows[row];
 			v = &r->val[col];
 
 			width = c->width;
 			switch (v->align) {
 			case CENTERED:
-				table_print_centered(v, width, v->type);
+				table_print_centered(stream, v, width);
 				break;
 			case LEFT:
 				width *= -1;
@@ -167,24 +169,25 @@ static void table_print_rows(const struct table *t)
 			default:
 				switch (v->type) {
 				case FMT_STRING:
-					printf("%*s", width, v->s);
+					fprintf(stream, "%*s", width, v->s);
 					break;
 				case FMT_INT:
-					printf("%*d", width, v->i);
+					fprintf(stream, "%*d", width, v->i);
 					break;
 				case FMT_UNSIGNED:
-					printf("%*u", width, v->u);
+					fprintf(stream, "%*u", width, v->u);
 					break;
 				case FMT_LONG:
-					printf("%*ld", width, v->ld);
+					fprintf(stream, "%*ld", width, v->ld);
 					break;
 				case FMT_UNSIGNED_LONG:
-					printf("%*lu", width, v->lu);
+					fprintf(stream, "%*lu", width, v->lu);
+					break;
 				case FMT_FLOAT:
-					printf("%*.2f", width, v->f);
+					fprintf(stream, "%*.2f", width, v->f);
 					break;
 				case FMT_DOUBLE:
-					printf("%*.2f", width, v->d);
+					fprintf(stream, "%*.2f", width, v->d);
 					break;
 				default:
 					nvme_show_error("Invalid format!\n");
@@ -193,19 +196,25 @@ static void table_print_rows(const struct table *t)
 				break;
 			}
 			if (col + 1 != t->num_columns)
-				putchar(' ');
+				fputc(' ', stream);
 		}
-		printf("\n");
+
+		fprintf(stream, "\n");
 	}
 }
 
-void table_print(struct table *t)
+void table_print_stream(FILE *stream, struct table *t)
 {
 	/* first print columns */
-	table_print_columns(t);
+	table_print_columns(stream, t);
 
 	/* next print rows */
-	table_print_rows(t);
+	table_print_rows(stream, t);
+}
+
+void table_print(struct table *t)
+{
+	table_print_stream(stdout, t);
 }
 
 int table_get_row_id(struct table *t)
diff --git a/util/table.h b/util/table.h
index 045ed2439..cb374947f 100644
--- a/util/table.h
+++ b/util/table.h
@@ -2,6 +2,7 @@
 #ifndef _TABLE_H_
 #define _TABLE_H_
 
+#include <stdio.h>
 #include <stdbool.h>
 
 enum fmt_type {
@@ -169,6 +170,7 @@ int table_add_columns_filter(struct table *t, struct table_column *c,
 			void *arg);
 int table_get_row_id(struct table *t);
 void table_add_row(struct table *t, int row);
+void table_print_stream(FILE *stream, struct table *t);
 void table_print(struct table *t);
 void table_free(struct table *t);
 
-- 
2.53.0


