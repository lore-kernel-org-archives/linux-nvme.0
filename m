Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB81C64E8A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507E620663
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G5PNSzSR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GHwfl7Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507E620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/1WytQkJcQbwSHBb+bj43DakB+PRBzfpTQYqhiOjXpY=; b=G5PNSzSRkQLQ8X8jo9Kk0n0hD
	yiKKV16a9SkCZW3RFZTNoRJoHjVZ9Skps31eiFcMC95vxCeEJ68rPt2V7TkRO4AqJpTEo2nhANeu9
	6rnebzlzTYWYDUQE5VGmrs4cnbJ6Pjkzgq3OuqWmJ04HeJRoINjnxHWFm0UeC2K9jYlIoOCNjOy/f
	TDx+rjzQm7QX3C515UunVBqJGB+bGBjywpmhHhz6raMHe5IdBW+RFzuOtunnGkL6w0n+xTne4jCYD
	P09GnUcBjeRiZ+QG+T8FTx7ZUiZEJ0z8mv5iUOxg3IerT1yt3AmtLT43E9Z8x3zGvke+eH97HXiE3
	znPP0j5jw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZt7-0000mv-SF; Mon, 30 Nov 2020 03:30:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZt2-0000kF-7B
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 03:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606707000; x=1638243000;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
 b=GHwfl7MscQGWqp+zVh7v71I9p8mc0Ti0FTmg6q1bIR3ZT93nkyBi7VLx
 CVBUhxWFcYxu/8l3kWGhtJ/uNUFJzdNLvMb8elEIYtYWpcH9ZlJld4hZl
 bN5PEkW4L2QbvGXnqQJQJTEi+JRtBZM8WKEMDEJyIpTsLQZgkSuZssBIN
 GkErch9tKDr90L+AMsWJZMKXwX1H1z4ueFO89ImED2cIH/eBhOZE2Kwov
 BRlmJ72ZSeN1utuH3YYUfskPOvj74YH39QgnwL7EFspmNAc4M7rkts/8F
 lIQAAiqWbn9NbdQ7d4edbSw2IvQBi4BPDT/I9OWUOckIDnf53upnVjWrT A==;
IronPort-SDR: yy9vEuBRk0dUarVrEy+VZz6qlf1w/+EuXtwqvDNYn6m1ecEWgBfGpDBYdyI2dH2GVoLbF6kcBE
 dNh/qU0iR7Elqy9O9rkM2Ny3fgr37rFouIUZKoe+CozByY1vCg2h1uT03WK1gErQIAe6eHOTEC
 1288RB9O/WiXCTTbMZRq7AqnOgNur8Ii8cfzuFSjqhplQnLeKEgOL90mQq+2IawcAJVRF219Ux
 iQNOik7pyprxbdD+/Y16GmqbCug8OsL1K04BhY6+glpo0Pasq2jZddMn+uHhH/3Sw/EbCJDeQ0
 swA=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="154974920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:29:59 +0800
IronPort-SDR: Y3s47699hprjyihho3JcQbqCOM+zFmj6r3DEJtuvhCtxrOUnDUOJOy/6IMjKVvBfc6c9a29a9M
 ykvZ9N+P9SXuOZWoRrG7sEGekFtr2eVmg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 19:15:35 -0800
IronPort-SDR: 1cd6sDZyQ0eW+cQgh9SqyaYRHq8ZG37xwpOgg+VbZJJk9PztxYllEcyJRy/LJq1CZAp2FZGK55
 q0ZDYSBiUV9g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:29:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V2 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date: Sun, 29 Nov 2020 19:29:06 -0800
Message-Id: <20201130032909.40638-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_223000_464204_5461A8F1 
X-CRM114-Status: GOOD (  14.09  )
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
NVME_ID_CNS_CS_NS when identify.cis is set to ZNS. This allows
host to identify the ns with ZNS capabilities.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e7d2b96cda6b..cd368cbe3855 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -648,6 +648,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
 		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CS_NS:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ns(req);
+		break;
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
 	case NVME_ID_CNS_CS_CTRL:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
