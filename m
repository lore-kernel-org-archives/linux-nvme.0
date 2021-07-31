Return-Path: <SRS0=g/A8=MX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE3C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jul 2021 07:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A32D60EBC
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Jul 2021 07:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A32D60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=kYEXbLhU5vmTDnzbYib1ltLbEZcWEU1pXTPsIHfEEeM=; b=xJKWNx0bywv8/g
	UoVx/cRnvHNi0dvv+JmePQOGqHTE+zXMo+U//+wmnJCAZez5Z1uPYJ7g1UNuebwWkUY72OV24tCVo
	5HDhJOpkYl8vNNkWoBlLLnXiSZvUlhrsn8vNaho1qClj8YZy9X2XHiN8q0cK64RcOtn6ubS3d0fTn
	dRFpjZ2Bp9XKFWJNRPQ5lwSynAQMoKkhvphYLeficYOQIpaKW8CM9F0YtHnjoFZrGRfROGyVHAbey
	aJstJPrxDGcuOrpzqVbfwaoLE4y07WfU5UTG6zzMmead68/VjT8nZ0VINwXLhhpw1D3892ADkfQDq
	qSrvUyPUBVw6JZECFW8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m9jSy-00BAqV-6H; Sat, 31 Jul 2021 07:31:28 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9jSf-00BApT-S2
 for linux-nvme@lists.infradead.org; Sat, 31 Jul 2021 07:31:11 +0000
Received: by mail-pl1-x630.google.com with SMTP id t3so11658798plg.9
 for <linux-nvme@lists.infradead.org>; Sat, 31 Jul 2021 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ixvu1XEGmErQ2qL4BETMLAH7Hfa5i4XGX4pSY/08eRM=;
 b=UVOfiyFjSOPhnd9YgU/y8Vy0AyLJkmUoykGQbUzZ/svRuCPBrMJUwoLwDEEd9fuDT/
 aKlkORWilmFJHRWejoKVMotXNvoRVlXTMTwecaAR/9leo9iqbOzCIZIAoeEZ3p2N7n4e
 ypriOK9bR3/koVtfejTDMaqGQeLXMd2RnG7Hz+X6ErgDRpSzh1ljLojsMNwj+eMLzNug
 4cTrV2g/jUWu2pgFoQnfD+t7VDvULn/2h4CFSxTSHmdUXuF36V6rmlHlg1j/pXgBwnhx
 l/9k2PtPFixDDXy7+eT/2Fhy2aarEa8MScmHcezb0Yc63fr3RuO3Toy68OH/0C4940NG
 1tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ixvu1XEGmErQ2qL4BETMLAH7Hfa5i4XGX4pSY/08eRM=;
 b=YQAS3Z7FE+DEjY0PeGCeXU5/PvfsrNFXck2txAit7JT65mJ6S25i4n0cFpij73HrWz
 5v7LCF2agcAGN7koubevVuePH1JrLU84ViIR07e0oTYcbrwVyD8aLXg/gKrg6mudXRkv
 qimoUmIGXOuTPG+0dAggpjMXv/FT3sxhFbmwChqynnbG4/lix2wT4limu0WajOVFG01g
 qJlj6peOWhi1jFOIvxoEzrjdNZeZdlb2Ri1j6oC+7Pe5LsqwrcJMB6VFpgwv1E5Yfnxn
 t4aoRSovWLvcki5xx3K5bQ0P4gOZHveyDhs0pZ2JyrsaMzOCCwZZYd8TMh/1RHCntrz5
 7jSw==
X-Gm-Message-State: AOAM532ITcpsfqcgRDBBV1rVXBrfqjElAAlxf/4YOZWFXJaqGxc0bRme
 1qrO70J8dfu7+c0cfxoT0eQ=
X-Google-Smtp-Source: ABdhPJyfOctsm0ZR+7H0I0bz01K3VNl0dsYentIfKEybvfc+6f+QvMe9y33bXwk5ETdtZcLqtLobFQ==
X-Received: by 2002:a63:1d41:: with SMTP id d1mr5703450pgm.199.1627716668396; 
 Sat, 31 Jul 2021 00:31:08 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.29])
 by smtp.gmail.com with ESMTPSA id z124sm5411949pgb.6.2021.07.31.00.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jul 2021 00:31:07 -0700 (PDT)
From: Tuo Li <islituo@gmail.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, Tuo Li <islituo@gmail.com>,
 TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] lightnvm: fix possible uninitialized-variable access in
 nvme_nvm_submit_user_cmd()
Date: Sat, 31 Jul 2021 00:30:42 -0700
Message-Id: <20210731073042.49139-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210731_003109_990567_19E7D711 
X-CRM114-Status: GOOD (  13.65  )
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

The variable metadata_dma is not initialized at the beginning of the
function nvme_nvm_submit_user_cmd(). If the parameter ubuf is NULL, it
remains uninitialized at the label err_meta. However, it is accessed
through the function dma_pool_free() if meta_buf is not NULL and
meta_len is not zero. In fact, ubuf, meta_buf and meta_len can come from
user space which indicates this can happen.

To fix this possible bug, only when ubuf and meta_buf are not NULL, and
bufflen and meta_len are not zero, the function dma_pool_free() is
called.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index e9d9ad47f70f..3d9fd098bd83 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -835,7 +835,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 			ret = -EFAULT;
 	}
 err_meta:
-	if (meta_buf && meta_len)
+	if (ubuf && bufflen && meta_buf && meta_len)
 		dma_pool_free(dev->dma_pool, metadata, metadata_dma);
 err_map:
 	if (bio)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
