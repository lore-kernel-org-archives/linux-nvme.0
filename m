Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B9CC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 19:47:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC37661057
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 19:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC37661057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dSGS6mAcxbxXBm+htsty83f2Nos99SuVOSQUCdQCUck=; b=rbGTiT5rEJtfRg
	7CrvbaUJiQLkjM4PllxTEMoVUW4vVW7x+SK6ltq5Ddi8/a6Gdr+sLAuQ3dmK+wviS5NSlTUafzwxz
	Bjh/GmviZAa1BlXQ7L/237dvgLmwQ1gLso+vGlEXSFohF+EHZqdT3C+VLf2HYpgggZmO3UYyYhEXY
	pTIvsUPSXWJbInCZo8+lb5ln6hwsqwZBe/jueZgBAhzIy8YgmsX7v2cJO2jqYdXm6ww+Ivv4gLnAX
	+a/X503W0TeHUL0GHMzre0rZt25ehoL8Y/t7DMA6BjOLGhJ/GLaWVZAMM909T0K1bdadTeH8V7ujo
	IqNZnf02h5uQkqRtkxYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lssYI-00FvxM-N4; Mon, 14 Jun 2021 19:47:18 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lssYE-00FvwU-4v
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 19:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623700034; x=1655236034;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/fG0MGaxWcC0zalHa3cruTZB5HPoJBaIyPWZYvsotQc=;
 b=a/hJJv76HltUOsaBfuulJRJrlLgYILe6bwXzInQXV80YsQwDrXT8MnfG
 rUjQOZ8fpdkOO57InDrdrLqlLsp+hj4FLE8tpIAqgSIT+sbWemHkiUm9Z
 oWeo5MeRAXcYEjG3yNW0qWLsUcjsl8FEjeR6EUXpr11drDgRuU7QiNr1p
 y+pa8zCG2iXGT6CSC9MRKspiaQ1hK8FTD7rh8HDhy5JM6vMQYe06HAxTT
 MWQGedJFxUySPFXvFAVWG9wiRgQQ1rJ2gtlwoHfiMO2ok+M1HAiStCGBW
 abluiaB5/cX0mrUcnwMAC1e8yoUPQOGaaKjwDuzPOWlQmAyFpeO5Fs8HK A==;
IronPort-SDR: Sm5EvCnG5ARRVQKYQjpJdHHF3ok0XAVGs6I4O1JL35nrQ+Tjx3VyrWtrSyYPwCnEH+CPiVpBZq
 OAbZEtbF5o8PaAy+JGB2m22z67mwlxLo+6M+KzBt2uSUhCC77r5zzAZIyoogOMlmWu/o28nleE
 Jy33hL+ODoQ9QgARoqfaBgI/OsPhZVx4jJbzjovLWss1LwRsclCVs35xyzFkZID+UX17ZZe0n3
 piDiqqzP1RehoAJqqTHiM6Q7yDyc1PEhO/JsVNHjtEBSvmrokpJ5aTjdF7W9NxrhqyMTDvPiTR
 aX4=
X-IronPort-AV: E=Sophos;i="5.83,273,1616428800"; d="scan'208";a="283328730"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 03:47:12 +0800
IronPort-SDR: yeQqemadert5NfvUsdDcxAxi7ulywUkPrdvle/o7DWbq8zBp+nfU7e9SU5YO2Dt3hRv8lVXn8u
 UHcVqVICrCe8BULrHtchgj1QpNyPJtp3Tv85vMasT3c6yYA/z8ktyRtGsksH6eBR6TKUQcJb38
 t1l7c6SvM1HVcu0dKa2kgO9iVuxVBDw/jGbhM6B1KUCnaRBi+Orka1FTOuC4QVNDpiwW6NKQ38
 JRkEqOg3M+UcnwO2BG1UnXOzxSWomNe1qJTTELBj+qfPuZ1nla3hrnNRhobFhyNSygX4i2V+7b
 Mde7kFJJPXQCnlnU3cmmO2KR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2021 12:26:08 -0700
IronPort-SDR: LjUCu+tzqGPqA39d7E8njaEQ+TJvxiswJnujmZH+7XhxioJi5sE1di/Bbv5cLPsVKlhG4NqwRY
 TlCyJgA2Z8SrZUxyk64t6CHvYCWFdJX1VHZGr7ZDC205PnT55uZkIiYbL8nofnFaGVm+A4L2DB
 avlnHfDhxun6ymrOaGJ2RTk62D/5GYmwShKcJNDHv44IvScnwFMVH3UKIp6Aw0OBzuk5/N/nDN
 Of62PD6J2Ui+rN6sSzev4RW5B77Dq3xUFd0u6QGYEw6zGY6zjUwrjNt0aycYj2oQpvBO0w4vn8
 LNg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Jun 2021 12:47:13 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: use U32_MAX value to report NN
Date: Mon, 14 Jun 2021 12:47:12 -0700
Message-Id: <20210614194712.622-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_124714_230500_98657D96 
X-CRM114-Status: GOOD (  12.36  )
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

For Spec regarding MNAN value:-

If the controller supports Asymmetric Namespace Access Reporting, then
this field shall be set to a non-zero value that is less than or equal
to the NN value.

Instead of using subsys->max_nsid that gets calculated dynamically,
use U32_MAX value to report NN. This way we will maintain the MNAN value
spec compliant.

Without this patch, code results in the following error :-

[337976.409142] nvme nvme1: Invalid MNAN value 1024

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..c8c4a7ba4958 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -393,7 +393,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
-	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
+	id->nn = cpu_to_le32(U32_MAX);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
