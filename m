Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF50C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1B5613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1B5613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NGhYmglG6wP+F/gnfZtgFSwZ6t274mmgkTXiwe1xQZE=; b=oi1p9F2NC+27Kp
	8X69Du2NfT3dX5smkvhMO2NhA467osax3h4LZ7BCKUvdSLnCt2vBr24d2UG6bfmLi/bM8HLfcgwh+
	R11pElwdj2SivzdFOijD3UdgLbOXDJOSARcjuqGuzKlZbCvjACLZ8OvlDYOryS+7MIxdSBI0pDqy7
	ZDs4gZbJv/MMiFAQ2gP1fS3WevLa5F6kmoigg8UInBZnYoerirJcSNlKAPHXkalEbQJPMw6WrwR4N
	QpPDv9ceQABabMA4A0yTowMdUa0PrfQpvL7zzrWUoRfRNU48DOsXYHyubLF9JG7CvCUiDia+b41FY
	pmUq6fgjXv9c51NMdaJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbsP-00Byle-A5; Mon, 14 Jun 2021 01:58:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbsL-00Byku-D4
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:58:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635934; x=1655171934;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZERBYf1Txp+asurr7hK/FBc8HLgWiFTxShPN28VSvLU=;
 b=DE8dpIRA+CX1iQ8bb8U9oC7SPVP4rCxq5VAB8XbKAeWPeG0oCXjkuKHg
 DqW9yxrA2B8LeNyNC5fBLiXnQGiDRafSPmYGdpQExxnKUDfEqVGq3+SfE
 ErM6kqEVTLA06/aI58NPkEadZqwITyx75ZkPAXHVqRpBh83JVYKBIXAQJ
 zq80IiELvN032UIguYbGNSvGMT/eVTlzM1kheo9k+dQxD/cqmxSP2aEF/
 itpTmGPPi/g3wS4U64pCgL1YrKaddn8JTVp1n8gjlLfFbDXwUN/kYpqpU
 t/mtEsDbDnNRwkqks1R1tyyRFXWhE/1cacXATMinlxT7zmFz2S6rR3DAv A==;
IronPort-SDR: /JKfYl8DsioviRU/dCLlKZpyvXSjHm/W0GgCo+fyNmB3r6//nlho4mq2sen5Wx0MucGQnkeLIX
 aWVwwvzjoHTp5/thLd2YGYsjRRMIGJwMIEPPsG5TD4eXnR/sKpLz8iYCYMIUE2IMHNvuZNhjls
 7d23lu5vTHRqnf0Jyq6PWY5Z5eq5nKJVNvH9mvPubr/lMeRUnhks2/xL76TqvGyX/0Rtfj0W66
 MB0vMVJMWs3b/JZTLc9CxHkADwIF/PWRcYOnYmbA5qhuR6oumN7Nyn5SdZhOAET/vUBgDDMO2P
 KWE=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="172340318"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:58:53 +0800
IronPort-SDR: Dhv6pErXwyWXnpqAxsGnrcp6JtP0m4ZQr1lK4dZlXyI2BjsGnlULiPrcZUOeyjCJySgUr7o6R1
 RRGkgfpBx7BSExA7N4M26hy/TpQHpZf2teCHbjgu2QeJNzdEb0HUt3z83zl9veVmQIr0okcJRt
 H2Ae76jBSNsXko6TTwYeanNRhyoewD76v6PiCUluzltgYFhRx0gs5he2RMmquZp4MSthG9hRSf
 ue1EvJegjh0PL5ynGPOPMKkA3zaDmyMagXHqxMPHT86/D3LjYW+3feRbeziy+fX02Xc8YTl7e9
 m4E/pe84LFYXBULW6eiz7ViW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:37:49 -0700
IronPort-SDR: NFonAusB13mt2jlEEqOOz+rfrFfj5lKjpeyiWRaLr0nZVrl/xgAEL6+T2HaTYgDjq1B8Qpb5S9
 9lgxhpsMvUEZr2HxTKs7eqmK6lgA0mk0LERv33t77+UhoSVYNifPEHo2gTkGEwCYHLXglW5Zoe
 sZd3BE89zjfEzT0s9oOnp5yp2cf0Ztj2JEz4EK340Z7djEOFIVB1nKCGIKe22KstXG0xPAFayv
 ZGxK7afkQdXdRUbxO7Wp2gb5mPROIyfMaH0kgB+gnnF66v0HYpkkLcLWI0ZF4iJV7HbqR0E2Lq
 Qd0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:58:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/6] nvmet: small cleanup
Date: Sun, 13 Jun 2021 18:58:45 -0700
Message-Id: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185853_540939_1944C1CF 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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

Hi,

This has cleanup for removing local variables which are only used once
or not used to do anything meaningful along with type mismatch for
subsys->max_nsid.

-ck

Chaitanya Kulkarni (6):
  nvmet: use req->cmd directly in bdev-ns fast path
  nvmet: use req->cmd directly in file-ns fast path
  nvmet: use u32 for nvmet_subsys max_nsid
  nvmet: use u32 type for the local variable nsid
  nvmet: use nvme status value directly
  nvmet: remove local variable

 drivers/nvme/target/core.c        | 30 ++++++++++--------------------
 drivers/nvme/target/io-cmd-bdev.c |  4 +---
 drivers/nvme/target/io-cmd-file.c |  4 +---
 drivers/nvme/target/nvmet.h       |  2 +-
 4 files changed, 13 insertions(+), 27 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
