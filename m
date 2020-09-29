Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97EC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:32:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38812075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o1yR1xVF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNP4Jzzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38812075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bsCEICSqnX3P6t2BFWHnpYJ2bKPv7YaVy+EdcAXgFKs=; b=o1yR1xVFiqoDY6Wy3L/vt1MPu
	bTQCwSK0pUYMlL/CAOiqfvc8zLtQHW3E8GWbsH06BKMrlRVPETQq+NbhT7ytziGWA9Vw81rEfIbfQ
	gtle6f7dQE+EqKrzq8SoFowC8mbX8fqW8OB1F5GADDvb9/LGm1tA78NWi7QQf1i+5+budyLi1cj2u
	0QowuE6T5lXR2pgAoQf4JSpeTflhj6zvJZcNDSKESg/j+6SiaRuvTgtG6LN3pPOhWd4lLUbtLjUUZ
	Mo7KTn9Z+OqICxX+rot86j0VHLko32X+qfkPvhsXOPEMFKuy6A6C5hc3iNA35S/AbAeBkdBlcqIwQ
	DX3s1+7EA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kN4VF-0007ua-OL; Tue, 29 Sep 2020 01:32:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kN4Uo-0007et-OU
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 01:32:00 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2678922262;
 Tue, 29 Sep 2020 01:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601343116;
 bh=DxmXQ0Tdp39gX86Jbi3MkEGmk5C1zYx5p0z3mnIsGPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nNP4JzzwiUhRsajLCmo+uqgcnV5tSyeWg4Ez8dGLxFIzj0fa9+x12cTdZ2NyTQFP2
 LY/n/Pd6DPopT8Fp8QxhPnhv8V9Q93pWiGc1+m6HqereTFa6jUD8gU/Swv1vRD0VdC
 Jh0huIg82yItOGfoSLszVKoegDjKSvrn7y+jZsnw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 9/9] nvme-fc: fail new connections to a deleted
 host or remote port
Date: Mon, 28 Sep 2020 21:31:44 -0400
Message-Id: <20200929013144.2406985-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929013144.2406985-1-sashal@kernel.org>
References: <20200929013144.2406985-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_213158_974826_E5B2F743 
X-CRM114-Status: GOOD (  14.91  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: James Smart <james.smart@broadcom.com>

[ Upstream commit 9e0e8dac985d4bd07d9e62922b9d189d3ca2fccf ]

The lldd may have made calls to delete a remote port or local port and
the delete is in progress when the cli then attempts to create a new
controller. Currently, this proceeds without error although it can't be
very successful.

Fix this by validating that both the host port and remote port are
present when a new controller is to be created.

Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e95d2f75713e1..7e3f3055a6777 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3012,12 +3012,14 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
 		if (lport->localport.node_name != laddr.nn ||
-		    lport->localport.port_name != laddr.pn)
+		    lport->localport.port_name != laddr.pn ||
+		    lport->localport.port_state != FC_OBJSTATE_ONLINE)
 			continue;
 
 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
 			if (rport->remoteport.node_name != raddr.nn ||
-			    rport->remoteport.port_name != raddr.pn)
+			    rport->remoteport.port_name != raddr.pn ||
+			    rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
 				continue;
 
 			/* if fail to get reference fall through. Will error */
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
