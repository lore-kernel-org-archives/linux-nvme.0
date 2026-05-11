Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242ACCD4842
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULt2gR3Nffbhefzqe2RElkUibwUCCk9figU6Hj5594c=; b=WJhsCPboFKjUZLzqxrtgewKnhA
	4SjKqUGaCsMLalf/wN0RuBap3ht+vfHVmkU5F3kzvUnKqTSTj3SuGtVaPpY9Ghbw0XgUO/0x0W7Dc
	CHj2FlKDc/mN6RQ3LtH15QDbCEbzMpQ6firGAiYiZuZOjFdiK/xJift3pwe1mFgkmcBGhFRDwlm7y
	qQMPjBWctrmDgZlhDq46tqPNdTm44BW02WV6wW9KAJYSQjk3gHlfj77V1aCV+1qeJ5Q14IBRgO2Bp
	S3kv43tiFy30oSj1nJc3FH/l23VqlgK239huctpdkWoI+kE5Gg7hA8CR6uZDq6EkVYw9dO+i2Sr/Q
	oaO/jcjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFM-0000000DQEj-09xe;
	Mon, 11 May 2026 11:56:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFH-0000000DQCX-3BFT
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ULt2gR3Nffbhefzqe2RElkUibwUCCk9figU6Hj5594c=; b=eVHzOvKlf/hPL6Lms4beP+NXrR
	6UYNTXXiUqK8q5DXmXog/NGuTcZJpkK6EHJUgYy5d4EAN6nP0otxsycfVfcR5ZnDVf4hXMyyF39FO
	RwsGLqVAyov5LBeGJpyfbYCLBoWnt72bqwVi2QenQ1zI7K4Pt5dc5eMERdgq8pX+Q227yFTKqgjqe
	rJpLqF/17EQNWuXW+m5St7UGnn/YfDpHbsLVS1mDghNWdCk2IX8CfhkabzQcybKVCktdKRAk93OMB
	CN6dEwMP0pIC3aavjrfp70GEHP4nNaGMuHRF8ckOOB2PvEshn5AtMZLi3IGvP5oflhRMMRaP/0HjJ
	z8RTFdow==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF9-0000000BXgq-0Asj
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:22 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BB5rMw3863469;
	Mon, 11 May 2026 11:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ULt2gR3Nffbhefzqe
	2RElkUibwUCCk9figU6Hj5594c=; b=cR0a57aeHLdcc0qVYJ1+bvI6oppbiGWy5
	bvC/V0wOio6wvh5Akv1MjzZ9fII7Lkv1uKfRZkMV9n5f4KtJqjRt0Ph8GZZZb8KC
	Iq8V7j2s2sqKSWHG63KBZSiKZL9x+7BFraEhUk11mcL1Jibfg/KOXZV62i2GkKw3
	V5DTiVIwCW8hnKs/o2ZyE+Z0zukskwi9S2DzWLoowCBk7GlcXJJh1sdwJIHlN8NX
	4S+e3hcw/wTdAtr8tSXahyawTN0rwC6tYBxmFBHDoTgT2YP2VUdg44G1ago+zuQ9
	whRgv8MZYKCwgCoqxkc6sh4mrFUozIZUwAIpPAsa6dmUIHmxw6MBg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4r23k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsY13010552;
	Mon, 11 May 2026 11:56:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q56tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBu6Ws13959560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D491C20043;
	Mon, 11 May 2026 11:56:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 061D220040;
	Mon, 11 May 2026 11:56:05 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:56:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 4/7] nvme: allow table output to be directed to a FILE stream
Date: Mon, 11 May 2026 17:25:44 +0530
Message-ID: <20260511115555.2638335-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01c3db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=QpZY1N37boQIoDvs5TcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX9CYeMBl0h7Mc
 MoObRUUJm7QKSoQjbIq7tSNItT6umbAj3Fsbb3+UGtDFYy/Rvzt41ogqAPuiuoS13uIpfnRA+OV
 pZ6dgikVcAXjfXYFsjPaFguKmXrtne5RSrmFyFXjM/r90QQqn1476qKmN+v1W2P1+HcpRgZFU32
 Xr4ShEjAGLaPfxnN0jhc446FVkZUA92c1e3+6wKfjMyJlCQNt+mTNqSvmHeDI3jxUe07sG6YzRN
 GdiCMuDJoDW6SfIh0Ivg1isO4JX0zgVKfioE/1ID6AHr+tUsuWrLWZod+ERqyvnZxR3VhCgz2Rg
 leM5Kx0xe8/nfyAO9nc+BkIBgvn1fsaFQucixY3kr4XqXCvsYPnZ4j+DCc/DHUsN1oq1Hvx7J/x
 MVFmgh2r2zM2NdKXa19/PiawqvTqwZZAhblTiLookOgQi+gxc6PAh2/E5p2eWkUAcu9FdCFTrIl
 3kysbK3/e2MlPYhhlmw==
X-Proofpoint-GUID: 8M4nmZEQszFrF8orbnxKJg8KKOcuaZpa
X-Proofpoint-ORIG-GUID: 8M4nmZEQszFrF8orbnxKJg8KKOcuaZpa
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
X-CRM114-CacheID: sfid-20260511_125620_228566_6E43469E 
X-CRM114-Status: GOOD (  17.24  )
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


