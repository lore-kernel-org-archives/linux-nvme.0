Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5923C11D3D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94BF2469F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pn+Ly5CL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvSoy4HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94BF2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FjsZ2D2ezwVLBU/IcQHrR6qxjDSrjSZeIQ3TK6Xvnpo=; b=Pn+
	Ly5CLxnFhcqja+upWAXH/CRf/YZQkeos7ysUI5rhY4JY43BCkP0N12X8VVcUh45nVM3XOx6G+yukM
	r5A/A3Vxl/VFAQZL4hZ/S5Ru7KySbI95g8OI78HotKlrgTPE2Vbz4UYYil/K/KOLyL+hUl94ThVJ6
	1iq88kDLUWrY9qg3yaQ5t3Ulne0S/NUha5L3g7E/eUfItnqbKWo0iV9l+Nt1Ubno01ijXIznOErI3
	daZtiy0D3Qxj7zWl4ilo9K/zRuJs8H1wo6tQyMtWg/YMa5444O1HCDQa+N1kkNL5nX1m6KZaRei0j
	mvHfNZTUEeAuK7CeggjgCsltm/Ajwbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7MIE-0007Ni-0X; Thu, 27 Feb 2020 16:45:46 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7MIB-0007NF-6b
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 16:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582821941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pXvUgvcVE3RYhskHp/BxNDAbBgF5rVzNd1xTPOwDw4=;
 b=SvSoy4HJ/dFsKgNBJSohQ+F477RPw5L8J+S+NLFCMyCxsnkWW5Q4KqBsV5crAg3RDANNXf
 thFj72qqLDDe/SuOhBspfllUDNp775sXVE8+VLdDIWYThZiBgdTF4SOTDwi8MohUeaUux3
 3nrv/gxAIcEHQYIcCH6XKB5CU8XJasQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-42WP1aOaNGO3QZ_6na8VMg-1; Thu, 27 Feb 2020 11:45:39 -0500
X-MC-Unique: 42WP1aOaNGO3QZ_6na8VMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 590151137841;
 Thu, 27 Feb 2020 16:45:38 +0000 (UTC)
Received: from rgirase.pnq.csb (unknown [10.76.0.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19B756E3EE;
 Thu, 27 Feb 2020 16:45:35 +0000 (UTC)
From: Rupesh Girase <rgirase@redhat.com>
To: kbusch@kernel.org
Subject: [PATCH v2] nvme: log additional message for controller status
Date: Thu, 27 Feb 2020 22:15:26 +0530
Message-Id: <1582821926-26895-1-git-send-email-rgirase@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200227_084543_323975_11753F98 
X-CRM114-Status: UNSURE (   9.13  )
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
Cc: axboe@fb.com, Rupesh Girase <rgirase@redhat.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Log the controller status to know more about issue if it 
lies within kernel nvme subsytem or controller is unhealthy.

Signed-off-by: Rupesh Girase <rgirase@redhat.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90..9819646 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2079,8 +2079,8 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
 			dev_err(ctrl->device,
-				"Device not ready; aborting %s\n", enabled ?
-						"initialisation" : "reset");
+				"Device not ready; aborting %s, CSTS=0x%x\n",
+				enabled ? "initialisation" : "reset", csts);
 			return -ENODEV;
 		}
 	}
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
