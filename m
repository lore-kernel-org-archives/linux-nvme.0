Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29062C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYv8VFtbzI1+liBtQ1o0REykf7AhxrHKuAwugxz8G5c=; b=39W5kJr5kITopsR6iPXKixWK5v
	aovIcZI/4xHZi3Abrf5+vA7L0txE6TgZie1G1hPnDLla2Klf+LpPn9UvQc2Tpo/vwp1t6yLvx5m7Z
	BXYpACSsNtig+XnJnU76sLay6DJg47fuuVUvI5e2S3AuDSt29j8WrTTpeYDHu+jUdW3hrDgHp4K+d
	EUwYq9gTjXbIBwz+sacNoUB2b1JIbNWJdZhwad86Ffrv9EpE5L9hmd6nVXH/NCjABtgh/Wo/qzrlZ
	wEzdrW6ob7bHVASs8aHmA28qdUWtqpQpkRAd2yj1EUBpcopAgcPlduUN76KOozUMKPZkxf0AtA117
	fLqmIYkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdyw-004siP-9K; Mon, 13 Mar 2023 08:56:38 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdyn-004sei-Rh
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 08:56:32 +0000
Received: by mail-wr1-f53.google.com with SMTP id t15so10496560wrz.7
        for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 01:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYv8VFtbzI1+liBtQ1o0REykf7AhxrHKuAwugxz8G5c=;
        b=TLxVXEhNaMmHOL6zus/fYQGX08MB+J+gNbLPBmk/HzkjDW3qaEZ5OgtFzcn4WiJ9eC
         tbtxwkuiUwL53TdZUqViqJ4cgotQwja8uMZs2OlJAlg1SDb3z6fO9ESjV6ytU0c6SdtK
         gQLWGbwB9jWCCmJ7xNpZpkIjXb7IQouAk1PaW1qeag3stzdaF7atm2/vFYL4JWkrxJmv
         XncUqBf1KmHXo0RzBkcbThvY4GtrKhf6iSGX8JaExrvFcEES4ha6OPzdCTMiTz7vAOGn
         +dRSav2f4t9lE1JOO/pngdpsaZj3S9VRgmULHP2kueSRIZLnb8iZMPMzcbmvQz3Rwqqc
         pzZQ==
X-Gm-Message-State: AO0yUKVOoOsXOR56eGR6mtVpKTneJ1d2S7ie6qsd1L2CXLQq0nTUnkum
	XEYdPzArkaVfkOs7DiLUwEnfPUf+naM=
X-Google-Smtp-Source: AK7set9RLk/aylmFTqmhXTe419TxS9raMBLxbQyofOdjAY9ePHAGlwECz4FZYPTcIPheIakfk7K3wg==
X-Received: by 2002:a5d:4585:0:b0:2ca:ab68:eff9 with SMTP id p5-20020a5d4585000000b002caab68eff9mr8926477wrq.7.1678697786726;
        Mon, 13 Mar 2023 01:56:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i15-20020adfe48f000000b002c3f9404c45sm7312580wrm.7.2023.03.13.01.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 01:56:26 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2] nvme-tcp: add nvme-tcp pdu size build protection
Date: Mon, 13 Mar 2023 10:56:23 +0200
Message-Id: <20230313085623.9321-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313085623.9321-1-sagi@grimberg.me>
References: <20230313085623.9321-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_015629_910524_7D9AE0E5 
X-CRM114-Status: GOOD (  11.20  )
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

Make sure that we don't somehow mess up the wire structures in the spec.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c73811907afa..0ec7d3329595 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2691,6 +2691,15 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_rsp_pdu) != 24);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_r2t_pdu) != 24);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_icreq_pdu) != 128);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
+	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
+
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
 			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!nvme_tcp_wq)
-- 
2.34.1


