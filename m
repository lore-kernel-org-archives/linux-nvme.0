Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA70C7EE2E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gsdzk83Ciinm16GVoD/jkeSF9Z6Bi2D6LHyVzkYmLQc=; b=d0uajerIfeosuX2Wuqt3N8UylT
	t+udo/A/RRQhSl9wMz4hBZ7ad6EInBiUSHDz8wAcpAvYn9QhB0gWM3dx1/NGZ42BjKBUTRTi7f0WW
	74VjfuZr3yXQ6V2XUaPfJdbUFYynToKiI9SeDmInqFj2Z3qHL4yDI5QMW2GlfOyfV5OJAkhWjK5Iq
	wJoOeYx4FqbqCpcVP4IpaK/QGG3Oz5CTPgQTq53+LPv9KDaE+nfhZ21CMaxe636SkCsUru1jqLYE9
	s5nFbK0G57v0+vGBqHqbtXlj9kBNCYfMtBsfYrge+J5vRLd3HLjMrKfDDG/oCgP+EPuLSaaOUxCAs
	7XNdR63A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb5-00D2KW-38;
	Fri, 09 Jun 2023 12:52:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7bb1-00D2HX-2w
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 12:52:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 819A81FDFB;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686315119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsdzk83Ciinm16GVoD/jkeSF9Z6Bi2D6LHyVzkYmLQc=;
	b=KWEeQ6g8u2btSJNLQ0IPtGaM6zHluiPkjNGc7zhwi+zR4LZ6k0MovUWqvaNnTvZMcmtTBj
	Skee3xbfWRoZIetPRQnya8SScIlosePkSzyZneXY3xMia9NlDSXwhlfKbYzDAesioVGkYS
	ETyhcNztZVtfHAZ8yD5FzWtXm7Dpf7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686315119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsdzk83Ciinm16GVoD/jkeSF9Z6Bi2D6LHyVzkYmLQc=;
	b=QgpwxF8986HuKvGCazcMY67gPk9G2hLtpi695YqCK9dN+qpYeT3cynNf6tZ9PFLBD+GsZG
	yzoXeJ1oUz1nnfBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 700202C146;
	Fri,  9 Jun 2023 12:51:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 64AC851C48C5; Fri,  9 Jun 2023 14:51:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] selftests/net/tls: add test for MSG_EOR
Date: Fri,  9 Jun 2023 14:51:53 +0200
Message-Id: <20230609125153.3919-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609125153.3919-1-hare@suse.de>
References: <20230609125153.3919-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_055204_098141_62CC1B4C 
X-CRM114-Status: UNSURE (   9.88  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As the recent patch is modifying the behaviour for TLS re MSG_EOR
handling we should be having a test for it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tools/testing/selftests/net/tls.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e699548d4247..c1cd1446c7e2 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -476,6 +476,17 @@ TEST_F(tls, msg_more_unsent)
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


