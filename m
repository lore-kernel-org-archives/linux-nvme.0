Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E9C27C75
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RrknpDodOR9F02ScTJnAduYgh9ssRMOFhdJIsOS526E=; b=Y+35sSqiyYHaKqSKG/oue7LIei
	I8uU+YiRP3omfTiLi7nWBwKaGiJFXY2TeaGZZdE8KhauYyOes7q4uG5vZkrc2b3xYyqsicVs5wsjy
	ezdVaLRcR6Ka9TRLw+BzA5JDOOpQRDvjQqsNkiqhs0DeTuzXvAC6y4ziPWr4/uKEpGdTdJvk3drQ1
	NA+YQRhVgvW2s5WbhHpefcwWcu+PkT93hEWD/4YPm40GJ42V3VVS1rF4TSBQOYAkgp+IYp7OV2cIZ
	LeixbGR6f4GatdW+24n5+k6Fq0o4QKarNPZmErXWa73CNqCjNedmpKYNDcqKPMJnU3zyt7c29H238
	3FSQZOiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI4QB-00000002V60-0ItQ;
	Fri, 14 Jun 2024 10:44:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI4Q9-00000002V4v-0RLm
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 10:44:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C70B61EFB;
	Fri, 14 Jun 2024 10:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF93DC2BD10;
	Fri, 14 Jun 2024 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361875;
	bh=EGB9SUM8w1YRC11pvjda/kPfb1g2cvCXCGvgsBUygZ8=;
	h=From:To:Cc:Subject:Date:From;
	b=m7k7cbI0kcImx9lupPt6QcHlg7Lwe2hpwk9kPnHC/NXDhGm34lyijm+lkWgnh3V87
	 lqojQ9DOzThJCH7Tlzk8u9b1dEpwq1y0vsFQQD5DyyjGuicNQyepfDLsXAl6gniPsm
	 9oqLxGfTIMLZWPm78uAMfpgFjskgWXSeiqKpzWmQT4/z/82P0QP1yZ+Wi/w9SJGmGu
	 S/Fd1TyHArPA5gbG6GecPhgA0hrEx8I7G/LqHSIljBBxNMvXWvODF7ZFDLwlj3uOhL
	 hdMqp04tKSswPGz9PinBXDv7SDMDLnFXTHmPNwET9pOsf8L+DGkBzTmcPARsyigIqp
	 6PtRHoyMT1ZKA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmet: do not return 'reserved' for empty TSAS values
Date: Fri, 14 Jun 2024 12:44:23 +0200
Message-Id: <20240614104423.103215-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_034437_201982_EF4879E2 
X-CRM114-Status: GOOD (  10.75  )
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


