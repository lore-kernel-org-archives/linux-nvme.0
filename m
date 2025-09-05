Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D169CA1013
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+xc0PcXwpZFkCOJf0wVjNG15YbbnA/XarkJsriWbvQ=; b=UoTPnSLOIx80Po7SgNIlk7uDhh
	CaZNaCj98jWz8pnEhWzX3cB9oABoOhAo+Oeh9Vu/qRxzGEXiyNyuaintIFiIXQVJnldVjLh3mooft
	1KiubiL4vtIrdioN/O9OZ/36uclPphPFRpBgRme4y3nd8VzBc5VXlb1DFXFwKdNa7l1S9TSWyUWVI
	oG1B5GrCfEDaFQ7V2/gl+l5E7YW1IS4gtN/8rjk6KNwLv3kKklYrBDvT6nAXAT79RFLk3zzyRoOGK
	AKWmhvdKrdA0hvRqzPMk/lM3c3ny+lYgQMwhQdtaflb6pTMNMCPikg1F9DdfvxBamvwuTWa+CFm2E
	q+mALh7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugZY-00000005Ye6-3XV6;
	Sat, 06 Sep 2025 00:14:28 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uufod-00000005G7y-2JfU
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 23:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114759; x=1788650759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vkLGon5Ycp4wW93u90Sw0Ny4k82oDFhfXs3NR6U/ofI=;
  b=Rx21SxmzNuL6ILbZSis2gOjMkVDupEtK6tQdbstFlZpMX4MtRnYCmvb8
   iEw1IQR8IoAksptsZQagpd1wDC5ZLyr5bUjKz1xG4zE+W+ISUXZ69mXP2
   KuKwo8qInHFV3gnMnOKCYNXoyb9X/SKzfYEkkpDysywZ3DvddbZXKomHZ
   dwRUu7fjABruMWg2qfSCNiTeFX5/00zUNjnBONPIF4xgV3Tr/FOl44H72
   YURhMHQKafELiG309oqCk840FXcb3LhzKZY8dXqeaUd+CKYnycgh/lXnt
   KZw29k8Q7/hkqcoAwGuMzlkw1W1uHYZXAxn3Y4xpG0/jQMg+hnzWLdVA4
   A==;
X-CSE-ConnectionGUID: I2+7dd7+TH6g/oLObmRjEg==
X-CSE-MsgGUID: a+d3vfyWTCW3PKar//Al0g==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109647389"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:57 +0800
IronPort-SDR: 68bb7185_EEwi5VSkF7pEXcTpqvUWimKEn1wyjM55rljmbhpeADQChY4
 /U73OeJ5Y1EycPWAbobeJnmoC9yctv5Wm+ahJtw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:58 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXP1tmwz1SHvh
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 16:25:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757114756; x=1759706757; bh=vkLGon5Ycp4wW93u90
	Sw0Ny4k82oDFhfXs3NR6U/ofI=; b=th+T+nn+cUP+UpbyW3nJ3OQRd5ZGJMkTi3
	pKK9X3v4p/EnzzUcNJSRenyyANYT3J6s37i/c2bNysLVia7mcjxJAebIY4NGpwvm
	OZUEDi0ek31QuY1J7KhbLSxQL1VdgyNkS1awto2OIXBOO+dvfoDI0u8794jiKWi0
	znpEJh1Ol9LhDzFxnY8MZVEc8FFS8OLPXLoqa3FWeoRnNZ7eoLNYiGWFIhMpuqM+
	ByHeWFUB1pT1a0UzV7gyDRbBQCmoZnikiy3ihk0ho002hVrIDvMkgEcQFiA7WyHF
	cUGImqnMxJvBFMYFDSXUP8rgw7fJ7LOxkoO37jb7Jl2+Ij2ZES2A==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MgCLjfILekTl for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 16:25:56 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXN39dnz1SHkR;
	Fri,  5 Sep 2025 16:25:56 -0700 (PDT)
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for I/O controllers
Date: Fri,  5 Sep 2025 16:25:50 -0700
Message-ID: <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_162559_650317_A3B85472 
X-CRM114-Status: GOOD (  15.26  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

An administrative controller does not support I/O queues, hence it
should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
only exclude a discovery controller but need to also exclude an
administrative controller.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fab672e50510..ef6f84d677d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3496,14 +3496,14 @@ static int nvme_check_ctrl_fabric_info(struct nvm=
e_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
+	if (nvme_is_io_ctrl(ctrl) && ctrl->ioccsz < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
+	if (nvme_is_io_ctrl(ctrl) && ctrl->iorcsz < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
--=20
2.43.0


