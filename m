Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D035C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Jul 2022 08:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zow9hZ69xldY8OJfnEDyZCUGS2ouUPCrRr5mz0lRg3I=; b=4p/jMDN4231x+ciEoi5Bnk6axV
	XBvfXx8I3iFcusK67ppEoWIEPgb0gS2Y8XMv06xKtFLiZqUjWu/D+/XBVz1jdSlxnNs28lLBo51zI
	nv/Ebn1yapNRPIIhsk7g0sGbCLJIV+uXv0t3XhIq9OR2FykaAJyyUnZSOK4e5Zvlb5H/pQ9DUHVvO
	8U+Zkcxf0mcQceg8oI2YNUK4b3wA+RcQ/5e6a2e307lOJC21/G1V0Mxz2wuZTBoE7iFwccNQC4tX3
	SMJGSWRODjeNMFW0vgWoOzkfDGFU6bgEzBoEEwWda7lIIks9xB+F0ES5YlV6vE4qOzoeC71yJ/qTe
	+8gj/mKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFXRs-001Wbo-5w; Sun, 24 Jul 2022 08:58:52 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFXRo-001WJU-Cz
	for linux-nvme@lists.infradead.org; Sun, 24 Jul 2022 08:58:49 +0000
Received: by mail-wr1-f46.google.com with SMTP id l15so7915507wro.11
        for <linux-nvme@lists.infradead.org>; Sun, 24 Jul 2022 01:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zow9hZ69xldY8OJfnEDyZCUGS2ouUPCrRr5mz0lRg3I=;
        b=HTuGvQqfYew7Tlnt6m0T0gupkb0QimF9Pkve92e2/mQ/8Xsxrn6s9vSC3W6Dh5466r
         mf2RxRijSCuEB/FEfGUKRPa29L0vXAQqP2ZrV2Cay12QZEuWsGeoEyMkBANb1Rxq7Ara
         9QfuhuGNNmBae1YLG1StV/LMBo/bKhq8klY3T6hhik32xLdY9TX19iSHaAnkufBX8MF2
         VHxnWHP+a4kv15rMUyM2uWx1kwVtm9pPdX29gGJIB3yCvF8NMbKPJuRT8gwnpbb1ev5N
         aJ6uK9L2wdqUb3ko10ccoHYyGhXrx693Vhd4maG2K/mBJpoWL1389LvZIND6o6wpqaqj
         lhVg==
X-Gm-Message-State: AJIora+786tpMnNNpXWamGzz9D7UU8t51GvrJ7bgDlJfwwUSEy4RpkQQ
	SR6nK75Mb47nbIAjw9sUlESN+XvBS/c=
X-Google-Smtp-Source: AGRyM1vYeI/95p/PnwbyTdKu0FH3WHTBgiW4m+Tj+mhgWbFODmOEnAAKWVOFfYOGgF0A9irRnJo+xg==
X-Received: by 2002:adf:e492:0:b0:21e:45af:5070 with SMTP id i18-20020adfe492000000b0021e45af5070mr4667661wrm.483.1658653125580;
        Sun, 24 Jul 2022 01:58:45 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d4486000000b0021e47fb24a2sm9030012wrq.19.2022.07.24.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 01:58:45 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown
Date: Sun, 24 Jul 2022 11:58:43 +0300
Message-Id: <20220724085843.494463-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_015848_462474_A112B8DD 
X-CRM114-Status: GOOD (  11.91  )
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

We probably need nvmet_tcp_wq to have MEM_RECLAIM as we are
sending/receiving for the socket from works on this workqueue.
Also this eliminates lockdep complaints:
--
[ 6174.010200] workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_tcp_release_queue_work [nvmet_tcp] is flushing
!WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp]
[ 6174.010216] WARNING: CPU: 20 PID: 14456 at kernel/workqueue.c:2628
check_flush_dependency+0x110/0x14c

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 0a9542599ad1..dc3b4dc8fe08 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1839,7 +1839,8 @@ static int __init nvmet_tcp_init(void)
 {
 	int ret;
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", WQ_HIGHPRI, 0);
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
+				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.34.1


