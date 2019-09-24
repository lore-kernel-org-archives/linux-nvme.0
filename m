Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC18C432C2
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B142D20673
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hg7Rf+FB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VkWvQaFm686/rhhtEqrP1pn2+qEiyCDklHljbJicFCg=; b=Hg7Rf+FB5mG6nK
	0ju3HYoCDW2+RzuIL90yuaEL/6nBoga0fZMf+ju82iTmuSBdOAOh3my7AwBZ4Ue4WLOI7sWil/PYH
	1RnqEBs7M8eztdYZwO+qPhWbandDkvDkZ81lq2duF8xNPhnmQ3m5E6j7OcZMCT4tefY0YiugHco7i
	9HiJWKKewo5qaF7ZCLDeN7dUdIIk+/Mvse9ODsWDe1tnmYtG1Lxo/7yzj7B8TgqiEb/Wh0vMyNMVg
	D0WG5T5P9V3dfWP+FKI8qGystKtc1qi4tpkCC3u2SKb6H3kUFfE3E74yhB+Jf7dAfcB+vMrAx/GQD
	AI2m7V8aMDnyvGWJzHbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCnKa-00078M-99; Tue, 24 Sep 2019 16:06:24 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCnKW-00074U-Ls
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 16:06:22 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 09:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="193487322"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga006.jf.intel.com with ESMTP; 24 Sep 2019 09:06:19 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 09:06:18 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.226]) with mapi id 14.03.0439.000;
 Tue, 24 Sep 2019 09:06:18 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH rfc 1/2] nvmet-tcp: time based stop condition in io_work
Thread-Topic: [PATCH rfc 1/2] nvmet-tcp: time based stop condition in io_work
Thread-Index: AdVy7e0qAxE0m75yTtWrldI2AeTLeQ==
Date: Tue, 24 Sep 2019 16:06:18 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D3683F@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWM3Yzc5NzYtNTNhZS00MmQ1LWI4ZTYtZWRmZTdhYmZiNzMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblJ6dXVFblNCeUZqQUdRcHQxTkNtNHJrZnhmV20rM1F3bnl3WmFZSGNoXC81YitJRTNRNGx4bmlYTUhEbTBYc2sifQ==
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_090620_839900_FD3546D8 
X-CRM114-Status: GOOD (  14.69  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


When network enabled with busy poll have nvmet_tcp_io_work()
do/while loop condition be time based.  Time period set by
sysctl value net.core.busy_read.  Allows for full busy poll
monitoring of recv/send activity during busy_read time period,
and not exiting if a single pass in loop has no activity.

Re-queue the work item if any activity during the complete
busy poll period.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bf4f034..a232ef5 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1167,6 +1167,12 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		container_of(w, struct nvmet_tcp_queue, io_work);
 	bool pending;
 	int ret, ops = 0;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned long deadline, bp_usec;
+
+	bp_usec = READ_ONCE(queue->sock->sk->sk_ll_usec);
+	deadline = jiffies + usecs_to_jiffies(bp_usec);
+#endif /* CONFIG_NET_RX_BUSY_POLL */
 
 	do {
 		pending = false;
@@ -1194,12 +1200,28 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 			return;
 		}
 
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	/* When network fabric is running in busy poll mode
+	 * process for time based quota deadline.
+	 * Do not check pending since we intend to poll for
+	 * activity during complete period.
+	 */
+	} while (!time_after(jiffies, deadline));
+#else
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
+#endif /* CONFIG_NET_RX_BUSY_POLL */
 
 	/*
-	 * We exahusted our budget, requeue our selves
+	 * We exhausted our budget, requeue our selves
+	 */
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	/* If there were any ops completed during the complete
+	 * poll loop period then requeue for another round.
 	 */
+	if (ops > 0)
+#else
 	if (pending)
+#endif /* CONFIG_NET_RX_BUSY_POLL */
 		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
 }



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
