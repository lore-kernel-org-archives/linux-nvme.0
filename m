Return-Path: <SRS0=n1R8=2N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E99C2D0C8
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:42:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A232067C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+xe3BOZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rFZhbHMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A232067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=40WED9bwvKlJZehnJNkxj66AFiwvN6SDAdY+LE/X7SE=; b=Z+xe3BOZI0vFhk
	pWv5RcFChf3G03vijsLT4ca1uD7L3lXD/159nxKi888y0ZClQs2vkfieqV0yu2vwAIopA0Ll0h1nZ
	hk+MwTRjQOPbbAPUswAGyYB3RCVXX+WS6cwVMl1qj8WVEEwFdv9KXPbQvZ5EUjIS7XIqzOR1mrdUk
	0kg/Wz9JQ4jmN7ztAujs+tVadHmpaIiQjuiU27pTEAeAVsO2y1Dq8SEblmWIhgzgxH46Yk8T8WyEl
	gMny5y6GfB2sds0P0lr5L621dL3Ye+wirZbflzd7ineU1GRCWRtZ2zyqTmeK9bZ5IbA+rQu0vidW2
	SPG5GbBob8U2tWm1OkAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ijCju-000814-Fa; Mon, 23 Dec 2019 01:42:30 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijCiy-00074F-LA
 for linux-nvme@lists.infradead.org; Mon, 23 Dec 2019 01:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577065293; x=1608601293;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=x51IhYE1QyMmY3UHAvxQPb23Eyep04ViD2uP480XSao=;
 b=rFZhbHMe6oDrQfsaSVgKbUtEU7KBk5qf2Kte0RUpo5f/tu1IKJLHh8xg
 OMABz/Rjlee/eiTF3f0s14U0uCsYctlkFNkXIo7F8ZSDYCWvgrgK2rorE
 ZFO1WKzPRv8PmyknTElA+sMfKUnVsVNAIFcZk32gFY8S2uBaTg4iOvShg s=;
IronPort-SDR: u42+C2cWqXai1yZxQ5RHbMfHWMe45P1ZHZVjdw7UCnZe5/KJcLLskVMaz9YebLrkIktGlNlnPd
 F/lMiZ6/3Qyw==
X-IronPort-AV: E=Sophos;i="5.69,345,1571702400"; 
   d="scan'208";a="8788841"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 23 Dec 2019 01:41:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS
 id 1FB17282FB5; Mon, 23 Dec 2019 01:41:20 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:20 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Dec 2019 01:41:19 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <=linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [RFC PATCH 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
Date: Mon, 23 Dec 2019 01:40:56 +0000
Message-ID: <20191223014056.17318-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191222_174132_857102_E28D899B 
X-CRM114-Status: UNSURE (   9.06  )
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
Cc: axboe@kernel.dk, mst@redhat.com, jejb@linux.ibm.com, ssomesh@amazon.com,
 Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents. This notification is
newly added to scsi sd.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 5afb0046b12a..1a3be30b6b78 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
