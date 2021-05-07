Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454BC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:52:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEFF61027
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 01:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEFF61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kTKgjmrzUR3DXWAaGkUEjsfRgO4C818FF4JIJCKJbsA=; b=MAd1bsqMN4ivuG/SKf6xKj7U8U
	1xcTBe2t4pmsy6x9Rp7blbcs9FBji0d0WqA6fbCREusdEoll8KYDmOEo1lo5OTJGbAS7v7qsgmiSv
	8AtiJ9tHDmkGGwcO1coo3LH5W33Tm5rOCekTIL+/X4+1IEARuB2kECDptdlPzTAQ+aMu92g5snuMY
	WhFLc54px2aUO5frxg7L/EEZP6TZqDRoltOUSfRyHbir5Ys26+u2ly78zEDrMXq3J0Wn1DIHUuRlP
	MuR9lyInfY5XqlSjxMC/WfBOmFaEEJbvvN9fXiiqFt6PzYvJvPiJA1Q8iHsWMOZr+RKLMSVnpNKz1
	1AexHh5g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lepen-005oUb-Oy; Fri, 07 May 2021 01:51:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepec-005oTw-Ry
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 01:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=x43JNlt7fTr9MExve7hnv3ABcEX+ZZ44DQM8ooqYmok=; b=wSxj06K6w5P2P9nv7UlAo7lhdp
 aFo120mZ4xaB95vc39bAIFfPpzakTmlshyHkBO1A/xf/I0+mCAKqJMgDt0AhQgxi/1c8HRvWOCaSb
 Xu62LUOEJNMacStljeVTG7x+ckTzYhFCivCEnMOvY/QHMCzxcdV9/6MZphcly9oSTflYuhQ4Z84Ee
 JuRDelIKoHdUXD4jo3ZuC5ByiYaIDp9aFfvRc59GQkIJ2eTYNfzl+azUErLk72Fw1msYJpq90SerF
 UqZds5gWn59dbyHafpyEsvCf+OdvmTxrZ5ZpMaoXpr1s5xCr8yEbAdbuqThOu61FyH/z7B5NVGl+j
 vqJP/cPA==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lepeY-006Vpf-Mz
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 01:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620352302; x=1651888302;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2yuHCjfXdwTmwuXeWCFWNRZ16TyfCcmk7KPk2cWG1rk=;
 b=dSoJWA4WKUi0/zYbtilbTeIe0/YiQDMYCyTnpn5rhnkrAXI/WwuRmYDM
 RZFx6SWx11gIYWx01tUfBFVi/E7N4ZWNJgN5VBbge4dQmWbCuQQ06q6MJ
 DoprQ2AgADF1zLdppKp7AiBkmVQMMDAUKdYi7Jh11OHuEWbG9fugu4tJN
 FiHs684Exw7H0ELGh7HxDi+OOBKlh1Pvd8suvWyu8e5NMh+vQCZWUqjp4
 na/c0Ca3PhCVFvI5i/JfZKgUAEjvVo8W4MU1VzYuQTBl2zFcyJhn9T35G
 s/upgRXiPju0nwBx0wYX89o1dnRvDhrfnsiIP8ZCwbOxwnwy+2LpYjW2e g==;
IronPort-SDR: lyOq+Jmz3Yidyo83GJ909lkdQWvI/XoAPVhTPnowM4Xy7qp+/9rbhd8aU6aOHFHzGiZ6jZeGeg
 XDpF4+pAEmFCy1DavciQiQMmP43GxQ/iqtZ5rChZdEJOcThuNUuLwBZYxL/fIUviq9OdX4ASvd
 UR3xQJYX2BkSRzQZYqFbG2jCpazoqx2PqrYAvMhauvjj9eTcD3jxFJeH8TmvnRvAv4jjzQoOAs
 LgGFiEx5atja2qRtJhGMq+z+CRzBfzuJ2O80plxVPFrbM7jEYpTNqZw5TNWCWXXKZcxCKdxwUH
 34g=
X-IronPort-AV: E=Sophos;i="5.82,279,1613404800"; d="scan'208";a="166711728"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2021 09:51:39 +0800
IronPort-SDR: 3uvBOCr4RS8z42+4fmb7rkzuacV+PTRJTCuU7tQcv/JG/5bE5QpfcvFNM68OpNy+QAXuclfwcg
 5qaw74jcL5uQ5nZA0rliyEHSf72Lf2a6/YAaYYyd+8jMRnlyLySV3KKYFTHVMog/ycarpLFove
 pGIxCRJ4bG6JCopyGbJwGVu9hY+09UcGfBBx0VVq2hI0kevh13U7G0iHdv9I0jJJGS8TODy/5T
 xQehGn3XUj5KelMGnpqpEs7CE80b6NiZX+OvVmUb6k5K3eLfPCJKvqxL2HNiKlsEgiP+j+VBpu
 6g+liGBhlqbMnV5Zikkd0nmH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2021 18:30:18 -0700
IronPort-SDR: woLkXovTyuucs4rpSphq2Q1vHaNyBfZkQNpTJcXgUAesMay78tCDtKGpcob6YISafzrq9kLq9M
 ROpOkqLuFvq0Sw02SempjWJOlKwQ3u9Ks7UZKjJd06yf5CPAgP5p76zs4Sc5PrP8WPbDsElbuW
 QMyWoMgqtRtrovGGGCJnkpbZkdoz9a1iEALDY98c87+1S/Cvw60yJFXOOSOy9TQG37E1G1+kRj
 QVRi62gx4Xdg41Qtm217oH8dACxnSaN7Ftl202Xxqk7XF2DascvgLRAiRTwkTAxjCACPUP5Vdq
 StQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 May 2021 18:51:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/2] nvmet: consider req->sg_cnt for inline bio
Date: Thu,  6 May 2021 18:51:34 -0700
Message-Id: <20210507015136.11069-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_185142_854956_BFCCF416 
X-CRM114-Status: UNSURE (   9.63  )
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

While testing I came across the scenario where checking for the
transfer size is not enough for inline bios, this issue is not easily
reproducible with the test tools that I have.

This small patch-series adds an additional check so that we make sure 
transfer size and the req->sg_cnt both fit in the inline bio for
bdev and passthru backend.

-ck

* Changes from V1:-

1. Add a helper nvmet_use_inline_bio().
2. Add fixes tags.
3. Add reviewed by tags.

Chaitanya Kulkarni (2):
  nvmet: fix inline bio check for bdev-ns
  nvmet: fix inline bio check for passthru

 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 drivers/nvme/target/nvmet.h       | 6 ++++++
 drivers/nvme/target/passthru.c    | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
