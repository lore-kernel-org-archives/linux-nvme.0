Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1361C43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 18:12:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CC521974
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 18:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RCwO8xRA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w64D22xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CC521974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qkq8PY8e5EDVySkQvhhm6QLFVHv4mLXdey1HMoe7RjA=; b=RCwO8xRAOLyunq0uUq8qGg1Ck
	OqZBBB2QTs4B4v1NIyjZD93TQMwFcQtHx6cShcYLGvTuGq1OgwIKGeKoAFUupNzp7KBqrQURzwmCK
	JUoCTsjvGsBOktpQghodzu9mtifhycKYFyDYthJikbWLGQZmdufbz5h2PuSrHgJWkPmbKIHLgq/Cp
	WHaSz3vfxGZ+qjV6pgeVAGyfn9CDmtRHWC168zR89kEymdmFTLAcVVwMyRY8AgBXs8VSMnLcXapdK
	od1GaLJAICn/li+kz149ko2EPVCKZih2GOOll1vGQ/6Y0h5Sl/E1+TCRiu3xvoDNzvZsgNgvy3ywj
	G5jOoQFyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIFRX-00020f-JS; Tue, 15 Sep 2020 18:12:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIFRR-0001z3-IS
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 18:12:35 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7EF8521974;
 Tue, 15 Sep 2020 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600193552;
 bh=ns9GjYceAzaazuyZVF/IJVcRSPLAlTokE4WCzsO0CZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=w64D22xsuBUouZcT1jmnqozEkHoyUVsy1e9SEaOWfVQ1G27GUq5wOKJXEczMsGpfW
 cONnoxhhe2Y+o5pvg+rBiy7Arxk7ND9VfS5sli8rDIMMd582/9jfbpX18fUfQ/Uuw4
 9etoXF72f/A6PnVt01wIHMT783hOjlE1sCcy2VdU=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCHv2 2/2] nvme: translate zone resource errors
Date: Tue, 15 Sep 2020 11:12:30 -0700
Message-Id: <20200915181230.3674743-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200915181230.3674743-1-kbusch@kernel.org>
References: <20200915181230.3674743-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_141233_700604_BF59DBFD 
X-CRM114-Status: GOOD (  11.51  )
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
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Translate zoned resource errors to the appropriate blk_status_t.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Use BLK_STS_ZONE_RESOURCE instead of BLK_STS_DEV_RESOURCE

 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a61a24d45f..6d5c95a3e03c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -236,6 +236,9 @@ static blk_status_t nvme_error_status(u16 status)
 		return BLK_STS_NEXUS;
 	case NVME_SC_HOST_PATH_ERROR:
 		return BLK_STS_TRANSPORT;
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
+		return BLK_STS_ZONE_RESOURCE;
 	default:
 		return BLK_STS_IOERR;
 	}
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
