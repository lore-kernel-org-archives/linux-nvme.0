Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407AC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB48F206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 02:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kufWnnMP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R3EOe+iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zzAvP6ATRxJLbFyq99w8no9v7FSfBoRMH1fMxnWsc8=; b=kufWnnMPUVR3RGmMj1G8tWoo3
	WnaYZYGI7LFlJ6me7IYmPNNtQR6BqCi2Yp0IQ8/lpeoTwLqx41cvna1SEPR45ynhMnDrYER6izNuq
	URWd7OUdV7dwsVE89KZZfrEadOuKl5llmt0JqbCw9mM/B//sN61iCWFQt9C/vg1HLhLs8Y/plyanF
	MT9kN+08gOmiHmnBnsPpFhC4zepO1WHD12V2lpZoPkK0ujFnkUbBceHxuSy0Jntl8aDlCQnu7kf74
	Mbcgccmd2otUxwQ4CGYlxRdXsBTZea2+/jtsCBHTlhyPtT94mxER0eZvjfaLuGaWg1J5vYvoRT3mr
	862uhxPBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki7EI-0005IA-1E; Thu, 26 Nov 2020 02:41:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki7E4-0005EG-DJ
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 02:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606358500; x=1637894500;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
 b=R3EOe+iE2XeA/snWfE2G6X+Fl+U1eNz4ei8gFntjcxD7IXohtsgdcrSH
 Br63Rl7UCSgoXdy69AbubuxpBYFQ/PH64k3mak/+A5do+I/B55dvC0ae1
 C+2Wj4kR7GCwgwyRRB4Z18hY82VQaRk+lDWkUaYbeiBIyYvd6O/lWOeXD
 cxUU+xe2jRCRdJFej2EC0ze4mcqiZlESj/Sb0WCQ2ypcFIxeu5Lj4GUH3
 O2/ITbAHWYrkw5NUCaLHMbBxehEbPu5TyO4Yce9/zN125XJxHNJod2fza
 c/F+FNdwqxb9GQfTHS880OooPOOPpyvqhHE7lwDt3xG9An1QQZUCIedYU w==;
IronPort-SDR: /UqkJWALXMQobDTOb9EiWOYIhc7hnXna8qp4De6zE8PI0uhYqt6VScFuEVMvRiKaDVTSqrCQm1
 PQB7HKdqe0QXzNtvawVtPS/weyKetpWkS13YceRcPnOI37bwBh4+5ZgU1ZkkzC3vwDm96YZijr
 +sXziFwfh/2vPHXfsb3V1oEJ2lci3uBLHCV+orR6wD9xWucbtkJc5HWqaaVfqtCpXiHYimXUEq
 l1Nw76R7p30RQ0OmbPtrr8XNwLTGa9PNBCotXPSs8aTBGBr2CzideA7yODTZ/TSdX8v6IGR5UB
 8Vk=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="157983134"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:41:39 +0800
IronPort-SDR: HCPyWkSdbIA7VzVb7k7r/dXu9YDv8KEqC6NEIahny6Y2AoUGCXTAV95FtMGAAOs5blf/HfHFcK
 FfF/28wWatC2X2VZiroGziwHiQRcz/e3o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2020 18:26:01 -0800
IronPort-SDR: gZMRNQ2cNMFz1CREp9nYzKUzsorrmFdbbsr9pGLbBkjJO79U8qt5N5saEET0FYQ9oODFC1IVYl
 NZyXdF/lcCmQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Nov 2020 18:41:39 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date: Wed, 25 Nov 2020 18:40:39 -0800
Message-Id: <20201126024043.3392-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_214140_697270_15A2D168 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
host to identify the support for ZNS.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d4fc1bb1a318..e7d2b96cda6b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -650,6 +650,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_ns(req);
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_CS_CTRL:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ctrl(req);
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		return nvmet_execute_identify_nslist(req);
 	case NVME_ID_CNS_NS_DESC_LIST:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
