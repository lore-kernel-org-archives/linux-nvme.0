Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F8C3524A
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E702084E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 03:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ba7Fa8oC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E702084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHifPEKhErf5OY/uhjpH4TYA+nPlMRwwvc3AqIBPjKY=; b=ba7Fa8oC76RB+N
	2EtUwuBJ4lpBPD4kUFpkWO+nG8YpG98tp6Jg5SNYmV1B1mdcbEdv9hWQE6v3JdRtxlPy8dzkPslzK
	F7c5kD3RA3IWxcOIH2eMnVq/d1seltPVUQXAbRusHLuh2WN/yjt4LqpiQgUxPhDNOwZhDs/Tt4gqG
	rx6mYDPieRMDdf7JEcQpwtbZn2lVuUhrRuUnKr3qT3r6OX/lT3Ho8c+dKao64/6v0M6vOTcAOx2jj
	tursWfmAR9RDXEKowP+Cxo6F7IL2SmCUYAL3XBfwkjWTOHVXxLH0kgQfXeI6Cf2nGjDkgY+njWJTW
	MRACBmAuVJ84yckcJLmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyowL-0003jr-Vk; Tue, 04 Feb 2020 03:31:53 +0000
Received: from mx1.didichuxing.com ([111.202.154.82]
 helo=bsf01.didichuxing.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyow5-0003Ws-16
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 03:31:45 +0000
X-ASG-Debug-ID: 1580787094-0e40884f73171f140001-VMfPqL
Received: from mail.didiglobal.com (bogon [172.20.36.143]) by
 bsf01.didichuxing.com with ESMTP id fiqcEvVRpsbRbBJm;
 Tue, 04 Feb 2020 11:31:34 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:31:34 +0800
Date: Tue, 4 Feb 2020 11:31:33 +0800
From: Weiping Zhang <zhangweiping@didiglobal.com>
To: <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>, <bvanassche@acm.org>,
 <kbusch@kernel.org>, <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
 <ming.lei@redhat.com>, <edmund.nadolski@intel.com>
Subject: [PATCH v5 3/4] nvme-pci: rename module parameter write_queues to
 read_queues
Message-ID: <2ff979c6ee5469ae4f6f652e95974e3cf6bce99a.1580786525.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v5 3/4] nvme-pci: rename module parameter write_queues
 to read_queues
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
 bvanassche@acm.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
 tglx@linutronix.de, ming.lei@redhat.com, edmund.nadolski@intel.com,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1580786525.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.143]
X-Barracuda-Start-Time: 1580787094
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2764
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79763
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200203_193137_464399_5FFD7962 
X-CRM114-Status: GOOD (  12.45  )
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
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now nvme support three type hardware queues, read, poll and default,
this patch rename write_queues to read_queues to set the number of
read queues more explicitly. This patch alos is prepared for nvme
support WRR(weighted round robin) that we can get the number of
each queue type easily.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/pci.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e460c7310187..1002f3f0349c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,10 +68,10 @@ static int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
-static unsigned int write_queues;
-module_param(write_queues, uint, 0644);
-MODULE_PARM_DESC(write_queues,
-	"Number of queues to use for writes. If not set, reads and writes "
+static unsigned int read_queues;
+module_param(read_queues, uint, 0644);
+MODULE_PARM_DESC(read_queues,
+	"Number of queues to use for read. If not set, reads and writes "
 	"will share a queue set.");
 
 static unsigned int poll_queues;
@@ -211,7 +211,7 @@ struct nvme_iod {
 
 static unsigned int max_io_queues(void)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
+	return num_possible_cpus() + read_queues + poll_queues;
 }
 
 static unsigned int max_queue_count(void)
@@ -2016,18 +2016,16 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	 * If only one interrupt is available or 'write_queue' == 0, combine
 	 * write and read queues.
 	 *
-	 * If 'write_queues' > 0, ensure it leaves room for at least one read
+	 * If 'read_queues' > 0, ensure it leaves room for at least one write
 	 * queue.
 	 */
-	if (!nrirqs) {
+	if (!nrirqs || nrirqs == 1) {
 		nrirqs = 1;
 		nr_read_queues = 0;
-	} else if (nrirqs == 1 || !write_queues) {
-		nr_read_queues = 0;
-	} else if (write_queues >= nrirqs) {
-		nr_read_queues = 1;
+	} else if (read_queues >= nrirqs) {
+		nr_read_queues = nrirqs - 1;
 	} else {
-		nr_read_queues = nrirqs - write_queues;
+		nr_read_queues = read_queues;
 	}
 
 	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
@@ -3143,7 +3141,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 
-	write_queues = min(write_queues, num_possible_cpus());
+	read_queues = min(read_queues, num_possible_cpus());
 	poll_queues = min(poll_queues, num_possible_cpus());
 	return pci_register_driver(&nvme_driver);
 }
-- 
2.14.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
