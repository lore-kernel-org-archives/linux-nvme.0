Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577F9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mS6/Tcuovh1DTl7EiuuMIiUrz60RAvvOmID72sZnMiA=; b=0oe9CojXHeUeTYhZigbco6UyG2
	b6sIKjxAPWenBq1xwgic5oGBDto+zvZL+eZZDd0bNJS1SBOT95W02tfMnmW+D4j9FsQUp9Hzlpcb2
	Lgm9Tknwj6UeaAN1FMnP6SHgohnB4bfV/E71uq0Ea71YT3DG+Sz/IFGNBkKePMKMQXDzQYhM6Fmho
	pnNWWmSLYNKbqevmGY7fjd6nw9s4duAJsQ3IcoawiJO+eqF4qX+o6FpaCoxkrqJ93LXExGduPfrrX
	8rEfsAvdnS/u5GIxLIp05uT1YZ1Snho7BPrP4vsTWg0y8fjqdO1b4jFSUltdqA3eak1hgBeMtSVQH
	EePedJ+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqqU2-00BmZH-P4; Tue, 17 May 2022 06:15:02 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqqU0-00BmYR-8O
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:15:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4ACC2209C;
 Tue, 17 May 2022 06:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652768098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mS6/Tcuovh1DTl7EiuuMIiUrz60RAvvOmID72sZnMiA=;
 b=KG5CYqZww1GjqPoKbZLHdK/cFTnI7LWeXbvtezkBVPIdEVYFb4tkse9JyTG/Xo1pUwMA6r
 P6wiFHs3Jqcxi0EJ9gUpkfwp1OGuszO69Cac+NVmBUHXpQ+e4Or7Z+/i2LTYmcjdVWi4lf
 ywmZESycXSdqc2MLr8+eMrx8amcxSJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652768098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mS6/Tcuovh1DTl7EiuuMIiUrz60RAvvOmID72sZnMiA=;
 b=BDMyCejNJW7G6vTOXiywzkVXqeAWRVxJsrqG71NGQaX6hqAmeGAUYGC1wjNHbWPujJMztK
 CqUZuSefjuIPKUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95AE513AA2;
 Tue, 17 May 2022 06:14:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2h1kJGI9g2KuVgAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 17 May 2022 06:14:58 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Arunpandian J <apj.arun@samsung.com>
Subject: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Date: Tue, 17 May 2022 08:14:56 +0200
Message-Id: <20220517061456.7623-1-dwagner@suse.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_231500_480923_DF136022 
X-CRM114-Status: GOOD (  12.27  )
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

When I reviewed the tests I asked wrongly for GPL-2.0-only. The
project is using the GPL-2.0-or-later license. Relax the license
requirement to GPL-2.0-or-later.

Cc: Arunpandian J <apj.arun@samsung.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi Arunpandian,

Sorry for the mess, but could I get a signed-off-by from you?

Thanks,
Daniel

 tests/nvme_copy_test.py           | 2 +-
 tests/nvme_dsm_test.py            | 2 +-
 tests/nvme_get_lba_status_test.py | 2 +-
 tests/nvme_lba_status_log_test.py | 2 +-
 tests/nvme_verify_test.py         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/nvme_copy_test.py b/tests/nvme_copy_test.py
index 8bee55584e0c..7cb087e27ef6 100644
--- a/tests/nvme_copy_test.py
+++ b/tests/nvme_copy_test.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # This file is part of nvme-cli
 #
diff --git a/tests/nvme_dsm_test.py b/tests/nvme_dsm_test.py
index fe3dc01f6a8d..51f35ecec0a3 100644
--- a/tests/nvme_dsm_test.py
+++ b/tests/nvme_dsm_test.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # This file is part of nvme-cli
 #
diff --git a/tests/nvme_get_lba_status_test.py b/tests/nvme_get_lba_status_test.py
index 5f970c487478..7ce8d33b829d 100644
--- a/tests/nvme_get_lba_status_test.py
+++ b/tests/nvme_get_lba_status_test.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # This file is part of nvme-cli
 #
diff --git a/tests/nvme_lba_status_log_test.py b/tests/nvme_lba_status_log_test.py
index ecc3fce8bff2..8420adf4e5b9 100644
--- a/tests/nvme_lba_status_log_test.py
+++ b/tests/nvme_lba_status_log_test.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # This file is part of nvme-cli
 #
diff --git a/tests/nvme_verify_test.py b/tests/nvme_verify_test.py
index c783d5de07a5..19559c028c8a 100644
--- a/tests/nvme_verify_test.py
+++ b/tests/nvme_verify_test.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # This file is part of nvme-cli
 #
-- 
2.36.0


