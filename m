Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFFC47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:08:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560B2613FF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560B2613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lryRh2BZz4MQfUNojH15GtNNxj8iHjxHUQ7pVxKIghg=; b=zv5F3tnffRoO6T
	VKlhKicBI8LRzyIJaeTSTuAE/RNDJuv7fw0j5o2pdiYU553mUMT2D78Rzz7S3TSnxP1/pEN4idilJ
	htZjGqfcGAVKoxldifiIBqqeWzG27j8epveDZ9m1+Gf/1Ej4bdUp536Y8WmQpYo1cqtHIU58Xr91T
	AEQnFhaOZEKEn8vg8yJoR+2xG8+/4cA3dXrQJwWwn1zZdHaGcSb+j3QXm7q0roOu5zsBVYMOwi0r2
	1SQFjk5O+e8x2Ot9wEaINLBPYzay+5suv+ps43JQt/KezvUNr/ENl7CGZOO4woYKeHo654alGbht5
	tV9s88FDoKzYaepEKVtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loqpv-009kGj-66; Thu, 03 Jun 2021 17:08:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqpU-009k3S-K0
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:08:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AB14613F4;
 Thu,  3 Jun 2021 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740104;
 bh=KQj6+Mec5t1lduI9hVJiOB+XDnYJwpycELEWfMg/2Js=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RBOLkEUVwTLQFq6mO8Z+1WXBEQOVkdtaMHgeumSQpQqeS2N6j7kRsm5CQk22p4n9X
 bF9PwzU60efKp3cEUTj+Jq7Y6htL7qxHY7l8aXBP45zLdeh8JpXAf0bcY09m9eLpf4
 O1SI64RhfCv5VENmRhbFb/K4I0Yb3lqD74KJMoGcynjtcbdp/66j5cSFglqS+sQXD5
 vGVeyl87oJJO0uyVQzCMt9Fvubq/UQEubceVt4cOWhQsCU8gG99tD0IzEAqod0bJrE
 LueURKGpwaId3gpaMQk43feuHQ1zYru6+j8pj/ttvkVoQJ+lu28JkOhycDgsRZZ9Of
 rH843LfgUblkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 40/43] nvme-tcp: remove incorrect Kconfig dep in
 BLK_DEV_NVME
Date: Thu,  3 Jun 2021 13:07:30 -0400
Message-Id: <20210603170734.3168284-40-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170734.3168284-1-sashal@kernel.org>
References: <20210603170734.3168284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_100824_708906_40609078 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 042a3eaad6daeabcfaf163aa44da8ea3cf8b5496 ]

We need to select NVME_CORE.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a44d49d63968..494675aeaaad 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -71,7 +71,8 @@ config NVME_FC
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
 	depends on INET
-	depends on BLK_DEV_NVME
+	depends on BLOCK
+	select NVME_CORE
 	select NVME_FABRICS
 	select CRYPTO
 	select CRYPTO_CRC32C
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
