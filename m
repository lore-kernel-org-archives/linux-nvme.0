Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEB5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vW+ITDeJRiq+ks97F/GPKwS6DK9wLl+BvDB7oOXnvFM=; b=TKOr04lpwIXX/QoSH/KEqGLiix
	D4e95GYxjPRCAshMqSLbaiMQsJE7lBJAPg413L5EbC43JXtDJr48hKx1r1E/BQZwPh4SnXG7xSyOW
	1a0f3Ey1DEDa5B3Sg2xtqEYpheBMdbOr7anF3G1asZgVsKbFFD5+u8n/ftXYKitPQkasgTw+oR2Uf
	1Acms9zRCzxMdAxVmLyzfGhdpItAKVmGOApgZr6p4bgPWOmoyb21TvzsEU2RIXjUCfhMRFNYiLpvT
	Gj8JEv0MQJK+yb6L5e4mxMNfQYJtL9yenBEWPyMrMO2s5s80PH3Ab7Zx1faHqsIC2DP6L7SR1khOV
	aWMJm37Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWvUj-00D0KH-Bk; Wed, 23 Mar 2022 07:33:25 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWvUf-00D0JW-W6
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 07:33:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B527D1F387;
 Wed, 23 Mar 2022 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648020800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vW+ITDeJRiq+ks97F/GPKwS6DK9wLl+BvDB7oOXnvFM=;
 b=dBdsgl/HSdna+njahsOyz8LMWom51wihjI37sZhdHLhbTDdL2ZiKitH3l+RgtOncwewrpO
 cJ0sIr5EQFId+VXIL4z4+w/LJcIGiVkJtNtcAzBZilPXwwAw5yYO0TCNECde7ks8wS5jo1
 o1XWubVWkBSGmPG3RL3jkheNvg3qjdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648020800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vW+ITDeJRiq+ks97F/GPKwS6DK9wLl+BvDB7oOXnvFM=;
 b=jC0lT1VbahySd9d/BXJBKDOBIp9kPDVBtoyr0bELsZsVbYRVE0jnupJ8CjMtHM34l5BSKG
 yOFXoGoYvGIGpiDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 89244A3B8A;
 Wed, 23 Mar 2022 07:33:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7BC605193892; Wed, 23 Mar 2022 08:33:20 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmetcli: support 'dhchap' attribute group
Date: Wed, 23 Mar 2022 08:33:16 +0100
Message-Id: <20220323073316.15862-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_003322_206352_10C389CE 
X-CRM114-Status: GOOD (  10.17  )
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

NVMe authentication support added a new attribute group 'dhchap'
to the host configfs directories. This patch adds functions to
display and modify these entries from nvmetcli.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmet/nvme.py | 2 ++
 nvmetcli      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index d170204..2ad9006 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -892,6 +892,7 @@ class Host(CFSNode):
         '''
         super(Host, self).__init__()
 
+        self.attr_groups = ['dhchap']
         self.nqn = nqn
         self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
         self._create_in_cfs(mode)
@@ -913,6 +914,7 @@ class Host(CFSNode):
         except CFSError as e:
             err_func("Could not create Host object: %s" % e)
             return
+        h._setup_attrs(t, err_func)
 
     def dump(self):
         d = super(Host, self).dump()
diff --git a/nvmetcli b/nvmetcli
index 8ee8590..8da379b 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -661,6 +661,10 @@ class UIHostNode(UINode):
     def __init__(self, parent, cfnode):
         UINode.__init__(self, cfnode.nqn, parent, cfnode)
 
+    def summary(self):
+        info = []
+        info.append("key=" + self.cfnode.get_attr("dhchap", "key"))
+        return (", ".join(info), True)
 
 def usage():
     print("syntax: %s save [file_to_save_to]" % sys.argv[0])
-- 
2.29.2


