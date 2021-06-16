Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2CC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 00:19:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775C3611CE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 00:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775C3611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=f8wdtfBf81GPapXCUG90rUa/aAKzery5f+8ULziEi6o=; b=Y+ija+0qkTzjzh
	2DMwnEZU0S1wZe5gPZ0L54Sn+0yPVnYY+3KtCjehm8F34uZ+dND5LXbfAAadix+M1QDdejCwLcZ7O
	nX7OlvbdURD70wQAhu7bvodiM6zsV9wk9+llpQvd9toHWkHWn1Zp8f7UFtrQ7pJIKelD0G81Rm5WL
	0IWW7HeaV7SY1C4kxbuNV0w6EV124ha2V80XqMovLvUOIkBdPBf7i/DuqUIKqI9P6dV92x8+0IeDu
	RqbCwisWO6R0tPJpkWnwVLIGYcymdnilBJ6OvaBVIDujLyrjF2dS5QBz1zzdDdqyWe3P0+5M3trRA
	yPvAAaDInPfCiM7hUFEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltJGc-0046iJ-NQ; Wed, 16 Jun 2021 00:18:50 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltJGZ-0046h0-MW
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 00:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623802728; x=1655338728;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8RR0uN6/SWhxIhzQE2mb6vFAX4h3MsqiW37Bl4g1UKY=;
 b=RI+lvbgYPHEgZTqzg39oneVgLWFMRAqcroTcbK+zNRUsqSztp/ipuo5g
 /V7nlr+4y36a1AJCm5M8YUTZR+EgVakFNxcpNDMY+1o/S1pHugRx/+qE9
 2pF279nAsi6oXCSl6nN2Q3P3biY6FrzYaSiHqkD1JArxzbp2VJpWoxbSR
 el0SoNhCrGtsM5aa90IW2tgVY34mfcz+uPGKpzWjRw1C2rMdBksoMOCQf
 NL7mHI+mOTO4d+0zhtRU2SYQny1jnZxykKKj0SN6Ur0y9M2agOrXTsuCu
 IaZEASaKtF0rESzK38jmYIhFqQo/Dyb2FfmybmVzwjRxCl+lAiZhtRi10 A==;
IronPort-SDR: /TDoeHjSboi8hU3DSmZEFz8KW4uQKahwG/WDK6flwuJkZUmIGZo/vlhWb76TblqdUiq6aZIGAV
 eQKTozEYB5v1kziXhPb3gD1OPwxtT/Vf4CEA3AWCDQZ65rl1FVRrMeoOeS5fZ2cAeqKQeTur9X
 CKsnoNmhUaPg18sYF9dvxLUgXin9KW7WlR/P8q8fGBSF4SsulqZGrj4WjoRkpRda4sjkYCW75L
 a2roGOeI35UAEv9iYrNMYZG9EX2F6ausjLfb7O0vqAUIM3wm+a02N/5Ccs8f1BkblQTUXA6YnB
 z2w=
X-IronPort-AV: E=Sophos;i="5.83,276,1616428800"; d="scan'208";a="172598451"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2021 08:18:46 +0800
IronPort-SDR: uz9X4etXmYLpOwi0UcscM9bQBaJMNvPjQa8lIzlqpERY5wTGwl+Jquh16q6lobLP7R/pBtmKk0
 IARw0WvR7eRcTHfxnyhzCXc2twDGbWhPWSRW8SN5wDpMUe//Dphc9nu/yNra8026WdI4SMJEo9
 RunNqAh76SvjuR77a5y2vouvixe52PeMGRWX3WFGuuw8zy/PCnrQGu2/k54ssmQWlG9gbcD0Fk
 llOPysVwDCwulm2j9pfJslqex10OWro10bP4fAl5FbgmiL8l2d21l3pFYUQdoH7PCCbKgrAt8F
 IGcgL1AjQhG/+FPM6+UL3Xu4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2021 16:57:40 -0700
IronPort-SDR: /wNn/4H02MKjN97A+vy0gakEtrGEqA/2uH3cYz6Wf9poxAjD3YUSZmHq4R+eJ1A99YUnR9Bsyo
 iokT50HKE3nBXnMPAa/DuS9seaTBnVa8M3Lijuj4FrB0JSsEEVlZMwPTEGzdN8D0Psp40V/Jtp
 uhMJZpJ79BLGNUwYTC9W+UnyG+a/1Inw4bRWQaAUkTve7vk17PEaXE8Jp0nLmABsXfyyDzY1/7
 oJPXkqMqrR4rF82mXJsOLfDd/TaIzDEJc9oIV9U56Y+xIZorXXhkQnFQHRDImenYAczbD1vR/D
 QRo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2021 17:18:46 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmet: mark zmgmt recv work function static
Date: Tue, 15 Jun 2021 17:18:43 -0700
Message-Id: <20210616001844.58969-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_171847_846059_45069763 
X-CRM114-Status: GOOD (  13.03  )
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

The function nvmet_bdev_zone_zmgmt_recv_work() is only used in
target/zns.c. Mark this function static to avoid compiler warning :-

>> drivers/nvme/target/zns.c:257:6: warning: no previous prototype for
'nvmet_bdev_zone_zmgmt_recv_work' [-Wmissing-prototypes]
     257 | void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
         |

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9653e01d9c3c ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/zns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index b8ff75293e53..c4be4012c4d4 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -254,7 +254,7 @@ static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
 		sizeof(struct nvme_zone_descriptor);
 }
 
-void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
+static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
 	sector_t start_sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
