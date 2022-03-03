Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E7C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wpl655kTjseHRcukTn8S3p2F1tvc5eMqjLS5tZY+xa4=; b=uKl7E+9aSPNN7jib4H0gK/DQAQ
	V7JcfruhRjn9B0dszaudVqsAOkvuYyE2SaH/KJOJnwdgTwMzdqWBf9i6Mf/FA5JdTuVrgp7V5Opy9
	oc/eWUcYdckfjI6VvwBtHLTWzgHXfyBmSXdQNmh8hPS32/uLdu+2463kqJVKMlrJzRjuGIR/aT/K7
	XEe8CbdaFmk7Xuqh8hOp8gmU4p5Ap7UQrat8Yz3btRoWAT2Xew3HmkTcR+JpSFiVrK0y4NLjR4+BQ
	QgwaPOTe4CDgwA7am+dnYeDGX3jJ0rjgsn7RsEVn0A3edBgMOU8G6BQPhlrialIiRKr1uIR2kYvLC
	L5MWnArw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPrpB-007fFV-UZ; Thu, 03 Mar 2022 20:13:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPrp9-007fEC-MN
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 20:13:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2C51C61CAD;
 Thu,  3 Mar 2022 20:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E3C340F3;
 Thu,  3 Mar 2022 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646338398;
 bh=g7HEXU1edCJeEuz6s3HW4755ffa012L25T8MW/aD5Rg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=niESzphuotFbUU6f1ED2hUOlhkI4P2+lTiecEF1INmxc8xQDrx0zmTMAWAnci4t3i
 PBSx79kgrocHEcXsJFoLemjIFV6/AbkJCd7sgxaQDOQvphDH+Z455Nl5lCGwATFm8E
 1lGYfU9q+YsatInm3A4ihGye8ZVmR3UZCtQHyww9vtOYUY5zYBRKiOZ5t3ju5t9/5B
 dUX/E1xc4+Q2hCvAQGbGyv7/f0F1YCAzwa3C4glYuWrTYwQBcEOfwNfslH6KnuMHxL
 pKo0XXVPkATWjpOyYH3ohKWnHqyU/TJEjSPrLYs9tub/xUGRXun5QsZdRjWLJJuyno
 RWUpMh5Trz8Fw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 2/8] nvme: allow integrity on extended metadata formats
Date: Thu,  3 Mar 2022 12:13:06 -0800
Message-Id: <20220303201312.3255347-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220303201312.3255347-1-kbusch@kernel.org>
References: <20220303201312.3255347-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_121319_795176_9400C5C4 
X-CRM114-Status: GOOD (  13.65  )
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

The block integrity subsystem knows how to construct protection
information buffers with metadata beyond the protection information
fields. Remove the driver restriction.

Note, this can only work if the PI field appears first in the metadata,
as the integrity subsystem doesn't calculate guard tags on preceding
metadata.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ace8c61850b1..ace5f30acaf6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1754,12 +1754,9 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 
-	/*
-	 * The PI implementation requires the metadata size to be equal to the
-	 * t10 pi tuple size.
-	 */
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (id->dps & NVME_NS_DPS_PI_FIRST ||
+	    ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
-- 
2.25.4


