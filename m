Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81560ECE58C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AB921920
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlpO5RBz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB5L71Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AB921920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nO16ppd+P0f1q48cA0phbZu4KBauiB4xJ4jGaLMukms=; b=UlpO5RBzNFwm6+
	oCwoPobSW1cut2chs7PoHXFivUz4zmiW2rt8+Yr8mFw+1tv98NjjyxJl710eBROG9Qhf39r2U9rFn
	l7s6Wt6ijOtDXERxk9k0LJ2QRc+MqSw7wd+ZF4IRnIIFZUg43O7lJQJfwfitDMjgzblSaGJ3VQJ3x
	bkGQwayQJfHSaXUxYVW8pw/g33FF7tnFtRiql6Wmhe6sfrSF1bj5Dj2XXdgOzeCJidgN7qkssCyc+
	cI512zcbBlM/OF/6w5nb4pblJWNMdPlw2cmvZHA2layKh4g2HKwy3EMPLyx1maNTP4wafut/9DcWy
	ZH+E3+9+W4p4yAHmytng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIFiL-0006Pt-UJ; Wed, 09 Oct 2019 17:25:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIFgy-00044d-6V
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 17:24:05 +0000
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C89FA21929;
 Wed,  9 Oct 2019 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570641843;
 bh=HqvXM5KNaKG/zgmqzl+/ZTz93tY+4j8tnfWyNVjau/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rB5L71OlaJzeuc1a/F/Pbtv9Vc7iaYO+SZdYz6wCuOFoix7ep6I7vNivjCxCBBS71
 HdVP5OkKi6AYGku9I9EE/dqhh5sMKEaD8G+AEAANn7sT1GQcdVdFG+K79m7gudPJUw
 bSyb7VCEwXH/D6iaKfeZ3OWFbLbxwKr+NXYijJP8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/26] nvme-pci: Fix a race in controller removal
Date: Wed,  9 Oct 2019 13:05:34 -0400
Message-Id: <20191009170558.32517-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170558.32517-1-sashal@kernel.org>
References: <20191009170558.32517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_102404_286304_D7AE0D3F 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Balbir Singh <sblbir@amzn.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Balbir Singh <sblbir@amzn.com>

[ Upstream commit b224726de5e496dbf78147a66755c3d81e28bdd2 ]

User space programs like udevd may try to read to partitions at the
same time the driver detects a namespace is unusable, and may deadlock
if revalidate_disk() is called while such a process is waiting to
enter the frozen queue. On detecting a dead namespace, move the disk
revalidate after unblocking dispatchers that may be holding bd_butex.

changelog Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae0b01059fc6d..5d0f99bcc987f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -111,10 +111,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	/*
+	 * Revalidate after unblocking dispatchers that may be holding bd_butex
+	 */
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
