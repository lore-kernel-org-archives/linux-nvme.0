Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331FC2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF84206D5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6TIk0B5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HzOkXX2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF84206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kj3HFodM7bLeKpyJg1U7/NQ37HrWkFJfZYWzFgQ84sw=; b=s6TIk0B5NDdyXj
	luj90z3iE9RfEtbl3F4cZy6PBPFUlwCuI411DfwucaYnvTve4wk1ojoDCCG8tS54MqvDGx/SdqYvU
	O7xnYNYHfYCWbrCPdo8wj6t3y2aPBpFpuhqCOEOwW9/ozDRRychGH8ddLvrqpSkN7JhUkFDLoLxm5
	vUlWVWTbo/EXL9xEIgpHSCXJ5ein7VNPrAhmnFTMSrH5Id3sXOtwf069E+QiHRxANahH9l1kf2y3y
	c+U1+imXCIyATscTi+tUAnd27izuhvWdOPrIIorwQ1RKbiznVRw67wZp/fO7jszkW3xc8WCk6HCwv
	T8vVGjTvd10vS16YiELw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwwmg-0003oB-Hy; Wed, 29 Jan 2020 23:30:10 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwwm6-0002aI-Cl
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 23:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580340575; x=1611876575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yhegzVwY8X2y0VM3m5FGUcNSnFAXWRc3w6Nd/G8krxw=;
 b=HzOkXX2Ou/2Fm2dsdqftSUZXPHhUWfnnvmVF7nwiKWjQOR1+qmoZ2VZN
 ZHhcic+DabY7OnJc6JkISibnjCdiIECmtYKb/P7vmLuF+peNEboZhcXZu
 HE9HzoW2+dmx8CcTtip9SCyKJ2RaZaiHfzziReAUruabVp0ZupR5Y06NS
 1j/BdkqyRZ+QTfGVnMmj+/6+tQWjbDLC8PRb7BSZhVqMbwif7oPCXSCQy
 BDxICTvQvLLQcvdq34Ejpz1S9n52ifUd4oxVAxQtkWMExQAgzYh3Ll9tl
 y6KwCcQPM95nk/zIs82tkpwtNxuCs9UgYIUSf5yXdnTcG2Tem2wPxA0qG Q==;
IronPort-SDR: tVtHi2ggFzSA+07Wt7UZ6vCHeSGH+cZPResuVgzjD6bvs+kjT5u9mAZKKEfCSQoydUzZ+Ue2HC
 FmY6ftBDMF44ffyo6BCTe+skGA0M5GfWDJnK8dhy8UDeoYAhi3VlL7FBYngfWFS2n48RDGadiU
 e0WOjQSqJsUizxGIUuePMOwj/q9aEhMEgvQsHbgLm3b1Vv1S60Ct9QhaHQwLLvkq82YWQh/rRr
 G//kEBR4BPedrDSdoL6yrrMFXP/SHdmndQb/mAyEUvWU3j67cICrdz4RiE+rZMZSFsJrnNdYsq
 wHE=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; d="scan'208";a="130160265"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:33 +0800
IronPort-SDR: 5fqHSUaoi0lX+RgOp5ZW8Oanmd14Y81hpQoIXhkkxPxPf6Pf3tPzcqM8ljf79YwtRaZJSHMqYQ
 CdlHxDV0cN30affRHdlRB0peklQ3Hh1ZA8OW+AA001BC75i86rwHMS1+/jPDsv5u2HBI3CRvPU
 TD3SG7nSVzw7W/2xgF56SmYoato/4TFMPhD3s678/f2yaLDgCt+S4Wo8qjRIZt/Pr5qfuDQqO7
 mazdXrd009pGUJHuB9JN+TiCjwKDokcmRufRYukb9+79JB2/tEbGI/0BbRYJAamBWG4RJlhek/
 ddwNx2k5X3gDwKgQWQlRA4Wb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:22:44 -0800
IronPort-SDR: QBrRE3i19TU7CMyH/+/ZQ2KESII2BUI7FX+WNJk99N93BFvc3LrphHytr8UhtizdCxCfLKaEwY
 42sMvhuutrFd3wEjHJxETIHM5hwZzR8vPSQYW3pjgFlZ/XQlsOvp7A0u2OdXk2kbhqS0g0yB4e
 96pu9II8ucDfpt1BChg/ipurvxToTDXvA25zfFk7vseIsTtWTbprnPGJ6e2vekP0bK97BMFcQ1
 50cntKO00WRY/0VVGK11Guj4bRUxglOfk/muaIsGM2BK/sVPnvwtgjusEk09eh3E6e/n6KsbeM
 bUU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:32 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/5 blktests] nvme: allow target subsys set model
Date: Wed, 29 Jan 2020 15:29:19 -0800
Message-Id: <20200129232921.11771-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_152934_472407_C1822F45 
X-CRM114-Status: UNSURE (   8.97  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch updates helper function create_nvmet_subsystem() to handle
newly introduced model attribute.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d1fa796..377c7f7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -123,6 +123,7 @@ _create_nvmet_subsystem() {
 	local uuid=$3
 	local cntlid_min=$4
 	local cntlid_max=$5
+	local model=$6
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
@@ -133,6 +134,9 @@ _create_nvmet_subsystem() {
 		echo ${cntlid_min} > ${cfs_path}/attr_cntlid_min
 		echo ${cntlid_max} > ${cfs_path}/attr_cntlid_max
 	fi
+	if [ $# -eq 6 ] && [ -f ${cfs_path}/attr_model ]; then
+		echo ${model} > ${cfs_path}/attr_model
+	fi
 }
 
 _remove_nvmet_ns() {
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
