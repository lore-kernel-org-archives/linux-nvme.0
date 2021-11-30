Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D983C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xmm+qnNre9RCCUNMLh0oisBpzWW72+UVqMfsZCWkkvk=; b=D5Ag1zc8NfusFTuP1XrdBBIWBL
	xHCq0zzg9sZb4y8LMsm+I/QG3MSBKvFPUi8seWwfXLO9cVpgv50oqYGF+Bzjjz4UfQMOEYHz3o1oR
	vKixRSm6S4SyVkQ6J8Sutkw/1t+NORZGacnyr3AwjTTNpwd4tRaer1qs83usDtrI0Q3TwAdCjUbE0
	tzEEtDLQzflDzkes2P/4tg29EP1TPVn3IK1gQUW0uLfRWbzjgLdTBpjcrGLSDlDFGsIlR4OhYy12I
	pm1FkMRHxdZTvnCuyXJd0aNSQkwMj06UDSbB6iBsrGGZNvXx2bm74F/avciH/YDRagqMIBJc7y2Sp
	7ZheCeTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms3Wr-005Q0O-Lh; Tue, 30 Nov 2021 13:50:41 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms3Wh-005PyV-3n
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 13:50:33 +0000
Received: by mail-pl1-x635.google.com with SMTP id z6so14986441plk.6
 for <linux-nvme@lists.infradead.org>; Tue, 30 Nov 2021 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xmm+qnNre9RCCUNMLh0oisBpzWW72+UVqMfsZCWkkvk=;
 b=JwEoHDCS7McWDh59e+41QLHoBblGaZQar8L/KpMc19mb9Yr0kLCTaKxfAwHR48EkPY
 2Zw3t5E/0LqsqC3nQIVoGDT6p7W+iQMkQzK2i6rGJfq+C3SyBKyW44fJ+ZlOFyTCGoS2
 nvUTf5Kw5xJgouGm1Ggm4irhZRtQCDnxhDa02eepTSX/HbtClF00yfA5e7GD9xaOQRPc
 3Ay73XeXIpNZxGFJ2JyPdgCLm/Qt3uv55KlMWIno1hyf9/xGsAQnTTSAHs8zj7UKi9Am
 nQY0miRHH2G1Kc/qY+fxnnmZ/2nSmeQbJewuiT9NS0U9OaYktxRGvv50uuhXDT6O90YX
 Ej7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xmm+qnNre9RCCUNMLh0oisBpzWW72+UVqMfsZCWkkvk=;
 b=phiqrD4Zs6r/bl6ilfK2x9ZU5t8CZqSSebuw/2JTxzmWfbdU3rw0fabJ+XzR9Uvb7g
 3tr1930UsSKfP6J3Z1p2ob/X1XNiQ6BKbB1IjkSBvMN8Lp+F0scaUSSreI4qvNF4YDA/
 eOPO1Zl3bgRwP8uU+WzfTrAsTgbiEjCOdComg05tOiDwZg92i8vujR1VxltmPcSfybZm
 MDN5XSjuYKdi5yL99EYihb5aWFuI5bENgnQsfTs2MFHdt1g4w1W+ItheaCsQbVV51Slm
 R6X9mTPIkNQAhI2EfOfLoYsU0IlfNJWNHRRmklKsNMdx9hLJR7i07SSh1f/gaxj+N246
 PYrQ==
X-Gm-Message-State: AOAM531I+ubwxaxohMj3SzAJuA+UZBoumrWRBYoUEfdVrXgYiyphednK
 qksR/qHXj6FWJsST7cMbDoY=
X-Google-Smtp-Source: ABdhPJx1rjxkJUxTUQRvDwmfb/HBlnFEuxSFucy6W/13/FspMgq3VNTYJCFfuZT6XZNaDVP+V6FQ+g==
X-Received: by 2002:a17:90b:4f4c:: with SMTP id
 pj12mr6246540pjb.218.1638280229735; 
 Tue, 30 Nov 2021 05:50:29 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.4])
 by smtp.gmail.com with ESMTPSA id v25sm20992925pfg.175.2021.11.30.05.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 05:50:29 -0800 (PST)
From: Dongliang Mu <mudongliangabcd@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] driver: nvme: fix missing error code
Date: Tue, 30 Nov 2021 21:50:14 +0800
Message-Id: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_055031_209382_7CB9034B 
X-CRM114-Status: GOOD (  11.11  )
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

Smatch reports:

drivers/nvme/host/multipath.c:865
nvme_mpath_init_identify() warn: missing error code 'error'

In one error handling path of nvme_mpath_init_identify(Line 865), error
is not initialized as an errno.

Fix this by assigning error to -EINVAL.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7f2071f2460c..2cbeb6d6b064 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 			"ANA log page size (%zd) larger than MDTS (%zd).\n",
 			ana_log_size, max_transfer_size);
 		dev_err(ctrl->device, "disabling ANA support.\n");
+		error = -EINVAL;
 		goto out_uninit;
 	}
 	if (ana_log_size > ctrl->ana_log_size) {
-- 
2.25.1


