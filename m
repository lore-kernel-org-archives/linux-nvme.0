Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5865EC3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvuqq1Y40CkNlRc27HbVDJOOg8mtTS03BNLU2TiiDaE=; b=ZPgPBannVaWtQAGHCA99qjR86x
	FfAFnzQaG9UhgrEDX7tKxUJpxBCW4tYU80zQN+oIsVvu4ZLplSeAJnB5T/xKYUmsGQCwiVRUJ2n+d
	iS/GjHvFdIRa+o4kgdew2tt5xS5EBFuVpz46+oT5AemWqbLRt0IGmeX6fPCB02trXHnt/4g4smcjV
	jc4OwESH2c5iTrTyJwsIY31IXa1I+QzqDs2gBeEQ1Zbao4KwpncBni2MyK4UNZo2BOHsyHMA0jlJZ
	DePh5ENcc8kNzYL0db1mNP4qk7Rg2E43qSMqi63GRSD5DayXc2dOjSLS6OD/5mn0BbNnReEz9LADq
	u3k0GXcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9O-000000026Sr-0shu;
	Fri, 19 Jul 2024 08:39:38 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9I-000000026Lj-1acc
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7A476CE1ACF;
	Fri, 19 Jul 2024 08:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B91C32782;
	Fri, 19 Jul 2024 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378369;
	bh=Ct3yntYKwmCmb0uFolRW5QmEppdd4ydogYoNtk2aY0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFD7ZL/bLbMvhGxGsgi+rvih8W/KCkwUeZWL1/+CSTTnIRkca0G4S+DWTBTC7pAVb
	 pmdeBd0TiM2rEG3Cy+Ju0GhdSbXMLM/NZLjHOm+6bWo3iPcS5tpE7lg0+2YP/+PeZ4
	 ltfL9vyx2/38GZMAi82ZI91nFmVXRYb+dCrSpGcCbHYnJjrQw3aVkypBoRnN71jPFb
	 sH6mh8RIu6ggAg6pQAvxwEjJf383VHIm0rVtuhrTIRErNg7vdQG76OZHOENMDzxKe6
	 mLzr+B2nCILcHpl1c26qHzc1T2GQFVxl5UP2BgGDyZt3CaXAw8oDa41sMbdSdI9nZW
	 56xiD9hQG1DrQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvme-target: do not check authentication status for admin commands twice
Date: Fri, 19 Jul 2024 10:39:01 +0200
Message-Id: <20240719083901.35399-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013932_658336_AB8B6AD2 
X-CRM114-Status: GOOD (  10.88  )
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

nvmet_check_ctrl_status() checks the authentication status, so
we don't need to do that prior to calling it.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..d64480f01f4a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1005,8 +1005,6 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_admin_cmd(req);
-	if (unlikely(!nvmet_check_auth_status(req)))
-		return NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
 	if (nvmet_is_disc_subsys(nvmet_req_subsys(req)))
 		return nvmet_parse_discovery_cmd(req);
 
-- 
2.35.3


