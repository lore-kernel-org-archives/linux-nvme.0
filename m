Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AC0CDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bP2ryqbuPp406xCrhHtzqlf4a9UOvOW5tHNIoLCdgbo=; b=WzPhdbY4sOIhQ8kyZ3rbFhGxfI
	PZANxymJ9sXUrMRvAXLlTBewZh9jI/l6fVWE4uSRXAax/rhhgRKq395zroZQfPcoKua1B7jKxAgF/
	LbfpkgxeKHRJ6PEPyzdW3h/auE4Pp3lUZcGXJ9Y8y9SaTBuG2J1UlwIkOvx+Z0s9xBwJTITRAi9eo
	Ibue5r9v22mnVcSU8gqB66GxgNzbVVOLJuymYYIi4j8K/337T52jq/VbY9fQi+np3S7pV4BHBG4mB
	ekru2MDvDWkcKkpoq8wg/P3kn0Vf6h9VqzOlnA+4+JU7xYP612yROSVbQ3ZGkzzaiy6lMIKCtQ9jZ
	vaILtTvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqS3-002UNE-0G;
	Fri, 20 Oct 2023 14:26:11 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRw-002UKg-15
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:26:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 5DD7621A2C;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 272C42C8A8;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4DF8951EC191; Fri, 20 Oct 2023 16:26:02 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] nvme-pci: unquiesce admin queue before nvme_init_ctrl_finish()
Date: Fri, 20 Oct 2023 16:25:58 +0200
Message-Id: <20231020142600.47246-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231020142600.47246-1-hare@suse.de>
References: <20231020142600.47246-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.29 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.20)[71.37%]
X-Rspamd-Queue-Id: 5DD7621A2C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072604_521477_B8B6ADA7 
X-CRM114-Status: GOOD (  11.10  )
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

We should be unquiesce the admin queue after setting the state to
'CONNECTING', but before calling into nvme_init_ctrl_finish().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60a08dfe8d75..5b6dec052dfe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2709,7 +2709,6 @@ static void nvme_reset_work(struct work_struct *work)
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out_unlock;
-	nvme_unquiesce_admin_queue(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
@@ -2723,6 +2722,8 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	nvme_unquiesce_admin_queue(&dev->ctrl);
+
 	result = nvme_init_ctrl_finish(&dev->ctrl, was_suspend);
 	if (result)
 		goto out;
@@ -3019,6 +3020,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 	}
 
+	nvme_unquiesce_admin_queue(&dev->ctrl);
+
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
 		goto out_disable;
-- 
2.35.3


