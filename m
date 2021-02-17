Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFEBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C1864DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C1864DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Mrq5pYd4seOJvo0gktGPdWRTKO+G9ZMZ43LqV9GATE=; b=D0C1lj4NqM4TN1SVKsaQSUGM8
	qC4gyTaeFksx1s4IIm6N3sJny8hpfOmYlQR2mjCy6aJYQDjBAplHlDQlBYgewCD1LBfVSbo+Z6Bni
	OIcS7nRGmPyqV4TS6RVKIrIXrFxLUEvDm5kzacRG8j51uzb106kkaI2sH+cRwo1Jjs8gnY2zrdCUt
	gPU2aWtAfQUQW+y0MXGLV1Mgrlx7Js48t8yh9q5Ia5e2Y+PYP8yb8s6HBp97xrTbHrFKUdS60ChbW
	tbmGt3YTkgB1yYq1v39mOYYc58XCyBbBiZIGXYGr6RaIgpmKFVcz341CxoS/N7vdBByzSM9JvV/IW
	FXvLT8S1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAR7-0007ej-FR; Wed, 17 Feb 2021 00:11:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAR4-0007df-Q2
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520678; x=1645056678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hq45eQ0/LNpB1txPRx4e9jepI46C1pZjG9op1/t0ARw=;
 b=n3EMt0QLGsuce6nR2cpLw3lyC0W9gwh6B0NXQjLCvH6Q53gdLPe6T7y3
 fA90oeMFpDIkOcCYQEtgN7udlDrK6Fx6VNWZjwrfEXWarUK2zobMMXndr
 uvG01lM+DOCBKvn16JLNOm4rlmavehGqVHK53dK8DElBLv8g9jp88nWIv
 1gqk7ti31iMjcRTKnJk4MxFu82Q4qQkKIjXM7TnzSFf8w60bDhgUUQt4T
 M4ktmaEpzqzGntj3N+G5RW+44wmizB/vuvIHcb7f3fSjvEBM5Dn2uKY10
 gXFD+f0tMSUJEEgPLqPFnZsv5ic7EfKc3S3ogmbtxowth/oc4QrY9Rbng Q==;
IronPort-SDR: YBNgMp5h/HsSyGKuEb4q57TFgGBsuZ8SltJ+9l38vP3tbreUeARXDFQCySj4vH0BNycXete1Yz
 zGDM5IFUyfJVroByHycmR8ADXqSNSdjqj7K0JEHOlXe/umaBESq8v+4MQ4apL/9A0rMEhSlEYG
 n6969aFMMHx/YIOAyBxKd8Ajd9WQums/pAA7iYXislxvmEjWwH4eFMJCgMz+QztNK/0OWu2q9a
 RAPLnuFDFlmmYVdKXQJ4Tt1j2mRwqdWpS15fzccdoP7mRis1Gn3CteadTy6ANHmTZK7QYqir/K
 ukI=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160123490"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:17 +0800
IronPort-SDR: MQVWk1BE2vtjnBBIlLllcNPsysDxiA5iUkqk2Y8VSPiMFqmjc40aFyjyJmkyHLz62Zrhxwjr4a
 NMDjj+elp5HiQpP3udTjM3Woy1CVwv4yjEAtUsKY87YzvCSGImKGIijuxKkJ/B1Tfm/iCaYFyg
 Sg5SHG72RPXQ58dyAjJSDGVqWxhzn5S7ly5/LZbSsmd9Zpc09YTjhGl+JVT/6O7DWK+nHtpamF
 jcn5aSd+2F7qhW4cMWRAKk45oiZ4TxDsjHVAvF/ELFIJatc5Cy11RtoaHfjlyRs5imREk0nRDY
 j0tmYQSnDW9jn/nBQSz07uNp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:54:49 -0800
IronPort-SDR: sKwHa0MqDKJgZc4u6e52KBL4dKjL7zg8jWLU/vYYvGdxuXgFIvQRS45YcvoZ0CBnV/0PL5/bFF
 MR3gsiL7bId7nI/dyrZeV1TWbVZF0M/3H9OwPVUvGtOMdCBNvLT/UuQ7Pmc9zV0zsEH4fNBWSA
 cckl7dUGJmvfxjv7sHtH3nPve8qxuuZJNAgzpKBLBuuaE2BuqLr6csN1tRbIDnmBGeKOvX/HTL
 FKyYo+YZQX5a0BJahrA/qeQjoWQ7fehVHyWCk5j8y64OM7dOL+Npfhr6KlzffQMX/R7s2yFlFY
 e0A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:18 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 06/14] nvme-core: add helper to init shutdown timeout
Date: Tue, 16 Feb 2021 16:10:24 -0800
Message-Id: <20210217001032.25741-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191119_014591_E645E369 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_init_identify() has grown over the period of time about
~200 lines given the size of nvme id_ctrl data structure.

Just like the tail of the function it has small helpers to initialize
the independent fields that needs some extra checking, add a new helper
nvme_init_shutdown_timeout() to initialize ctrl->shutdown_timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5b8f8e0ee18..77f79a2a396f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3094,6 +3094,24 @@ static int nvme_init_identify_transport(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
+static void nvme_init_shutdown_timeout(struct nvme_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
+{
+	if (id->rtd3e) {
+		/* us -> s */
+		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
+
+		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
+						 shutdown_timeout, 60);
+
+		if (ctrl->shutdown_timeout != shutdown_timeout)
+			dev_info(ctrl->device,
+				 "Shutdown timeout set to %u seconds\n",
+				 ctrl->shutdown_timeout);
+	} else
+		ctrl->shutdown_timeout = shutdown_timeout;
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -3184,19 +3202,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
-	if (id->rtd3e) {
-		/* us -> s */
-		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
-
-		ctrl->shutdown_timeout = clamp_t(unsigned int, transition_time,
-						 shutdown_timeout, 60);
-
-		if (ctrl->shutdown_timeout != shutdown_timeout)
-			dev_info(ctrl->device,
-				 "Shutdown timeout set to %u seconds\n",
-				 ctrl->shutdown_timeout);
-	} else
-		ctrl->shutdown_timeout = shutdown_timeout;
+	nvme_init_shutdown_timeout(ctrl, id);
 
 	ctrl->npss = id->npss;
 	ctrl->apsta = id->apsta;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
