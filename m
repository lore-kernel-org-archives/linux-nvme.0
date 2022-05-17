Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C71FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=duXx5R7xGLK9hmiiFqB9oALYMaAMVDU6x7hPRQ0drhA=; b=Eg9HbRzY85eqHhrZNxGWNwl9ly
	6p+YXnbtbsDZo80fJFrhdNpfCcRTNFNieUuHI5y0oL0h2vjgK6yPunbQYEF84OiB3gD80S5893x+4
	1mM3lKR61jua3u5At2kdz6M5+76uSwPjnnu55W1m9JLm5dpfIwZPfRPAU2uchUmyM8kwKGbcX+ywa
	l/0U+40YZqNPMQd5EtMuP0FXM/GLNCXIvkATL5TKMmN/RT3IW8Nvr8FMHqgs+QguDJWMollmOnO0G
	Z30YqGWScSpi4gLyZc6ysN3AWnutqTCFZoHxeIQ5Gd3wRwn2d3Qj/0e+c9TlAkAXQcDHsFIWDgQSw
	aJbFAquA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqqgo-00Bo1y-LW; Tue, 17 May 2022 06:28:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqqgl-00Bo1Y-JU
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:28:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30B06220BD;
 Tue, 17 May 2022 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652768890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=duXx5R7xGLK9hmiiFqB9oALYMaAMVDU6x7hPRQ0drhA=;
 b=sFD9c+oB/3pwPmhWhM1w2AUoFGh3AsBS5L0tf0zqp/oPMqR/EO41/4xqkRtt399F2QThd0
 ndU/Z9VMXA4l3f3NI1vK0laVaVKDQ5vUZn4RaIsVlaHSHyqNhDQL2N/lh/pIMpFyDD3BVH
 iX6s0oAEyXTWOx5V0ri44fTp9w89cp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652768890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=duXx5R7xGLK9hmiiFqB9oALYMaAMVDU6x7hPRQ0drhA=;
 b=pEILuG5DenbJu9yqgK2Q9kVuqr+FQwDtEJr8+V3MrxqJWAYyackDuKeTNF9mD15ZpWax/N
 Fgm5IPujgZqt1hAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22F3213AA2;
 Tue, 17 May 2022 06:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UnBeCHpAg2ICWwAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 17 May 2022 06:28:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hanumanthu H <hanumanthuh@micron.com>
Subject: [PATCH] nvme-rpmb: Update license to GPL-2.0-or-later
Date: Tue, 17 May 2022 08:28:06 +0200
Message-Id: <20220517062806.9448-1-dwagner@suse.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_232811_826966_719E7530 
X-CRM114-Status: GOOD (  11.54  )
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

The project is using the GPL-2.0-or-later license. Relax the license
requirement to GPL-2.0-or-later.

Cc: Hanumanthu H <hanumanthuh@micron.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi Hanumanthu,

Would you mind to singed-off-by this change?

Thanks,
Daniel

 nvme-rpmb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/nvme-rpmb.c b/nvme-rpmb.c
index 1ae262af95a5..8f6e6a0fa3b2 100644
--- a/nvme-rpmb.c
+++ b/nvme-rpmb.c
@@ -1,9 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2020 Micron Techology Inc. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.36.0


