Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D30D78326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9tVKH5ZJCPN6t9I+nT8n+gUKTGrFMASYMHa2krJaMY=; b=T2TToA60wACIgs8zkmExWeCZ5L
	IB7eR05hU2jXhNAxlYNbe3un8UYWPX1p05rLpIAv5fY+74rHb58INRkrulA6OS99+Ol3KUhBPm3yq
	pr8l/Rqh077aI9bjOFg1lyi71ycxvyibRXxhc+JRlRuzNMOqc9dS1U1y7MzRINSbagCr49PTlQbD5
	IFvj0TqlekkJQ5Y8pqKIBfRTd9ngN/tanWrr+eKpyH0qc+xWzWUKIvrP2XTySxqliu7peFShSO40j
	vvy4lSizKXdPwYBIkKpHtcA6ydHwn8ruMXGwAdK2tDNdsJIu+DzIhY3bPqznesv2ehzC2dBxCMoA8
	2XreJrRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7Sn-00000006RAW-2owB;
	Mon, 02 Dec 2024 14:31:49 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7RU-00000006QjZ-1dJx
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:30:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 560A8A40DD7;
	Mon,  2 Dec 2024 14:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F82C4CED9;
	Mon,  2 Dec 2024 14:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149827;
	bh=q/4EU0cRrWIkiXqk0dXjd/z6g01ABRxjlms3ls0l7Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yna05BERE7KZRQrjDT+s1JZ4+/VgYZnGOn4H5i/qmEqpHs/XjG7lnMpQBHjBPivB+
	 hP9i9q6+Jx3kr23X8kbDvrIv15dt9aP4sZgkoJiWG3NPj7sxHB+LMBi4WuK6aPpcq7
	 d3q9KOHyB+Y0U5sI0NzoJbYJB7pW+DlqIaYJDoMZ3yh5jr/F6XU7ljq/qDan7zME3c
	 imEdAKn+mK+NP8rqTtVSRMeuCPLvQgQy5GQLaCDSQ8VoqGMiCUxt2kmWyUvOB0iGIG
	 lUgqNEay2h0AmhUlpovN91t+4/TyCdNHhhwrRSbFVj9PoGwjjJYzWrcWwre03WaYcf
	 dlAZ2KHyEHXdg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 08/10] nvme-fabrics: reset admin connection for secure concatenation
Date: Mon,  2 Dec 2024 15:29:57 +0100
Message-Id: <20241202142959.81321-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202142959.81321-1-hare@kernel.org>
References: <20241202142959.81321-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_063028_487626_AA06929E 
X-CRM114-Status: GOOD (  12.51  )
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9268c6f2c99f..3ce5cfe8a135 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2260,6 +2260,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		/* See comments for nvme_tcp_key_revoke_needed() */
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


