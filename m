Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6E9C3ABC3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 May 2025 00:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aWH2xlqMgTDDgBH+DcFeQqtTTTd9MDqKNid4Rm6OJAU=; b=uWKJu8FmrwQQhT/BjgLthvXh/i
	4fvsTcq9ddVhyKWKRT8bhbu5fNTVBjKrwuvyF3LvvU68UCFDjCFbbyCPCe2Ts3iRNWA/kzqBuTmUn
	yXpw44uO0obGYg21ToyxhRCNtAr4LFIa1sEYL137fgChPvpe8CEX35r02zrlpHasjhXTprhZeaVT7
	BtDL0wNW1xPYGmgmwdmUyjiTxPaYhtx8fnFWyVvqCje5uW3Rn9hkZHn/d/ByFsoAnLe/O47X0/B9d
	7AWiQ9c9CQrHfALgPTANptqJUiNT5/6jZZQWzSDivdj8Vy/NmvUDi4FE/7cNAYkwXimcXbP1cqh3a
	+UWrfZKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDXe0-00000005AOD-2UxT;
	Sat, 10 May 2025 00:00:44 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDXdx-00000005ANr-31Nu
	for linux-nvme@lists.infradead.org;
	Sat, 10 May 2025 00:00:43 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-22fbbf9c01bso19909065ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 09 May 2025 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746835241; x=1747440041; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWH2xlqMgTDDgBH+DcFeQqtTTTd9MDqKNid4Rm6OJAU=;
        b=aK6OXvQn9gnNPYOwBs7sDmLXQVWTrp1FNAwo/gTqUN16V9eXoKuZYSNVk14hvqvfcV
         +O96E/WFmxY/IIcq4MakkRq7KaR6UQnM49fauJRRQ/5wNubMDrgAiXxs4G75VPMMaqzo
         X8IQtoP3PpLMdXBG8ZHFMPtxMGG0T2/xbpUViEnewJRLo8QtxujGfAhDirBLVJf2EAra
         06ewksY+tKj6bhorl5qgR3SjuFSNySjMYXUVMcVm9YZDdyoZ15v1BigTsNumfbirnWtY
         gPvPkoTyw94mXbCUWIU1oMImB95i/+XhnA0BAA15lEMuT/vQwR0mEzs9nCnkMxUui2SE
         uGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746835241; x=1747440041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWH2xlqMgTDDgBH+DcFeQqtTTTd9MDqKNid4Rm6OJAU=;
        b=Wq0Ec/NztDTIMilKJxN/F2MaKSPISRegEexVpoHYzNaJFVHaNUGBHggNN/srI60nLU
         Bt46ivPgjJlQqUnaMAi2g4836asjdaiGPsjhB6ux2G+nd3h1EyoXfL9seeXBW/TspTtJ
         2kKaExvlM39YjCywJXluO4R/2d3XiiyqIcihIILUZ3uWoH2M/ouu3jApwQ3ONQNzijc9
         u8xzCTMAKM6KVqIoK/xfw8V3nkukUUdha98uFFLrGvU6+81xS+1RrHwOZa10h9V10OD5
         fqya/aFe6HMKadmmrb4xXSl50r5DeMzx7N89bgFBnrgJBXzpEEMpf91gI0tDv0L8vpky
         3zAw==
X-Gm-Message-State: AOJu0YyJco/0HD9v90LYS5AQIfu8I2v50aylb/iVdPZJeLMYcpd460EY
	mhsZG50/fNWtJXMp4onphYZLrQ0/0KggAEkPP5spAMrFtjblGkd37Z6biw==
X-Gm-Gg: ASbGncv7m4hgcppG+teWEi+rvogYKfyD5HBw+sgkzZmlsE3NZxXwrlK+9X7nCBkZV3F
	LcUoI4QuALylUOdwVe3hZ/IZ8wHzlnEP5QNApIFCmClRMs5oI9yTjx2T8bp1yu56a66H/78jckz
	EcVOzPIudwZ6BEJtM5fkGmB0as7aNOaS/3MltEts4etgRpUOa8cVXHLoVBW6Ak9r/iMFcyfSCNQ
	nQWp0tE+tIjeV2Kuo4Xu0ZeMl5oNAE9FoZwFNxG+CNI446OjvQvjOXRIiKZkGkQwfRBeFXVVOh4
	MeVC0Lw0Q9ZXc4FJYB7J5F0Tcgh7uEZu8utsVcgQ8+nmjcUkXT+2085AudsFZo9hErs8
X-Google-Smtp-Source: AGHT+IHPxQC1zqtb/Z2N6/E3h1fHhuyKeEqYoTjBs8erK6bNAd2Jghc5SuLaBdGIDtjrym8vhNZyCg==
X-Received: by 2002:a17:902:ecd1:b0:223:58ff:c722 with SMTP id d9443c01a7336-22fc8c7c1famr91402605ad.28.1746835240389;
        Fri, 09 May 2025 17:00:40 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2349ec816esm2033209a12.22.2025.05.09.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 17:00:39 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized variable
Date: Sat, 10 May 2025 09:59:05 +1000
Message-ID: <20250509235904.915626-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_170041_757220_2056110E 
X-CRM114-Status: GOOD (  11.82  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This fixes a bug where an uninitialized return value is used in
nvmet_sq_init().

Fixes: 206372d7c565 ("nvmet: support completion queue sharing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505091619.QFU1fxsd-lkp@intel.com/
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 042039011d7c..e30545586302 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1012,7 +1012,7 @@ int nvmet_sq_init(struct nvmet_sq *sq, struct nvmet_cq *cq)
 	int ret;
 
 	if (!nvmet_cq_get(cq))
-		return ret;
+		return -EINVAL;
 
 	ret = percpu_ref_init(&sq->ref, nvmet_sq_free, 0, GFP_KERNEL);
 	if (ret) {
-- 
2.49.0


