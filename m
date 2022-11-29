Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3298C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 01:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=usZUOMkU9Ty6JJAzRqT6r6+tEKYrvZxUQ4t0B2SRfAQ=; b=DVFfe+DVvNPN6lP8c9Y5zq0a2S
	MH9iTA8DOd8YAAC/pTHnLLQjI4bIIbmiW77c/kaNV8xY7bKcFh7250ORainKHtvm8A8JepPiiTAcC
	fNc6/vTZc2Y9tpDUXFiQqlKoaB1XHMYRzmTlANBIaOYjTbO9X+4NNuOlvPg7OowH1UhROqqLawMr5
	ueycBB602Qk4FFVvvrT2ZB02XAMGiXkrENHlfO2WBCfDe+dQzqipS7IFue0391p6/AY3FpS1xNXMM
	mLomnYt1LwEwBAGDM3TKFC2YV/82zGQZjA6Uc5gOTkUwSMNwjdCnRWFBhdYYcanE0x5n1Xp0yhw7K
	FKqSIuuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozpia-0051j8-Lc; Tue, 29 Nov 2022 01:47:28 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozpiY-0051io-5n
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 01:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669686446; x=1701222446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cOMinmP7YwLoFZtj6w7noAJ/JiJuR8Y8SegQlnLGlQs=;
  b=mJaqbJptCutdg5S4IgpqzUjV0JTx5bGx42jAiWAVdX84YmWC6baKIPra
   5+CMylWp9gxX/5W4sTlUol3Lb1AQG2Vxw7QlIlhU7zhu7Kd+hdAAQUfrl
   f/aEEyHBgCyYtUXnUzmRq3QewK+5E4foQ+3aZikUAqLhZPRO9BtaWLlyf
   sy1q52CM4zuHG2Z4UZHuX3HuCF25q0p5Zea17CCPb6BLt5+1aMz6yMK03
   qLtiu8IikTcTBRKotIui11TNdR0llzFfN9l2V5rN0tKsKYKsXC4iP3Rkg
   6UXDc18G3ADUtAhNtSS6NitNzC7Vt69X6/SngC3SXNrPqsjCKrS3VPu4s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="315024943"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="315024943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="768260495"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="768260495"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2022 17:47:21 -0800
From: Lei Rao <lei.rao@intel.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Lei Rao <lei.rao@intel.com>
Subject: [PATCH] nvme: clear the prp2 field of the nvme command.
Date: Tue, 29 Nov 2022 09:47:11 +0800
Message-Id: <20221129014711.91305-1-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_174726_270084_41E8D704 
X-CRM114-Status: GOOD (  10.65  )
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

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary. Writing a
reserved coded value into a controller property field produces undefined
results, so it needs to be cleared in nvme_setup_rw().

Signed-off-by: Lei Rao <lei.rao@intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..332367b66fbe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -891,6 +891,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.reftag = 0;
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
+	cmnd->rw.dptr.prp2 = 0;
 
 	if (ns->ms) {
 		/*
-- 
2.34.1


