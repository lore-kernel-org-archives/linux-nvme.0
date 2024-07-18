Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027E0C3DA63
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHxG5FqKhmdAUaoSnYuT91Tx1yynIiZ+utYwrO2cBsk=; b=eZeJr6aJ8sCs3T5//8YSqTrPq7
	n9BYi8W0QSVZqRJ312CaSEJN6eYL+1vsyEzsNNZ/pZhiaQHBLuR5AbtQPLaISaetApPj6Lu+oQySl
	/z4TcWVxijtsTuenD11H3poRWG99csneEdC+xb7eMymJF0Ogo+OQOlpdQaTJoWwGQelJnczptHP3T
	0GwO/R1ozCxBa4/odr5Vsa/KoaXPM+cMkU9y6+J5XVoESF4jmzctdysXKbCDN33jEe/ADCJZ//WL0
	OFJb+WMoDwTxUnBYd4NLT3R5m4ChxXcc91sQWdlfKDlnZ6CMH3k/w0k+VlmqXAkzgcRCfZSkgv8tn
	lnEUs3RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSjD-0000000HO9r-0trB;
	Thu, 18 Jul 2024 15:07:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSj8-0000000HO5T-30Bm
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 15:07:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 079E061B96;
	Thu, 18 Jul 2024 15:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93731C4AF11;
	Thu, 18 Jul 2024 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315245;
	bh=s1rqJPGL7eZeUv1xNfIV6p7ffjZMvRKYvBsX7vrPn9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4EwdEbZ4I5vjI1izeThKFpzWZHfFiOppFhsAHRGrUswdjuGDpLzXVwYvZyIlcsfq
	 2WamKGLxE6O1ymvB71WC3uqsl2NDw6LmILnPbTa3FMYEMCRS6mYfXOWCHcT+NrEQbv
	 7Yyy/K49jwr8QBA3Q1/Q8vS1Zz7I8SvdypCiiXrJc6MZLbg0aGDCWf0ET/S7fynlL1
	 biaFVCB03OMvdB56wDbLxG2cSrW5vwkZQFGRYeZd0TxneD2f0fizZI0C241VwxGnMp
	 BRj2QCOvvwMB0g6tM5ojGwirgth2no5YiM23AhahTW9pHw4yiuhpqUlUdH+456fQCl
	 H2NDg18cqGANg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] nvme-fabrics: reset admin connection for secure concatenation
Date: Thu, 18 Jul 2024 17:06:57 +0200
Message-Id: <20240718150658.99580-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718150658.99580-1-hare@kernel.org>
References: <20240718150658.99580-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_080726_933795_9C1A1CEB 
X-CRM114-Status: GOOD (  11.78  )
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
 drivers/nvme/host/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b748e4033df2..08ac764ebfb0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2254,6 +2254,15 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (new && ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
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


