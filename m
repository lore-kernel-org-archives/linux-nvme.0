Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7441BCD5BC8
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cDC/j3718ScOtsrvhTkhu2V6hhHTXRtjiOYjmFLOqJM=; b=hHlPFTStCTJ59aSnTJdGjp2bjB
	7xQV/Fi7ej3mECdHW85Xw0K0c3nclph317Onrl4fciGXQkdc/fSU3FN0OPsgS5VAUfFocEfmbAc4R
	umT1l4Znni6KSeqNBhs4l4pxG1ury4vDwkKMGRlx90NkkoWrn6Bwo1SnxyM8fceSFT1+1P4RzICZJ
	R8dBjLU5on6wADG9Q8MFJbLyKS3OYPSKUeGnfqCF0F3RP5KuszTpWutWCPEJYUVfloNFQwrF6tkj0
	v3S2j61ZCEAfVB8oPk6+u9v3kYSdU2lTJZjKHrSOyiYoXVAF/inTXRRyIL8Avn45DL3H0ObE5DEFN
	EG0aYr6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRo5L-00000001Vvq-0nFy;
	Tue, 26 May 2026 09:28:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRo5J-00000001Vv0-0mfE
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 09:28:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3625860018;
	Tue, 26 May 2026 09:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4E61F00A3D;
	Tue, 26 May 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787703;
	bh=cDC/j3718ScOtsrvhTkhu2V6hhHTXRtjiOYjmFLOqJM=;
	h=From:To:Cc:Subject:Date;
	b=J/f3iSz4htEXQKJIWtpuBCfXQhFb229mNKE2PMo23rxaQwNG9ktxzeYzkoBSCkI7B
	 SyqNTt4ySc2s4oSWojUIcMicAZTBNM09ayIVDHsuvuSsG9L7ZLGw/13laJvHoUiloJ
	 p8f0IhfXokdNRazhc3Kt72detk0JaGPlTvn8VB5aXNJcNSq0qHyz0T4yFpDoAKvc5u
	 tAJZXHk4TcS+4T/R/n144drk9s6a4LYU2XAtbdJBd8FeJtx4VCXxFA4gxRGgTRohU2
	 /gfSbsciLJP63KZ8nsBYSdRi7ftyB/Zb8AxQKJwAi6pdv8ozfMFqxak+bMipRduLGO
	 SPUV68/WxsjCQ==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v2] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
Date: Tue, 26 May 2026 17:28:05 +0800
Message-ID: <f83c3bb5e83450b46394f3c14c50f07860c0cb10.1779787436.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - add Hannes's reviewed tag.
 - drop patch 2 in v1 as Maurizio suggested.
v1:
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779170418.git.tanggeliang@kylinos.cn/
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..88291d45e162 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1844,10 +1844,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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


