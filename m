Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB3CC7618B
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJbdagRDg0o/AzfV09ITAt4qVr95BUhFzTnbq2cA+zs=; b=ljRXvqZluNRiLCgHn45mPGf5iq
	3p8zGULO4lUQqjFDjYPl1XsOxTZDRHIf88oXk0bFU81jXFia+NLTFvJkAGMkoVujR1ep3DTkkraPv
	7gsKC5g1KYpnfjhCIpQB2eX+JwGRRv28HSlduz9W5teYnv+NvQbM6M4Ssr0PCWhCb0Z44pbLMkxGi
	4t3Tyc+3kEGO8qZg1MzvSbbCiocyyh2VLJnFwAy5ixjlFDJFdTAPcG9fFbdouttM1tTVupHqLPqnz
	EfWSOWC0D1PWDa4yNziJBj1Ufl8kYC54iUZrrSa6ClCL23AN05GNY9YAcnattBf6ppNS+QQdLQhD0
	T+e09m4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrJ-00D8AA-1l;
	Wed, 15 Mar 2023 10:59:53 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcOrD-00D87t-0X
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 10:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678877986; x=1710413986;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YaiQJBzja6m4X5lOLGdpQfRfT+R8W/8ZDYDQXrhmWDY=;
  b=oH9k/4IkZvBYbi1Wru+pXoBP7NiZ4Sj4F0iyMDaBT1JfH4kbQqv8L+7W
   NVOJLtLSFtaHL5jNHR+65HuvhgCVII9Q+p+lJS1vBshWN96cBZQoPouSw
   9KXIc/LkEp+aD6FCZU75mRhHZOH9ZFvPPL0ay70vYnCxf5sD94ymVfelP
   5bMLqRZmNcVO3y0r1WM+YfGwcyIRq0QPpNK01bRD0dLyMQtjt2SeGcRrZ
   YdRHMHWRDqC17ViDa6RZRbEUXqtcRUs8EkyvoYm8bZZMio5ngnaPHIpbx
   qpCz0bZBWrdiw4lTCcTHB4wAan+ELPhj584iPZ05NfHmkI0iWmmrI6sW9
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="223966392"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 18:59:44 +0800
IronPort-SDR: 2VdjDFx9olsKXp9PLkT4YDHomsiZPYf9L9pn7vNPHgQ/arR8yNcN0hJ68qG1MeFWwNwYC/f7/C
 s+2R1BL09umDr51qjMA/J2wvXVPj8Udk5EnLO8IFyr4zx9Re7v2yPO473KzIaoha3N3XCxxfy/
 NO/DX6xBpqeUsh2XwCVtlSLRWT41QOJOIdFQxO9FTrJKZIvh6tpzZ5tXVIWqBQQ3bu8cbvkRDM
 d+ju8XMoQdnA0vkQB1/Kf3C8kQaa1UIIEsOVm5RPHcUJ/9DeZXreCu2WybmBcblgm/aQiLi30u
 rn4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:16:10 -0700
IronPort-SDR: R0CzxrL/K5BSg+lsnlazFABq8+9XMwnidmSgA4EQQmpuRRV90qQQJphhylZNDZA5YSxlzFS/fl
 c+0ZozAjbS9cOoA/5dsOq7IP8Lt9kEuNif6T8qEg1DbelosxFMwsLXpTngjlsYEOPje7Ik/mJF
 cgcNsc+EgnAMuR3fjSPu0BT0Eim52VWZ7Xzv3yTeOTUyVZU9vVAeAYLuQNbXPA4serzBm06LXr
 OAiJCFyIx/IILCMtdT27yDkhWSG3/ZRTG7Ax8evAUz6VPIJXyuSKmQx7V7w5LbN6BcPEenmJYx
 3+E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 03:59:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc6q40dTdz1RtVt
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 03:59:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1678877983; x=1681469984; bh=YaiQJBzja6m4X5lOLG
	dpQfRfT+R8W/8ZDYDQXrhmWDY=; b=IjMS0CteFKXST0QqQLOLhx/Egb/TrGAH6H
	oA3j3QXVsnWOB7pxk1pvDBk5EeI8r36IH7+RUeuq0sZR/MkbrGM7Fl+QOJ6Lm+Sh
	IJyFYc3YSjx6rmMVCJvgxlwWGv1O5MsC6mM/XQCfhIPGoJj4etPgHt8lkJRtgU2X
	ODdBjf3cAPnitBgSbqksl4OTV7r/aNA/g42AwZIDPEev4hfi69B0ZtYNURN8WWs+
	hGxwmfS+zuHSD5cDTzMI6OAFhy0Yeum168npfAoKyKqG9y2oH2Y8Fjtwj2Xe8aIJ
	PbFpoNG5hSWhNfXpUfvFNQ6wVJkuFzNEZRA0HPXH/FaBcY3bplmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bXsVEr3LQNDC for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 03:59:43 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc6q273ZDz1RtVm;
	Wed, 15 Mar 2023 03:59:42 -0700 (PDT)
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/5] nvmet: Fix Identify Controller handling
Date: Wed, 15 Mar 2023 19:59:36 +0900
Message-Id: <20230315105939.305825-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_035947_293672_0B7510EE 
X-CRM114-Status: GOOD (  14.70  )
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

The identify command with cns set to NVME_ID_CNS_CTRL does not depend on
the command set. The execution of this command should thus not look at
the csi specified in the command. Simplify nvmet_execute_identify() to
directly call nvmet_execute_identify_ctrl() without the csi switch-case.

Fixes: ab5d0b38c047 ("nvmet: add Command Set Identifier support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c
index 7fa60b1aee58..cd1b752c52cb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -688,11 +688,8 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)
 		}
 		break;
 	case NVME_ID_CNS_CTRL:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ctrl(req);
-		}
-		break;
+		nvmet_execute_identify_ctrl(req);
+		return;
 	case NVME_ID_CNS_CS_CTRL:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
--=20
2.39.2


