Return-Path: <SRS0=oQz2=O3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173FAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 06:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB23161371
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 06:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB23161371
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z2ejgywJOEFxbps6kTdslOkWrRbym3o7lZOyKgpHQa4=; b=UVj6yUD/rHx2bF
	6owJNIIdsnOrwyjBGTpdqJYSylk0f+wNezZ6i2Zd2iJ9dUAfzxwnlaoEKLGmFiZXYN8Tjfq0kK/yn
	GNOMc+v92yQFslZBPjCdF6dLoEelLnhgXvExggRMTurTauCfoUo9pmdLqblt3+sMPn3GPQ0bmyVV0
	QPhWS+a/N129AmLdGhgrussUxRkxDW38kQK3gDLoXWNlc430SdKvDPijMmnBJ+jdukwWRy8iPaqO4
	tAxcqgeUlabkzptJWiDdpTzN2kSZgRK07sa+wxi76NxVDJUqWZJPpHKBbQDvjq819TsQAFdG6LiKO
	R5RSinATZ8ckJVYSmM6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYNIg-00GJdU-H1; Thu, 07 Oct 2021 06:54:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYNId-00GJd4-Pz
 for linux-nvme@lists.infradead.org; Thu, 07 Oct 2021 06:54:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC16E611C1;
 Thu,  7 Oct 2021 06:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633589679;
 bh=eKAz6BdLJEEeh+Axc/zcN2YzBmbfh8b4u7zbw3bMvCs=;
 h=From:To:Cc:Subject:Date:From;
 b=OPTUKN1BiJhR9aBJROEREHDQpzH9WNARlKY1WYHL38Z+Mxtfqq/S/+S+lndhTlgz2
 4Or8ccbw/DwX0AMmONNig4u71aklpckFlhbExq4UFbARXPBamX6bzYor0L7V6pchd3
 uo2jbQz7o62rFk7jWRCeEDtprDfQW2vBz0SuwontDbfKBAgu6aPasZoUYBf0HxYrrM
 NHqpPSlELjUiE3Oj4LlAl2Gtc/LlHgl4F8r0l2vLbh1FP6cgf0stcrGr4MRkmwXUwq
 8TPUu73qr8SECKJVO6aqqW8Jk1ul4GDzNiMzx63MuvwW/jOfht2DgKn5ca5p8Rygqh
 9Xgsq2bbyb07Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: Fix abort command id
Date: Wed,  6 Oct 2021 23:54:36 -0700
Message-Id: <20211007065436.629383-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_235439_880964_8C9FF398 
X-CRM114-Status: UNSURE (   9.32  )
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

The request tag is no longer the only component of the command id.

Fixes: e7006de6c2380 ("nvme: code command_id with a genctr for use-after-free validation")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..7fc992a99624 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1330,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	iod->aborted = 1;
 
 	cmd.abort.opcode = nvme_admin_abort_cmd;
-	cmd.abort.cid = req->tag;
+	cmd.abort.cid = nvme_cid(req);
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
 
 	dev_warn(nvmeq->dev->ctrl.device,
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
