Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA8C35E04
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4100E21744
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hF7OYm2N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zg9LgK8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4100E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MlNpkAre3/e3v0CjeI9COKD04U/Tfypf70HTF8/3AUQ=; b=hF7OYm2NY5U4Zm
	LOfXjK8bD2twuGhsNZwFMx23uCzgSrGvT+WhSDDZErJQ2qTQz1WZ/8fx/rEtkwRHjkprySiD7IBet
	9uuY5DAWfYp+3mFNCTWyAAK/Hl5186yBR5XiT9w0V+7gcLWYyo+BHMRczMtaSEpUHE/R+pS60QlNg
	DzqPr72fyJt2q3T9J64iOUghWhlpQ31HnbJqdt6PV3FaZI/jpavhlxT2QUGhivsW7cVvDrVcpP22a
	bbwQ/0XLw5SVYoEE1K+3TCDM93oSnRlIkqwewv4zvXXzAJUQNoODTPt+8OH+pgtoNwQ4t49kwBDJ9
	qdWhf4VKdK6mNCzijAmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6gPc-0003u9-IM; Tue, 25 Feb 2020 20:02:36 +0000
Received: from smtp-fw-9101.amazon.com ([207.171.184.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6gPK-0003b3-NK
 for linux-nvme@lists.infradead.org; Tue, 25 Feb 2020 20:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1582660938; x=1614196938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=cWa6Fn7t0zpgUPTzyy7cZ2J7YPrWlvJCca1owelSg8I=;
 b=Zg9LgK8Dz3KUJVca8m6bVOATYIdesuxiYm+BUHXnuNEj2DZkGqxFClht
 fGHXG9tt9ze5rsZBxqZWUuHucWR1IWk0kGpXMdTMQy6wD3f+yp6hU+FqX
 xmUw9xN30s+PZs63UWCN+7CulsrWQtTeyu3zPf/wNVlxkmImwQv3AHu5S M=;
IronPort-SDR: 0CTfqoGrztyFkxdWl7N+5xyPS/L7yzb0LCX1wGufvVj4n5Lfie5aXLi34SDtZ1xsd6Elp+FXKS
 Vw9pMSA3ejrg==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; d="scan'208";a="19066438"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 25 Feb 2020 20:02:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS
 id 23DF6A2E94; Tue, 25 Feb 2020 20:02:11 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:42 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:42 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:42 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 5/5] drivers/scsi/sd.c: Convert to use
 set_capacity_revalidate_and_notify
Date: Tue, 25 Feb 2020 20:01:29 +0000
Message-ID: <20200225200129.6687-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_120218_826595_B5660BCB 
X-CRM114-Status: UNSURE (   9.49  )
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

block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
notifications via uevents. This notification is newly added to scsi sd.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8ca9299ffd36..707f47c0ec98 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3187,7 +3187,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	set_capacity_revalidate_and_notify(disk,
+		logical_to_sectors(sdp, sdkp->capacity), false);
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
-- 
2.16.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
