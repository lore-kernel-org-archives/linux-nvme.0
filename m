Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BF7CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veBikA/EZITVPTJ7Mq4q8k3eH4Ib30FGG9MogOgvp/8=; b=duhh06YA1MBh/c3QtvB1Cupjgr
	vGwwfCoSp2MdC6iAhw5mCxT72xHSWj/c2adL56N1jtRnPWSv+/u255URZ+osj+qtGHng/xGSBWlH5
	rzaONbigzPcp6H3jlFkV/qNY/Gs6KdC0nY9hLx7tgxsUoPUqykhbmUmvmDbddSkIUU/Vy0a0/9phf
	TNkqXRX70GI0DALHkpshQ3PRJJFM2ToQBAQ32GcsejdjQAuIV5ASgefbNIPjoGZBpL6640zNQ2C8F
	EGPEh9kp0WCdEMJDbAlELwibM3OsMhbTP+3P9b/bzEHoN8J6ftagNEyLvdil5CeDBjrQ5n6WcSoEJ
	WsHVBacw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDfa-00000000HdU-45yr;
	Tue, 19 May 2026 06:11:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPDfZ-00000000Hd5-2luz
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:11:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 25480601FD;
	Tue, 19 May 2026 06:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E575C2BCC9;
	Tue, 19 May 2026 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779171068;
	bh=iWfSG98PLVn91VQRFqb5TSCVlU18OksL20HoSjLgfek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iz2ZLGkFAN1QYU1IcHrfXpBK/ve4Bngy1Hl8slVmi3Cz5ku5xHl4meVpFa9G43Krl
	 PCSPuova+Qq3QEI2ilvYpCDPohwNFklp/FiFppzAaLtdiTBrhkpbcbr/RYDa/GAdGP
	 RODBeDSjIuMoKt8dAdmpToY9Zv5d9kgXtDW1L9dbNLayxxDGw622gq6dC+8FC6TuoD
	 NVArCPkOLPnBrr/Ub2TLnDMQrUXLuN7D2MV+9Pa5VQaPHDhOqcGzbdtamU+QXBRnUt
	 Q9CaXiutW4jHLwBNkJwpfIdTnr1CnI0r8eT5NpNOCPKm8DHXjgBfG8yt5/MAnpQy2r
	 tu+hjaHZzEAHg==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
Date: Tue, 19 May 2026 14:10:20 +0800
Message-ID: <6bbdda41e981777241d74d069b0cec7bb655bf58.1779170418.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779170418.git.tanggeliang@kylinos.cn>
References: <cover.1779170418.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The return value of nvmet_tcp_set_queue_sock() is currently ignored in
nvmet_tcp_tls_handshake_done(). If it fails (e.g., due to the socket
not being in TCP_ESTABLISHED state), the socket callbacks will not be
properly set, leading to queue and socket leakage.

Fix this by capturing the return value and calling
nvmet_tcp_schedule_release_queue() on failure to ensure proper cleanup.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..8a243d22a511 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1842,10 +1842,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	if (!status)
 		status = nvmet_tcp_tls_key_lookup(queue, peerid);
 
+	if (!status)
+		status = nvmet_tcp_set_queue_sock(queue);
+
 	if (status)
 		nvmet_tcp_schedule_release_queue(queue);
-	else
-		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-- 
2.53.0


