Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F1606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gkKV/h6y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OJByFAz6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=QaAMuJbecrAztR6OaS8JIvlR/iE1jXKP7uKOYNLmkZs=; b=gkKV/h6yS0CibHZVZxV4ZMtzWl
	YrMH40ZE7ij+E2lncAJ6VT4NGMP4AEK8s7dH7TbyWMorwsXWA/CR4JOPJqou4pA27zYmytI3j0L3O
	K8TWzq/Hy2ABzZH4GCXg7L4LaUwC+wDlpI9C7WTQc5l/GP+DDeW4KG0moqnz/1EG1lGbd+HyTSkdD
	2vvgasj1p3i83aTT09EQJjdvtcUlnlduY6BGxbBKuEPY9MpcHuEmTk07tpBji1IgtenHwfxaCVAz9
	w5KhKAO7lS4evjZakw0eXhT/4uVjBuXP6EkGcBcr1cMyC6pKpoob/gbKRUrqbCJbOdoGPplSI75bF
	5NOGSuZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfo3-00000004Xc3-1vLj;
	Tue, 27 Oct 2026 11:57:31 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLfo0-00000004Xaz-0ivB
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 11:57:29 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so960093a91.3
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793102247; x=1793707047; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaAMuJbecrAztR6OaS8JIvlR/iE1jXKP7uKOYNLmkZs=;
        b=OJByFAz6uxZhBO7/okkxrpr+Opl8b0GBtLR8NSR9drAwrAXbGXutgY1QMJTDkO5Wgl
         GnihgN4pKyol6Reali4mQiFEPhXFbE+fRKGapXjQ+G0TFy7x+N9luYU/CTATdM6XWXVX
         frofNZMcjId5DneqzjGHiaS9vCyjUZey9MifJyhgDqxm7FFm9Ex/g+h067ywizq2o4Vu
         k15JkOFOEsUpWNmMU6fSPDX9j30rItulhmluP2jk8jo7CHV2wMpYWcO2LbpF8PJij883
         O27nh/Nl77bPi8Rs+aTMi45cpBUe4bASU5/60zhNFdlD0TyVZJG0yX8siPdIhALEfvLm
         W+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102247; x=1793707047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaAMuJbecrAztR6OaS8JIvlR/iE1jXKP7uKOYNLmkZs=;
        b=h1w7AheVlAkxXWy2sEdCqcRi95wRgcdTXNWMnayeBxnmXUU9LFldMtmHojCX/xxXgr
         QBpiSclHs2yb97ynpkqp0Khy6v9YYwZBPL6TeU9x6+bYqaxgrwKkydssmm2/07tS7NAN
         1icIWkfdL5cAh6czcXTZofQuQPjde+n6Xsk84AnLcUigs1UdXr1rWirn0Ri2pNGgFG8s
         AZJ+FoGsNZZROV+0eqqi63f1dB0nIsm7fDT/Dku1M6Xw7ROf2xxg6bWehKJvkHzyYuTh
         PAtMC7rYHukXe0smGUKKrIZSyseFZaRadJ8Rmy9swt9r9yrfktot5lOFWbQExSm19pGl
         5ChA==
X-Gm-Message-State: AFq9FYIsa7dHlJ8HmjQEHdSyDUA+vmfZcLN9aa98TCQ7GN4HrjV+S+As
	ODYRRLe4sVJz3+bdIhhGmYyMZ4vMtc5e7Xj/NzMSlZICJzy5+1eY0/eg
X-Gm-Gg: AYBFou2QIJ/7zUi7gHOA8z1cXeCRPyiECQz4PF152Gm8qj55AjOE2d90WOwH3Ym3x/I
	ywO4+vKkjBRgFIJTssKcjXhWPfZSIbx9ZHo88+IOqRaOfmsp5di0u1neq/vOeU6zNbUe7zHLDTg
	5CBiGiWV8LGq7cCrX2Q8TdTmwImBSF29EEg2cFb2BTGyW8MiB5cpLivbUyA3TG2MrAtGBfm2LJW
	fngi8DSDdGyq+wxQHWpvPhpnJKTFXzyMuJVMygwUWrBTanLbAyapsltz1ptKqGWTLzf62Mi64T/
	W6lXMHjdXu5iLCFTruggDdGu94/oCMAuM4EsVwCI0w2WUEpMIFSt7mOd0ec6yz/5zT2UtC8nLu8
	DzmZlEUdQHsB+RUA7IoVtyzlny1ygX3PHFvibV3oGrYIxdz7SVhNgxluXkp1NbLiIGGxTo4tkvK
	xYLDx/SHI4OpYMe2M5Wzi/hpSYTFxWy8K/urz3EV6+Z5cSJV/hJJZIuLVa9yEmrgnTzwwtA+k06
	7GHbRV9mB9KJo6kcK/Hq7nR8mMJS6FUUQjwG2hWYRhKnC33RvC2OISO6Oo6VPIYN7sJldQLm/s=
X-Received: by 2002:a17:90b:3dce:b0:3aa:6b5d:a02e with SMTP id 98e67ed59e1d1-3adeafd64c2mr8426537a91.54.1793102246644;
        Tue, 27 Oct 2026 04:57:26 -0700 (PDT)
Received: from n151-105-216.byted.org ([106.38.226.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427bf1sm3704970a91.6.2026.10.27.04.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:57:26 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	leon@kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH] nvme-pci: unmap the full IOVA range on PRP setup failure
Date: Tue, 27 Oct 2026 19:57:18 +0800
Message-Id: <20261027115718.2241149-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_045728_214765_07D0B801 
X-CRM114-Status: GOOD (  11.35  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Guzebing <guzebing@bytedance.com>

When using IOVA, blk_rq_dma_map_iter_start() maps the entire request
before PRP construction begins. However, iod->total_len is accumulated
as PRPs are populated. If a PRP list allocation fails, nvme_unmap_data()
passes this partial length to blk_rq_dma_unmap(), leaving part of the
request's DMA mapping intact.

Use dma_iova_size() as the unmap length for IOVA mappings so that
cleanup covers the full range mapped by blk_rq_dma_map_iter_start(),
even when PRP construction fails.

Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Signed-off-by: Guzebing <guzebing@bytedance.com>
---
 drivers/nvme/host/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9f..4f07425afb8d5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -958,8 +958,9 @@ static void nvme_unmap_data(struct request *req)
 		attrs |= DMA_ATTR_MMIO;
 	}
 
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
-			      map)) {
+	/* IOVA mappings cover the full request even if PRP setup fails. */
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state,
+			      dma_iova_size(&iod->dma_state), map)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
 			               iod->descriptors[0], attrs);
-- 
2.20.1


