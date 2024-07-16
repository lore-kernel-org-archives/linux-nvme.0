Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF30C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iKEef4aizPwbCL/Sqt7uTZi6C6yUUbF7X52369SPOkE=; b=3w9lCwOattBlWmwp7PSwaDzE4p
	RvIGton5ApeJDZNxGgl0QHu6rz4PKknRpF8NhaKbENocKxIZgyukr4EYccggxz4SQ4dEVXvdLUmKS
	OLtXutDpPgShz12+wwWYK/hSS9hvlO6I7tUdZ1BYwglKYvctKvYts3nDIRWeY0egyR76gsygMvK2j
	znnrQ8RkXuR85aJNhmup+NotExdsJZeNSePkfLsOdTgo3Y7CvUOPyyk5ffqIs4fGEegI92ZZ0crsr
	c+My2hGxQwWidFcW0EIOTLbHuTBIem9vtBY3BJEyiLfxG7MmDN9KnZhdjKDtSDUzS2sJFbxYxSESu
	y67F/n0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTck4-00000009c77-1PIP;
	Tue, 16 Jul 2024 07:36:56 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjv-00000009bwl-00xz
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 443B1CE0F9B;
	Tue, 16 Jul 2024 07:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24A5C116B1;
	Tue, 16 Jul 2024 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115404;
	bh=EBLuUKkG6B+9y3FEp4+Sfl/Q7ASOOS1tsNylCF6Ozhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbOyOGQM8WZJ8Orv8SKcUvS0uBkUPb6VtVkgEMgId08GwOyPObKDQT98ozFXJZcBL
	 bDR0TygPluN2jk0SrNHWGwQodzNGk5ZU3ILEORBsq9TbfgqI1+EIbL5LOaQQX/N67V
	 ioIhtAmQ3eMbsUcc5vQSD2iZSecuy4DlbZuaXW6Ibs90U7pC2hMdgSEl+OGMMpmrRF
	 /VDXIjhVo1Y9UhZ186bRapFUvMDMOZL/KcHG/JvDBkZwAnYrth66ljSIZt0s5U3GBG
	 1JZViN1HIDiJvh3eOF79LtzRDlPDdjvpJ8CMzYFo4fT/Caq5jGNoLEPUSgqE1082Sg
	 Wlz6i+NYult7w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/8] nvme-tcp: check for SOCK_NOSPACE before sending
Date: Tue, 16 Jul 2024 09:36:15 +0200
Message-Id: <20240716073616.84417-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003647_333759_02E76FA5 
X-CRM114-Status: GOOD (  11.41  )
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

From: Hannes Reinecke <hare@suse.de>

It's pointless to try to sent if we don't have enough space; we'll
be notified by the 'write_space' callback anyway.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9634c16d7bc0..f3a94168b2c3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1424,7 +1424,11 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	}
 	req = queue->request;
 
+	if (test_bit(SOCK_NOSPACE, &queue->sock->flags))
+		return 0;
+
 	noreclaim_flag = memalloc_noreclaim_save();
+
 	if (req->state == NVME_TCP_SEND_CMD_PDU) {
 		ret = nvme_tcp_try_send_cmd_pdu(req);
 		if (ret <= 0)
-- 
2.35.3


