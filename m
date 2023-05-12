Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD61C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 06:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6T7RMEiQ1eaq7XQr7ngd2hC0SPN6QQZP6Fs4cZ14Wl4=; b=O6Epys/VK9AgXhhyquhzCgbkg0
	d7ZwygXhN197fZM9P5scphwNsELKBcWxxnnz50S8GVH2QHIGixZVbcAJZzPicirg47mG/9h19Y4XX
	wV7f5NgANYEDmkHrMPPdWHotKtmTw35u9H85ffYaP+shWqcHdYnVwbc0n3IQdMBKb4rqxHYAGVyfZ
	riYtbuvy/BvASXh7l3TMnLcEw7K8ZXo++Y8ryvHYqGnW/Rdsols1Dv8XZHHu9Ih14d3pzHdnwzpf5
	kkfUgjd2iaHDdYH3tHM5TInVS5pmtWic8bWeqNvNbVPXXF5mDn+CunduiJNph+XG9AmPSage3ytob
	7zdId01w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxLua-00B2VU-29;
	Fri, 12 May 2023 06:05:52 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxLuX-00B2Uo-2p
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 06:05:51 +0000
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ab0967093dso3898824a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 May 2023 23:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683871547; x=1686463547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6T7RMEiQ1eaq7XQr7ngd2hC0SPN6QQZP6Fs4cZ14Wl4=;
        b=B06Tx0PEWj6Jof48ZZKvl1QNBYC5xlSgGcyiM8zXqW4gz3Ia5WmhAImP7DbQynwevR
         NAvkv/hDjkor/Y21eXLqhY+uPy5m0R5kh+QB5eOELtVYfiwEfc8ipCXf7helD48Ow/oR
         6BtQNGs+ENFjeackuyu42+6FadMfEslhadySbgi0VFx/kcOpO5J6KvSmveg2+OQ//XfA
         ECtiT0Pv8QnygaMHb6CMBqtj5HJDyiLP9ROYU9ASLJl6Fu98xokrey1gyvRwRj/bLYK8
         nfcjfE9mTawLGQ7Ssu7INKWO4KEUqTx2rCWxnZmsPzrDiYdOmzdVXOFN5raIDKTy6fed
         Kszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683871547; x=1686463547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T7RMEiQ1eaq7XQr7ngd2hC0SPN6QQZP6Fs4cZ14Wl4=;
        b=JDaopdwUUVHyzTfnVRPnOOQrSgiQwvXFqVqhxdnmS/Vf3WQ5cbwdfgMB2FeK+kOHEA
         A/XO4os+8zar9NUcBtGSi65QmqxBno54QFq2DiweohD5SjC1VuFYLJwPmzGc31umgYaA
         jR5JyYBEFB60rb8fM8P1Yoh6PYmrIasJI3z+4DWEd29FQFQV84yMTe9hUKRogd3QgV4t
         GKgJkvRu7CiMCkInI83OXj8pl0+z0LXUXyNlCDTi+73YS7+ZBL2s66BDWlePAhpm2tNG
         sGgaoDtdcf9MbThGnPwJuPO69i9RHz0HX+KX2v/A2t/KyvHks9JKzwD/ir9pyuez4C/1
         oXIw==
X-Gm-Message-State: AC+VfDxNKwEbtzRp4BnzWB8yx9qIaYch8L2PdZr6MC9x1dBre1TvYBKi
	MFfuuWTOfMEVgRgo0c2Nlw4=
X-Google-Smtp-Source: ACHHUZ6t+UzZ1xOVPkRQyBP8Stz47wES5bgIt/MdWwthqQwJEe6zKSAZ56u1UhOfQJR5ACRsaLo6fA==
X-Received: by 2002:a9d:6f90:0:b0:6ab:1b09:56e6 with SMTP id h16-20020a9d6f90000000b006ab1b0956e6mr5625838otq.26.1683871545597;
        Thu, 11 May 2023 23:05:45 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.194.6.55])
        by smtp.gmail.com with ESMTPSA id d20-20020a056830139400b006ab37d0b2e8sm2098890otq.74.2023.05.11.23.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 23:05:45 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci: cleaning up nvme_pci_init_request
Date: Fri, 12 May 2023 03:05:37 -0300
Message-Id: <20230512060537.70097-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_230549_939281_B06A7156 
X-CRM114-Status: UNSURE (   9.89  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Erase the superfluous line that retrieves the nvme_dev.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..b027e5e3f4ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -420,10 +420,9 @@ static int nvme_pci_init_request(struct blk_mq_tag_set *set,
 		struct request *req, unsigned int hctx_idx,
 		unsigned int numa_node)
 {
-	struct nvme_dev *dev = to_nvme_dev(set->driver_data);
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	nvme_req(req)->ctrl = &dev->ctrl;
+	nvme_req(req)->ctrl = set->driver_data;
 	nvme_req(req)->cmd = &iod->cmd;
 	return 0;
 }
-- 
2.39.2


