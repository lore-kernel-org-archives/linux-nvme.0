Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDDC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuTKUyifbQYdEyDsz/GRco032opBpuVGKtnUt8afS2I=; b=H3pmWBFOM2LE53hYpjVb6QXUyI
	5h/GEF4RZzcLMJXj+WzxTJ9fDB2R0PSD6xPDKS2HQHMoHzIWAOou8wqSTfi9YB1NLXzZgu1e9iGlF
	o8mmXBk6uhR9sAYwjSK1/GzElE6NqRpO69aA6UlnpyuyL5k4GhpMoLiAMrTEYbTQykghtRhDCJ/dn
	ch5B7gPStorl8tajA9rupRfPZNko2B4T7TYcoHFdJCkIEY/Sla9i2c+z31k9D8DNz6FriCl/ah2wc
	3vXGQp9yevhr8JXT4Llbtoxv506Hb0KtsU7J+W+eeJdZOMyw+fpPH7W2qcI1XnyfK0fCcf4ctJZGz
	G6mXwGgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4wu-001FOx-K8; Thu, 09 Feb 2023 11:18:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4wc-001FDs-7v
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 11:18:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B6F2761A2F;
	Thu,  9 Feb 2023 11:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8A9C433EF;
	Thu,  9 Feb 2023 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675941505;
	bh=hUPAz7/Vrxl4ojlvrN3CtHPIGvlkHC4PrRoeJ8keh+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+O0U0X7KEovmmWUj123WvEQpXyGb/36wxKeIRb7lt1EJoIuTUjwe3r6bUmiJEDue
	 OJCsvOWbTKfmUvxsBlTq5KhC7VzEguIjHPRILQdcC1SdJn7tvXVQKnrn8hl+uPeguZ
	 k+Od9JDXRycvCevQriV7/49Esyg27isQEbxvL4Al/CaNqnzPLyWZ3qeeyzgY9pgI9d
	 JVLzM1fzmFXCEbLOqzufq8jYGfqsMrMQklELNMystjCCcbH7n6gHFMiRvTJvWd/h0p
	 ShhG7IXApnmGnY7fdx/P/Lx7Rpq4MEQDxSJd6sU6FyNzkNZIAa9EKMOK0tI4MSzByO
	 8ehcMsEaUmt5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amit Engel <Amit.Engel@dell.com>,
	James Smart <jsmart2021@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 15/17] nvme-fc: fix a missing queue put in nvmet_fc_ls_create_association
Date: Thu,  9 Feb 2023 06:17:27 -0500
Message-Id: <20230209111731.1892569-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111731.1892569-1-sashal@kernel.org>
References: <20230209111731.1892569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_031826_380679_32ECE9E9 
X-CRM114-Status: GOOD (  13.58  )
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

From: Amit Engel <Amit.Engel@dell.com>

[ Upstream commit 0cab4404874f2de52617de8400c844891c6ea1ce ]

As part of nvmet_fc_ls_create_association there is a case where
nvmet_fc_alloc_target_queue fails right after a new association with an
admin queue is created. In this case, no one releases the get taken in
nvmet_fc_alloc_target_assoc.  This fix is adding the missing put.

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c43bc5e1c7a28..00a2a591f5c1f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1685,8 +1685,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		else {
 			queue = nvmet_fc_alloc_target_queue(iod->assoc, 0,
 					be16_to_cpu(rqst->assoc_cmd.sqsize));
-			if (!queue)
+			if (!queue) {
 				ret = VERR_QUEUE_ALLOC_FAIL;
+				nvmet_fc_tgt_a_put(iod->assoc);
+			}
 		}
 	}
 
-- 
2.39.0


