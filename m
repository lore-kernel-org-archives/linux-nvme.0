Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC92C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CE5y4oApy1lFmSUkhIRCaYPpvHeX7NKTq6a44CH/i+Q=; b=YD1Yps9fpmtT127SmR/vR5VYCJ
	wI/Tibdwe85MAlEDxMmLd8AP2rx02mgvT1C+638cuzYG7dXXxoH5gm7ltl8K2Yz+KnFhmxjhvkC8W
	Vuph/s+p4fwGLpqiqHs+tiuXmMMt1llPEpThC7rjhXBWLZ4nFjfdM4timYPlSQataoG/Xer/YCC21
	pPrFQEmp0AHFQkAr5HURKj8oYOK7ewzQzEKiDyyONlCMzwpdpA38UgvW0wRr2MrguYPpP5U5ZwzUL
	QYbT8q6ig/w2OQhtG3xN4E6zxO7rxc5bgFQDs5xG02w83tAdlwuUnwzpQ+CebfpqvkbMPslSvf9e9
	dIftxH+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4rp-005py2-Qi; Tue, 30 Nov 2021 15:16:25 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Uj-005hwC-La
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:52:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5B749B81A53;
 Tue, 30 Nov 2021 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F9C8D183;
 Tue, 30 Nov 2021 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283951;
 bh=g2xtFHDDDqGZ65N/h46+t86BVmQAKlSj0QJgegHbjLU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y3B32DTzjf0RkZRk7UmeDm8ZTcM6eU3aSPkEHr5dKeZ+mw4ajr+FTrCSF2/Xdp0ZC
 F9vk/akNIktptVDo26iqAED2khqXCkULMrwppJfxJTxvTBN2xkuHP5LB38jlkNqDtt
 t13z1hDK4ZQtdzqXpNIrtumI9X7vtfyejANhtwBCqOfDjCz3mdkah2x7p9ww0NQCFz
 QrXhvcLBaM/lV0Bq/YUU3iTbrRaFl/kIIX7GZVJsEVTMa/23dCGosJf4p8vmO7hqHK
 9qKzQYWtzw3ci+DKnOtivH+/NA3CeJ3yN5diSBo1zc3ZXKyn4wj2wPJKsRnirBMWN2
 vooaz6GQ5gHOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 18/25] nvmet-tcp: fix memory leak when performing
 a controller reset
Date: Tue, 30 Nov 2021 09:51:48 -0500
Message-Id: <20211130145156.946083-18-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145156.946083-1-sashal@kernel.org>
References: <20211130145156.946083-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065233_904373_0B6318C2 
X-CRM114-Status: GOOD (  15.35  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit af21250bb503a02e705b461886321e394b300524 ]

If a reset controller is executed while the initiator
is performing some I/O the driver may leak the memory allocated
for the commands' iovec.

Make sure that nvmet_tcp_uninit_data_in_cmds() releases
all the memory.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d1cb8e78eb415..427de5ad6ded1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1342,7 +1342,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-- 
2.33.0


