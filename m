Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87380C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550BB60E0B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550BB60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=alrLrDiUG5DrWxaktDCqlvWK34xhGHw2juMuDN5yrdo=; b=QbA8XeNrQcQMSq
	0SJgtviUjqQmEkopgaI7WM5Y6ymYKyVtZmQN9aiZ/neBuc0MP3PoJyKRWX45s3LYtSjYn/ZYUsOwi
	7eEpFYFkRwmNUMMHAp7qonQfvUxDB0/KikdZVA8XX7NV5oYDu6fgDgyfybnrvtAW5y+PXEPcdBPie
	Yc+uXk5DpnLsHy8UvImF/WU5ITOX22Uh8xEGnvshfZfF+WD0dElH0appv7NjudQXpjtv9viqDd24e
	et6xQXeZuTQeC4Yvk+2Fkn/V8paaCKmJLanp6OGMdJQudxJ7mnf5xKmjWS7psgvwV7+guaXRq/WZD
	sruIKTwlEGDK+4P/Z1SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxjWd-006lS3-Bl; Mon, 28 Jun 2021 05:09:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjWD-006lIw-Fd
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624856972; x=1656392972;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fZ8DvUXDosqiexNt7MyIGuhkS1KpKraq9p7YoO/Ou7A=;
 b=bVSSIboI+4bYQDDfTXrLlpcg6zduYaIUcQ/TH8wU47zOBVEXutyhkQr1
 aIC8N9omfqRfr/3Fllk5TE/BuKgjUPOR+z8dU3lffjkjpvb4Kp93Z0Am4
 w7sqjDIIyqk1yhJCvbYpIQt7JrLcoPiZuGCXTpxda25iUAtdk6XKozr6J
 NSFZMEew+7RSHN+wnHj1FEwKMXW5qFN3fOGnBjicU9nDiDWSlBsw4rzJn
 /cT3gB8vyv0dX+RSiJ4IlQuj5eC1qZnMOkGPXeOnUqmOOjQVBTqQxxAdC
 ihUthMcQRRPMBE6igUCSfPGEuAwhnLO+GabjWtt3huImGz9qJmrA0zsI3 Q==;
IronPort-SDR: xwL7tDv2XKVQiElVl/XfnElZMZXEgl12TWf+Nar74rtTyVD+7MBa134T+ewNb+pgkF4m4iIHAs
 wz6Mi7VeBPETep8CyDUR9mVYnnqKo+87O24R4ZRyY0l0TfUubfvojD/5Uvlhu7WMOW4TwCt0UG
 S3a8Cwaad5Fd07//+wy6fL3EZRoCCx2ODDzaL8GFWYxBbD/VLfw7oAqLhAVrxF6sKJb/O2I9NB
 6DyKZimIr3dkMUTnlIYDVr2ByozPWvdS2OOEeO42NFkFQJNBwO1aju+Jn48l1XjkgkKIfZ1LcR
 0RM=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="276851409"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:09:31 +0800
IronPort-SDR: laxt7S0FQDHu8UwGfmG708gCS8zTnGwrLzh3aObI80xRnPAtXCUaL15KUKH58u13XBuM/zgXFG
 aW1ZrnH7cXX/+CLrqtrhBU612xcr3soa1tszflO6fQShZF2OrjSGwlgO5bGHDRJTWeJsc51pD9
 h+mi2Zmip8a9IsXd6nsEPenV4JyWBqjp5POrodnCDKK/f3x5RQVsILC2OrmWz7fbLaLVZaHBdH
 0jp4wIkxs+GTB/tqzrHDoXaGteEBKNa7KGJleBzXco129QvDiX6nC3lRUfRUd0tHBcp4Dwrtpv
 yqu1Ap5rn7jt0LJPAzImgQ4x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:46:23 -0700
IronPort-SDR: TwNiY4M/Ho2HUI+XNJqi0GrsV5GDiALxTrG9mwWYvH/iGXEgO8fwcdymfprg1GP9oef/sk1HaF
 gxBTmjVyrSYAYVGxiPtVVeuhsL/xfEazQ4Rx2EmnL3ROAmS0y7YvsmpqN25/XcbNP2O1fy2bkt
 YtB/WtieVh+Rc2Y+REGk9lWTohVhtP0CE28RKCWiCH6vCZKJOzvGAsvGOeHqnJXDVk5URmhwdQ
 RbSVk7OthL49un2my5cgiN678kQs+ivJ6wpRp1zbQ3BEkW/yiGDsP0AmlUEMFllyp5YBvRHtGv
 ipY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:09:13 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 05/14] nvmet: remove repeated call for changed-ns log page
Date: Sun, 27 Jun 2021 22:08:08 -0700
Message-Id: <20210628050817.19788-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_220913_665076_D556FBDE 
X-CRM114-Status: GOOD (  12.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return status from nvmet_execute_get_log_page_changed_ns() and complete
the request in nvmet_execute_get_log_page(). This reduces number of
repeated nvmet_req_complete() calls for log page handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8c798559f1cc..2b018b84bf3f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -221,14 +221,14 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
+static u16 nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u16 status = NVME_SC_INTERNAL;
 	size_t len;
 
 	if (req->transfer_len != NVME_MAX_CHANGED_NAMESPACES * sizeof(__le32))
-		goto out;
+		return status;
 
 	mutex_lock(&ctrl->lock);
 	if (ctrl->nr_changed_ns == U32_MAX)
@@ -241,8 +241,8 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	ctrl->nr_changed_ns = 0;
 	nvmet_clear_aen_bit(req, NVME_AEN_BIT_NS_ATTR);
 	mutex_unlock(&ctrl->lock);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
@@ -335,7 +335,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		status = nvmet_execute_get_log_page_noop(req);
 		break;
 	case NVME_LOG_CHANGED_NS:
-		return nvmet_execute_get_log_changed_ns(req);
+		status = nvmet_execute_get_log_changed_ns(req);
+		break;
 	case NVME_LOG_CMD_EFFECTS:
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
