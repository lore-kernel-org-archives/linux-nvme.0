Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7935DCD11DD
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zd/5Z8C+y+U19Nejkh41Eltpl0oVA1gwNATrljAVQf8=; b=sQSRnR8zTeRh1VaXuebDmwkxrS
	8AOiAPtRdMU3V3ft0m3NX+sUrlfSxP1QyC3aoZ5Zy005QzvIVbthFRESp8r4DEafbygF2SVku+Ak2
	Jb6Pxlr3i6822aIDnOtGWDxxNIPXu2mwQldYosaMgIO+XDJMfd/0Nsj68a/jD6YxU7/7nUih6W04o
	sS8qvIp4M8BWOS2NGcN4zmgaNeVVyWFhrLvKDhI4KEn+6+Q4/Ap0G91huf4wcsYFUr6QuM1LI5Dz5
	oOMOkjVYcBQSFQ4eVKmxCQtJnvegiebilbUqS4E5GBZXwR6HI9evG14yP8yV7jSalg7QivEQrde8J
	2T7ccO/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5XH-00000004NcV-2iLq;
	Tue, 26 Mar 2024 12:04:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X9-00000004NVu-0dZy
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:04:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9CA5B61046;
	Tue, 26 Mar 2024 12:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C5C43390;
	Tue, 26 Mar 2024 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454642;
	bh=F7rOKSzAzDnN+aQiv8DCFDJwM+6jcADEXGwdV14qrcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzuVPiqqkqUNOd1g1yzsxPGLTpJH3tjUM7Onj+EtSn7cMgJIhOhkXNOYXiaPBcg9n
	 iFJH7/VPbZNxCAVw6Uu2UuffTQUDGcsy8Kv4rYDPwrpEOziVE8eo6cUNz0lG+FAds5
	 IvL24xrfz2HksuGeoM/r7HWbqFYTFaHXPPmzBiGMdoxQhDigOA8feeqCk33bo1DO2T
	 pPNooSfvNlEr8hJU65QUPzPY67Xn64kd3RCPyCkdK463D0eFKPTsPgmOoobMtjhtAf
	 HlPtHF4k/n6VDNdBXkNa9lkIR1uWLxOkTDDzQKJ7VdTES6XJP3SvnH00kiidbv3p+Z
	 Xf+nhqgB3qQgA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/7] nvme-fcloop: implement 'host_traddr'
Date: Tue, 26 Mar 2024 13:03:41 +0100
Message-Id: <20240326120342.105740-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050403_303147_5DC11C14 
X-CRM114-Status: GOOD (  10.73  )
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

Implement the 'host_traddr' callback to display the host transport
address for nvmet debugfs.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/fcloop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 913cd2ec7a6f..e1abb27927ff 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -492,6 +492,16 @@ fcloop_t2h_host_release(void *hosthandle)
 	/* host handle ignored for now */
 }
 
+static int
+fcloop_t2h_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
+{
+	struct fcloop_rport *rport = hosthandle;
+
+	*wwnn = rport->lport->localport->node_name;
+	*wwpn = rport->lport->localport->port_name;
+	return 0;
+}
+
 /*
  * Simulate reception of RSCN and converting it to a initiator transport
  * call to rescan a remote port.
@@ -1074,6 +1084,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.ls_req			= fcloop_t2h_ls_req,
 	.ls_abort		= fcloop_t2h_ls_abort,
 	.host_release		= fcloop_t2h_host_release,
+	.host_traddr		= fcloop_t2h_host_traddr,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
-- 
2.35.3


