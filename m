Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2AFC001E0
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ur8bxmTX7RGEWUho3Mf/Fk06O2EG1BkelISI9wrzJxA=; b=Jb/9eTC0q21l/ppPOIMq8Mtfvq
	cjZacxaDOfxLVuCOALps+eNETBSjuxlDLoYAbzefu7MD7yWcyXFA2ebMsMLzrTwvMXZL1RfwrMKAE
	JaqcMYJx/CtjSgfXzupgLgZhqd2soDwgw0HT/B8pgmBIGFiAKSP4jk2sv/+VpsJm4j2iXmP00G2zT
	mRFpx41SjmlPjHbaf8knoEZbH0d6goI46a4dvqREEnZSG2RDy9ewPBryFsCE2THqjKwCl2h78FVeU
	EdQA51NsqZ/Himkvj08MbJRWCJTj+EovoFEVEjruH3QvYJlc0N+rBB/fwhP3V3MNtjGjlaKuSmu99
	kOY+68Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzf-00BMB9-1d;
	Wed, 26 Jul 2023 19:16:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOjzX-00BM6n-2e
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 19:16:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 189DC1F381;
	Wed, 26 Jul 2023 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690398967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur8bxmTX7RGEWUho3Mf/Fk06O2EG1BkelISI9wrzJxA=;
	b=dBSDFdWJxF151d1+sbgc1zNJU0gYnfo3FsGmjcjDfXpIfmRy8KjSfhNB1Egjp2i8vzfIMU
	8KhV49cCPQxx4ECAiD8B4jZE2H2GrSzfY/C31OfcL5vqxIz+IvBg628n2juXVSXIxu2NJh
	eZiQ3kLuM8KnhPyzbxxPgETfHckFcRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690398967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ur8bxmTX7RGEWUho3Mf/Fk06O2EG1BkelISI9wrzJxA=;
	b=V16zE0G7JooPAq2bpu+SQ0eO1xLR7Za1uGeDhJT0Ntc537SMZGB5KFuPDq5lI9HbkzIJn0
	4BEQuDxd102lX+Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3170E2C146;
	Wed, 26 Jul 2023 19:16:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 25AD751CA333; Wed, 26 Jul 2023 21:16:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] selftests/net/tls: add test for MSG_EOR
Date: Wed, 26 Jul 2023 21:15:53 +0200
Message-Id: <20230726191556.41714-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
References: <20230726191556.41714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_121612_050469_3A78D179 
X-CRM114-Status: GOOD (  10.88  )
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


