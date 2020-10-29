Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC3C4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA5320838
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TvK/6lp+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d6+0BAzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/APqGqxfGU3rYgdOTGT936dBL7Tz6QOi0mlQnwYhywE=; b=TvK/6lp+Z6gIDDIMu9pHgVJClp
	YrKdolLJQz5TWTa9nhZNBvaYzPoYqHsBXU/hEP4Zvtt+hFe36TXBRbRYat6NiPdNg8LrYZ1BO15AN
	cJnKrtruF5xTBP0qCnXqlrjMOzHa+NG2dQV4/NeC1g87y8KtoKkTwmt0+SZWpFB8bypG3kNG5l0Vc
	jEiLF4LlcNtzlPUXQM5W7VpTWDKq41MdsIZ6F7NScvfvdm7cdnY/lMI/F22W9CcgPLZQ7GagYpmo0
	PoQL5N4ak7keQnKSHAEj2rDqx38AmKL3c+OAYtieNkpGwrrTxst5ATwQXIpyvmEIKBxOwfMmMF6u2
	XCSB2eqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYD9Z-00017u-Rw; Thu, 29 Oct 2020 19:00:05 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYD9W-00016S-S1
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 19:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603998002; x=1635534002;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KsoYPETpotuAuLzpDL8FaVEWU2mYTVWDFPEv9Glr3SA=;
 b=d6+0BAzY1RP6U2CMdnuF7+wQKOo+scDbOt/IikYNyseVHu1E4w/ZtziJ
 RGAl1Bd2vuOji+s3J4O4FCAe4DvXDVy7GVSm0HCMTfLpDpvLuEZkZSDqu
 PGf59IsUQ0fQoNasiGT/qcTHZLq4NXPTiidrW9JrN+yVsA4RMWZOSPLfh
 Yoq12NfMMDQKrb/KXUhcuWGrE1nbiKEVWAapL1GOjc1CTTCRlT2YUZ1PS
 fMpeReqZfuyA0gwoXgbTNJ2wAlBUh8Fw9I03yWZRmgZRZPlITaI06eevw
 3kEQn4BDYBNjNG7BTP9I0E0EmT9uPJvJQhHTRcdZ9SB1PMstQSrOjY54i Q==;
IronPort-SDR: TSOKHEFUGY1OvyafRJYI70wtmxcjpJnOW9v2x+LjGPwpGuQnhRBpJHkU7gKL5UBHWSViPLjKbm
 QlboFBBtFGFXQEsPisDJTFVdniqZnhuK88V4otjuDdpSoiyJWpcHCaiKELaubr7D//QcCiBaeK
 HlVQWr5uM3stw/vCRWUj8PCRjgAEjWWTMsxXZT1UaZUq1y5X0olzkhW52176wQ3KB55dXynvdT
 29tmIaqzYt3icB12jOhZw6bgLVJd6aLYueSO0V1Mo5b1ZEdnlO0WRt10s60aRyLMctlOkNeuaK
 k8g=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151175626"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 03:00:00 +0800
IronPort-SDR: /jDD/SGXk5JX8m9Og6y21OfHQSAH/qLBvVIuULb2ggN8+6Gk8Qsp5pwOiMDxkNMT/KVxqY59C+
 nvsAdhD3h/wgutItneh+jdva1V3KIOWQFA+OI0P1HW6mlV1WyrT2DMdAlvHAyXK9qGX5HJMCM/
 y9y1c54bNvrnFO10edgZ4DgaQpXFKL7pAMk8g2vdfgBY47Ye7wzCGY4eCAPOgqZGyUyycFEYY0
 gJDogPISVxsT9u19CwdlRcHefcxyTFI/U/ADS8qPTpdPVHsUl29q6zEjQYpIMxwM4Gs3zYou4l
 uJrYbGXZ974Y87h5MuuET2VH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 11:45:05 -0700
IronPort-SDR: ZqZrGKUYA9CeStjE0i0/B3+wAVwfQL6iTMAp3za0udxCSQ9YS2StGxRDbIlFIdGfXIB790++V/
 s+VAq5Goirra3qZcHuZShLu7t+gD9EEnEWjUh4A3ogBE+2DYB0C6orNXAwGoDbGwAdX4/zwusu
 a96nC88B+Se/BprGMPZS507FuFRlYUZiK/Po1NijZB7v4hXztiXLZ11FcNgh4SEiOUx8586ewP
 VGWyT0HzTMNDnlQF0MAGJZvEP37B/g+OmmVc5N0gDYeUDTVHOMfe8mmab4tLdBYYe56C78EdlB
 40Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 12:00:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-core: pr related small cleanups
Date: Thu, 29 Oct 2020 11:59:56 -0700
Message-Id: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_150003_099987_6269514E 
X-CRM114-Status: UNSURE (   7.86  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is purely cleanup patch-series for nvme-core pr related code.

-ck

Chaitanya Kulkarni (2):
  nvme-core: cleanup nvme_pr_type()
  nvme-core: add new line after variable declatation

 drivers/nvme/host/core.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
