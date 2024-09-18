Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8A0CCD1A0
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vFY1Q/yY/2f1ySUxHG7WeFHTFi9YXR7Cv/l4WMqD5Vc=; b=DYxxoq9CWoRDGdhyNkFTq41J1/
	VvOulk6TkZloUrE0SPBLMInq9Gt2IetoER33QpViGdYbEbsOxqwPfp3rSmtxt3Db18v88EJoyCY/J
	TBEhflrtn1fiZkcKk8Dq+BMVTgQV4MbJbORJvM94xQWoIeE20QHTbnjxNFW7Due0xR3TA0cEkRNYN
	Q31REFpZPIOZXIYeuZAaygfNNIb0c6t+EutuflAKstpEIrGXMW3IdKHil7of7LAaJVFepSfRGWh4P
	pKCLUObq4BW6Wbd8qSqApC4MAEzKEWJqbSEIOlJ8+rYeTqX6LRVthfYSXq99bYXZ04uWAYJSJXG/O
	Sgj75NuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1squtQ-00000008LgF-2Zp1;
	Wed, 18 Sep 2024 13:38:52 +0000
Received: from mail.diekuehnen.com ([78.47.205.37])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1squpT-00000008L8X-1Xfh
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 13:34:48 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16B377DEEB;
	Wed, 18 Sep 2024 15:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diekuehnen.com;
	s=dkim; t=1726666474;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vFY1Q/yY/2f1ySUxHG7WeFHTFi9YXR7Cv/l4WMqD5Vc=;
	b=BD6KQBFXw0mdb9jAo+lTa7ijwv9y+tHJzgQ4YmvC6+uhXxu8GlWCVa8udgZxjz9+E2Sf1V
	4yk3JLhQb7Aq9CcKS59MbOUecED6CJsJeovWM83OPW1AP34XM5Dir4C+B0hNxxvhpJ4x7M
	LsKI7rNJdZ7vJCToJMhIw71Hu8V/dOuNXdPxWWPPYtdf7ONZc13KQ/yFQSbz2ZVhQNgpDL
	zOiTcAtp0Vu24VzUx2RugaTKmwIrm0GdM8a0HYN3DbQeFX8QwhlFJUwUrzGj8KhJi0jXFx
	BcMq8twOgEcCqmMTwQpwew6OJVzQlhh7QYilsPZ9hCiKfdvxnjHSaIcIykXVSA==
From: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Open brace following function definition on next line
Date: Wed, 18 Sep 2024 15:29:35 +0200
Message-ID: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_063447_728929_EA0D629C 
X-CRM114-Status: UNSURE (   7.78  )
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

Open brace following function definition go on the next line. Fix it.

Signed-off-by: Andreas Kühn <andreas.kuehn@diekuehnen.com>
---
 drivers/nvme/host/constants.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 2b9e6cfaf2a8..66d6158822c5 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -195,7 +195,8 @@ const char *nvme_get_admin_opcode_str(u8 opcode)
 }
 EXPORT_SYMBOL_GPL(nvme_get_admin_opcode_str);
 
-const char *nvme_get_fabrics_opcode_str(u8 opcode) {
+const char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
 	if (opcode < ARRAY_SIZE(nvme_fabrics_ops) && nvme_fabrics_ops[opcode])
 		return nvme_fabrics_ops[opcode];
 	return "Unknown";
-- 
2.43.0


