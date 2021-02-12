Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B41C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B1264E3B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B1264E3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M8mecCR9noT30xzPG71QB7apAPLuMJb1emeFxShlP0I=; b=Aim5OIDtE+KJBUW0H1K1gwyTq
	uyQm7fMfn1sosngdDJoAnh63++v0ccoebazAloF5oVfF88a/1x3bc9TmnOD7yv7s4NFbzQdw7180C
	fiw4/ioA78NURwTA7RhXca370zMeSeMDPOpBmHUjp1tXmUhiWTVCRqmuXrby0bKLNehXHQhpXJSap
	9Cued6qvuBbrM0R/38JarqWPtX5Mj2k5Rp3B++qbdcpQKs7kKuGzp6gi8bNt+Qw3u/h35RDwuYj6O
	Ru9tjL6D0azDWgmkhCmZXiPvIlWaSttzVpkW0SmQLhqX8Vm7FumbapK5LWUJ6nf8aNsXvjc3PC+8V
	5LbKg3mGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAakL-00070M-HG; Fri, 12 Feb 2021 15:52:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAakH-0006yQ-Oa
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 15:52:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BA524B775;
 Fri, 12 Feb 2021 15:52:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] nvmetcli: add 'merge' parameter to set_config()
Date: Fri, 12 Feb 2021 16:52:27 +0100
Message-Id: <20210212155229.98816-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212155229.98816-1-hare@suse.de>
References: <20210212155229.98816-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_105237_948802_8EA07A4E 
X-CRM114-Status: GOOD (  14.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Daniel Wagner <dwagner@suse.de>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a parameter 'merge' to set_config() to allow for merge a given
configuration with the existing one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmet/nvme.py | 8 +++++---
 nvmetcli      | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 83fd75b..22aef5a 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -331,17 +331,19 @@ class Root(CFSNode):
         for h in self.hosts:
             h.delete()
 
-    def restore(self, config, clear_existing=False, abort_on_error=False):
+    def restore(self, config, clear_existing=False, abort_on_error=False, merge=False):
         '''
         Takes a dict generated by dump() and reconfigures the target to match.
         Returns list of non-fatal errors that were encountered.
         Will refuse to restore over an existing configuration unless
-        clear_existing is True.
+        clear_existing or merge is True. If clear_existing is True the
+        existing configuration will be cleared. If merge is True the
+        given configuration will be attempted to be merged.
         '''
         if clear_existing:
             self.clear_existing()
         else:
-            if any(self.subsystems):
+            if any(self.subsystems) and not merge:
                 raise CFSError("subsystems present, not restoring")
 
         errors = []
diff --git a/nvmetcli b/nvmetcli
index 8ee8590..f2b59bb 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -104,11 +104,11 @@ class UIRootNode(UINode):
         UIPortsNode(self)
         UIHostsNode(self)
 
-    def ui_command_restoreconfig(self, savefile=None, clear_existing=False):
+    def ui_command_restoreconfig(self, savefile=None, clear_existing=False, merge=False):
         '''
         Restores configuration from a file.
         '''
-        errors = self.cfnode.restore_from_file(savefile, clear_existing)
+        errors = self.cfnode.restore_from_file(savefile, clear_existing, merge)
         self.refresh()
 
         if errors:
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
