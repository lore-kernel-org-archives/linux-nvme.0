Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2373C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pDv8zR1BJ7lKwW4En6wgyPuXfrpwh8Bt8tJq9S5Czh8=; b=feBnu/RUWM87U+MLVnVaesIAh3
	1+Q5KBXp6i6VI51K2vOrHa100wGPYsUHhPXQdE/tGbGNR/Aicsm0PwFe+IovZtPsLu7OzHIoA6GFt
	ABzPWIdyLeXB+ZNiR2lxqhOMJkcIJXyvs+UteqPpk757ek8BzQSnNJR1cja3wn75Am+FfbR3szPn5
	+WbBM59P/+1MOuKF6OC+PnkvGIx9BDvnT0FtS2rhXfa1N32TdKJL13Ja0Cm9BEjTISumRbhv5iocK
	WrRSS6bgT/PeYRJphvnj2aUyiT6iXAB8lGo1X3gmeBedaIV8VAdvVS81hcXy7AetwEovUiqhTQP/f
	ZySXLsYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hAE-0000000FdC1-1ejY;
	Fri, 18 Apr 2025 08:33:34 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ggv-0000000FZ53-0wsS
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 08:03:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C0A8A294730;
	Fri, 18 Apr 2025 10:03:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iDRzz_rRKilZ; Fri, 18 Apr 2025 10:03:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 56781298566;
	Fri, 18 Apr 2025 10:03:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rvMd9rz47ZUS; Fri, 18 Apr 2025 10:03:05 +0200 (CEST)
Received: from anvil.corp.sigma-star.at (84-115-238-41.cable.dynamic.surfer.at [84.115.238.41])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id D388F294730;
	Fri, 18 Apr 2025 10:03:04 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	dlemoal@kernel.org,
	kbusch@kernel.org,
	kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de,
	upstream+nvme@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] nvmet: Fix out-of-bounds access in nvmet_enable_port
Date: Fri, 18 Apr 2025 10:02:50 +0200
Message-ID: <20250418080250.2736590-1-richard@nod.at>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_010317_418310_35CE28CC 
X-CRM114-Status: UNSURE (   9.10  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When trying to enable a port that has no transport configured yet,
nvmet_enable_port() uses NVMF_TRTYPE_MAX (255) to query the transports
array, causing an out-of-bounds access:

[  106.058694] BUG: KASAN: global-out-of-bounds in nvmet_enable_port+0x42=
/0x1da
[  106.058719] Read of size 8 at addr ffffffff89dafa58 by task ln/632
[...]
[  106.076026] nvmet: transport type 255 not supported

Since commit 200adac75888, NVMF_TRTYPE_MAX is the default state as config=
ured by
nvmet_ports_make().
Avoid this by checking for NVMF_TRTYPE_MAX before proceeding.

Fixes: 200adac75888 ("nvme: Add PCI transport type")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 71f8d06998d6..245475c43127 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -324,6 +324,9 @@ int nvmet_enable_port(struct nvmet_port *port)
=20
 	lockdep_assert_held(&nvmet_config_sem);
=20
+	if (port->disc_addr.trtype =3D=3D NVMF_TRTYPE_MAX)
+		return -EINVAL;
+
 	ops =3D nvmet_transports[port->disc_addr.trtype];
 	if (!ops) {
 		up_write(&nvmet_config_sem);
--=20
2.48.1


