Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AFBC369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I52KuxtBbxEpcOBfPxaowpNFBhZMTVbSZ490JV3zCR4=; b=xT2yioB3GeOtX+y9LQSXan8Mti
	O1x9ttPxJ+KCnR2QVBuu/OW1t/dtv1qrqKFzUx4Fy0zAew/sCpM2rTHANTyqV7+G+whfjSebZR0+g
	KkbcXllG14lxPS7KTzmS0tCfKHMSzX7mYKYTiV9/5u9J3uhcdYbo3COnl88apMeJdMjxDHueARIB1
	4AvAHhNp6rWJ04qCIQZtC4tzAJjtWeE9IcyxOlPzpnVt1gtAmJcODkY7U1mW+oxzZGSrNCd1dRMnC
	uIuxBupcvh4cZMqA407WIFEvMBc14opK0j10qpuTOFudV4cyDrKYzD1S2pmqncUFBtM6eGny/qSCX
	wZjLyFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtZ-000000029A2-2KTZ;
	Mon, 14 Apr 2025 13:30:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtY-0000000298P-0pCx
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I52KuxtBbxEpcOBfPxaowpNFBhZMTVbSZ490JV3zCR4=; b=SEGYVd2NSBHeUltmXJWG0ay71r
	34uCtHZDULUlwwIaBSyfAXttwES1JKtACzZWluR6D2PqORn0P+u7d62ZMm3EQAJhZJAwXSfKOtRgO
	xrS0M7t6Ktrcm10iG3Ymwv+h2jLjMXyKb9voocehcVak7EO+XxovklKJbrtV+iuzcC63eLfutKGfp
	g+bPFv+ARPcn4aINL9YzypJaL47QZqxqxx0VmrIEAij++PPRgMmmISGeQiKMlChu9LWHUtN6u6JjP
	eQIQnurMWYyWhP/7H6gBcQsjgKDJOsvi3mymY/TDR7vFUXtfCggcfZpTb2SFDt8hA5t2q6uYtGp6q
	eDq2kqhw==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4JtV-00000009h9Y-1UMh
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:30:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B23B40C57;
	Mon, 14 Apr 2025 13:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8879CC4CEEF;
	Mon, 14 Apr 2025 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637435;
	bh=kZHpTbJ32OJfohvkuDdUc6Dcq5+uv6JHJ0LJt2BxiWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjIErUc5mwuVVL7acc1EL3/bt+j17wstheSnCO1Z3fbqUOF/M5AmaDy5cyIWksDB9
	 NhUz6PvcvRznzqWSv2ppy7AO/jjG3/ENp4XZK/BzzwKYYakx8JuNwlKXtrMRIdm2nb
	 yEbD2o3sIwwjgKhrRLBHvN2ESa77CpDX6af32lfQFGU12bM7/OXZ2FSQ5Nqfo6GPFC
	 GwXLTj+7rg/1dROdV6p4Kt+YM1ykgV2l29BKveIkshtSSpUojuk0a7UrHsUj0pdWET
	 M0j0mtrCv3muS9V1sPcgORj+NzbTJiWd0XYNA5X0XC8HTFU3kqtO3cADWiGchLJwIZ
	 lNcZXB7+kvksA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 18/24] nvmet-fc: take tgtport reference only once
Date: Mon, 14 Apr 2025 09:29:51 -0400
Message-Id: <20250414132957.680250-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143037_607427_8537A82F 
X-CRM114-Status: GOOD (  13.91  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit b0b26ad0e1943de25ce82a7e5af3574f31b1cf99 ]

The reference counting code can be simplified. Instead taking a tgtport
refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
if not a new hostport object is allocated, only take it when a new
hostport object is allocated.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 8a02ed63b1566..50953e0f9772d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1044,33 +1044,24 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	struct nvmet_fc_hostport *newhost, *match = NULL;
 	unsigned long flags;
 
+	/*
+	 * Caller holds a reference on tgtport.
+	 */
+
 	/* if LLDD not implemented, leave as NULL */
 	if (!hosthandle)
 		return NULL;
 
-	/*
-	 * take reference for what will be the newly allocated hostport if
-	 * we end up using a new allocation
-	 */
-	if (!nvmet_fc_tgtport_get(tgtport))
-		return ERR_PTR(-EINVAL);
-
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 
-	if (match) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (match)
 		return match;
-	}
 
 	newhost = kzalloc(sizeof(*newhost), GFP_KERNEL);
-	if (!newhost) {
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
+	if (!newhost)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	spin_lock_irqsave(&tgtport->lock, flags);
 	match = nvmet_fc_match_hostport(tgtport, hosthandle);
@@ -1079,6 +1070,7 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		kfree(newhost);
 		newhost = match;
 	} else {
+		nvmet_fc_tgtport_get(tgtport);
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
 		INIT_LIST_HEAD(&newhost->host_list);
-- 
2.39.5


