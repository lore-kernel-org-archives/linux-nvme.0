Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D0C5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 12:27:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BD7206E5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTUncAx1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hbXXynQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BD7206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jl88SfZ4Ix+T7ii05bh+1vbby8NPVB4TQ6lhe0O/eAw=; b=gTUncAx19Picx55c4pPD/BPkgY
	efAzArym/jmWFuFtjeUhbAEwEFNXiW2gS7nslqqrWq+8fKCHkLEz60UM0RGQ+LmiN+yJ1EjrTnLqx
	Vsoq7x86WgBqmH+Bnk36d73PW0FXe/aZI3+swBQWV4qR4S8LXiZM0/s71l0ODPPhZMOUkKJKgZ+Yg
	omD98Gg14TmTIgnwknlMV7zoSBgCtUHSsS6jYgpeYWKym+WUIuUshU0zV+zzA7nNekWXy5RnPyHXL
	zf+COfiKSsu5MpthmghYEVjluNPU6qkpIM3Ov1CsRrUJJF//NCjiOb1fjpzRKTrqSGFSDGbVp3bxt
	JxCm11Pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khttk-0000l2-Dn; Wed, 25 Nov 2020 12:27:48 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khttg-0000jf-BI
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 12:27:47 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fbe4dbe0000>; Wed, 25 Nov 2020 04:27:42 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 12:27:38 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 25 Nov 2020 12:27:37 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <chaitanya.kulkarni@wdc.com>,
 <hch@lst.de>, <sagi@grimberg.me>
Subject: [PATCH 1/1] nvmet: make sure discovery change log event is protected
Date: Wed, 25 Nov 2020 12:27:36 +0000
Message-ID: <20201125122736.4423-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606307262; bh=NtDnjSdPtWDRMQGUWMJtIVBmtq1el6YfBWb7Gswj6UA=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=hbXXynQrpolwsndiKS71o8MMni3xTuL3kdMuCIA/r8Vp8OkR8lo/+nsUQxCv9gWt4
 CF4ViurCe3ixGFTDbE74jQDLCg1uUxhLjJ7ixMZDzMiGaduzd+d10zVmoKUnlaNPF/
 CqFju2yydq7e8ee533Qz01Xs9Ak6kFAvEAFAe0OEokPk7b/KLliyT5sKZ7J6t21DtA
 Yc/urcfwatFt6VVrivRc+g5zrDlFMyX4fTOcuH7UAQEiuMYKMLskeZsY58tjC13F/N
 ZoXH740BtRqsaaReMC0g4M01rmhywWVNxkBZzZGTTRKOuY8YgYCBiGF0ecr5HoOvf6
 AHjj+aKOPERPQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_072744_503194_C5517D19 
X-CRM114-Status: UNSURE (   9.38  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>,
 oren@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Generation counter is protected by nvmet_config_sem. Make sure the
callers that call functions that might change it, are calling it
properly.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
---
 drivers/nvme/target/discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index f40c05c33c3a..682854e0e079 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -69,6 +69,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 	struct nvmet_port *port;
 	struct nvmet_subsys_link *s;
 
+	lockdep_assert_held(&nvmet_config_sem);
 	nvmet_genctr++;
 
 	list_for_each_entry(port, nvmet_ports, global_entry)
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
