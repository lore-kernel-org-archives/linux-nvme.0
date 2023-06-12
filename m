Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08DCC88CB4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnoDd1ud8H0idMsQDGdSV9a0/2M3xPxf+OAC9kFme/U=; b=rhy7HBQiYb6nLXXamsGGBPVHIz
	8U0ATUWGQAkujlIJUBH6q9ynotz3Iwl6IIsikX3rRJGLcUeEwI3hqoaa/465OXKKr+OkC1Ng1ZJNS
	Q0qp4cX+PsvAcnLeoUEvHiLnz84belqx8SAMTHTBYEk/sxhWi5+CjmV7Xy6kMNHhutRIWe3JmRM8T
	h6vL/fc9e4DIIE2nUF3wspTZzwSlcXjT5d0mbXhhN0CjUQT2PeCCHdFgDZlsyvHkJaJGwnLfwDx1J
	7Ge/w+iL09VvY6HcAK/PL1lKtZ0dMOAQvUA2Gd7WxKBz/oNZv4Pgf+xSjIcIHG7Y5XGcI487NH/Zw
	KHn0y3sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igx-004KK3-0k;
	Mon, 12 Jun 2023 14:38:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8igs-004KGM-2T
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:38:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2979922807;
	Mon, 12 Jun 2023 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686580720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnoDd1ud8H0idMsQDGdSV9a0/2M3xPxf+OAC9kFme/U=;
	b=TnkXIxB/OSXqVHqH15krrp6iQM5cql7frcztU13RFgC8knD3ApJjQLirsc+ImDy3zNeMVs
	UiiOmCKQ+gPo0lQNCbqu0q1cdiRZImfQl/WSsbPxp3BjV5C8P24LPOjftj6KHtiMT4rpGv
	oR+p3ld9vfp/grtjX+ejyOGBfNJ3BTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686580720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnoDd1ud8H0idMsQDGdSV9a0/2M3xPxf+OAC9kFme/U=;
	b=ZWflSIEhbOKa7kKx8R2OCl2VAFbAiBAgaI58KbzupxnNO2W07Rovp2z8V7uoupcrypeXpt
	mTphTwwfQJHj5bAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 002732C146;
	Mon, 12 Jun 2023 14:38:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DF00C51C4CBF; Mon, 12 Jun 2023 16:38:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] selftests/net/tls: add test for MSG_EOR
Date: Mon, 12 Jun 2023 16:38:33 +0200
Message-Id: <20230612143833.70805-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612143833.70805-1-hare@suse.de>
References: <20230612143833.70805-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_073843_023447_65DFADEC 
X-CRM114-Status: GOOD (  10.33  )
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


