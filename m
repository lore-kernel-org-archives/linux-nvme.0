Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196ECCA9EC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603B20862
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gn8OXAye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EgvS3g5ULmuUVyeYKI2d47XjWbXKD+F9CuJgwmf+620=; b=Gn8OXAyeMqQaaS
	DcWsNnvHkSZY6D3F9Pqb9d9F1W7L2BozdOkKXydM5dnuw6tbjzDJI9AUmLe9hm2awaApHemmwrMWn
	YFny5s2ehqO1/7iCt5uoM3iC1/+3CRutAiCifQAxeKamo7uknA0ZD2eLlIzvHoIUrpMRhAdosm66N
	B5HmTGfMFaQiSzGmgtAzxf0tY9Zmz8rnBK3LHKEVrpuZ5gTAUdLrrpBXtvhfLpJkANOMgfgmxfVD8
	+KYf4/MpcBtN6QHUu5dS2tEWA3Vdmz7qMJNwcOGQ2M2lbHzd4Nn8bLipymBoiSZye1ifiFRQRBBLf
	5m2aK29Qv7EX8dMyMIuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPwQo-0002Z4-U5; Wed, 30 Oct 2019 22:27:10 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPwQm-0002YQ-1Z
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 22:27:09 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 15:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; d="scan'208";a="190427168"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga007.jf.intel.com with ESMTP; 30 Oct 2019 15:27:07 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.167]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.73]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 15:27:07 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/2] nvmet-tcp: enable polling option in io_work
Thread-Topic: [PATCH 1/2] nvmet-tcp: enable polling option in io_work
Thread-Index: AdWPcCRj0abE02mZRrKdz2Q1s1mxUA==
Date: Wed, 30 Oct 2019 22:27:07 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D4AFC5@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTkzMDE5ZDgtODVhNy00MGY5LWIwMDYtYTBhMjY0NmU2YjYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiemJDYWVPTzgzK2krZVBqelhMQ0t0YmZkRmk0ZEVobVJKTmVXR1N2YTd5SDRvY1VNSjNTT2Z2QmpMaTJBZURmQyJ9
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_152708_131403_7922DC4A 
X-CRM114-Status: GOOD (  15.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move to a do/while loop terminate condition that is
time based and applicable for all modes of operation.
If the system is configured with busy polling the loop
period is set by the socket polling duration.  Allows
for full busy poll monitoring of recv/send activity
during this time period, not exiting if any loop has
no activity.

If busy polling not enabled, preserve default mode
behavior in that the do/while loop will exit early
if 'pending' is false indicating no activity during
that loop. Loop time period in this case defaults to
1000 usec, same as value used in io_work() for the
host side.

Outside loop add busy poll check if activity during
time period indicates more traffic may be 'pending'.

Re-queue the work item if any mode determines that
previous activity indicates there may be additional
'pending' work to process.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080..4f79b77 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/nvme-tcp.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/busy_poll.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
 #include <crypto/hash.h>
@@ -21,7 +22,6 @@
 
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
-#define NVMET_TCP_IO_WORK_BUDGET	64
 
 enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA_PDU,
@@ -1162,8 +1162,15 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, io_work);
-	bool pending;
+	bool pending, busy_poll = false;
 	int ret, ops = 0;
+	unsigned long deadline, bp_usec = 1000;
+
+	if (sk_can_busy_loop(queue->sock->sk)) {
+		busy_poll = true;
+		bp_usec = queue->sock->sk->sk_ll_usec;
+	}
+	deadline = jiffies + usecs_to_jiffies(bp_usec);
 
 	do {
 		pending = false;
@@ -1191,10 +1198,19 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 			return;
 		}
 
-	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
+		if (!busy_poll && !pending)
+			break;
 
-	/*
-	 * We exahusted our budget, requeue our selves
+	} while (!time_after(jiffies, deadline));
+
+	/* If busy polling active, any ops completed during
+	 * poll loop period justifies more may be pending.
+	 */
+	if (busy_poll && ops > 0)
+		pending = true;
+
+	/* We exhausted our budget, requeue if pending indicates
+	 * potential of more to process.
 	 */
 	if (pending)
 		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
