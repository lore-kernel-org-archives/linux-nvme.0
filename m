Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89D6C27C77
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 07:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6xVvqzH7Lw1nKcXJMLEckeWiSfJihKvkJL/MZyawXA=; b=PzD4oAAfEjqMf4sV9S0epNEFZx
	oHfhZjEXfnrCBp8srVNfNEASN079VDxEeHJ+vCBN8GZJa64KFEeXDzyyfkAFVbUmxAawsHDeaGu/c
	bi/ViDvnSONbVpnAbme/jaSRyd2Ca4jY73b7r5j8pU851YPzAhH3sGs2LIjjPWHGLK73tOVA76g+3
	2J6fhOHF8LFGxHC3VQGgn9OXxOj/wLqQxUhbQpB9MrqCB4bHq/VR2Aycid+cY+E0jMhzJCgyM1Tgv
	L63h1xJaOO2mPAemaMnLUU07tpDTSuEPlLDnkuZug22ONfe+lx3l/RNbotskyvFWRq9x15htgQgev
	vIUX3KaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mL-00000009e41-1XA7;
	Mon, 17 Jun 2024 07:27:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6mG-00000009e16-1XJX
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 07:27:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BDEC6CE0FCE;
	Mon, 17 Jun 2024 07:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF02C4AF48;
	Mon, 17 Jun 2024 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718609260;
	bh=dck2yTyqwUOBhZ6skPbR2uZZZc8sZrWfj0rNdEq2XSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ic3Bmj+NjX50Zkdn49EgnX06V3RXErsc1j6++GnB1K7qcnIHY98CeNCYr8dtGs0A6
	 2onPXqMCL+y8yKEKSy0cD+LFrLE8aWZzH1qod4ko2WPfzbU0dG9bxVLDBQJCdBgLju
	 G64FcoRQDHfs6d3EpTqsFQAfj7hRFd5CYeoTy15ZWyajDjKC9TYxKyJV/cWwkkInr2
	 byiE9FADlacetO39QpHBPTh8XrTChxroO/Lj9uNyHTAxehYkY6wcov5er4frxUHxEo
	 81dVuzaKSs5KjMcUaHUMzrB6NH1bxu1D+pOQR4WnDNEnKno+DgpdDglOmIWHb6YAem
	 c1ZCkReA9IhTA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvmet: do not return 'reserved' for empty TSAS values
Date: Mon, 17 Jun 2024 09:27:26 +0200
Message-Id: <20240617072728.134728-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617072728.134728-1-hare@kernel.org>
References: <20240617072728.134728-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_002744_621468_CEEC8765 
X-CRM114-Status: GOOD (  11.23  )
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

The 'TSAS' value is only defined for TCP and RDMA, but returning
'reserved' for undefined values tricked nvmetcli to try to write
'reserved' when restoring from a config file. This caused an error
and the configuration would not be applied.

Fixes: 3f123494db72 ("nvmet: make TCP sectype settable via configfs")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index bd87dfd173a4..e60224356048 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -410,7 +410,7 @@ static ssize_t nvmet_addr_tsas_show(struct config_item *item,
 				return sprintf(page, "%s\n", nvmet_addr_tsas_rdma[i].name);
 		}
 	}
-	return sprintf(page, "reserved\n");
+	return sprintf(page, "\n");
 }
 
 static ssize_t nvmet_addr_tsas_store(struct config_item *item,
-- 
2.35.3


