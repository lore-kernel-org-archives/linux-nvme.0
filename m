Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB073FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A91qtCLgWSv9EAarpQPvAeBqTxGxwHrTL0unJiqPuMY=; b=0AdiCohXr1z6/9rCnKrDiU8AUE
	tC9Imq0OTCGRU/ILO50NFiELdw98XZUvJDs2WpQD/QluPdwhFq99wBYzGS3T6ot/ERt5pe4yESZjY
	seVpoLxUYI63Z+SSML4B36RrB/xxpx9UmFNfuowX+4iXEDH0xSJJhGJ4hABV9WQwVWdWPen+04KgM
	KQza+OELfXdvmv1FvLGyYV8ueS5DNxhWLnL36ML2hPAbA6eBJdlzg3bfjrlprgOYHYcgsTCh3kmRj
	D4sU6SnibC3Sl6Qv6RchpuTjjqnpn+K1oTbztKLIycmQuEXl3nTAGEak8qxyxEmGA8T3e/6ZQa6xI
	wF3GJdPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP14-00000005E7U-2Xsc;
	Thu, 30 Apr 2026 10:53:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP12-00000005E5o-2cAp
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:53:09 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U0vCYd3558379;
	Thu, 30 Apr 2026 10:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A91qtCLgWSv9EAarp
	QPvAeBqTxGxwHrTL0unJiqPuMY=; b=Dp/la67jYygRgVZW9HhrpPK/bf6WMKoly
	i70ZlBffxonvYpe2sl57Koe8phambz1qscjjxcl/NT3crJTtFK5xw2/70AeLyN8Z
	dL9SGnm8r8E6yfHM11+RD98xVlve2wmcpkSv7Afgj7+36U8V3CTv6pwEP3RN3JNJ
	kJAuGwFtDkst8eC+w36tnqYzUBvGo0R6hwK5myA5N026eU7OwfhgDTlhupM+kIst
	vAF8W2Mf0dJuDaTCHecCY0BK9eLlQRyeqG6bWjZvvDpI6hTTQMO+TFh5SaPgB6ix
	W/D/JXncn7QDHA8F5FasCIqVxA80XhRtGRmppKXxqgdDzd88gQopw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44ydf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAclGB006982;
	Thu, 30 Apr 2026 10:53:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkakkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAr0dI13893992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:53:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A02F20043;
	Thu, 30 Apr 2026 10:53:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7DEB20040;
	Thu, 30 Apr 2026 10:52:55 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:52:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 4/7] nvme: allow table output to be directed to a FILE stream
Date: Thu, 30 Apr 2026 16:22:25 +0530
Message-ID: <20260430105234.1172446-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bb_dYJzh84ArVI2hzFUmmQ0nrBaenx-V
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f33491 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ErdE4i3cOaMO9bKolGYA:9
X-Proofpoint-GUID: bb_dYJzh84ArVI2hzFUmmQ0nrBaenx-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfXy5I9ayJc6nhc
 4maBm3jHwGywrlFygodzWr8vnTqGddJDZT3CVfjxCb001NGtbKFI8Tp4KQbhPnWrllHOmjIAVNC
 npbllpBdKkQZikPqAtb6U8Aqnu9uv2CJlemJpwWL/tjCq87++eSVqQ8nZ4qdYC1apGTiltZR6U1
 sZjD0504ewQicQ+o2FXOUsB/4ISaLVzftuOmf6bs4NSfiYzart+bsjPvkfWbjN8dvWPYEB1VICk
 vkqHNRZs9uH4baciFQsVG4CQZb1cq8P8St3CikOx4NKxy/96u5bOfxWWf6DBmbo3PR7gyxWMTz1
 6N6yIxnuFA64kbGXMm6scyojmsOjKUuMtwln0ykrGT4kVecMswvJ0hwjJGpIi0dyuZzBST0F7ib
 +c67U1iydQM84Yuzuw6iHzE/A+SKAbzGbxKt20dpzWd32a2driHjfZueIfBZZI/MoUxBqlyucXH
 amlIq0p4OgtNZNf7kAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035308_666058_2366F3AD 
X-CRM114-Status: GOOD (  17.49  )
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
 util/table.h |  1 +
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/util/table.c b/util/table.c
index 19ee6c1e0..82ed53776 100644
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
index 045ed2439..26d6a52fa 100644
--- a/util/table.h
+++ b/util/table.h
@@ -169,6 +169,7 @@ int table_add_columns_filter(struct table *t, struct table_column *c,
 			void *arg);
 int table_get_row_id(struct table *t);
 void table_add_row(struct table *t, int row);
+void table_print_stream(FILE *stream, struct table *t);
 void table_print(struct table *t);
 void table_free(struct table *t);
 
-- 
2.53.0


