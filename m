Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D81C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIMcA8z+WBKAkW13YsjUtCNEo27aVXFivONyOXhQiIk=; b=wOOzbhAF0HCFecPEZIQpeWyNjk
	TEjqH/lh94Rz8B8axBB0MAWFrnjnU+U43VwDVLxwblv73TbpcaFGkqAHT4MJ1CKiJrZVe0IuwfLaC
	heQyXdIfA2PEbEcGoiecq1lEKh7eChG/0cDRvC/Vy/2XhDo/6gEWaWMcOR7Pt2ix2q3TrHkFp6Fog
	7QRUa86wFYOiDkbGa/0xxyppKLDLP7c5vimM7NhgTVDezt+KyfzO80zrXy/IjYdUI3/UVgTSc/GqQ
	ZzyQbnLhm3kQDLZCMCr3zlU7oR2ZYXcsJMgEmQjjxFnw6Ef4vO4ZvM/o3rcaTiG3QQUD3LB2hLta/
	q5UDseKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dm-0076Jk-0s;
	Wed, 19 Jul 2023 11:19:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5Dj-0076Ee-0A
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:19:52 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0E6B41FE96;
	Wed, 19 Jul 2023 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689765588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIMcA8z+WBKAkW13YsjUtCNEo27aVXFivONyOXhQiIk=;
	b=vfZ9Z952BQf6kDfkeIYy3IonJ3Pfjcr66kQHqG6Wr3XPdECzjhN2p7K8Ta1pUTZeB6LfED
	MHkGravUAAr8ihs2j7Hrt6moqZd/aqZ8L2tWNErppPFlIIHCO5MwEp4px7qaYg1uZhfZKs
	Bw/iDAsIwU8jp5fmOqqSPWwiqjc+ga4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689765588;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIMcA8z+WBKAkW13YsjUtCNEo27aVXFivONyOXhQiIk=;
	b=s8qfH8JmvRjZLTU60e6r53c8Pivb9tFqYrqUi2HPi9EfxeUL6DRD5BcPcEaugHZQrZ00gs
	5MFHKMxfSbZPrXBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E9FFA2C146;
	Wed, 19 Jul 2023 11:19:47 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DD17551C9EC1; Wed, 19 Jul 2023 13:19:47 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] selftests/net/tls: add test for MSG_EOR
Date: Wed, 19 Jul 2023 13:19:41 +0200
Message-Id: <20230719111944.68544-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719111944.68544-1-hare@suse.de>
References: <20230719111944.68544-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_041951_501597_3C913195 
X-CRM114-Status: GOOD (  11.03  )
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

As the recent patch is modifying the behaviour for TLS re MSG_EOR
handling we should be having a test for it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 tools/testing/selftests/net/tls.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a3c57004344c..4b63708c6a81 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -486,6 +486,17 @@ TEST_F(tls, msg_more_unsent)
 	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_DONTWAIT), -1);
 }
 
+TEST_F(tls, msg_eor)
+{
+	char const *test_str = "test_read";
+	int send_len = 10;
+	char buf[10];
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, MSG_EOR), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_WAITALL), send_len);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+}
+
 TEST_F(tls, sendmsg_single)
 {
 	struct msghdr msg;
-- 
2.35.3


