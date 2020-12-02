Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16BC64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751EC205ED
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751EC205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/1WytQkJcQbwSHBb+bj43DakB+PRBzfpTQYqhiOjXpY=; b=AGXzzcTdElBhSNhEPAHpoi4i2
	o960GMiMwZBT1sNWfJcYnt+uLdF4jb3+qLxKJKgPQ4KNTazJEeILcEn2tNH6eBmBQg0TzVc8qvOTC
	sfWYNSVPU7/iELJBAP+5Uau06mCdDbIQ+HCZdRZ3IoyNKW3FQQBSI3VMs3/hGA0v740TAEB1bQ10w
	Q2s7MpBCSg04A59FhLoeX9+MKP6PNZxNBHNSJKM3RQVPeW9f81fhVKRTf+0cJpnnIRp1sDAmOuiqo
	y6HX9Da9y3K7mJxdmt19+8eloHVgueBedce/3tl1NMcjBxNDLy3em09KEoFbixe9MO+OMoqqFyG4F
	xrzC83l5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLYG-0005a8-7A; Wed, 02 Dec 2020 06:23:44 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLYD-0005Z0-KA
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890221; x=1638426221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m/bvl+lK7ll6HRYiQ0kG1ndR5SFePuzrxfzuz5g9atQ=;
 b=WLasRGUGGN+EfZVP26/VORWp6MnM6glMUyrsdH+DclSROom/aeYBF2sA
 mkBUqS4pMLGQz4TNL/202pyaTdg8++Gm4CVahpdjd8lwm+1lq5dZLVjd1
 M5DGnGs7wn27E/VrVcQoPiehqpum80vO4m85MLJquGNamIDY0BpiMpPKL
 WHpfSAFdElmpdsMKV4ZmV8eQDGd1BL72b0xOyJr8/76OdwA56IN/U27I9
 WiLSl+FwVZVujbrkuW3LgidwdyoDFk+Blo4gJ0bb4hcappafwqSqQU9Ok
 40/b7q8kqjfp39CLgyZfQWWyjSrsN1DQe4OLxEvs/+MVypAhceQDrSQYm g==;
IronPort-SDR: 4WlSrfkzxDceoNYRIpW5CM/0Lec2skIxKrhbt+T5bCwLPAFZyYa038qLoV74JcwenGJnQNT6X6
 H2QaiRlAPju4ivH898YL7f217x8ubpel12e38kCnKjHnVMyBw69gXer+5dvWHRriM7XEmN4unC
 vTstmC2bJd+EgY0d11u8CAXA5PDUHa4I5LYVmsYLZoVxWLIm+3JAA67TwfWvwrX9pxPROaOJQc
 iXP+vdy28V3gdkbQZWu8o+qmV1NsD8yWZZIKX8mZleX9q+xB9BCECHciSB0whtSmgsGthCoC9+
 Wj8=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="264126150"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:40 +0800
IronPort-SDR: eT8txsKfSoLlS5tLWQPPIzJpcKj30SDOGabsJsa/Im+h5lZG6CROt/n3QEv+Cjc6WpqHwRoIgv
 DTnpX5cRH/9YDnDd+vYP7WBJUKVQhizV8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:09:15 -0800
IronPort-SDR: uAvQnVjL1BD+KQuTygNy/y8RUkvVQGlyDCNHcfrpeh6fTnotxPc4aT5mSLjG9SdiUup1AE/oVO
 gYiUxrgjPNWg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:40 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 6/9] nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
Date: Tue,  1 Dec 2020 22:22:24 -0800
Message-Id: <20201202062227.9826-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012341_831922_44A35B49 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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
