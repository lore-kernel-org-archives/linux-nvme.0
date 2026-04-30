Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57445CCFA13
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWKCz9YU+vejlHql1kI2PYqXAtQBPrjv5W5WBNPvMUs=; b=fJe6vLbzAUoi/h9qn11vcanFR7
	BJmpSiWfbRueLYRPQshplxC4LNWLA5De/nBbe5JlvZadn1QCC7Wj+xXtqcUugm/UgUocQWSTfdoID
	DXSQ/jZicUyN7d/UgDN+kghjz/+grukWrdNWHirT31/yHn2htC/mWPOwqoI0/cJnvDXHPIlSus1Ea
	bULiND6vCvigdzOlTemnl8Bkl8rnPmnQAUzx7VFBBmbz7HLcWDfUkUVnzDJbuAV0jic+/zL7GSMWA
	M4NpHs8JaO9DFLBaLDT8+b4rTOxG1V3mkqkslM0r+m+Bqg1MzFPpmDOyQLzyXeVabZB9cUhdN9gBP
	WmJU8tkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0y-00000005E4H-38Kb;
	Thu, 30 Apr 2026 10:53:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP0w-00000005E3M-0BQi
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:53:03 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U9YoLl1473100;
	Thu, 30 Apr 2026 10:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pWKCz9YU+vejlHql1
	kI2PYqXAtQBPrjv5W5WBNPvMUs=; b=qLk5+dSMRP0fsnAyMBDjI4xB+aRohCjEA
	95kvMws9VtKtnTvfCwH+uu606N2IXZsqD+jnJFsQy+njDluht3fR9bLxkOVz9xAh
	tEQRiRUrZfoMP5JUwfIREFZIzbH0xWJiUzM8i/quvQ+vUMYwTTlXsfpyw4v63S1T
	LJz4OPAWoKbxccFx0Y2gPK1EFbEuHDFhmtIFEoL9Ca3TYM0nY2TFU+AHtKFOlajR
	GZe3VZm7xNVuZ4ehtcOudwqHk4rZuru8PE7udpepcFi19CbWC6/UvYBM5QxXCT/3
	Ho6b3HzrLA/5Z6t6uvX7HEHIUkyk9ZiFVugQfZlIL+xM9tWTlm33Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vnhen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAcj3W006970;
	Thu, 30 Apr 2026 10:52:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xkakk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:52:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UAqseU47251760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:52:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCC6A2004D;
	Thu, 30 Apr 2026 10:52:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B49B20040;
	Thu, 30 Apr 2026 10:52:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:52:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 3/7] nvme: add support for float and double types in table_print_XXX()
Date: Thu, 30 Apr 2026 16:22:24 +0530
Message-ID: <20260430105234.1172446-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f3348b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=baLtsfQgTZjGHMyQpWwA:9
X-Proofpoint-ORIG-GUID: p9VrqZL5lK8oZlUzHQtWBjm-K1JMY4JD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfXxiTdsPW/Ss7V
 Te9LumYAc/Jk5Hl0zFa/recC/fQhsMjcLn6YG74g/i7rV4ia93Z4515tpjkhLRn24hNfOCdV9yj
 BQb5e+xpyy7TyFYAe49g2Vs28UXWc76D4x0+UjaxIbnN/ZOiSSlcVe2g6vKvrBjMXGHVGIh7Y6Z
 M4LsCfLHPuO3O75W0QZeUN7THyh4HidZOsNKLtvY4An3Iotir1CJgW7SwQXI2HhIwjQIJiCSr7I
 T2kn8+zdDag4F7jSlI0KUfcbNLsmRgJaBqekOV9hOEn+Jb9mDbrsY3R/77nSwsoPXVE5tsmg7wy
 pxqzH4nms0U1r2iLsQSPSbg4f9xjv137dLQjHFkZQiPMSHv1fw0ey+b/ig8+MPN4u8HAg418rxB
 rPbbtq1/0FpseWJGmiwjr9Hke28EcmDQ1wjhir/EXNkHA3kmDkO/L2Wh2x7+JGjc6AncAMQgH05
 lH60cVMIkAtAJf9MG0A==
X-Proofpoint-GUID: p9VrqZL5lK8oZlUzHQtWBjm-K1JMY4JD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035302_201290_2AADE0F4 
X-CRM114-Status: GOOD (  18.25  )
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
index 1a69cd39a..19ee6c1e0 100644
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


