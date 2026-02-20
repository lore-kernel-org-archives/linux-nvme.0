Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FABC531F8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnvrwXKPD1mz6+9mov3GXHuRhTeAw5K2AjQa0fuRQNA=; b=OCbCQb1zMjKvtklhR1HCEF6hnE
	HpH4aPkJAvid9mktf1VLafMqIkLANT3jXVV4m2oELIQHL81Ampu72sbx2cegkBV9AGMyEGrBhCtN2
	Wa8uiR7LYO6Ufq/29trLoPbvzI/sl2dfVSqtzuRQzb4X8ZQRDw1yhIsLh5y/hUMJXtfqoEgwwfJVo
	21TB5OgxcUX2Vo/nW2e3t5xHFeUU5TqJ0ws1JMVaZzD6JIxOj/P22Ms3OkocbUYgXgApMtWeZsC9p
	JO0bbo9PHAUufTGObENJiI0lsuJ25uqcAsx5dz8zE8VtG+hjRrCWsmeCpF7vT3UcG3Ge01/1o+EDc
	LqVv7pZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBl-0000000DA9A-1s0j;
	Fri, 20 Feb 2026 03:28:21 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBh-0000000DA6o-3kB6
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:19 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-2a9633ef0d6so2012265ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558097; x=1772162897; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnvrwXKPD1mz6+9mov3GXHuRhTeAw5K2AjQa0fuRQNA=;
        b=WMTSSCQfcCmKOqF4YEIqpPFov10F8c9VJGqkV4xS/xAyIinZXHbYKeM7rHCbQInpFE
         VjlS9q9idBotUod0JhJu0hR2j2EDrko0HS9AWSa29oA2avxhkNpx82XlG3nzTkPHhWg8
         jeWCijNH2R9+IeK7AZk6/9LOJWGw8w8h2MNa+pb/J50IhH45UStbJPT9uUt3x7wthfhf
         P6PKZFM4bNxrj0Sk/97neqn+HmwQFzdNUxJp6PAUUvq7gQhK4UNRG75uCROFPfahVM9S
         Zp2Aeq2yMjiI2jRTY2/lNT9qTyAIsotUp+/LT9/XphnEsPe+Wivu7+m9y3SCqcB0oLIJ
         EyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558097; x=1772162897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnvrwXKPD1mz6+9mov3GXHuRhTeAw5K2AjQa0fuRQNA=;
        b=WTbMZWWZ9Rla71DfkOkeTABr4vUuNHMYw6zvCDYotcet8x+ggJeJKxbGyyfYeLuLrL
         Bbu1JK86JtavIBxRTntBP0iOxcnTc5MjffpKRRVykk/cg6adtR8scoox63dyIjlVgFo1
         pZl4PGC4PE+diy2DhiexMuSJxjtN5jFJ7S4ZI7PtFZ0DpeThCuSv5oH5bqnfoe8Qfeb9
         zUQCW7El0kyeLNbTVfRog15rofvSNhkC0JlBqfMyEJvinkrBqCS9h2nGIOXvvWS64UWk
         u+vyJpryvZ1hYRSlbPRI0/bdJTLFFg2ogsCZ8dfE+QLsdLMR3RLVmqOp3OzbgSn3flaj
         sZ3g==
X-Gm-Message-State: AOJu0YwO3v/012MgmBNMvfgM/V0c7YqXApbMULVyE7+tGeg1hbKPqikE
	ZNjFABzBV2VlLx2PbSP2Ji7GOIGEHjJQSAB3mnqyl45B2LtvjVP6JOZy940oMdI4+1k/JhpP7x7
	3TFTG1O8yiAs/QlPqLh8sgZBCZI8U0q1eBDetWDCBhOwEwbAh97UZ
X-Gm-Gg: AZuq6aLUtyBonbbNw3tB+5sfYt3W8bHgXY4aT+MyXpy6wCrx5VGhCCN5MblAEBilb67
	aC/0Pw0R9wC5nYP0R2ZRlk4e5Faf0YtUUW7qLNOw9uVAH5mybp97n0HcbRvNDv2B7tpf82DNrPv
	Y4P6SmdOTbHahA+lsEVb5IiQr1aKxfLmlBGUO3e0BUmGvgxWbRE8WgLZzMCSUhUv+StlSDVSMXE
	T17eBRD6lEL/lLm9nM2v82tfWwY305b08zXJlYWBL81YEXir18Vl/+GOUwhl2A1SosBiFu9EQbW
	pHguZahU+8qO7wFSdRwDj0srcATSu42uFL5px2R4C7nUl+KmzhoFMJDQT3Mp4tm6sstXBLRZpIu
	07rR8m0pOxSdOFOCM2av4LLYWm6hOIBmO1xSTXDY=
X-Received: by 2002:a17:903:1983:b0:2aa:d5fe:f193 with SMTP id d9443c01a7336-2ab4d001292mr157822975ad.4.1771558096920;
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad1a79387csm23110195ad.27.2026.02.19.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2CA6F341568;
	Thu, 19 Feb 2026 20:28:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2AAFAE420F8; Thu, 19 Feb 2026 20:28:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/6] nvme: always issue I/O Command Set specific Identify Namespace
Date: Thu, 19 Feb 2026 20:28:06 -0700
Message-ID: <20260220032809.758089-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192818_074406_7095D4EF 
X-CRM114-Status: GOOD (  16.06  )
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

Currently, the I/O Command Set specific Identify Namespace structure is
only fetched for controllers that support extended LBA formats. This is
because struct nvme_id_ns_nvm is only used by nvme_configure_pi_elbas(),
which is only called when the ELBAS bit is set in the CTRATT field of
the Identify Controller structure.

However, the I/O Command Set specific Identify Namespace structure will
soon be used in nvme_config_discard(), so always try to obtain it in
nvme_update_ns_info_block() if the controller supports NVMe version 2.0
or later.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 674dd823b209..70ff14a56a01 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2351,11 +2351,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		ret = -ENXIO;
 		goto out;
 	}
 	lbaf = nvme_lbaf_index(id->flbas);
 
-	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
+	if (ns->ctrl->vs >= NVME_VS(2, 0, 0)) {
 		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
 		if (ret < 0)
 			goto out;
 	}
 
-- 
2.45.2


