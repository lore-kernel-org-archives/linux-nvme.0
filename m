Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C0CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xPyVHMtOD256TRRiINOr0IX1chSdPtOcsAg7WIm+0lU=; b=Irj1PQtErEA0D5yrd3PMFZMUJH
	y6J+K+24VeixxBCGJBlSemQ/gBbCpXKTQDBKauaW1uRAA0eyEfSDvIb9qaZFS0faREe8NlMVpIJmz
	q7uTp0bLB6pJQ1gcqYFxkslBEW76cN6AQj5tmDsHW1kmEFmI3C1VARyJg4N6IZELAEMMnnkUKB+jn
	1DIbMdOcaNSaK/ElohRxETkt9iUqWUd+8nEqgkxVl8ahN57uqYSk4HFspJ3icqW+Uho41XUwHrxxY
	gDl4Mc4X48YDMIgJmQ7jbzrDdSFEUI9D0qLbW4kswVd1GTT+bJOC2+GJyS1My+ovJxQYZRikb5sxR
	+umflgzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzA9-0000000Fqj0-0gA4;
	Wed, 03 Apr 2024 11:52:17 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrzA6-0000000Fqhq-3JxS
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 11:52:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 122C2CE28DD;
	Wed,  3 Apr 2024 11:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4445CC433C7;
	Wed,  3 Apr 2024 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145127;
	bh=Va3xy/xjl82LKh2Fix5PiZeju49xdkhp5qJE1PbjZrc=;
	h=From:To:Cc:Subject:Date:From;
	b=cSB7mAbyHUbhcafOqR6B9LYJ6Rh2WxE4XcrAjEGS9CTPuYOC2T8z0crT25js9DqoH
	 gxhQSlEnT7Ru7K4r9FNXEWqoou8LIfB1mhgOfFaOCCcyLwc7SCU879KbagS5gsyMTr
	 41bjMZoI8ELwdT+SGQyGyav2ExTN3wEmByxoBCGrc6kzYx49gmh2/oeJZRu0XRr2Sc
	 qP4MSVW1tbaRYh6cpj/GmkYphjJMCEbJPxDaLcrE6Pv7I5XrAu6lIM8G84Y0MuDRX3
	 0BfuDh1o1XpS9AxCOI8igKRu+A1qDh47I9t9EHijz4fuLd4Gp9HSB6Poj7EqSCsMj+
	 3GoSnwrOBbyXg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvmetcli: Support unique discovery NQN
Date: Wed,  3 Apr 2024 13:51:56 +0200
Message-Id: <20240403115156.22244-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_045215_203671_B366056D 
X-CRM114-Status: GOOD (  10.73  )
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

If the configuration supports unique discovery NQNs we should be
able to view and modify it from nvmetcli.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 nvmet/nvme.py | 1 +
 nvmetcli      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..fc9c7fe 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -241,6 +241,7 @@ class Root(CFSNode):
             raise CFSError("%s does not exist.  Giving up." %
                            self.configfs_dir)
 
+        self.attr_groups = ['discovery']
         self._path = self.configfs_dir
         self._create_in_cfs('lookup')
 
diff --git a/nvmetcli b/nvmetcli
index d949891..3424e6e 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -94,6 +94,10 @@ class UINode(configshell.node.ConfigNode):
 
 
 class UIRootNode(UINode):
+    ui_desc_attr = {
+            'nqn': ('string', 'Unique discovery NQN')
+    }
+
     def __init__(self, shell):
         UINode.__init__(self, '/', parent=None, cfnode=nvme.Root(),
                         shell=shell)
@@ -116,6 +120,10 @@ class UIRootNode(UINode):
                 "Configuration restored, %d errors:\n%s" %
                 (len(errors), "\n".join(errors)))
 
+    def summary(self):
+        info = []
+        info.append("discovery=" + self.cfnode.get_attr("discovery","nqn"))
+        return (", ".join(info), True)
 
 class UISubsystemsNode(UINode):
     def __init__(self, parent):
-- 
2.35.3


