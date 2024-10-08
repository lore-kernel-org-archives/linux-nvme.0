Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB11CED255
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WrZ/RTOiFAX9QYuEHp2z1N5HW4ZCe7BTAYU2woeok4=; b=1gYAeJVy1l0sTJ8Eq6H0ED8LKO
	WmzrdT9hRanrQUWTO24e7Ie7UKA/BWgaYreqiwXxNqDLqGZms6hprQJ9hz+oIzPEhmfJrKSClzI2q
	ZkBgmQlMRzoF63BUZ1IvJQYIm9L1bqn2j2Rv4qMh5pa/7CzU/ZPrEHYbGJGLsgNLyo7BAUvHBaKKz
	4t1vE4xMjJX3wGFiN/StxQkUq5S9jIDqBtzwh6koNEcwpneru+CAco/YQUKY+sfQ6n8VvmBwGNsPF
	HuJ0Aal1gm459N/+VROsapC2ecQfHMif5S+ddcGlKVpcnbmHbTXZFV04exPhJqsGkINWriZTJjhVz
	srFU/aKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5GO-00000004wje-1bic;
	Tue, 08 Oct 2024 08:08:12 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5GL-00000004whT-2UMT
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 08:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728374886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3WrZ/RTOiFAX9QYuEHp2z1N5HW4ZCe7BTAYU2woeok4=;
	b=WbG0Gna5qpOuUVaNFQ1m6AFcgMpt7NHg7wTSID3ciZSSTKas1iwRUay2c+ZdvJ8Fv44n2pgCWfEX/iatan/+4m+IN20gbgRAU/Rvl+PSs+vUAY1yEjslD8xn8vQ/LSy8q+e762V4B3bCqE4dwPydWs9k1nbEiVJhUTej4+yw8WY=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGc3tt5_1728374880)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 16:08:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmetcli: reservation configuration support
Date: Tue,  8 Oct 2024 16:08:00 +0800
Message-ID: <20241008080800.7712-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_010809_793960_49A588CB 
X-CRM114-Status: UNSURE (   8.51  )
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

Add support for reservation configuration.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 nvmet/nvme.py | 2 +-
 nvmetcli      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..20b3cca 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -567,7 +567,7 @@ class Namespace(CFSNode):
             if nsid < 1 or nsid > self.MAX_NSID:
                 raise CFSError("NSID must be 1 to %d" % self.MAX_NSID)
 
-        self.attr_groups = ['device', 'ana']
+        self.attr_groups = ['device', 'ana', 'resv']
         self._subsystem = subsystem
         self._nsid = nsid
         self._path = "%s/namespaces/%d" % (self.subsystem.path, self.nsid)
diff --git a/nvmetcli b/nvmetcli
index d949891..6e5348f 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -283,6 +283,8 @@ class UINamespaceNode(UINode):
             info.append("nguid=" + ns_nguid)
         if self.cfnode.grpid != 0:
             info.append("grpid=" + str(self.cfnode.grpid))
+        resv_enable = self.cfnode.get_attr("resv", "enable")
+        info.append("resv_enable=" + str(resv_enable))
         info.append("enabled" if self.cfnode.get_enable() else "disabled")
         ns_enabled = self.cfnode.get_enable()
         return (", ".join(info), True if ns_enabled == 1 else ns_enabled)
-- 
2.43.0


