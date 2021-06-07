Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38A1C4743D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55AA613B9
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55AA613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y8b15qxFn4IPqMBeBntZCOvaEmBmWF05fhYSslEgry8=; b=t+lIHxZud7Khg9
	gsnB+KjUAzg2s6W9E3Ue7WGxI9RrMzttd99bDEUhZVDD1bu2/rHDpaSv3dwRibT65ZuxQDpjQ7bdF
	ciH19Ef92nvZ1p5JNJfmY5BzzSyB6w94Ha/LWtGua6nXig+NJhRXC3rBSV+AiPukc4XOShU4pse4j
	yg9w2ZkvRgqEYKLdSNKycMUELKuH5HlTY4OW+nAPljC2KwqJ4o30NrWvxzoMb9t+qp/Mz/ZSBe+0z
	uCrNZDfvf4b9zPfp/IR0u5HPK9VYLBkvAv4EUEDkkN7L4mKMZ8+1YLE7HK+MP43HCzViHePw+EjMO
	KfsFnGFNGQwdPPxoYOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3Gm-0016Ed-6i; Mon, 07 Jun 2021 00:37:32 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3GU-0016E7-BR
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026232; x=1654562232;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wLryMsR3bUjl5KNscwasszegZS9bis/iiSe5ruPU21s=;
 b=cIST58RbWwRhi55rxLulzcod91CWK025ACfDaQXPRh1splwlqJMNHgjW
 5WHDBV5RLzFgmIhsjWoMwq+uK2wkTyLc0ivLWIuqBS8X7c9xT8CCimtem
 +jOCeIDLrWfRi8vqdY2C8u8TTfTU3mkGLGJ6e6AUy+rfJJRWga+2Uym0t
 S3cAEtjRRhVA1QfSxhaSVsw76EyxcHvgJf0D2AZ5fLMCNgmw2UzpSLUF5
 PvVqZ+xK2p6UcshLoTvhfjueJ8/AqhgX34P0U3L8TCT3rbAdDVC8FphKD
 AClsArhwZW94d9qN0bYKLNxVJOe8M3XLGThyNMRSLK4CVbO8kS5+Kq+cY g==;
IronPort-SDR: DcEpa0gENUBXLBaqx3ISn4O6YtYsIZDVrdJprrRi8STPvnIZ9XShPcwE3AbLnW/P7xpck5PgvY
 ez2XH6V5QIFgbL0GQORjsJV9kbui6ceSTfPhkP+mDSWPOZe703qbt81iopijgJ26zQJqGdJyJQ
 G4w4bzCdcVzlehfKWYd+AAS9Gk0G8EYlrswL8pYvBG0tT030GxEhTME+JUx3SIiDCv4sl/TBfi
 pcmeWqSDZTQvR1yFR5FmeLxquJxDqWVr7XEhp56y4AQvXbz0izUNdDwJQ9+dgt3nkqajL8/yvz
 LRU=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="170970729"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:08 +0800
IronPort-SDR: LHOprmD0StEQ6xLQzppmg4AfjZpp9tpcaaeLU9LyJa84dmzpsp83JpEc5zofHedXMAd5P/NmJY
 egrh+IN00yt5O5ao+U07Cm1q02mLJTv081HGU7jesoscFetv4FHZGTBjloHIHgmjweO2NscICE
 cSZlXagQwLLC672cmWE8ehRPaLK/H0CZuHYEWMv69XIMzqeVbKPUkFl+E/BPzIfeF89O11b96n
 SVm3oQdxKlWYUtzKOJIoArCRhc/ikXUdF0//lOlFKVqlHapPet/hiGDZvUnGA/xq5hYozPBAIk
 VrnJJkJNc0oOKQuIx2XETh0u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:14:52 -0700
IronPort-SDR: Vum80njXaNrYYlhRumY2gcdlufH/eGRpt7IMBIHfUoU3WDttKr6ZUbQ6K0SEIy5SAMAv2UoTEE
 mJWDdFunFQataraBCzHF6jzh+ONw4YwHrMO7nyG+2Ir8Zc7QcSKLIhnv27DGO1j6CBLYVJQBnY
 6E6dSnvOtdxlujkPAxkwROawCYV0lzD00IBeyP75kzLqf/yuPhrNCLI7pEV9cbU1bXKZOtxWD1
 LXIOGmzINL+PKLjfxmeeC5nVitFrTN16nM5fAI8HwhArUdrGBbIVJ8yxQVURf3NJW4djQSpKiA
 6jQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:09 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/5] nvme: small cleanups
Date: Sun,  6 Jun 2021 17:37:00 -0700
Message-Id: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173715_244746_0D03A0A2 
X-CRM114-Status: GOOD (  10.59  )
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

This adds a couple of helpers to remove the duplicate code. The last
patch removes the exta white lines from nvme-pci.

If this makes sense, please consider this series for 5.14.

-ck

Chaitanya Kulkarni (5):
  nvme: use helper to remove duplicate code
  nvme-fc: add a helper to check ctrl sgl support
  nvme-tcp: use helper for ctrl sgl check
  nvme-pci: use helper for ctrl sgl check
  nvme-pci: remove trailing lines for helpers

 drivers/nvme/host/fc.c    |  2 +-
 drivers/nvme/host/ioctl.c | 26 ++++++++++++++++----------
 drivers/nvme/host/nvme.h  |  8 ++++++++
 drivers/nvme/host/pci.c   |  4 +---
 drivers/nvme/host/tcp.c   |  2 +-
 5 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
