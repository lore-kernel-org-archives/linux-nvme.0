Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B18EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jun 2023 07:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=px9gT/KHHXqN5GEW81nHUKR4q3nSAUObTcZ6KdRcDk8=; b=hPHCooxkhhhf+PYMpOKjE/NHBU
	0/WcX3kPIkMXeXL2Dw/njWIudXWkaRMqOq6Jawojpr1QVxyZeJkzuKbOWabAqUGR1vUwC+VwU5uzI
	03AYp86jvSLbrOPus/PB7BAJbyH4P3nVTSQlrW4N1PC1LrKM0coRaWc1hMY/TBVpShV0XVRPRCOXJ
	EN0mweHgTiqUBsMmoR8yKKme5xHD0mUvdilZ1iqFdeHuiQu2Y/5Q3qYQ3wKo0mlt195ZU8N3lidTx
	IGFJ8NoPPKLoBf5H0sefz40xyEdlsBBd3EY59gbuKFcMp6Ex/f7VcsZ9ICoDklikSfT6sWi2hZApM
	kLjdVDZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCF7x-00HJaH-0A;
	Thu, 22 Jun 2023 07:53:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCF7u-00HJYV-1S
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jun 2023 07:53:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0B21961775;
	Thu, 22 Jun 2023 07:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6501C433C8;
	Thu, 22 Jun 2023 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687420389;
	bh=xqQMO5ckGzta9FIBew+/npULicYzwRKPYfzW82Q8QLY=;
	h=From:To:Subject:Date:From;
	b=oLDV/Q63lXH+H40PzvhtbwdNpUFMKMjreDsu9B4FIsqUh8HTBcVqPuqaauC1hpRel
	 e2k1X27+bByx9DNhqtzut+OgOobmogJE0jYCGI0WH3vdc0C36q6vfTQta4jC8VpYXq
	 lIMkOUmqb3vDb90IolJiAihaIbWFvvbJIhPRRF9pgJPHd48jYLDkU8/YMijMd8so9z
	 EDhUhsfs2wBkHIwfAT1u01u5KGGpxpeB0BfcMgzV8VQCKArlKhk14YEckSKdcHXaBz
	 J0e0o8P2oogHIPpKNKj1jzZGseSTNdjV5/vLtvZcGXJE+6jw+QvIZE7rz4twriVPFK
	 T+QFVmj12AfOw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: host: fix command name spelling
Date: Thu, 22 Jun 2023 16:53:07 +0900
Message-Id: <20230622075307.692950-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_005310_526394_25DAFA66 
X-CRM114-Status: GOOD (  10.79  )
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

Correctly spell "Zeroes" in nvme_cmd_write_zeroes command name.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/constants.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 5e4f8848dce0..20f46c230885 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -12,7 +12,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_read] = "Read",
 	[nvme_cmd_write_uncor] = "Write Uncorrectable",
 	[nvme_cmd_compare] = "Compare",
-	[nvme_cmd_write_zeroes] = "Write Zeros",
+	[nvme_cmd_write_zeroes] = "Write Zeroes",
 	[nvme_cmd_dsm] = "Dataset Management",
 	[nvme_cmd_verify] = "Verify",
 	[nvme_cmd_resv_register] = "Reservation Register",
-- 
2.40.1


