Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030CC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bnMntlLMQYrhNkuVcSuOs5s6XcnnmndYA8qYswUBYbE=; b=naxJippgIQVQgZpCoTu5Sl+JY+
	jtkW4dW4qQJ7HQzQ74/X8NYISzaNd6DoptHMC6Iwke/9XSxvPkVif9o334uBDGGeMMeyrrH29SGr1
	9GG+BIdHAVQ//P97FBBiDJeg7UJ9mFF1hm9HDR7VEuBKpIpkSQptmzIRKuK/CeCPZD7pUi15cufL3
	+TCB6ksEw+WYXMHGGmhKW9vNbKtyzSkVq5/Pm4VeEvlkrACtplrUY67rLtfjaHzx+hZTiwUft2RNc
	oJQ1LB2CPQIHB/NHqgbOT+lCEJ7a+M+PjtScmXuB0PMb/zW5R5iM5tiNlO1+eflgmZ5iMGLPCNFKK
	25e4GPNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcx-00Gm82-2b;
	Tue, 23 Jan 2024 14:19:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcu-00Gm2q-2u
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:19:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2651ACE2F08;
	Tue, 23 Jan 2024 14:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DE0C433F1;
	Tue, 23 Jan 2024 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019574;
	bh=CeEiuiY0lBUKhUn8JHRUH7Lq6tzcXuLS5PapE4x/fW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4m1OVZRjZDpke6I6kHRtMGlQTKSiO5p9luQvsJ0UKW9/1KBoVpm68XYZBouPuD5+
	 6gqbKIoWbYSyoi271xAaLgnOV3S0vzqkP8AOWNq7oj5WiVuXgWZ6zZuegi+B8exxRq
	 BrGH3L0dvMcJ2llOUQZTsN9OyPObF3xY1H7C4mZ9Nv8GZT7OnNfnAKsrAQfv3/jTeh
	 Wgsih0/qrVqFHVrL7edMEm7lK/uH0aD/cTILRoPILWZW5SzX553yVWbZPSRQQ1J+x+
	 wzxVXPm/kHmiFFoum9w2dmT0szN9iY1HO7tB09Uox6NekKYPBXown7FIf4MWpvmbgJ
	 yXF5kjgXbnMDg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/11] nvme-tcp: check for invalidated or revoked key
Date: Tue, 23 Jan 2024 15:19:05 +0100
Message-Id: <20240123141909.79061-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123141909.79061-1-hare@kernel.org>
References: <20240123141909.79061-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061945_116329_57C0C19C 
X-CRM114-Status: GOOD (  12.35  )
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

key_lookup() will always return a key, even if that key is revoked
or invalidated. So check for invalid keys before continuing.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/tcp.c     | 8 +++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa88606a44c4..a7da088331dc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -635,7 +635,12 @@ static struct key *nvmf_parse_key(int key_id)
 	key = key_lookup(key_id);
 	if (!IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
-	else
+	else if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+		 test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
+		pr_err("key id %08x invalid\n", key_id);
+		key_put(key);
+		key = ERR_PTR(-EKEYREVOKED);
+	} else
 		pr_debug("Using key id %08x\n", key_id);
 	return key;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c160b1a64ec0..fe4fcfa073a3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1571,9 +1571,15 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 
 	tls_key = key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
-		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
+		dev_warn(ctrl->ctrl.device, "queue %d: key %x not found\n",
 			 qid, pskid);
 		queue->tls_err = -ENOKEY;
+	} else if (test_bit(KEY_FLAG_REVOKED, &tls_key->flags) ||
+		   test_bit(KEY_FLAG_INVALIDATED, &tls_key->flags)) {
+		dev_warn(ctrl->ctrl.device, "queue %d: key %08x invalid\n",
+			 qid, pskid);
+		key_put(tls_key);
+		queue->tls_err = -EKEYREVOKED;
 	} else {
 		ctrl->ctrl.tls_key = tls_key;
 		queue->tls_err = 0;
-- 
2.35.3


