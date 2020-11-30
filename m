Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF508C63777
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B58520663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CmPwtEde";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ibEcXuCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B58520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zzAvP6ATRxJLbFyq99w8no9v7FSfBoRMH1fMxnWsc8=; b=CmPwtEdemXEEjbZ7rUhg9iqb8
	lBejKl8AxyQMjZ+tlliruNKm0N+n3WWZp9jBPG+txlljtLnrR8UDjoM0Ov8l0CYpqtG6Lma5EDS6N
	5WZwW9fCXjcpGhyZ/dX/HyO5SLslihOlskXHBqHwhtPSVDsThp08C2eIaNctu3kFcfA1h7VX14/oM
	WlsvP9bUM6Sz9UWiYL2GYOmnruwosSDtkxI310HcmoCGGCeXLc2wJhJMe+frk65/oGnOHIlP5XEeg
	mUoQUWNQhc64Do4aOPY1SahWuCM6Qw76xzwcO0PJpvQxiB9vZuixY9ZYV25Bug0lQsfNwZ6re0auI
	XFmulcFAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZsz-0000jF-AB; Mon, 30 Nov 2020 03:29:57 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZsw-0000hl-E0
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606706994; x=1638242994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
 b=ibEcXuCrR7d0PyUrrgzBVdfmkyjBVMPmrYRhTkqCo4OP5JQge6VskWJD
 jRzcBQN+x0Tx4JZEFhHKrwNo8/g/Rx9Q+QtJ84vdH0kvXLkRn6A0n1G58
 PGfYPqaP2RcKX7vZU7JG6toocRzG47bYSnRoq2zfBsiV11U6VqpkBtzLo
 J7V4S2D+mH7c5vw31Li21bAzXCwCHflkpo7I5+1rIRT+0CQzc/m45k79v
 Tg2MOhE2Ja8P64ClGvD+sqVpY4jR/IeR8mY46c0uACuQILXSag7n5coMb
 vnMvlTGypxTK2tc4AzjmAHkZhBtg1K6XuYxs2vdUpKDoSRxIQIBkXC+3o Q==;
IronPort-SDR: x6YOXbk+mntMFSIqT/bFFZnJ7rsa6Pro26+tvpFeljG7jaB1ybglbineWOrpXdGvqW/JxorODE
 15C1pLj2v2X/ggI8QdiAHB/WkmXhVHr7DPnu/E2PKFags+cn1BwelSaiCc7u9LH/EFutmWuiUV
 Y3YDilJaJsPNc3TgIjigu0RnDy+sgEzSotGlLAD2fknuYAq9qDrxjSjK/ZpetzKSoY/n4suZq0
 P7Ru3xNiKVGS7RSsEnZlRwBuWF/bEsDCmaqLdxQUh5Ce/Dp7eohPr/XH/CffuUYgegrRfgfrST
 v2o=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="158242322"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:52 +0800
IronPort-SDR: bQzgg8r+OzLGUP0A6tnTVxe92O+DBX6jwsG6/WgIRG4ivzH4HEgEYsCIPCyXqkiggVDhaZqKEe
 wOi5C+IUpLdqtsXkE6b2imoZ0b4uoT39w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:14:06 -0800
IronPort-SDR: ZghdTP2hUjm0I1Qgwto2KfQJ9OGlJkbo1+lSPAJEzbmb15HOrtNBh91W5okyYiyTe/4R+GSkZb
 5DTBgMLHPVUw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date: Sun, 29 Nov 2020 19:29:05 -0800
Message-Id: <20201130032909.40638-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_222954_672605_5758DD44 
X-CRM114-Status: GOOD (  13.30  )
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
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
