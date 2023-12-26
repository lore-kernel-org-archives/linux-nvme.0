Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07400C46CD4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TjiYTH/haIaG4GPsvGiXpWndc+b7MOaOLyPb6Tc22kA=; b=b8yIESn7s3pu2lsqLIJivobGV/
	ivuLrcGdkKHU9HELOzqV4yv8TMrfwcz9AdGg+nus51xFObTlYmbp3hGvh/1mFyIPx0ZL81p/+gFlw
	aycNOSZDx75qgKwb9CYY+alHzll9WjcYBtk8wqaohdhHxFXBtUoJkyWGh1YnVjCNY+7GYjgXH3n3a
	4vAKx313Szxl2o77GjSqF9beSch/TZVHzaEpbM9OsdFOEyEiv8T3QjgsFfvxtFYJfTt6Z10EBfi2l
	wWpCbgdCFjb/1AGRDmvSARsaFkyputj1bIiJMd20eqf43DMusT6IlBv+f6KmnRTd2E2mj9ihy8mYg
	JSwKwmaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rI2Zu-00BtFE-35;
	Tue, 26 Dec 2023 08:14:18 +0000
Received: from 213-147-167-40.nat.highway.webapn.at ([213.147.167.40] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rI2Zs-00BtEn-1c;
	Tue, 26 Dec 2023 08:14:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-common: mark nvme_tls_psk_prio static
Date: Tue, 26 Dec 2023 08:14:12 +0000
Message-Id: <20231226081412.180149-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/common/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index ee341b83eebaf5..a5c0431c101cf3 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -111,7 +111,7 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
  * should be preferred to 'generated' PSKs,
  * and SHA-384 should be preferred to SHA-256.
  */
-struct nvme_tls_psk_priority_list {
+static struct nvme_tls_psk_priority_list {
 	bool generated;
 	enum nvme_tcp_tls_cipher cipher;
 } nvme_tls_psk_prio[] = {
-- 
2.39.2


