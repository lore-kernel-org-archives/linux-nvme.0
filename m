Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E207CD37B9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 11:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8Siltx/i+/HSuTsHkWqty59zyFlmDMjsApojHjk0B4=; b=iQLUAhul/E/Jt4FRdNppdTNGd4
	2g6/y+M2nPssmGUW/TxYRIoi9MMzjvktwwhWIkcdZUIvcfIOxobbr8TyLnp980IuNgncsdGIjMPcg
	xxGPkINfZqjLm7uwgYcao+nEz65sYXdKZGTF0dLlV08nDD82tgiwwGyaYHTQFK3TOj7tN5E1z6XZJ
	CUptzlHxrBGpWotuuUlrUcGIlDJqvz9u/o1D6dvcjqng/AKQWS2XY20xGw9bgNvLiTWnv/Kt63dhg
	1usJonD0i0OSK4SDyZ7DIr+vZalpljhbGXlR0pHB0zrOrMgifL3uZqmDwFxGgv9ZsVAVJMT1QqJhH
	kDj0GeQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFP-0000000DQGl-3IcR;
	Mon, 11 May 2026 11:56:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPFJ-0000000DQCt-464R
	for linux-nvme@bombadil.infradead.org;
	Mon, 11 May 2026 11:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=J8Siltx/i+/HSuTsHkWqty59zyFlmDMjsApojHjk0B4=; b=Whue4Y/0hCvPZ7x75EAw5rH301
	+YCkw9xVPuS8+x1ZqfOJxO0VcH7MY64dqNc14b1YSPT31rcoJznfeAr92ZQQJGOSXQ0pgSeHbScDv
	mW7qCrYIZMlAwPvpSnyXOr58AU7k2iaUhWG8hi5BZmDKTDeXTwDTix+1BYwO+6Gkr4XCNKXlu351i
	/fBOp0JLLYYEtjKhNL/VF9ghdMEkoZNJIbu2UwW5lv+CF+zOju8/XakQY+SiGT8j1VZ/UWFfxyphW
	TClrEZU2/Ee9l4poCytRFGxxF+O36Ldnm69z6KzZRaWeVQcVz8zUnBpOx30kbfqdXSHezMP4jq6RQ
	YvY8S9WQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPF8-0000000BXgp-0HLJ
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 11:56:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANuQgX523107;
	Mon, 11 May 2026 11:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J8Siltx/i+/HSuTsH
	kWqty59zyFlmDMjsApojHjk0B4=; b=P1/qOJnpE+j+kQIPVcg1q9TFve6cHXn7g
	T44rJsG26fxMu0CMsMxvSMJqCePM1l5g/7nzjbFpRVgtdOOtn6iYjTbrXiWiOnC2
	tJwfL1dTqQFZKsNWYfPZfXlrKFPnOQgNbzSjbyOi1boE3As3cfYb5YX+Dr2IjD4e
	ynTXpu5S6WeoxHgoWhnVUn+xDnZ+78K7iYtWJXBGSHdnyCSd1smraKq9t8KYpGc3
	dGuLv91C1M4K1nxgQgo4KkiG99xptuE649ZRW5Dd8ryID61M+Zz40yUkI3ylLQTe
	JsuDnQp6eIF4uljRcKN43p5i2lufkPEpfLAa7BuKfe1k7xBXFrO6g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhqrme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BBsVFB008360;
	Mon, 11 May 2026 11:56:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4whd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 11:56:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BBu4H349873222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 11:56:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 970AC20043;
	Mon, 11 May 2026 11:56:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B5E20040;
	Mon, 11 May 2026 11:56:02 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 11:56:02 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 3/7] nvme: add support for float and double types in table_print_XXX()
Date: Mon, 11 May 2026 17:25:43 +0530
Message-ID: <20260511115555.2638335-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511115555.2638335-1-nilay@linux.ibm.com>
References: <20260511115555.2638335-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a01c3da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=baLtsfQgTZjGHMyQpWwA:9
X-Proofpoint-ORIG-GUID: RU5FD3xeVG2qQ0lZa6nl_-yC1Zu4suMz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEyOSBTYWx0ZWRfX47hTCIhNqAvr
 TdTg1tNyp6ae6XKP3tuACenHj5YdKT2RF/JZ8zUgxyL07itVZT2ZkPMZkIiXiFCbZqSTcR6TxZM
 UKbTxUFUD6+8eC3lt8IODC7jdeSYaipwDTpGIF1W63l03TNecNw0C1z/c9SVnkkZ6NLNZeJT2iQ
 gvdfLhYa604dheqDOuLkBIOk0hqyhW8vSfMw3LfdbuNYHpbud2hSF9UmwEUeyWKvt0+zQAWd8Tg
 6skIp7HtLB3D2ZlwAQcv8yLZz4bsJfE4G3GzrihF+txC/E02nD9RsfY9qj9CDUPwSg5t6eYVlpX
 Pxt+h9UVkjStEzSZUXfIAd9GGl8TAFggIg7xt0Uy+E3ddP4dcQYVvJy81utjwemH3T7XFds7HgA
 jEqKCuNemp/X1WsUlFoREFpqSLM1g3gnzwPm9s2T/7r9GNcDIkfg/N3Ucg4/r+6u0RZW6mPTCOf
 xm55gMCSqQb3EuTZIDw==
X-Proofpoint-GUID: RU5FD3xeVG2qQ0lZa6nl_-yC1Zu4suMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_125620_282555_623C754F 
X-CRM114-Status: GOOD (  17.68  )
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


