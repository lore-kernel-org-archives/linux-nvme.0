Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D886CA0EFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+QZRs4Hlo0FfQUMeo1qNtp6EUDUZ1+rfWssb9Byq5CA=; b=MbxaLkdVPaqtYS9vQZSfzsU0+M
	Id9SdQz0/Cfdk0tAKpPB7zgsN7NKyf67G71Y8NGaWhYHEUh9tviz+DZBRjciICt8k3z1Rgam6TJ7O
	dfieBRawVUcOJndCq+Ok3RgsndUQkNR1eh66dK7uAyLNz0QrDeC2xwuGYi+wOtAxZ4Ql6xAeBk2aJ
	JCsD9ARb7Xr2rF3kBDQ1oJ8qUgSelvVmJsMnW3Yyatt4EvviIk+t2166uVISm94gwZL1ERW9XQwOV
	xTsh0vUEDbOjh2bnG2ZVZHNXURGsl8jSuH60XUE/nBdvqx814uWHCO5mzrQ3XoGzPgJ3w/K4tUf+i
	UXGRre6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphjv-00000003wBH-1dvf;
	Sat, 23 Aug 2025 06:28:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upQMC-00000002P6q-1OgJ
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 11:54:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 78F5841B6B;
	Fri, 22 Aug 2025 11:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B7BC4CEED;
	Fri, 22 Aug 2025 11:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755863695;
	bh=pVmXxg6rJKZi9xByUQ/3EJXOYyEq0lgrwtPHYQt3n2c=;
	h=From:To:Cc:Subject:Date:From;
	b=GLji4G08OsvwptiH96a5X8pp87mrvu9tp87/QrXQft+0NtDkJ7HWD1PDli88MHfco
	 Fzq6Hbr1Uwdf2E9Fj06vf2PeSOwZVoTmR6384EIpMBcDRH7QJsirbLeZ1K/Fr3/A9W
	 NJ0b0xN/FFFhL4JPW2PHZDWxpfDUSdFZtCKDaJJTKZcLvc34sGBkRgGBPU/KZKJfDj
	 rPc5r4ueGavzDvMWPx5c99/LRAkCILfTz2hR6mF7w4G2MQZ7kVqr985UglI9jLkV+G
	 4bRQbmgaWMUoDHUVplQZC46zRt49z3fj7XydLw1HTCUkWBC/98HeGYU0g4aAeR24W6
	 DmgmJbxSoxvug==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH nvmetcli] 'discovery_nqn' configfs attribute
Date: Fri, 22 Aug 2025 13:54:49 +0200
Message-ID: <20250822115449.105656-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_045456_393268_DCB8D94C 
X-CRM114-Status: GOOD (  11.64  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement support for the 'discovery_nqn' configfs attribute to
allow the user to read or modify the persistent discovery NQN.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 nvmet/nvme.py | 1 +
 nvmetcli      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..5111db7 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -234,6 +234,7 @@ class Root(CFSNode):
     def __init__(self):
         super(Root, self).__init__()
 
+        self.attr_groups = ['discovery']
         if not os.path.isdir(self.configfs_dir):
             self._modprobe('nvmet')
 
diff --git a/nvmetcli b/nvmetcli
index d949891..9df6e89 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -94,10 +94,18 @@ class UINode(configshell.node.ConfigNode):
 
 
 class UIRootNode(UINode):
+    ui_desc_discovery = {
+        'nqn': ('string', 'Discovery NQN'),
+    }
     def __init__(self, shell):
         UINode.__init__(self, '/', parent=None, cfnode=nvme.Root(),
                         shell=shell)
 
+    def summary(self):
+        info = []
+        info.append("discovery=" + self.cfnode.get_attr("discovery", "nqn"))
+        return (", ".join(info), True)
+
     def refresh(self):
         self._children = set([])
         UISubsystemsNode(self)
-- 
2.43.0


