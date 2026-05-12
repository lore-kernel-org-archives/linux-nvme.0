Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C814CD343F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8Siltx/i+/HSuTsHkWqty59zyFlmDMjsApojHjk0B4=; b=Sgq/84doxfcN+xceR1fWKlM+A8
	it9ulAmdOWCV3lSWMxmHPxJB31uoafDaqalB1cJ1+KV4yd11sMlg+TYG+a94kqF3P5a3ZJMuh4l8P
	hReD0w1nVomrbC7m25QJtrqrx7xwVlwfzKqKUB7n3trnCfcTxC9K4tE5YM48vVgZGQ2uzzqU7IkTX
	fPKs6hB1FGhpVynrBWBVb8ZJHDL7Isa2PM1tCrALSesXX7tbJ407IBKizcM9wEdVf4NzA5ND2mLrh
	hSdhgRqBNlAgyCItc1/hyQjKT80ro5VssnjGAc/gb57sq9nIsqgnXZN4ZoahBDGgDVUTasG98zYwq
	v7+FyU7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWj-00000000JCb-2KiR;
	Tue, 12 May 2026 20:16:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtWg-00000000JAu-23od
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 20:16:23 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCAfTJ3775703;
	Tue, 12 May 2026 20:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J8Siltx/i+/HSuTsH
	kWqty59zyFlmDMjsApojHjk0B4=; b=Tvw7eoKdosy1EN+edLSEVORKp54ThYLdo
	ScUszZz+PRZf2Y50xJKNGGeH9uir3qTMyK1NedJY0cjEWI9jldu3nZMM+foQgziM
	ZmkxBTpF9gOtWL1lqG9NpN/b778GkdcEFdKc3Lq48iqmP2UjuDmYZvUOnq5MCB8W
	FkpNQBIGlqnlCizKM+NH8P/VpQX+Dzm9tI2rHnDWud9mltk2qNwbav+1WpJS52w2
	SQebRrqrUlNaU8RLbVGaJ59jpfTyaS1COkJ83m7L0L2FqwcW+1X4HGUf9vsjB/8G
	rSQsA75PMA8sU7H19YYvaqR8ugnRz7YGG7R1rBxeY49/giCZy7rdg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6mm4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CK9a93026963;
	Tue, 12 May 2026 20:16:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgcrf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 20:16:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CKGEv321824176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 20:16:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F8620043;
	Tue, 12 May 2026 20:16:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760A620040;
	Tue, 12 May 2026 20:16:11 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.87.130.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 20:16:11 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv3 3/7] nvme: add support for float and double types in table_print_XXX()
Date: Wed, 13 May 2026 01:45:48 +0530
Message-ID: <20260512201559.3057514-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512201559.3057514-1-nilay@linux.ibm.com>
References: <20260512201559.3057514-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a038a92 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=baLtsfQgTZjGHMyQpWwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwNyBTYWx0ZWRfX29pNnAsxv8JK
 AZaRe18wwVBXsPtyxEb85qaqfXHEn6J5ye7rybNEKrcLLxH1qK8VglAgmXaCLnGYMls910cmFzT
 rF1MzyBNDE2xjeS7Gdjo4FAZX8wXStEecnV5pe+iPhArMCSyaBuFqPzeEeEElPmNty2wXCuEW6Z
 rNYodX83BUsuJXr92Y8NJGHrWh6axjm0wf12abV1U+1f9YfnxI+670qDVAlPUcviBzqeWp8HWaJ
 MeOwB/WQ/xNSNBVkl1AbIh7l/ZhjrCjnhZ4EQt3rnjtgB2qJYlcpIFwiSlOE7vR7QcTfCLJBqMt
 NJqPlE8TTdQx4kmRG0cM18o5rzBcEU+8b2FoaXo68wN8t1IgF1aqzeN61ExL0AsbPnrotQvA0W1
 Rr0zvPwWmWIw+3Vt5tW7yVcbtV30myU2sNYNbE90QvAfrJ2jelfjYYeWGTO5SA1RGWhRIKqyKsL
 vyj0lPf6s/Gv2p+xoKg==
X-Proofpoint-GUID: BdnTvgfD5oFvVWDaoWXWRGzT9fb53J4C
X-Proofpoint-ORIG-GUID: BdnTvgfD5oFvVWDaoWXWRGzT9fb53J4C
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
X-CRM114-CacheID: sfid-20260512_131622_641120_B2AA703A 
X-CRM114-Status: GOOD (  18.26  )
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

The table_print_XXX() APIs do not currently support printing values of
type float or double.

Add support for float and double so that these data types can be used
with the table printing helpers. This will be later used for printing
nvme-top stat.

While at it, switch error reporting to nvme_show_error() for
consistency with the rest of the code.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/table.c | 22 ++++++++++++++++++++--
 util/table.h | 26 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/util/table.c b/util/table.c
index 1fed89db8..60302fff7 100644
--- a/util/table.c
+++ b/util/table.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 #include <string.h>
 
+#include "nvme-print.h"
 #include "table.h"
 
 static int table_get_value_width(struct value *v)
@@ -43,8 +44,14 @@ static int table_get_value_width(struct value *v)
 	case FMT_LONG:
 		len = snprintf(buf, sizeof(buf), "%ld", v->ld);
 		break;
+	case FMT_FLOAT:
+		len = snprintf(buf, sizeof(buf), "%.2f", v->f);
+		break;
+	case FMT_DOUBLE:
+		len = snprintf(buf, sizeof(buf), "%.2f", v->d);
+		break;
 	default:
-		printf("Invalid print format!\n");
+		nvme_show_error("Invalid print format!\n");
 		break;
 	}
 	return len;
@@ -81,8 +88,14 @@ static void table_print_centered(struct value *val, int width, enum fmt_type typ
 		break;
 	case FMT_UNSIGNED_LONG:
 		printf("%lu", val->lu);
+	case FMT_FLOAT:
+		printf("%.2f", val->f);
+		break;
+	case FMT_DOUBLE:
+		printf("%.2f", val->d);
 		break;
 	default:
+		nvme_show_error("Invalid print format!\n");
 		break;
 	}
 
@@ -167,9 +180,14 @@ static void table_print_rows(const struct table *t)
 					break;
 				case FMT_UNSIGNED_LONG:
 					printf("%*lu", width, v->lu);
+				case FMT_FLOAT:
+					printf("%*.2f", width, v->f);
+					break;
+				case FMT_DOUBLE:
+					printf("%*.2f", width, v->d);
 					break;
 				default:
-					fprintf(stderr, "Invalid format!\n");
+					nvme_show_error("Invalid format!\n");
 					break;
 				}
 				break;
diff --git a/util/table.h b/util/table.h
index a2ab2860f..045ed2439 100644
--- a/util/table.h
+++ b/util/table.h
@@ -10,6 +10,8 @@ enum fmt_type {
 	FMT_UNSIGNED,
 	FMT_LONG,
 	FMT_UNSIGNED_LONG,
+	FMT_FLOAT,
+	FMT_DOUBLE,
 };
 
 enum alignment {
@@ -25,6 +27,8 @@ struct value {
 		unsigned int u;
 		long ld;
 		unsigned long lu;
+		float f;
+		double d;
 	};
 	enum alignment align;
 	enum fmt_type type;
@@ -135,6 +139,28 @@ static inline void table_set_value_unsigned_long(struct table *t, int col,
 	v->type = FMT_UNSIGNED_LONG;
 }
 
+static inline void table_set_value_float(struct table *t, int col,
+		int row, float f, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->f = f;
+	v->align = align;
+	v->type = FMT_FLOAT;
+}
+
+static inline void table_set_value_double(struct table *t, int col,
+		int row, double d, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->d = d;
+	v->align = align;
+	v->type = FMT_DOUBLE;
+}
+
 struct table *table_create(void);
 int table_add_columns(struct table *t, struct table_column *c, int num_columns);
 int table_add_columns_filter(struct table *t, struct table_column *c,
-- 
2.53.0


