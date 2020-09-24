Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D78C4727E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD992396E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LcY6A/gZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrUPOA5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD992396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NIrULNOOXTbo7zHtBM868Sa5kfT+wWdAjqvixU6qCTg=; b=LcY6A/gZYsMZ3mE8NUAv7zOK6
	EwhgADOOXmQSKg4n21J6oKmqbgttNe+4K4l4CrUZKYI+1hFEBgMopJTtLUmsBcxI+zyQXneDVvq8K
	N6b1b9NjS2K5CSaQWu9w1YG5jhfNHEihkQ2S0qqN7kTyJ1YvrfT6QORbyn7q26cpPYEQRw2SlkeMy
	Ox1AqUIWRXSxBqRkegkY5Es1bUOxUtFWE6dylxuCwrLkAuAbGVQtpjfFupLjFDR0nn76hFrf8+CTF
	XMmNucpPs04cT1L9sDCB5UjNlU876ohdMSDGhJbHfDHx2ZaBmG5ndC3OvRvhvRkB70dV/smEZfoxw
	JzADJhpfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLYFM-0002tv-Ih; Thu, 24 Sep 2020 20:53:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLYFF-0002qv-Om
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 20:53:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 97699239E5;
 Thu, 24 Sep 2020 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600980817;
 bh=gIKjuXGa0OuRcH6QYTNcvBoiexuKob7ZVE4w4YhSggk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IrUPOA5nAYJ+44LTj/QigEHctkX0QkHyB7g/gP/ORVRqppaWqcBf9AeRn8eypjB9f
 RQ7dIREM47I3HNlD49xrakO5gXI1mf40rNUKSv+Hu+NPUBzxIQp6liDEh4/NGs0owg
 4V08UXnR84tiWBZT0OOqMQXA++WwR/Ozu4Wkt57Y=
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [PATCHv4 2/3] nvme: translate zone resource errors
Date: Thu, 24 Sep 2020 13:53:29 -0700
Message-Id: <20200924205330.4043232-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924205330.4043232-1-kbusch@kernel.org>
References: <20200924205330.4043232-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_165337_874091_052CD557 
X-CRM114-Status: GOOD (  11.36  )
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Translate zoned resource errors to the appropriate blk_status_t.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 614cd455836b..a0d26fcbf923 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -236,6 +236,10 @@ static blk_status_t nvme_error_status(u16 status)
 		return BLK_STS_NEXUS;
 	case NVME_SC_HOST_PATH_ERROR:
 		return BLK_STS_TRANSPORT;
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
+		return BLK_STS_ZONE_ACTIVE_RESOURCE;
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
+		return BLK_STS_ZONE_OPEN_RESOURCE;
 	default:
 		return BLK_STS_IOERR;
 	}
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
