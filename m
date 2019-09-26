Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DAECE589
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 16:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2CE21655
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izPRwrHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2CE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zyFrjbTJpqZR6de0Q7ZlBIZMBnjBotdr2EkBZchyymE=; b=izPRwrHlORDV3u
	I949MfvB5YhuyqhKRkUwjcaSU/P9G6Gn+RY5lO245oqkOsn9GZGb+id83ETS3XZ52otNziFaV0Ueg
	eZ2qC6v7J+O6QRnAfHQ7nCTF0neYp0pJ2MOvYz7lkD/8XS/rvkFmSq7Xmw0JJH+agIPXB9zxrvaTO
	TGA+dbRT1ih+8ELq54Fxvu4rOiMNfUHMeWm+s/teruioDZnzyAOkf38drmulQQiPDUklLzWxVYq8g
	b3QFT/95KqX8Fsmbe8z19SrKpiPbPkzInfXGW0nKnExCbkRggRAT4/72WxKGGtqkcW2ct7WiPa46y
	hFMif/ZtDlea0quMpRpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDWnG-0004oT-Ar; Thu, 26 Sep 2019 16:39:02 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDWnA-0004hj-TU
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 16:38:59 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 09:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; d="scan'208";a="201685877"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga002.jf.intel.com with ESMTP; 26 Sep 2019 09:38:36 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Sep 2019 09:38:35 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.226]) with mapi id 14.03.0439.000;
 Thu, 26 Sep 2019 09:38:35 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "'linux-nvme@lists.infradead.org'" <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 rfc 1/2] nvmet-tcp: time based stop condition in io_work
Thread-Topic: [PATCH v2 rfc 1/2] nvmet-tcp: time based stop condition in
 io_work
Thread-Index: AdV0iGjbKvWo9MHKT5+sPKvOVIqgiA==
Date: Thu, 26 Sep 2019 16:38:35 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D37CA2@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWM3Yzc5NzYtNTNhZS00MmQ1LWI4ZTYtZWRmZTdhYmZiNzMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblJ6dXVFblNCeUZqQUdRcHQxTkNtNHJrZnhmV20rM1F3bnl3WmFZSGNoXC81YitJRTNRNGx4bmlYTUhEbTBYc2sifQ==
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190926_093857_000440_2762BE42 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: 'Sagi Grimberg' <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move to a do/while loop terminate condition in
nvmet_tcp_io_work() that is time based that can be
applicable for network interface that is in either
interrupt or polling mode.  If a busy poll time period
configuration setting (net.core.busy_read) not active
then assume interrupt mode and default loop period to
sufficient time period that would have satisfied previous
default ops count of 64.

Preserve previous interrupt mode behavior in that do/while
loop could exit early if at end of an iteration that 'pending'
is false.

Outside loop add poll mode interpretation of 'pending',
resetting it to true if any recv/send activity during
complete loop time period.

Re-queue the work item if either mode determines that
previous activity indicates there may be additional 'pending'
to be processed.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bf4f034..8ec124a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -21,7 +21,6 @@
 
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
-#define NVMET_TCP_IO_WORK_BUDGET	64
 
 enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA_PDU,
@@ -1167,6 +1166,15 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		container_of(w, struct nvmet_tcp_queue, io_work);
 	bool pending;
 	int ret, ops = 0;
+	unsigned long deadline, bp_usec;
+	bool interrupt_mode = false;
+
+	bp_usec = READ_ONCE(queue->sock->sk->sk_ll_usec);
+	if (!bp_usec) {
+		bp_usec = 1000; /* 1 msec default for interrupt mode */
+		interrupt_mode = true;
+	}
+	deadline = jiffies + usecs_to_jiffies(bp_usec);
 
 	do {
 		pending = false;
@@ -1194,10 +1202,23 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 			return;
 		}
 
-	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
+		/* If in interrupt mode, exit loop if this
+		 * time through there was no activity.
+		 */
+		if (interrupt_mode && !pending)
+			break;
 
-	/*
-	 * We exahusted our budget, requeue our selves
+	} while (!time_after(jiffies, deadline));
+
+	/* For poll mode, pending will be true if there was
+	 * any completed operations during the complete loop
+	 * period.
+	 */
+	if (!interrupt_mode && ops > 0)
+		pending = true;
+
+	/* We exhausted our budget, requeue if pending indicates
+	 * potential of more to process in either mode.
 	 */
 	if (pending)
 		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
