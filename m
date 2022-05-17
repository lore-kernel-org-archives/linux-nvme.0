Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FBDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yPe1Vi3azf0tUGntWeNFdqyehG9G2cDOH3n22pB6lIs=; b=SlePwENMpFdvL0qLzatRvcQDu9
	z/zoaipBH3Xm1O/WYClJsUiVM3/dD7RmGdTd2oaOiftY4deUf05bP5gOjVNTiERJ+hljFKMEZ0dYk
	rRX/6TtTg4tziIbJY9kqq6eCLPP6S9XsVT54Cmc5NucxGqzwOLXnMDKJ/eNYKh9COtO9NPPndiMAD
	rPxoYnQAfr8kIhq760oqLe4JzieY5ZFryFPqJ/z2pVsSNQ/j1zAGWeNRejW4HYO5BZNebOCBSJqgX
	MZqzd6vALTs6GxZTPmvxhH9+din86L6obX6JBj1/d0mFm3JSJNzChMQdBTJuQBSsyyI3qKO7kF49f
	4mamQxgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqqIW-00BlPe-Hc; Tue, 17 May 2022 06:03:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqqIT-00BlOx-TB
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:03:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 557D31F8DD;
 Tue, 17 May 2022 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652767384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yPe1Vi3azf0tUGntWeNFdqyehG9G2cDOH3n22pB6lIs=;
 b=xmlcnVKR8THNt1rzexr9YlrT+QK8IpsBnISdI9P2ov+KSd0hjmF+cn+lBCx3wwz7W6PRim
 pmXWxu79m5JMDuq+V9W94j+jLc9BACm9PZIX6BBwPq6r5j2Y7An9OGsamf8p6zn1OBMKFn
 OO8RdldSwYnxkgx8b9ZkorvaLqSdvR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652767384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yPe1Vi3azf0tUGntWeNFdqyehG9G2cDOH3n22pB6lIs=;
 b=yvTULCInBLjIWD08qD+Kua49pYTd/TnZzoSjt55s5cm+YBxKILF0s4j+zgSeYLDdg2XotO
 jdbYHOkaBicQgGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4600513AA2;
 Tue, 17 May 2022 06:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ig8REZg6g2J6UgAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 17 May 2022 06:03:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>, Arthur Shau <arthurshau@fb.com>,
 Wei Zhang <wzhang@fb.com>, Venkat Ramesh <venkatraghavan@fb.com>
Subject: [PATCH nvme-cli] ocp: Update license to GPL-2.0-or-later
Date: Tue, 17 May 2022 08:02:56 +0200
Message-Id: <20220517060256.6733-1-dwagner@suse.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_230306_127676_A0F47570 
X-CRM114-Status: GOOD (  12.05  )
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

When I reviewed the plugin I asked wrongly for GPL-2.0-only. The
project is using the GPL-2.0-or-later license. Relax the license
requirement to GPL-2.0-or-later.

Cc: Arthur Shau <arthurshau@fb.com>
Cc: Wei Zhang <wzhang@fb.com>
Cc: Venkat Ramesh <venkatraghavan@fb.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

Could I get a signed-off-by for this?

Thanks!
Daniel

 plugins/ocp/ocp-nvme.c | 2 +-
 plugins/ocp/ocp-nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/ocp/ocp-nvme.c b/plugins/ocp/ocp-nvme.c
index 1e7649b7d600..56cfdff9825f 100644
--- a/plugins/ocp/ocp-nvme.c
+++ b/plugins/ocp/ocp-nvme.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* Copyright (c) 2022 Meta Platforms, Inc.
  *
  * Authors: Arthur Shau <arthurshau@fb.com>,
diff --git a/plugins/ocp/ocp-nvme.h b/plugins/ocp/ocp-nvme.h
index 19378cdfcfdb..3e3f437aeaaf 100644
--- a/plugins/ocp/ocp-nvme.h
+++ b/plugins/ocp/ocp-nvme.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /* Copyright (c) 2022 Meta Platforms, Inc.
  *
  * Authors: Arthur Shau <arthurshau@fb.com>,
-- 
2.36.0


