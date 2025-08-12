Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9555C87FCB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pASGiW5CqxkrtB7uXEHLMTXJvtgAvdc+xFBCwDLnKs=; b=tXpjwRcPW9SBeSHJCSYcbp8bOo
	P7CA7xemq5S8DK11RP3lHvl5KEpONltRbzGnPMXjaaRsHYeYx29CLYpo0X/KWrJHWat/bsALtA+0C
	eA1KxJr+9DmrXe7cjfms92nI+luUXqiuprQ88NENNgZqpaH7xwvUG04y751HrjNYco38lVmajI031
	7dX0trmxwH+Vkt2ZlTJdd/dsl6zZwItTa+xQurvS64niI7hS0tveLIUxoiBt7JNBbwfjVdWmUKDE8
	Pcy/KHXdAlL16d7y0t5f2N2oY5L30bpibbEyw3w564X4WnzhgcwPGih1qQy4CuX0gqvEoS8Eat9gC
	M1/+tyHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulsqQ-0000000BZxl-2yPS;
	Tue, 12 Aug 2025 17:31:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uloYN-0000000AqlI-2il6
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 12:56:36 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CA6BTO021311;
	Tue, 12 Aug 2025 12:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5pASGi
	W5CqxkrtB7uXEHLMTXJvtgAvdc+xFBCwDLnKs=; b=PAqJlp8fZGR4gVAYFCTZ8R
	xyuM8QbXGFsAw8jbZnX7qREqT7PhJMqFeTOQ8zXozXGQLpSHW6s52oyafX7f3QGb
	x1+dMFqHq0Ms6GgVETVW8Ow4pKIRHsbzyNsP9LJZgUEEAL7m99mHrQlPGE4nnad8
	BuHBAvmWmxaAmWR+I6GZf6YAGIyc+elGidfR34V2JtGZP9LR8U010ILutPFAb/HR
	B6FM0dTDT+7VKKvXvaDLj4qhJ7T42t3B8GNX6ucjvGdjoDNoNxii5VUPKLOZ0I+E
	UCqY5DPO73uVgZTfMbYby5Lz0060oEHc+npRLb2NCZ4XoBELqLVCyTaedo/hIdIA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14eebb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C91KEY026275;
	Tue, 12 Aug 2025 12:56:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh212jvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 12:56:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CCuTY513042114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 12:56:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B782A2004B;
	Tue, 12 Aug 2025 12:56:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D756120043;
	Tue, 12 Aug 2025 12:56:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.161.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 12:56:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 3/4] nvme: add common APIs for printing tabular format output
Date: Tue, 12 Aug 2025 18:26:04 +0530
Message-ID: <20250812125614.164445-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812125614.164445-1-nilay@linux.ibm.com>
References: <20250812125614.164445-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BlbYSvD8c3R6EDGZoJAyV-OcRTL54Qxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEyMyBTYWx0ZWRfX/LnfOBEAC1X/
 ikk1y+9F8hW6OIWblYDdzf8GXD5FngGYF96YusJwpZphzfHfQUqsxZG2knmg2OOB1Qx2Jv1J5Uq
 2VRkrU1fo+ntmtlboZP9z0ymyyYBwsFE9TXdRShOo+DfYGq/UFBxhL06o+Tfyh6eWf+Hbj5aJ6H
 KrzqunUJHnuTuiD6L1X29fSQmoi6l67NBjo7gIPE6VlF8bNFe7peHEU8zs8yBwtHTpCsZbgbbO5
 pxW897Uvcou/azuMM3hSnnIRltPDN1PjdVvxfQbyvkc5oDBs1wdwpl+uKpWqOrzRxp4z0j4uINh
 6qBA92S5b6UOKijdOrnduzExV+cji5Nk3Y7wessrXSEcmW0I25QmgAn3fGoZVue1xSRC78RC2K5
 +iyonCZnM7jv5AAjtkZ2afv1N5dK6FeZCpu+wvD0NgGc7ZBDymKej22qLXhh0wCHRXjy9Vye
X-Proofpoint-GUID: BlbYSvD8c3R6EDGZoJAyV-OcRTL54Qxc
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689b3a01 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=4uDYPXIRBbESX5FRMbQA:9
 a=HnP58PXFyB9par0t:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120123
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_055635_699582_1F7A79FC 
X-CRM114-Status: GOOD (  32.42  )
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

Some nvme-cli commands, such as nvme list and nvme list -v, support output
in tabular format. Currently, the table output is not well aligned because
column widths are fixed at print time, regardless of the length of the data
in each column. This often results in uneven and hard-to-read output.For
any new CLI command that requires tabular output, developers must manually
specify the column width and row value width, which is both error-prone and
inconsistent.

This patch introduces a set of common table APIs that:
- Automatically calculate column widths based on the content
- Maintain proper alignment regardless of value length
- Simplify adding tabular output support to new and existing commands

The new APIs are:
1. table_init() — Allocate a table instance.
2. table_add_columns() — Add column definitions (struct table_column),
   including name and alignment (LEFT, RIGHT, CENTERED).
3. table_get_row_id() — Reserve a row index for inserting values.
4. table_add_row() — Add a row to the table.
5. table_print() — Print the table with auto-calculated widths.
6. table_free() — Free resources allocated for the table.

For adding values, the following setter APIs are provided, each
supporting alignment types (LEFT, RIGHT, or CENTERED):
- table_set_value_str()
- table_set_value_int()
- table_set_value_unsigned()
- table_set_value_long()
- table_set_value_unsigned_long()

Usage steps:
1. Call table_init() to create a table handle.
2. Define an array of struct table_column specifying column names and
   alignment, then call table_add_columns().
3. Obtain a row ID using table_get_row_id() and set values using the
   appropriate setter table APIs : table_set_value_*() function.
4. Add the completed row using table_add_row().
5. Repeat steps 3–4 for each additional row.
5. Call table_print() to display the table.
6. Call table_free() to release table resources.

With these APIs, developers no longer need to pre-calculate column or row
widths. The output is consistently aligned and easy to read.

Suggested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/meson.build |   3 +-
 util/table.c     | 278 +++++++++++++++++++++++++++++++++++++++++++++++
 util/table.h     | 117 ++++++++++++++++++++
 3 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 util/table.c
 create mode 100644 util/table.h

diff --git a/util/meson.build b/util/meson.build
index 75aed49c..5b402b1a 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -8,7 +8,8 @@ sources += [
   'util/sighdl.c',
   'util/suffix.c',
   'util/types.c',
-  'util/utils.c'
+  'util/utils.c',
+  'util/table.c'
 ]
 
 if json_c_dep.found()
diff --git a/util/table.c b/util/table.c
new file mode 100644
index 00000000..48918b37
--- /dev/null
+++ b/util/table.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * table.c : Common APIs for printing tabular format output.
+ *
+ * Copyright (c) 2025 Nilay Shroff, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+
+#include "table.h"
+
+static int table_get_value_width(struct value *v)
+{
+	char buf[64];
+	int len = 0;
+
+	switch (v->type) {
+	case FMT_STRING:
+		len = strlen((const char *)v->s);
+		break;
+	case FMT_INT:
+		len = snprintf(buf, sizeof(buf), "%d", v->i);
+		break;
+	default:
+		printf("Invalid print format!\n");
+		break;
+	}
+	return len;
+}
+
+static void table_print_centered(struct value *val, int width, enum fmt_type type)
+{
+	int i, len, left_pad, right_pad;
+	char buf[64];
+
+	if (type == FMT_STRING)
+		len = strlen(val->s);
+	else if (type == FMT_INT)
+		len = snprintf(buf, sizeof(buf), "%d", val->i);
+	else if (type == FMT_UNSIGNED)
+		len = snprintf(buf, sizeof(buf), "%u", val->u);
+	else if (type == FMT_LONG)
+		len = snprintf(buf, sizeof(buf), "%ld", val->ld);
+	else if (type == FMT_UNSIGNED_LONG)
+		len = snprintf(buf, sizeof(buf), "%lu", val->lu);
+	else {
+		fprintf(stderr, "Invalid format!\n");
+		return;
+	}
+
+	left_pad = (width - len) / 2;
+	right_pad = width - len - left_pad;
+
+	/* add left padding */
+	for (i = 0; i < left_pad; i++)
+		putchar(' ');
+
+	/* print value */
+	if (type == FMT_STRING)
+		printf("%s ", val->s);
+	else if (type == FMT_INT)
+		printf("%d ", val->i);
+	else if (type == FMT_UNSIGNED)
+		printf("%u ", val->u);
+	else if (type == FMT_LONG)
+		printf("%ld ", val->ld);
+	else if (type == FMT_UNSIGNED_LONG)
+		printf("%lu", val->lu);
+
+	/* add right padding */
+	for (i = 0; i < right_pad; i++)
+		putchar(' ');
+}
+
+static void table_print_columns(const struct table *t)
+{
+	int col, j, width;
+	struct table_column *c;
+	struct value v;
+
+	for (col = 0; col < t->num_columns; col++) {
+		c = &t->columns[col];
+		width = c->width;
+		if (c->align == LEFT)
+			width *= -1;
+
+		if (c->align == CENTERED) {
+			v.s = c->name;
+			v.align = c->align;
+			table_print_centered(&v, width, FMT_STRING);
+		} else
+			printf("%*s ", width, c->name);
+	}
+
+	printf("\n");
+
+	for (col = 0; col < t->num_columns; col++) {
+		for (j = 0; j < t->columns[col].width; j++)
+			putchar('-');
+		printf(" ");
+	}
+
+	printf("\n");
+}
+
+static void table_print_rows(const struct table *t)
+{
+	int row, col;
+	struct table_column *c;
+	struct table_row *r;
+	int width;
+	struct value *v;
+
+	for (row = 0; row < t->num_rows; row++) {
+		for (col = 0; col < t->num_columns; col++) {
+			c = &t->columns[col];
+			r = &t->rows[row];
+			v = &r->val[col];
+
+			width = c->width;
+			if (v->align == LEFT)
+				width *= -1;
+
+			if (v->align == CENTERED)
+				table_print_centered(v, width, v->type);
+			else {
+				switch (v->type) {
+				case FMT_STRING:
+					printf("%*s ", width, v->s);
+					break;
+
+				case FMT_INT:
+					printf("%*d ", width, v->i);
+					break;
+
+				case FMT_UNSIGNED:
+					printf("%*u ", width, v->u);
+					break;
+
+				case FMT_LONG:
+					printf("%*ld ", width, v->ld);
+					break;
+
+				case FMT_UNSIGNED_LONG:
+					printf("%*lu ", width, v->lu);
+					break;
+
+				default:
+					fprintf(stderr, "Invalid format!\n");
+					break;
+				}
+			}
+		}
+		printf("\n");
+	}
+}
+
+void table_print(struct table *t)
+{
+	/* first print columns */
+	table_print_columns(t);
+
+	/* next print rows */
+	table_print_rows(t);
+}
+
+int table_get_row_id(struct table *t)
+{
+	int row = t->num_rows;
+
+	t->rows = reallocarray(t->rows, (row + 1), sizeof(struct table_row));
+	if (!t->rows)
+		return -ENOMEM;
+
+	t->rows[row].val = calloc(t->num_columns, sizeof(struct value));
+	if (!t->rows->val) {
+		free(t->rows);
+		return -ENOMEM;
+	}
+
+	t->num_rows++;
+	return row;
+}
+
+void table_add_row(struct table *t, int row_id)
+{
+	int col, max_width, width;
+	struct table_row *row = &t->rows[row_id];
+
+	for (col = 0; col < t->num_columns; col++) {
+		max_width = t->columns[col].width;
+		width = table_get_value_width(&row->val[col]);
+		if (width > max_width)
+			t->columns[col].width = width;
+	}
+}
+
+struct table *table_init(void)
+{
+	struct table *t;
+
+	t = malloc(sizeof(struct table));
+	if (!t)
+		return NULL;
+
+	return t;
+}
+
+int table_add_columns(struct table *t, struct table_column *c, int num_columns)
+{
+	int col;
+
+	t->columns = calloc(num_columns, sizeof(struct table_column));
+	if (!t->columns)
+		return -ENOMEM;
+
+	t->num_columns = num_columns;
+
+	for (col = 0; col < num_columns; col++) {
+		t->columns[col].name = strdup(c[col].name);
+		if (!t->columns[col].name)
+			goto free_col;
+
+		t->columns[col].align = c[col].align;
+		t->columns[col].width = strlen(t->columns[col].name);
+	}
+
+	t->rows = NULL;
+	t->num_rows = 0;
+
+	return 0;
+free_col:
+	while (--col >= 0)
+		free(t->columns[col].name);
+	free(t->columns);
+	return -ENOMEM;
+}
+
+void table_free(struct table *t)
+{
+	int row, col;
+	struct table_row *r;
+	struct value *v;
+
+	/* free rows */
+	for (row = 0; row < t->num_rows; row++) {
+		r = &t->rows[row];
+		for (col = 0; col < t->num_columns; col++) {
+			v = &r->val[col];
+
+			if (v->type == FMT_STRING)
+				free(v->s);
+		}
+		free(r->val);
+	}
+	free(t->rows);
+
+	/* free columns */
+	for (col = 0; col < t->num_columns; col++)
+		free(t->columns[col].name);
+	free(t->columns);
+
+	/* free table */
+	free(t);
+}
diff --git a/util/table.h b/util/table.h
new file mode 100644
index 00000000..7477eba4
--- /dev/null
+++ b/util/table.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _TABLE_H_
+#define _TABLE_H_
+
+enum fmt_type {
+	FMT_STRING,
+	FMT_INT,
+	FMT_UNSIGNED,
+	FMT_LONG,
+	FMT_UNSIGNED_LONG,
+};
+
+enum alignment {
+	RIGHT,
+	LEFT,
+	CENTERED
+};
+
+struct value {
+	union {
+		char *s;
+		int i;
+		unsigned int u;
+		long ld;
+		unsigned long lu;
+	};
+	enum alignment align;
+	enum fmt_type type;
+};
+
+struct table_row {
+	struct value *val;
+};
+
+struct table_column {
+	char *name;
+	enum alignment align;
+	int width;		/* auto populated */
+};
+
+struct table {
+	struct table_column *columns;
+	int num_columns;
+	struct table_row *rows;
+	int num_rows;
+};
+
+static inline int table_set_value_str(struct table *t, int col,
+		int row, const char *str, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+	char *s;
+
+	s = strdup(str);
+	if (!s)
+		return -ENOMEM;
+
+	v->s = s;
+	v->align = align;
+	v->type = FMT_STRING;
+
+	return 0;
+}
+
+static inline void table_set_value_int(struct table *t, int col,
+		int row, int i, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->i = i;
+	v->align = align;
+	v->type = FMT_INT;
+}
+
+static inline void table_set_value_unsigned(struct table *t, int col,
+		int row, int u, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->u = u;
+	v->align = align;
+	v->type = FMT_UNSIGNED;
+}
+
+static inline void table_set_value_long(struct table *t, int col,
+		int row, long ld, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->ld = ld;
+	v->align = align;
+	v->type = FMT_LONG;
+}
+
+static inline void table_set_value_unsigned_long(struct table *t, int col,
+		int row, long lu, enum alignment align)
+{
+	struct table_row *r = &t->rows[row];
+	struct value *v = &r->val[col];
+
+	v->lu = lu;
+	v->align = align;
+	v->type = FMT_UNSIGNED_LONG;
+}
+
+struct table *table_init(void);
+int table_add_columns(struct table *t, struct table_column *c, int num_columns);
+int table_get_row_id(struct table *t);
+void table_add_row(struct table *t, int row);
+void table_print(struct table *t);
+void table_free(struct table *t);
+
+#endif /* _TABLE_H_ */
-- 
2.50.1


