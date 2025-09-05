Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E826CAC580
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2QyWVieaqicjp20VQhqAEZo3TuOxJI84jwsD3ybhiSk=; b=KJLY3SXYsuioPGasUS6mds5gi2
	0OdFc/kVOLNEGAA8qNzvuvrA6TxclJOfOnrWWDaq+LQc0iKXPq2HGa9FeAlK9k+FnsqowqVZ8WgVE
	2Su9au3L7nvMjN9oUBNo3VOBo50PkbQpKz/LPLg59cKRkV/P/nZSSCEr3CBBRhbjQK1ZtEigMxK0a
	pVRJvR1hFhMSQQ3XZCftksu6dQtvpcWzyqecM35+LwIkwXrs9lFrzqg5RqPypIhUu3yXUkT4PEIWG
	BkRQban0sK9+tuMeuuFr6Bjs4NaV8eVRa1E/GeZw38GPBkE34bhxPIXtC61J26r+gGsJKi8KTb4Zg
	b4vZCH3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugYX-00000005X9N-2tql;
	Sat, 06 Sep 2025 00:13:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uudhF-00000004dsw-0aKr
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 21:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757106612; x=1788642612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUXslDRT5Pnpqr6o+a0EDCIsWR+TcWfZU2WreWPQZB4=;
  b=lJ6XP7X7mrCDh8jBHY+Q8brq3KeiDIFuYJ3ijkjP6MGenNKCiWWnuZ0i
   fWreWA+H7nZLdau/fZ9lYSYfRD/nmEj5FrlPjVtoZ8PftCVf1zQ3kHsaM
   Y1A/YTuU4VfUShjdEICVwwr6fEQOm0p6Mju+EGeLhxpQZUAx3eAz4EID9
   YKxdDjq+/aQh6k88cs/new6940N+4OeewI9QIO11GcaT5y5TT/6KwzhwW
   6bpFKQdG5FvvfctzPfLG0p9+bhkegoQIbZ1CnGyaYt1G6xejOZtxR/cFi
   qZ1dvJ8nsBWOfBu/m0ebfxB7lJXDZjQJLPASIl2E3M7XAhkD8pUxzYJJb
   g==;
X-CSE-ConnectionGUID: ChvVwDIPSt6ReCFF6Uz+Tw==
X-CSE-MsgGUID: SUEqsrBuT66okcAXYQ86Rw==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="113683285"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 05:10:08 +0800
IronPort-SDR: 68bb51b1_2nIy+jPgCcXc6M6Im+pD9K3BdKtRqhG5RdENkRw+a3Tx4xO
 iZStUyTXUErO3qA+uQc0tep0QWL68/NKEV4qtKw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:09 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 14:10:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJTWh5QZ6z1SHvl
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 14:10:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757106608; x=1759698609; bh=zUXslDRT5Pnpqr6o+a
	0EDCIsWR+TcWfZU2WreWPQZB4=; b=KrOohj5SkU7dbfg8W/pStxiRxS+SwS4IRg
	MY7J79sP6OB96/HMNBHECv4eIZAC1uA7Atv8J17kZ3AuBnrsZFgw+TPlQp4Sg6Bg
	TTDRRdNMEDsDQD+KpfkgOpxdx1Sj9pLpaUFgDB/OFkTWEFJlR2XmasNyhUlsptRi
	quAdt/vDJSkg4Hbr7yBgJb4/y26EyiBdHV+YMzi1T4VMEw4qe43tRoX+rQeG5A5X
	hRL9zuG7pHIQx9g/yAihvTqW7KD8XPJUUmsdv2sNA/Ez6c4TXzMGxMZQGTk9eMU0
	lypcVH2fHrHqFGEl3YYIUsE7WIZ4pS7e7tkFgDHualeqEsnwRO5A==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RVJagoogZ-5i for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 14:10:08 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJTWg5w9Zz1SHkR;
	Fri,  5 Sep 2025 14:10:07 -0700 (PDT)
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
Subject: [PATCH v1 1/1] nvme-core: exclude ioccsz/iorcsz checks for admin ctrlr
Date: Fri,  5 Sep 2025 14:10:01 -0700
Message-ID: <20250905211002.1937414-2-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
References: <20250905211002.1937414-1-kamaljit.singh@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_141013_238260_C0C0A6F4 
X-CRM114-Status: GOOD (  14.94  )
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
should exclude existing checks for IOCCSZ/IORCSZ.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d67545bd7abb..ac72bae800a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3491,14 +3491,14 @@ static int nvme_check_ctrl_fabric_info(struct nvm=
e_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
+	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->ioccs=
z < 4) {
 		dev_err(ctrl->device,
 			"I/O queue command capsule supported size %d < 4\n",
 			ctrl->ioccsz);
 		return -EINVAL;
 	}
=20
-	if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
+	if (!nvmf_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl) && ctrl->iorcs=
z < 1) {
 		dev_err(ctrl->device,
 			"I/O queue response capsule supported size %d < 1\n",
 			ctrl->iorcsz);
--=20
2.43.0


