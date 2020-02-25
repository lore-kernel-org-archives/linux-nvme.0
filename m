Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD13CC35E10
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:01:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C5B20658
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i/N5C3HY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HcNT8+1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p18bs3Q1U01FfixbnDZ1hmbasiLGfvSEy5tWD93Jrk8=; b=i/N5C3HYemqB8/
	7skexhGE71NsM/veLclkWK7XhX3ii2hzuZIGLPJ75pzdGnwAOyoJhQNgm4XFQrdUwWv4A+/87pc2E
	/onvxjQbgpot2CPSEaJ7YALD4bpTINR3tgjJkWILKb5ap3gYKlqQ7FIInbQJV2vnpbqZVLwmtkr8R
	uGAbGIwhjFg0AFa5nzfi7ADGoGv5rlP4dT9aPNFWn2GrmH3Ys+NBAjUopMD3OH/J2IVYeBB5SoEuq
	3eY8Nqun19OLo/AhrjXx1OuBYRHY83nBK8Tf7j1xBbUGn5QaYBbBogiIDoXY7F6JLdP9O3qmWFmCf
	gbzmz07kWS417RhFfLOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6gOx-0003B4-Lp; Tue, 25 Feb 2020 20:01:55 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6gOt-000348-HG
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 20:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1582660912; x=1614196912;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=h4sGEbKL2BfyOYFPk4o3ZidZGMzs/+yLuzx6u+LWF+c=;
 b=HcNT8+1OlrdYmqWV487zHL7nvfIuGckLVriyfrtXD9iLlbI3tIc+oZGM
 TehPaTbOLwpbf7ooiSNroHsaSohJMz1cdj9ErxWt1jY/sHebbGyOXSZ2W
 xzhbeSCd51r3Gjr2M4MboAZw28iK68l+PDPtLBG25+SX6inARJzy6Oy8P 0=;
IronPort-SDR: PIcXLS6IdDwar29q1JwczS7BaXlePUp9+XEqqYnB09xUPN2199xfoVyhtsa8IMpr9vhSAd2a86
 jXf8ao08QJ1A==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; d="scan'208";a="28822857"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 25 Feb 2020 20:01:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS
 id CF115A06F1; Tue, 25 Feb 2020 20:01:42 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:42 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:41 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:41 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 3/5] drivers/block/xen-blkfront.c: Convert to use
 set_capacity_revalidate_and_notify
Date: Tue, 25 Feb 2020 20:01:27 +0000
Message-ID: <20200225200129.6687-4-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_120151_627080_DFCD640E 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides set_capacity_revalidate_and_notify() for
sending RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/xen-blkfront.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e2ad6bba2281..2f7cd842d6ce 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2335,7 +2335,6 @@ static void blkfront_connect(struct blkfront_info *info)
 	unsigned long sector_size;
 	unsigned int physical_sector_size;
 	unsigned int binfo;
-	char *envp[] = { "RESIZE=1", NULL };
 	int err, i;
 
 	switch (info->connected) {
@@ -2350,10 +2349,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity(info->gd, sectors);
-		revalidate_disk(info->gd);
-		kobject_uevent_env(&disk_to_dev(info->gd)->kobj,
-				   KOBJ_CHANGE, envp);
+		set_capacity_revalidate_and_notify(info->gd, sectors, true);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
-- 
2.16.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
