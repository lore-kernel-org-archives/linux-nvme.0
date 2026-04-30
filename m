Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F617FF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1Q0bQL+R3cflGMYPGow/6/pODkfMWCPJ4TvMzJA1EQ=; b=cNNRVsbBIDoO79APQVsdEHfIaX
	TpY1R8N9B1iUiscwf5YPddGH7AfQFI+7Zk6tNBRy38zXsmwUYKKRRGWIlmZpr1vx/LTd7ccsSak5y
	Yqs7anLsvNYVsCqesIAp5YVnJlXSL4u0yyrL5SI+WxmIKbW1G/CGQH5ITzh0tiJChWIwKmklIM8dX
	WWcj2SrSV0RXlOZlIlPXlOogWiqusRsaz8VvzuMx4jDpbG4aGU/SkTZWn5uw2Fwamy9YDxNXl1GQw
	goccPoQc4ThmSm2WaosNyfywrro3qbbGToSVFn+U0ZoTi3TTqbAZaAjmSn6GgzcfgNxZZvvHxfEQh
	oiFh5poQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP1G-00000005EEF-1EeE;
	Thu, 30 Apr 2026 10:53:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIP1C-00000005ECU-3uxb
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 10:53:20 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U8p18p3450963;
	Thu, 30 Apr 2026 10:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l1Q0bQ
	L+R3cflGMYPGow/6/pODkfMWCPJ4TvMzJA1EQ=; b=bD78tS/+YjWA9GFczzMnnn
	BiSG62anvTiAva0tvm8P9eVHsJ37swQ9vmgDvy1iY4hvF5KCoiJjPyBspYUJl+4P
	NxkG36DtnmiQvu8iSkiofrOc3zX0IWu/rfqBB76UfFQv5kqdEDpzfM8ROmhdleFc
	TpjZkZzefFeasGDcX2lXtDlJoDuS/o2hneJN2XEEEMekSTzUWy6prTVWcuELdylr
	CcdrVlpgSKXUTy3LGKJLQ/UML/0CMGjRQHHaGqs3FA3Q3rqQ4/8i2i3kIvTdUuHi
	UsD51GBe8+J8sD8bTmpocf/+YxhAT6TfvzxsTJ8WHYXJOO6LFXhOQ3cBJ2aJjx3w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5f91q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UAckCO032674;
	Thu, 30 Apr 2026 10:53:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehjgvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 10:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UArAXI27459860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 10:53:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BE2F2004B;
	Thu, 30 Apr 2026 10:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD3520043;
	Thu, 30 Apr 2026 10:53:05 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.102.217])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 10:53:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCH 6/7] nvme: add generic top-like dashboard framework
Date: Thu, 30 Apr 2026 16:22:27 +0530
Message-ID: <20260430105234.1172446-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f3349b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=m--PYSPP5Qbk68TkYnUA:9 a=uQPe_Wko71BXiCWw:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEwOSBTYWx0ZWRfX90gYZdDUicOA
 SwlIs1lPAsGzPNJ3RIKrocwDD1EiZkPsbusK4spkOVJ6nYvSQvilMEbpFxEYxPVsL6Z29uizjBI
 RROzpXIpUnYeKe8IRlP/6Gsew7olV2evYmIIkburIfqLDQCgp29Veq/QJI92InSx8RVfrqlPi9a
 eXSHLSsI5l2EL3zXCJ/l4qvXpZhA0Ij0/8ZVG4u98IQFgtaQwkXR1mFfrVEVDbV+u/f2NoW+0Pn
 qajiJh1hKRIrXeAQxgRQuib4d/sTd/Q1f6N3itdJn8wbkV0d3P34c/Xhskeg6W4lRAUov1TW+H7
 HjtL45VipU185bw3LtLcBSjhKUpV5fnLUDfVIz/iwVVPhqrUIvi0CiDI4YcE6yNP97jzyFLbj39
 qKOxBZUeJ9eAS++OPAP1wurASnUO2Z46J7UhSmX1jN+ZmJLpSbQwFzy8Wo/po1Df3khGYpycc1M
 hO8ucyIPy5kPFuP3vEQ==
X-Proofpoint-GUID: 5SOYiFPg80JuX5S_3Gmj-uOGbUZUl0Yv
X-Proofpoint-ORIG-GUID: 5SOYiFPg80JuX5S_3Gmj-uOGbUZUl0Yv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_035319_007171_F4902912 
X-CRM114-Status: GOOD (  35.92  )
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

Add a generic dashboard framework to support interactive, top-like
views. The framework renders data within a fixed-size window backed by
a larger buffer and provides event-driven APIs for updating the display.

Supported events:

- key input (ESC, Enter, 'q')
- escape sequences (up/down arrows)
- SIGWINCH for terminal resize handling
- periodic refresh via timeout
- kobject uevents (via netlink) to detect NVMe topology changes
  (subsystem, controller, namespace)
- reverse video highlighting for rows

Exported APIs:

- FILE *dashboard_init(struct dashboard_ctx **db_ctx, int interval)
  Initialize the dashboard context. Returns a FILE * stream used by the
  caller to write data for rendering. The returned context is used by
  all other dashboard APIs. The @interval is specified in seconds which
  represents the dashboard refresh interval.

- void dashboard_exit(struct dashboard_ctx *db_ctx)
  Tear down the dashboard and free all resources.

- int dashboard_draw_frame(struct dashboard_ctx *db_ctx, int scroll)
  Render the current frame. If @scroll is non-zero, adjust the view
  based on scrolling (up/down); otherwise render a new buffer.

- enum event_type dashboard_wait_for_event(struct dashboard_ctx *db_ctx)
  Wait for events such as key input, timeout, uevent, or SIGWINCH.
  Callers are expected to implement an event loop, and then based on
  returned event type take the action. For instance, if the returned
  event is timeout then caller shall update/refill the data store buffer
  and invoke dashboard_draw_frame() so that new/updated data could be
  rendered on dashboard . If the returned event type is up/down arrow
  keys then caller shall adjust the data start index in data store
  buffer and invoke dashboard_draw_frame() for rendering data. If the
  returned event type is key press 'ESC' or 'q' or kobject uevent then
  user shall take action as appropriate.

Reverse video helpers:

dashboard_{set,reset}_header_row_reverse()
dashboard_{set,reset}_footer_row_reverse()
dashboard_{set,reset}_data_row_reverse()

Additional getters/setters:

dashboard_get_interval()
dashboard_get_header_rows()
dashboard_set_header_rows()
dashboard_get_footer_rows()
dashboard_set_footer_rows()
dashboard_get_data_rows()
dashboard_get_data_start()
dashboard_set_data_start()
dashboard_get_frame_data_rows()

This framework is intended for use by nvme-top and similar tools that
require dynamic, event-driven terminal dashboards.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 util/dashboard.c | 851 +++++++++++++++++++++++++++++++++++++++++++++++
 util/dashboard.h |  53 +++
 util/meson.build |   3 +-
 3 files changed, 906 insertions(+), 1 deletion(-)
 create mode 100644 util/dashboard.c
 create mode 100644 util/dashboard.h

diff --git a/util/dashboard.c b/util/dashboard.c
new file mode 100644
index 000000000..b584561b6
--- /dev/null
+++ b/util/dashboard.c
@@ -0,0 +1,851 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * dashboard.c : Generic implementation for live dashboard.
+ *
+ * Copyright (c) 2026 Nilay Shroff, IBM
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
+#include <signal.h>
+#include <sys/select.h>
+#include <sys/ioctl.h>
+#include <termios.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <time.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <linux/netlink.h>
+#include <sys/socket.h>
+#include <asm/types.h>
+
+#include "sighdl.h"
+#include "common.h"
+#include "nvme-print.h"
+#include "dashboard.h"
+
+
+struct win_frame {
+	/* num of data rows which could fit in visible frame */
+	int data_rows;
+
+	/* Header start offset in window frame (always 0) */
+	int header_start_off;
+
+	/* data start offset in window frame */
+	int data_start_off;
+
+	/* footer start offset in window frame */
+	int footer_start_off;
+
+	/* Total num of rows in window frame */
+	int rows;
+};
+
+struct data_store {
+	/* mem-stream backing the buffer */
+	FILE *stream;
+
+	/* data buffer which is dynamically allocated by mem-stream  */
+	char *buf;
+	/* buffer length */
+	size_t len;
+
+	/* per-row offsets into the data buffer */
+	size_t *row_off;
+
+	/* header, data, footer, and total rows */
+	int header_rows;
+	int data_rows;
+	int footer_rows;
+	int num_rows;
+
+	/*
+	 * Index of the first data row to display. It can be adjusted
+	 * if user navigates/scrolls the screen using arrow keys.
+	 * Range: [0 - data_rows).
+	 */
+	int data_start_idx;
+
+	/* highlighted rows (reverse-video) */
+	int rev_header_row;
+	int rev_data_row;
+	int rev_footer_row;
+};
+
+struct dashboard_ctx {
+	struct data_store ds;	/* data store */
+	struct win_frame frame;	/* window frame */
+	int interval;		/* nvme top refresh interval in seconds */
+	int rem_interval;	/* remaining refresh interval */
+	int uevent_fd;		/* kernel uevent fd */
+	int term_fd;		/* controlling terminal fd */
+	sigset_t orig_set;	/* original signal mask of the calling thread */
+	struct termios orig_ts;	/* original termio settings of the controlling terminal */
+};
+
+/*
+ * The following comments describes how this generic dashboard implementation
+ * renders data using a fixed-size window frame backed by a potentially larger
+ * data store buffer. It clarifies offsets, row calculations, and scrolling
+ * behavior:
+ *
+ * Window Frame Layout (struct win_frame):
+ * ======================================
+ *    _ _ _ _ _ _ _ _ _ _ _ _ _ _ header_start_off
+ *  /            _ _ _ _ _ _ _ _  data_start_off
+ * |           /             _ _  footer_start_off
+ * |          |            /
+ * |          |            |
+ * v_ _ _ _ _ v _ _ _ _ _ _v_ _ _ _ _ _
+ * |          |            |           |
+ * |  header  |    data    |   footer  |
+ * |_ _ _ _ _ |_ _ _ _ _ _ |_ _ _ _ _ _|
+ * |<-------->|<---------->|<---------->
+ *                  ^     ^
+ *                  |     |
+ *                  |     \_ _ last_data_row
+ *                  \_ _ data_rows
+ *
+ * - The window frame represents the visible terminal screen area. It is
+ *   logically divided into three contiguous regions/sections:
+ *   header, data and footer.
+ * - The window frame size is limited by the terminal dimensions.
+ * - Header and footer sizes are fixed per dashboard layout.
+ * - The data area (includes area remaining after we account for space needed
+ *   for header and footer from the terminal screen area) expands or shrinks
+ *   based on available screen space.
+ *
+ * Data Store Buffer Layout (struct data_store):
+ * =============================================
+ *    _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _  header_start_off
+ *  /            _ _ _ _ _ _ _ _ _ _ _ data_start_off
+ * |           /                    _ _footer_start_off
+ * |          |                   /
+ * |          |                  |
+ * v_ _ _ _ _ v_ _ _ _ _ _ _ _ _ v_ _ _ _ _ _
+ * |          |                  |           |
+ * |  header  |       data       |   footer  |
+ * |_ _ _ _ _ |_ _ _ _ _ _ _ _ _ |_ _ _ _ _ _|
+ * |<-------->|<---------------->|<--------->|
+ * |    ^     ^          ^             ^     |
+ * |    |     |          |             |     |
+ * |    | data_start_idx |             \_ _ _|_footer_rows
+ * |    |                \_ _ _data_rows     |
+ * |    \_ _ _header_rows                    |
+ * |                                         |
+ * |<----------------num_rows -------------->|
+ *
+ *
+ * - The data store buffer holds the complete dashboard content generated at
+ *   each refresh interval. Its size may exceed the window frame, enabling
+ *   scrolling.
+ * - Represents the full logical dashboard content.
+ * - Used as the authoritative source for rendering.
+ * - Scrolling adjusts which portion of the data area is mapped into the
+ *   window frame.
+ *
+ * Relationship Between window frame and data store:
+ * =================================================
+ *  - The data store is transposed onto the window frame at render time.
+ *
+ *  a) Fixed relationship:
+ *     - Header always starts at offset 0.
+ *       In window frame, frame->header_start_off = 0
+ *       In data store, header_start_off = 0
+ *
+ *     - Header height is constant.
+ *       In window frame, frame->data_start_off = ds->header_rows
+ *       In data store, data_start_off = ds->header_rows + ds->data_start_idx
+ *
+ *  b) Footer placement:
+ *     - In the data store,
+ *       footer_start_off = ds->header_rows + ds->data_rows
+ *
+ *     - In the window frame,
+ *       frame->footer_start_off = frame->data_start_off + frame->data_rows
+ *
+ *     These two offsets (footer_start_off in data store and frame->footer_
+ *     start_off) may differ if the frame cannot display all data rows.
+ *
+ *  c) Scrolling Semantics:
+ *     - Scrolling affects only ds->data_start_idx.
+ *     - Header and footer remain pinned and are never scrolled.
+ *     - The frame’s data area acts as a viewport into the data store’s data
+ *       region.
+ *     - The ds->data_start_idx is adjusted based on the terminal scrolling.
+ *       For the first time when dashboard is displayed typically the value of
+ *       ds->data_start_idx is zero, but then if user scrolls the window then
+ *       ds->data_start_idx would be updated. The ds->data_start_idx should be
+ *       never set to less than zero and it should never execeed the num of data
+ *       rows available in the data staore buffer.
+ *
+ *  d) Last visible data row in window frame:
+ *
+ *     If in case window frame data area size is greater than the data store
+ *     data area then we would left with some empty space/rows in data area of
+ *     window frame. So we then clear the empty space beofre start drawing the
+ *     footer.
+ *
+ *     last_data_row = ds->header_rows + frame->data_rows
+ *     If last_data_row > ds->data_rows,
+ *     - The remaining frame rows are cleared.
+ *     - Footer is drawn immediately after the cleared region.
+ *
+ * Reverse-Video Highlighting:
+ * ===========================
+ *  The following fields indicate rows that should be rendered using reverse
+ *  video:
+ *  - rev_header_row
+ *  - rev_data_row
+ *  - rev_footer_row
+ *  These are relative to their respective sections and allow focused
+ *  highlighting.
+ */
+
+static void tty_reset(int fd, struct termios *ts)
+{
+	if (tcsetattr(fd, TCSANOW, ts) < 0)
+		nvme_show_perror("reset terminal attributes");
+}
+
+static int tty_set_raw(int fd, struct termios *ots)
+{
+	struct termios ts;
+
+	if (tcgetattr(fd, &ts) < 0) {
+		nvme_show_perror("get terminal attributes");
+		return -1;
+	}
+
+	*ots = ts;
+
+	ts.c_lflag &= ~(ICANON | ECHO);
+	ts.c_cc[VMIN] = 1;
+	ts.c_cc[VTIME] = 0;
+
+	if (tcsetattr(fd, TCSAFLUSH, &ts) < 0) {
+		nvme_show_perror("set terminal attributes");
+		return -1;
+	}
+
+	return 0;
+}
+
+int dashboard_get_interval(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->interval;
+}
+
+int dashboard_get_header_rows(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->ds.header_rows;
+}
+
+void dashboard_set_header_rows(struct dashboard_ctx *db_ctx, int rows)
+{
+	db_ctx->ds.header_rows = rows;
+}
+
+int dashboard_get_footer_rows(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->ds.footer_rows;
+}
+
+void dashboard_set_footer_rows(struct dashboard_ctx *db_ctx, int rows)
+{
+	db_ctx->ds.footer_rows = rows;
+}
+
+int dashoboard_get_data_rows(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->ds.data_rows;
+}
+
+int dashboard_get_data_start(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->ds.data_start_idx;
+}
+
+int dashboard_set_data_start(struct dashboard_ctx *db_ctx, int off)
+{
+	if (off >= db_ctx->ds.data_rows)
+		return -EINVAL;
+
+	db_ctx->ds.data_start_idx = off;
+
+	return 0;
+}
+
+int dashboard_get_frame_data_rows(struct dashboard_ctx *db_ctx)
+{
+	return db_ctx->frame.data_rows;
+}
+
+void dashboard_set_data_raw_reverse(struct dashboard_ctx *db_ctx, int row)
+{
+	db_ctx->ds.rev_data_row = row;
+}
+
+void dashboard_reset_data_raw_reverse(struct dashboard_ctx *db_ctx)
+{
+	db_ctx->ds.rev_data_row = -1;
+}
+
+void dashboard_set_header_raw_reverse(struct dashboard_ctx *db_ctx, int row)
+{
+	db_ctx->ds.rev_header_row = row;
+}
+
+void dashboard_reset_header_raw_reverse(struct dashboard_ctx *db_ctx)
+{
+	db_ctx->ds.rev_header_row = -1;
+}
+
+void dashboard_set_footer_raw_reverse(struct dashboard_ctx *db_ctx, int row)
+{
+	db_ctx->ds.rev_footer_row = row;
+}
+
+void dashboard_reset_footer_raw_reverse(struct dashboard_ctx *db_ctx)
+{
+	db_ctx->ds.rev_footer_row = -1;
+}
+
+static int wait_for_event(struct dashboard_ctx *db_ctx,
+		unsigned char *c, bool esc_seq)
+{
+	fd_set set;
+	struct timespec ts, t0, t1;
+	int ret, interval_sec, interval_nsec;
+	int term_fd = db_ctx->term_fd;
+	int uevent_fd = db_ctx->uevent_fd;
+	int max_fd = (term_fd > uevent_fd) ? term_fd : uevent_fd;
+
+	/* For escape sequence read, we wait for up to 1 ms. */
+	if (esc_seq) {
+		interval_sec = 0;
+		interval_nsec = 1000000;
+	} else {
+		/*
+		 * If previous pselect() woke up prematurely (might be due to
+		 * due to a key pressed other than allowed-key or non-nvme
+		 * uevent) then sleep for the remaining interval.
+		 */
+		interval_nsec = 0;
+		if (db_ctx->rem_interval)
+			interval_sec = db_ctx->rem_interval;
+		else
+			interval_sec = db_ctx->interval;
+	}
+	while (1) {
+		FD_ZERO(&set);
+		FD_SET(term_fd, &set);
+		FD_SET(uevent_fd, &set);
+again:
+		ts.tv_sec = interval_sec;
+		ts.tv_nsec = interval_nsec;
+
+		/*
+		 * Store the time when we start pselect; we may use it later to
+		 * compute the remaining time to sleep in case pselect breaks
+		 * out prematurely (maybe due to interrupted syscall or due to
+		 * any user input).
+		 */
+		clock_gettime(CLOCK_MONOTONIC, &t0);
+
+		ret = pselect(max_fd + 1, &set, NULL, NULL, &ts,
+				&db_ctx->orig_set);
+		if (ret < 0) {
+			if (errno == EINTR) {
+				/* Interrupted, signal is received ? */
+				if (nvme_sigwinch_received) {
+					struct winsize ws;
+
+					if (ioctl(db_ctx->term_fd, TIOCGWINSZ,
+							&ws) < 0)
+						return -1;
+
+					db_ctx->frame.rows = ws.ws_row;
+					nvme_sigwinch_received = false;
+
+					/*
+					 * Returning 0 would force screen redraw
+					 * based on the updated window size.
+					 */
+					return EVENT_TYPE_SIGWINCH;
+				}
+
+				/* recompute remaining time */
+				clock_gettime(CLOCK_MONOTONIC, &t1);
+				interval_sec = t1.tv_sec - t0.tv_sec;
+				goto again;
+			}
+
+			nvme_show_perror("pselect");
+			return EVENT_TYPE_ERROR;
+		}
+
+		if (ret == 0) {/* timed out waiting */
+			db_ctx->rem_interval = 0;
+			return EVENT_TYPE_TIMEOUT;
+		}
+
+		if (!esc_seq) {
+			/* recompute remaining time */
+			clock_gettime(CLOCK_MONOTONIC, &t1);
+			db_ctx->rem_interval = t1.tv_sec - t0.tv_sec;
+		}
+
+		if (FD_ISSET(uevent_fd, &set)) {
+			char buf[2048];
+			int i, n;
+			int is_subsys_block = 0, is_devname_nvme = 0;
+			int is_subsys_nvme_subsys = 0, is_subsys_nvme = 0;
+
+			while (1) {
+				n = read(uevent_fd, buf, sizeof(buf));
+				if (n < 0) {
+					if (errno == EINTR)
+						continue;
+
+					nvme_show_perror("read from uevent fd");
+					return n;
+				}
+
+				for (i = 0; i < n; ) {
+					char *s = &buf[i];
+
+					if (!strncmp(s, "SUBSYSTEM=block", 15))
+						is_subsys_block = 1;
+
+					if (!strncmp(s, "DEVNAME=nvme", 12))
+						is_devname_nvme = 1;
+
+					if (!strncmp(s,
+						"SUBSYSTEM=nvme-subsystem", 24))
+						is_subsys_nvme_subsys = 1;
+
+					if (!strncmp(s, "SUBSYSTEM=nvme", 14))
+						is_subsys_nvme = 1;
+
+					i += strlen(s) + 1;
+				}
+
+				if (is_subsys_block || is_subsys_nvme_subsys ||
+					is_subsys_nvme || is_devname_nvme)
+					return EVENT_TYPE_NVME_UEVENT;
+
+				break;
+			}
+		}
+
+		if (FD_ISSET(term_fd, &set)) {
+			while (1) {
+				ret = read(term_fd, c, 1);
+				if (ret < 0) {
+					if (errno == EINTR)
+						continue;
+					nvme_show_perror("read from term fd");
+					return EVENT_TYPE_ERROR;
+				}
+				if (ret == 1)
+					return EVENT_TYPE_KEY_PRESS;
+			}
+		}
+	}
+}
+
+enum event_type dashboard_wait_for_event(struct dashboard_ctx *db_ctx)
+{
+	int event;
+	unsigned char c;
+
+	while (1) {
+		event = wait_for_event(db_ctx, &c, 0);
+		switch (event) {
+		case EVENT_TYPE_ERROR:		/* fall through */
+		case EVENT_TYPE_TIMEOUT:	/* fall through */
+		case EVENT_TYPE_NVME_UEVENT:	/* fall through */
+		case EVENT_TYPE_SIGWINCH:
+			return event;
+		default:
+			if (c == 27) {	/* 'ESC' key */
+				/* read escape sequence */
+				event = wait_for_event(db_ctx, &c, 1);
+				switch (event) {
+				case EVENT_TYPE_ERROR:
+					return event;
+				case EVENT_TYPE_TIMEOUT:
+					return EVENT_TYPE_KEY_ESC;
+				default:
+					if (c == 91) {	/* '[' key */
+						event = wait_for_event(db_ctx, &c, 1);
+						switch (event) {
+						case EVENT_TYPE_ERROR:
+							return event;
+						case EVENT_TYPE_TIMEOUT:
+							break;
+						default:
+							if (c == 65)
+								return EVENT_TYPE_KEY_UP;
+							else if (c == 66)
+								return EVENT_TYPE_KEY_DOWN;
+							/* else ignore */
+							break;
+						}
+					} /* else ignore */
+					break;
+				}
+			} else if (c == '\n' || c == '\r') {
+				return EVENT_TYPE_KEY_RETURN;
+			} else if (c == 'q') {
+				return EVENT_TYPE_KEY_QUIT;
+			} /* else ignore */
+			break;
+		}
+	}
+}
+
+static void draw_line(int row, char *buf, bool reverse)
+{
+	/* move cursor to @row */
+	printf("\033[%d;1H", row);
+
+	/* clear the row */
+	printf("\033[2K");
+
+	if (reverse)
+		printf("\033[7m");	/* turn on reversed video */
+
+	if (buf) {
+		/*
+		 * As we move cursor to individual row and print each line,
+		 * we don't need to print '\n'.
+		 */
+		while (*buf != '\n' && *buf != '\0')
+			putchar(*buf++);
+	}
+
+	if (reverse)
+		printf("\033[m");	/* turn off reversed video */
+}
+
+int dashboard_draw_frame(struct dashboard_ctx *db_ctx, int scroll)
+{
+	char *pos;
+	int header_start_off, header_end_off;
+	int footer_start_off, footer_end_off;
+	int data_start_off, data_end_off, data_rows;
+	int row, off, num, resrv_rows;
+	int rev_header_off = -1, rev_data_off = -1, rev_footer_off = -1;
+	struct data_store *ds = &db_ctx->ds;
+	FILE *stream = ds->stream;
+	struct win_frame *frame = &db_ctx->frame;
+
+	/*
+	 * If this is scrolling update then just re-adjust the rows in a frame
+	 * otherwise we repaint the enitre frame post processing the screen
+	 * buffer.
+	 */
+	if (!scroll) {
+		/* flushing stream would synchronize screen buffer */
+		fflush(stream);
+
+		/*
+		 * Rewind the stream to reset the file offset position to the
+		 * start of the buffer.
+		 */
+		rewind(stream);
+
+		/* If there's nothing to print then return early. */
+		if (!ds->len)
+			return 0;
+
+		ds->buf[ds->len] = '\0';
+
+		/*
+		 * Parse screen buffer to find num of rows in the buffer (each
+		 * row ends with new-line) and annotate each row offset. As we
+		 * render the dashboard line by line we count num of lines/rows
+		 * present in the data store buffer and then also calculate as
+		 * well as store the start offset of each line.
+		 */
+		ds->num_rows = 0;
+		pos = ds->buf;
+		while (*pos) {
+			if (*pos++ == '\n')
+				ds->num_rows++;
+		}
+
+		/* If there're no lines in the buffer then return. */
+		if (!ds->num_rows) {
+			nvme_show_error("data buffer doesn't contain any line");
+			return -EINVAL;
+		}
+
+		free(ds->row_off);
+
+		ds->row_off = calloc(ds->num_rows, sizeof(*ds->row_off));
+		if (!ds->row_off) {
+			nvme_show_error("Failed to allocate row offset buffer");
+			return -ENOMEM;
+		}
+
+		num = 0;
+		ds->row_off[num] = 0;	/* first line starts at offset 0 */
+		pos = ds->buf;
+		while (*pos && num + 1 < ds->num_rows) {
+			if (*pos++ == '\n')
+				ds->row_off[++num] = pos - ds->buf;
+		}
+	}
+
+	/*
+	 * Calculate the number of rows that can be displayed in a single
+	 * screen frame. Printing more rows than could fit on the one screen
+	 * causes the terminal to scroll, leading to noticeable flicker and a
+	 * cluttered dashboard display.
+	 * We draw the dashboard data including header and footer. We know
+	 * the current window size and hence we reserved rows for header and
+	 * footer first. Then whatever num of rows are remaining is used to
+	 * draw the data.
+	 */
+	resrv_rows = ds->header_rows + ds->footer_rows;
+	frame->data_rows = frame->rows - resrv_rows;
+
+	/*
+	 * If the current window size is less than num of reserved rows
+	 * (i.e. header + footer) then we can't draw frame. In such case
+	 * return without drawig anything.
+	 */
+	if (frame->data_rows < 0)
+		return 0;
+
+	frame->header_start_off = header_start_off = 0;
+	header_end_off = header_start_off + ds->header_rows;
+
+	/* total num of data rows present in the current screen buffer */
+	ds->data_rows = ds->num_rows - resrv_rows;
+
+	/*
+	 * Num of data rows which should be printed starting at index
+	 * @ds->data_start_idx.
+	 */
+	data_rows = ds->data_rows - ds->data_start_idx;
+
+	/*
+	 * Calculate data rows which could be actually accomodated in the
+	 * current frame. If @data_rows is greater than @frame->data_rows
+	 * then we clamp it to frame->data_row.
+	 */
+	data_rows = min(data_rows, frame->data_rows);
+	data_start_off = ds->header_rows + ds->data_start_idx;
+	data_end_off = data_start_off + data_rows;
+
+	frame->data_start_off = frame->header_start_off + ds->header_rows;
+
+	frame->footer_start_off = frame->data_start_off + frame->data_rows;
+	footer_start_off = ds->header_rows + ds->data_rows;
+	footer_end_off = footer_start_off + ds->footer_rows;
+
+
+	 /* print header */
+	if (ds->rev_header_row >= 0)
+		rev_header_off = ds->rev_header_row;
+
+	for (off = header_start_off, row = frame->header_start_off + 1;
+			off < header_end_off; off++, row++)
+		draw_line(row, ds->buf + ds->row_off[off],
+				off == rev_header_off);
+
+	/* print data */
+	if (ds->rev_data_row >= 0)
+		rev_data_off = ds->header_rows + ds->rev_data_row;
+
+	for (off = data_start_off, row = frame->data_start_off + 1;
+			off < data_end_off; off++, row++)
+		draw_line(row, ds->buf + ds->row_off[off],
+				off == rev_data_off);
+
+	/*
+	 * Clear remaining data rows, if any. If @data_rows is less than the
+	 * @frame->data_rows then we would have some empty rows at the end of
+	 * data and we have to clear it off.
+	 */
+	if (data_rows < frame->data_rows) {
+		int last_data_row = ds->header_rows + frame->data_rows;
+
+		for (row = frame->data_start_off + data_rows + 1;
+				row <= last_data_row; row++)
+			draw_line(row, NULL, false);
+	}
+
+	/* print footer */
+	if (ds->rev_footer_row >= 0)
+		rev_footer_off = ds->header_rows + ds->data_rows +
+					ds->rev_footer_row;
+
+	for (off = footer_start_off, row = frame->footer_start_off + 1;
+			off < footer_end_off; off++, row++)
+		draw_line(row, ds->buf + ds->row_off[off],
+				off == rev_footer_off);
+
+	fflush(stdout);
+
+	return 0;
+}
+
+void dashboard_reset(struct dashboard_ctx *db_ctx)
+{
+	dashboard_set_header_rows(db_ctx, 0);
+	dashboard_set_data_start(db_ctx, 0);
+	dashboard_set_footer_rows(db_ctx, 0);
+
+	dashboard_reset_data_raw_reverse(db_ctx);
+	dashboard_reset_header_raw_reverse(db_ctx);
+	dashboard_reset_footer_raw_reverse(db_ctx);
+
+	fflush(db_ctx->ds.stream);
+
+	/* clear screen */
+	printf("\033[2J");
+}
+
+static int dashboard_uevent_fd(void)
+{
+	int fd, ret;
+	struct sockaddr_nl sa;
+
+	fd = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_KOBJECT_UEVENT);
+	if (fd < 0) {
+		nvme_show_perror("uevent socket");
+		return fd;
+	}
+
+	sa.nl_family = AF_NETLINK;
+	sa.nl_pad = 0;
+	sa.nl_pid = getpid();
+	sa.nl_groups = 1;
+
+	ret = bind(fd, (struct sockaddr *)&sa, sizeof(struct sockaddr_nl));
+	if (ret < 0) {
+		nvme_show_perror("uevent bind");
+		return ret;
+	}
+
+	return fd;
+}
+
+FILE *dashboard_init(struct dashboard_ctx **db_ctx, int refresh_interval)
+{
+	sigset_t sigwinch_set;
+	struct termios ts;
+	struct winsize ws;
+	struct data_store *ds;
+	struct dashboard_ctx *ctx;
+
+	ctx = malloc(sizeof(struct dashboard_ctx));
+	if (!ctx)
+		return NULL;
+	memset(ctx, 0, sizeof(struct dashboard_ctx));
+
+	ctx->interval = refresh_interval;
+
+	ctx->term_fd = open(ctermid(NULL), O_RDWR);
+	if (ctx->term_fd < 0) {
+		nvme_show_perror("open controlling terminal");
+		return NULL;
+	}
+
+	/*
+	 * listen for kobject uevent
+	 */
+	ctx->uevent_fd = dashboard_uevent_fd();
+
+	/*
+	 * First block SIGWINCH and note down the current window size; we'd
+	 * later atomically unblock SIGWINCH and wait for both user input and
+	 * window size change events using pselect(). This ensures that we don't
+	 * miss window size change events.
+	 */
+	sigemptyset(&sigwinch_set);
+	sigemptyset(&ctx->orig_set);
+	sigaddset(&sigwinch_set, SIGWINCH);
+	/* block SIGWINCH */
+	sigprocmask(SIG_SETMASK, &sigwinch_set, &ctx->orig_set);
+	/* get current value of window size */
+	if (ioctl(ctx->term_fd, TIOCGWINSZ, &ws) < 0) {
+		nvme_show_perror("ioctl TIOCGWINSZ");
+		goto out;
+	}
+
+	ctx->frame.rows = ws.ws_row;
+
+	/* put terminal in raw mode */
+	if (tty_set_raw(ctx->term_fd, &ts) < 0) {
+		nvme_show_error("Failed to set tty in raw mode");
+		goto out;
+	}
+	ctx->orig_ts = ts;
+
+	ds = &ctx->ds;
+	ds->stream = open_memstream(&ds->buf, &ds->len);
+	if (!ds->stream) {
+		nvme_show_perror("open memstream");
+		goto reset;
+	}
+	ds->rev_data_row = ds->rev_header_row = ds->rev_footer_row = -1;
+
+	/* hide cursor */
+	printf("\033[?25l");
+
+	/* clear screen */
+	printf("\033[2J");
+	fflush(stdout);
+
+	*db_ctx = ctx;
+	return ds->stream;
+reset:
+	/* reset terminal */
+	tty_reset(ctx->term_fd, &ctx->orig_ts);
+out:
+	/* restore the original signal mask */
+	sigprocmask(SIG_SETMASK, &ctx->orig_set, NULL);
+	close(ctx->term_fd);
+	return NULL;
+}
+
+void dashboard_exit(struct dashboard_ctx *db_ctx)
+{
+	struct data_store *ds = &db_ctx->ds;
+
+	/* show cursor */
+	printf("\033[?25h\n");
+	fflush(stdout);
+
+	fclose(ds->stream);
+	free(ds->buf);
+	free(ds->row_off);
+
+	/* reset terminal */
+	tty_reset(db_ctx->term_fd, &db_ctx->orig_ts);
+
+	/* restore the original signal mask */
+	sigprocmask(SIG_SETMASK, &db_ctx->orig_set, NULL);
+	close(db_ctx->term_fd);
+	close(db_ctx->uevent_fd);
+	free(db_ctx);
+}
diff --git a/util/dashboard.h b/util/dashboard.h
new file mode 100644
index 000000000..71acd6467
--- /dev/null
+++ b/util/dashboard.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _DASHBOARD_H_
+#define _DASHBOARD_H_
+
+struct dashboard_ctx;
+
+enum event_type {
+	EVENT_TYPE_ERROR = -1,	/* error waiting for event */
+	EVENT_TYPE_TIMEOUT,	/* timed out waiting for event */
+
+	EVENT_TYPE_KEY_PRESS,	/* key pressed event */
+	EVENT_TYPE_KEY_ESC,	/* ESC key is pressed*/
+	EVENT_TYPE_KEY_UP,	/* UP arrow key is pressed */
+	EVENT_TYPE_KEY_DOWN,	/* DOWN arrow key is pressed */
+	EVENT_TYPE_KEY_RETURN,	/* Return/Enter key is pressed */
+	EVENT_TYPE_KEY_QUIT,	/* q is pressed */
+
+	EVENT_TYPE_NVME_UEVENT,	/* kobject uevent received; rescan topology */
+	EVENT_TYPE_SIGWINCH,	/* SIGWINCH received */
+};
+
+int dashboard_get_interval(struct dashboard_ctx *db_ctx);
+int dashboard_get_header_rows(struct dashboard_ctx *db_ctx);
+
+void dashboard_set_header_rows(struct dashboard_ctx *db_ctx, int rows);
+int dashboard_get_footer_rows(struct dashboard_ctx *db_ctx);
+
+void dashboard_set_footer_rows(struct dashboard_ctx *db_ctx, int rows);
+int dashoboard_get_data_rows(struct dashboard_ctx *db_ctx);
+
+int dashboard_get_data_start(struct dashboard_ctx *db_ctx);
+int dashboard_set_data_start(struct dashboard_ctx *db_ctx, int off);
+
+int dashboard_get_frame_data_rows(struct dashboard_ctx *db_ctx);
+
+void dashboard_set_data_raw_reverse(struct dashboard_ctx *db_ctx, int row);
+void dashboard_reset_data_raw_reverse(struct dashboard_ctx *db_ctx);
+
+void dashboard_set_header_raw_reverse(struct dashboard_ctx *db_ctx, int row);
+void dashboard_reset_header_raw_reverse(struct dashboard_ctx *db_ctx);
+
+void dashboard_set_footer_raw_reverse(struct dashboard_ctx *db_ctx, int row);
+void dashboard_reset_footer_raw_reverse(struct dashboard_ctx *db_ctx);
+
+int dashboard_draw_frame(struct dashboard_ctx *db_ctx, int scroll);
+enum event_type dashboard_wait_for_event(struct dashboard_ctx *db_ctx);
+
+FILE *dashboard_init(struct dashboard_ctx **db_ctx, int refresh_interval);
+void dashboard_reset(struct dashboard_ctx *db_ctx);
+void dashboard_exit(struct dashboard_ctx *db_ctx);
+
+#endif /* _DASHBOARD_H_ */
diff --git a/util/meson.build b/util/meson.build
index 42412705d..5656b14a6 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -14,7 +14,8 @@ else
         'util/suffix.c',
         'util/types.c',
         'util/utils.c',
-        'util/table.c'
+        'util/table.c',
+        'util/dashboard.c',
     ]
 
     if json_c_dep.found()
-- 
2.53.0


