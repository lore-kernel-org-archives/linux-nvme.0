Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA00C48BE8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:00:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A27613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 02:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A27613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1dh7fTI4zGSccA0S3cphxoPTxKpgAPE4/21sYl8RYFE=; b=viIl83Qq/cn/on
	8i/lPl5yf/zh1HIvEe00igfkQTmHdiMv+sGIAQTOsvP3rsH5snn7VUDzELxOD4rLFTRDIwG4s6n8c
	mjlVRPeQCb61/op1otdRSF8kCUZxRJlZ0MJ1gi8aaXFlVW4AEoxs3jpoDsQDFzJaTzx5YCxio1+yX
	Vfz2K3bywZTYx4ZRj62hfkuRi1UGpW7tiL0z7xBIPV0WQn5H32R2pGpvd33Pd+W6aobrap64UQJWN
	pUFHPnh+i8kmdudbgwEUPJ/vHNyIj7GsGENnzAojYhtXM1N6QDlZE9fMgH/pk7F5kEbmj1tK3jG0a
	0p+D0opGsgtOTbtdpC4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbtn-00BzIE-5R; Mon, 14 Jun 2021 02:00:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbt1-00Byv2-HL
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635975; x=1655171975;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3cqLkuz4Hp64y6+23sdYYQpJI59BkbpcKQcqjKgLSaw=;
 b=JDzwgIsF7FYAfq6qeVK5f9wH1MFC4wI6y2HjCoKGuCmvbq9zC1nVA50E
 W8M7WBhv65Ajn96AZ9J+wcNYdXi+MZSzmuEFCo0igWxIcCpriN7dJMD/w
 XOAXmAXNReGlVR334a5oGMXkAm7KcudT6phzWuADj/wfdqvR0Y/EX812v
 tAGrDw2rp8ClOUbz4X/3mE3PZWafJaWYDCAcCLTvHdvfi1Dugm/A+taXh
 c4JdbG0CIy+SMCsTTtgdXXPDQjyTiTXDtMC2nZtUB+hNP5Z9uxkAba/6W
 Als8oyDxEbOoN2uvm7n1bPRolcLwrVuS6w8O0DPWIr1Oa0kUj+4WRm+FM g==;
IronPort-SDR: XT1IJAaV25UF8LDFSAZa9+/M6dSoME+E4BrQyqH07sOy+5mNZKafu83l+2i3N2MSkylmNVJer2
 4O0+L6BuYdx1WgRqbD9jRphXQNx6UwF0aJ/aX4iOQYDU9uIH8j1BRgRApm+oAv5LB7PjZ3bFp3
 xqyCIYjonr0//NLA357YBKO3HnhqzlPpGGQOs7TK1vAFQlKis9Etz7xh9WOelurAiGTJZeFx97
 WTVSONvr8KGhJizhzvONORDCFBIYXy+Lrt83hc6ni8wYDNig4GZZR0dSDOL7gf2pMXjOiK+Kbw
 f8M=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="176565453"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:34 +0800
IronPort-SDR: ATo2qA0C2/pZJfxtPu6UpDiR02s+5CHMru0v0KjFGIlbTUcNdCYiWQ+9FrLl17FJ2wU2eBEW1c
 GrjJabAfPLlMmklyaEdRhXpH6Ce7/p9pvWIKY+vq7kAb7/9RSMEXcSMcwRx04SQXfLHsxdtefi
 S8/acdQx6rByh7oPcSiXXq/Zq2VY4B2hekZgmyXlChr/zNjODvTs6qde9jBDy/HINQF0FjXill
 UVuI7hCHYZvyCL3QQ29c+Sgf4wet5BQoMmB0yvY8vtkV1waGTgQwfNQ7owtFiWImrcftKkydbs
 w05jgE/4339X3yZ5RCuU9cj5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:37:05 -0700
IronPort-SDR: 7O5BFfZHevPHbF3Us41bkenWZg49R6E+YGT6R0AkosjUUvR0Sfsr09bFOwgUx0Ag75rZv6A8jV
 GmsPWC/Wy5LwqE5tlAwPaGXEADP7rB4mzpOmSsDzp4hxP2S/gZxTLfDZnK7qkJkorxh70ew/7R
 bG8UplwFEJ/kXCCaOwvfb9DX/zpJXbD6hpJivcRF0OTbvO81MgQUpZMIaITDhqcrWvpuPK1OSd
 vTPz4NMcpvvEFqw5lf5wY3YhZghIUr26dSUlh9Ha09xl3oFVu/KiAXkxWlQIeX939/uNDa4wS5
 FjQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:35 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/6] nvmet: use nvme status value directly
Date: Sun, 13 Jun 2021 18:58:50 -0700
Message-Id: <20210614015851.53925-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185935_612385_52744A7E 
X-CRM114-Status: GOOD (  12.13  )
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

There is no point in keeping the status variable that is used only once
in the function nvmet_async_events_failall().

Remove the variable and use the value directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8494a132da35..45a5b273b525 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -141,14 +141,13 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 
 static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl)
 {
-	u16 status = NVME_SC_INTERNAL | NVME_SC_DNR;
 	struct nvmet_req *req;
 
 	mutex_lock(&ctrl->lock);
 	while (ctrl->nr_async_event_cmds) {
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, status);
+		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
 		mutex_lock(&ctrl->lock);
 	}
 	mutex_unlock(&ctrl->lock);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
