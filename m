Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5634EC77B7A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=45/c1qQCKk2Cy3X+PldH528dFASP04vJ5ovp/9rK6aE=; b=LkmUW5YuP7uJdZuXvZ+gzDn/5r
	5YX2ujm3GhfDZGDP5uer4n1QMZ5UmQSfp+kFbp47A9bEdwX3O0wLBsx4gfzvcMkclLB4Ew7/2SBLm
	5rIU+nElV2xuZkzrW4paIkt6U545t/v+hIiJfp82dMBUdUakLAAr+zcyA0bM672nUb7FUuWhqBZI0
	tmYla2MNgBSjMM+PXcKO72wRi+nJZT735PXPocq3CwEPug3D3yFNrRF84JPv0mzyEeebUegrTsBbQ
	sCounp2Or5XSEV/jfRsZ7sWUmfiO45/ZtlCVcAjwwR5xLLLcaRVW7qiRW+eBYM6lHzl4LKp1VeSyY
	henmgThQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0WXJ-002ana-2C;
	Sun, 21 May 2023 00:02:57 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0WXH-002amk-0f
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 00:02:56 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af6b5cf489so313710a34.3
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684627371; x=1687219371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45/c1qQCKk2Cy3X+PldH528dFASP04vJ5ovp/9rK6aE=;
        b=p1Q4VImQfVnzvGXAbVH5kH0r7AglNu4X99POK8G8zFeLaz4pJrIp4mvh1LmxywwFBw
         za3QO1ZnFiFjQd/OylvvDv9aI9OEcLw9jg5zz1kmFxp4wOP3f3il0JwvgxeWapEtZM8l
         ZPHPuDSs8WaTSQ8BFbpEH/ZL5M8BgLA27PsnHzgFaGgaR8p42xsRne4n4ggU5p/wbrRk
         4HucNEYU7xTgmwHrkp89K+HE4kW/WsB8NLy55L4kCv4g8tuYFRDr4RsL9WOK/6P3cknq
         px8jOuYIeHyE8zGLN59erNDHqU7/5HAKklw4NfhGYDtODzmqYrP7jpyiWRnTOn8alQE+
         dgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684627371; x=1687219371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45/c1qQCKk2Cy3X+PldH528dFASP04vJ5ovp/9rK6aE=;
        b=Osdwfm0DMBiQisa6AJuMG56zVmOu+Zkf9/VJoKzpC3BFfsu7sO2vkAfqkKJ1wneRBg
         2kUj5PrZUa2+XOwqX+a3oZ+7T8xn1n952TkyzwB8fNG6OzhPQiGr48XiOVq6GhQC6n6G
         A698KdN8C1B2UZM1rLauoR/bDDcc1ENC4/gSGiCTNYJ9/Xb6+3OoeBHHvYgN2W8Jda8s
         +uVW/sJRj7eiPY/Cg1tld2G5D9gLt4/gyX77FGoIBcskuvIN180B+QRjq4aAku1tF/mT
         RKPjNpDPyAuDXLbccm6+LzQDK5A5XvN3QQ5GR6JUsHlJw9XCFYIWh0ef+kMQQr/eVVBq
         m7GQ==
X-Gm-Message-State: AC+VfDxyI1yvGMJiqKH/yz2gp7ZdelbWXOFws9PGUL7TofDJdBIAmQ3d
	y8Whzrrznd85TTBhf+cQvRk=
X-Google-Smtp-Source: ACHHUZ5ssKZNcaeorGkzC8ygHfhWyhYlYLeTVE0ybOg9ofy2Fn1HklzkpBbwOzTzTx1re9dbR8RzVA==
X-Received: by 2002:a05:6870:9510:b0:178:9bb0:4c8e with SMTP id u16-20020a056870951000b001789bb04c8emr3595370oal.48.1684627369600;
        Sat, 20 May 2023 17:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2802:8010:1228:a600:7834:92bf:f8db:3e67])
        by smtp.gmail.com with ESMTPSA id ak4-20020a056871918400b00187e500e7b3sm982578oac.49.2023.05.20.17.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 17:02:49 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue 
Date: Sat, 20 May 2023 21:02:36 -0300
Message-Id: <20230521000236.100402-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_170255_285562_2AB4317B 
X-CRM114-Status: UNSURE (   7.51  )
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

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32244582fdb0..49ae26980a0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1533,9 +1533,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->qid = qid;
 	dev->ctrl.queue_count++;
 
-- 
2.39.2


