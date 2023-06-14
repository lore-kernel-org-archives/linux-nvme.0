Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C0BEB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fxtkHtT5A6GMtLGKYoodro+OS4G29aFMiXnJ0DLrxc4=; b=xJimUttJa5luU8fvlTcm0Jofej
	i7SZWWUTn9aEAFsR+xlpuxxJ6cnIluP8rOZPj/yZpwzcf9WdW5434OLttvg9vSH8XjcKkcNfAqM8a
	713llTc9VBPiBfoaGb2oY+bpx4pCorX7PQDy9QTKX5lccfVQ6hV92GkRiVVK4V6pjk1vrnF65cdS6
	8oAtocyo8CLaDEsKSALsltNrkk/Ua0CgnuCyIRhBpG2aaal4+mLxSGJb19km+FFBZ5E+PP7q5KdJl
	pNVEnnd4GZnuiQi6d4YsQkHBfoN+Z+YyjcqgYuCAcaN6lHrrhso1ex7wMahgcImt2IajixE5+Gbzw
	FlRE3UQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtk-00APk5-1V;
	Wed, 14 Jun 2023 06:22:28 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtf-00APgq-2A
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 06:22:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7D9B322513;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686723740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtkHtT5A6GMtLGKYoodro+OS4G29aFMiXnJ0DLrxc4=;
	b=bC3GeTAjIMkhUup0s0u9iNDIeiBgpz+ic8Aer6Gng/p08q4A2iSk8HVUtLmW267eJ7sK9A
	VRsp6f/jTxQ2VNyLr/Xk8GmnRQSu8HhKOsNahYL1fuF63bE+Xyw3JgK4mzNprF+V95AX1o
	aqmHAX41FECgf728sNBcBnv0tfAd/n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686723740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxtkHtT5A6GMtLGKYoodro+OS4G29aFMiXnJ0DLrxc4=;
	b=XMivhOyjdMkTasI4xS2Ijyktmo9WVmj8F1Zg7xWL8lTPuR5nL4yDTAMmpCEG4dnWQGJf1+
	H6O2seTi2pSnqzDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 687ED2C145;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5AFF651C4DDD; Wed, 14 Jun 2023 08:22:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] selftests/net/tls: add test for MSG_EOR
Date: Wed, 14 Jun 2023 08:22:11 +0200
Message-Id: <20230614062212.73288-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614062212.73288-1-hare@suse.de>
References: <20230614062212.73288-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_232223_888975_DBCA1008 
X-CRM114-Status: GOOD (  10.69  )
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
index eccea9845c65..e8540fa5b310 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -477,6 +477,17 @@ TEST_F(tls, msg_more_unsent)
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


