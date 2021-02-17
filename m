Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1A764DDA
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1A764DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=++84vlXu5Ld01Ntyk2oGYp4yJNTDkx0ofjLnnmdL0Rw=; b=EafkkzMS039QYMEH1ts5/Gac+
	WoG8QlQoIB5YwnZMLVA9/ZKGkLwDoA1mWJB4UFS4wSHEeVa1uBh7T/tTUV+16F2Kwx+51ijQN4CcB
	xzMMrfjUBFsAd92X8wtRmvsF17MfKaaSwrb1fq9BusynyYgwruorGFNX5EFwMGONLZhOcCVjTnPb+
	HsQP+NcKPOXV7qa8Y0U81tYBXVoHJ/VT/n7ZEOsdbUF7hJnPYdpIyN5gSivsy1xRnthHQ8n2AEzZt
	ERNZN8vZIiJWKRjOm6mmOHijwzk1dJwEwz9BLD0kylEB0ijinE/rYBpXfNzrg7X7em27Ot/Mh25sl
	K+0j3dmBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAS5-00085o-BK; Wed, 17 Feb 2021 00:12:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAS0-00083X-7v
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520736; x=1645056736;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=urHpzBy/RTI7tEi+MOAEn+IYROGqf1NYQicJpuVapFM=;
 b=hAL3+tydeEivMTpIY1cQzSRSaRIzV9XuQiowaFNVG+Z+5IcHU1hN5IHK
 6Cn62srVqje3a29EE27V8nA8Q0bLLVWw6YX0CfgVcXDr+AJX8X/tUnZqx
 H+rDtwAE8gRMGWeQcVsufnW9i7dpJbi6/O4CrwKHlBVZcrZyNrUomozkj
 RlyKap7k+4VmSx4xOTe8dGBtqKMczUaGBAC8U7Ye5MvZDbHeFAQ18F5pC
 uOzMwwMdNPNrdfNdCJK47ByK7cz1ifpxH+pmbCRznC5yzy0rsursYCKbg
 Rw/QQ0xVGn4FoJ3Mg1/6H95D/ElvRtSck3monCFJcbpHMMrsiWf7VMtJ+ w==;
IronPort-SDR: R7jLJIhep7NEcFPtmQyPCyvNTI+XjuymMIG1Sik6p6sH+GUMn/gzOy0UxWNHVbB5RzmfqnY3+V
 eirupZmxsuennxnkGQMlfx90eAtOuoaCswwuB0mhSfzL2Z6bZpeGD2jyvbMGVxzZQMGAm2VtJc
 HregTkO2gWM3fkDixgK+c3khzLodFTI2Ia+hASn01Y0EH9x1F05NBvVDXAjp6FB/WWJVqL2wHp
 fkfUCXvMOe/RxjqZlFveMfBc4yn5/uR0fXvY1XZAq+Rn1+pDJRGx+MAqVhG9JoL8PzkIAEBbFP
 EoI=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160098801"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:12:15 +0800
IronPort-SDR: YIUofAz+MgcWtbLArkyWy8wAB3m+E8eKuzvZvIOHWpDOd5+4wcOafvgm37H/REIHUcvXnKW2TD
 iI3ceJI47DfeZw2hC5onjEQK5u+PlDz7ty8EEDVF7IFvz13enJc/KmJaVxWf/gl3LaGjhzqkoe
 R0Hmtcciq0FY6GxyTCQDSqWT/4cgAdJRXomYLwsi9q58SlJ2rDKrSv853XrpxdC9Tvwl+DRkCT
 JZaD9h7hHuzijfJgNTG3v5hoP70Srs6emHvY8wKErAxQPGBsAbDjiBXyQjPIcUz7F6FKHPPVtv
 8yYRUTONC/jnCEHOhh2RfGDo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:55:47 -0800
IronPort-SDR: kTPgb1rNvK3ipfO+Sz5ahPI3Jg1Ew1QHzUDH65J9a/Lvi91jWF/B+b+0yWm4JR6M3xb3BGJgXk
 PZ+FPlDbMnvppiRprspoDn2hVNbBUs7r9qH4UDeJzuS8uN8AFZ9KrZEt615IWG7ifjkLvP767k
 wMMbXUf0xCzOsQQof4DxvMGvfCtHnayxBUXDSfBu3/2N2bPfVVJaEufCXnfjJ6a0QsJNu9w9eg
 Guwd6PxzcrgNeAGd5uslW3DmtKZE282F2H0iHN3LNpJqzxuGgLN+ODpksZCkZL/VD8ukzYbhO4
 sAU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:12:16 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 14/14] nvmet-fc: update function documentation
Date: Tue, 16 Feb 2021 16:10:32 -0800
Message-Id: <20210217001032.25741-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191216_450575_C5D96645 
X-CRM114-Status: GOOD (  12.65  )
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

Add minimum description of the hosthandle parameter for
nvmet_fc_rcv_ls_req() so that we can get rid of the following warning.

drivers/nvme//target/fc.c:2009: warning: Function parameter or member 'hosthandle' not described in 'nvmet_fc_rcv_ls_req
---
 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d375745fc4ed..1f1c70f9f8eb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1996,6 +1996,7 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * @target_port: pointer to the (registered) target port the LS was
  *              received on.
+ * @hosthandle: pointer to the host specific data, gets stored in iod.
  * @lsrsp:      pointer to a lsrsp structure to be used to reference
  *              the exchange corresponding to the LS.
  * @lsreqbuf:   pointer to the buffer containing the LS Request
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
