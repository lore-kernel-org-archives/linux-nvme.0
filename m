Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B31C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:38:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C4761246
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C4761246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rwLpLmDn3Dvc35QzjFXrQsFzU4Wo9KVpDzqZBW7dK6I=; b=RxgqyaOdi11Cd5
	gbf36uQlnzmE0feyhghQhuj+N9f3Ms3M1q3sYK4Z35r2yG7FwRP+XqB8MFyYm8lsNBq99aTJuac31
	QyFD3zZZclrl3y8i/mgM4bnZHOtDuZLTPdT9eeEnfTZtRByLJ9WdP1kkudiHVgzyAOmpm5vmS25Qf
	lwa1Pf4UUAWcM8IsvntFo+wDRrXMJMPPxedoAnuUg9Zzilb7iBsCdyQESkFfFwBjvyvEbD+M6opyt
	io85Xa0CFuO83ziYXf9sjdq4LSz/NmdNYYb86g11l1xCTqzsejaj7si+fIOci7P3oxT/Zv/ZuNquM
	KC5n8j2IUdFD3crphxIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbYN-00Bu53-5B; Mon, 14 Jun 2021 01:38:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbYC-00Bu2A-2L
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623634696; x=1655170696;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z/9uu/2DtlOSHu3yEL6yDGyP22pKD/Czi+9e9CX62H0=;
 b=gQhdEnA80glCEGwm8OGLAW2mGk1cGiAevHg9TkzgUkFoUiWi1UaymiSx
 s2IEMWVUhmqsKZ96YKAQm78HkMWFnqMJLWUEuyIxC+DCM//cfO/jmf2rs
 /QtzA4MN6ZR/Ou/MrGi9bwHBBYgUXGegdhufZFXIg17/MzKsVxWVX/ttj
 wjmBYuous3gTiHGUfQMLpeQLYEwEPjUV/Q/Kb1xbjSRAbM43cKVD8ZgIb
 yIFpr5sbOqpiG/8lXEqCYyFb76UfOVVIGWjQ3OvGJsH+nuKCrK8FtKo4T
 t1afibZdjuQasLrTbm58O7ECCeX2mRXVx8yBKnnh9nIg5yRoucwnAFIsU g==;
IronPort-SDR: RlVJaJrkVuuo8Pi2MhkrnAmNnaMpFrmxYfdDdrMogbGYq2nTMtK70IlNKoLYs+kpBLrdNl5CKo
 lRXHlp/E1JNBgO5dVYQPHFN2/LCUBOMMqCpwsx9NzoB4wiJzg3rbSdwU9UsFz4MG5/8LZtjXlr
 OXzQINVBPGXiylmYIKcPj/R8AJ57ZEmvI70eePLVPyl5qzEqd4QGOSFmAiYHEmynd967Rg3YCM
 SkkJGx4WTaKhnfXmRWuoDv0IsneYInJ2NHWAGn/kJcKNdEMUC/zW6HDL4ko7jdT6TH4aYzTD1K
 Q54=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="275559750"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:38:15 +0800
IronPort-SDR: XIEvu3a3pjVQUiN0r68J65AlDfCzC4PltSCC34xOai9xGaZadLBOGunA/EKsZ6+Ueym9WIcdB/
 9i0Ixlq06XaSr4KbMJySZIu/s0eaQsT2yGN5AXjFzfO+0rL2RQCgjPBXkfANOEJ24DvWssc7fL
 xY/ZwPTLKg0bMHEoV4PqF8xnTmhboGM6JRrXKJm+PjlODxcWQWFzs/zqGpi9EdUj43rl/bZrtk
 kS3subnfxgs5Kh/FjCbk6pjPPL5Mf65V+UitO27tT2gMCUFW7xShFFuflRipfxfNLdALkhvLZ/
 SffW0O6AF6ymszeq1DMYxj20
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:17:01 -0700
IronPort-SDR: vAIqjBAJkY0pP6X6yOpN3YsaDKhc9+femtXybgaKkCe23AK54by89jkSyZtwnpAnCGUauQb6Q8
 DKM5P4C1H1237esce8YSl5xjxRb/5lcld7NFeziWl0dUpCiiUQMdgMhRigmlmQt+TmjV+zVMYn
 epimoyeJlPJWWwKbCeVBJ5ujyTVtoebaxQdxFQ4u7fvdv434/h0Yu15qIM4MvR/F+nVY3QfgQ9
 RibRFDMD4brGmCEfSHZgwXt2gaazvWmge7FeGArOalod+zBq4JjiXufFSyvNq8vZMlwV0Yjvab
 Xl8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:38:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/1] nvmet: use subsys->max_nsid to report MNAN
Date: Sun, 13 Jun 2021 18:37:54 -0700
Message-Id: <20210614013754.37940-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614013754.37940-1-chaitanya.kulkarni@wdc.com>
References: <20210614013754.37940-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_183804_196608_E8CBDAFB 
X-CRM114-Status: GOOD (  13.19  )
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

Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
MNAN value.

Without this patch it results in the following error :- 

[337976.409142] nvme nvme1: Invalid MNAN value 1024

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..a8ec377bb68d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -394,7 +394,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+	id->mnan = cpu_to_le32(ctrl->subsys->max_nsid);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
