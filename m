Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C7AC44507
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mrlKzFTfv/+m66dDVgOOeUrH860KZnSXvWz00SqWw44=; b=BYODnCZGRdBgF8eHMBL60lgT2P
	ds/53coQFuh623qksN2+ozvTcHHqNg5AQW42FPaLCChucjASzHGYUXQLX1cn3yU77gPeHn6+9tRFL
	NyzJ/3MDEfBNxrdfb9m5hDA65E6YMiAFA2es1ruigqnmCo28PXCK4tFGwm+APXCX9TkPmafWUPplh
	kT2bfSiHVClcC/lMbA3FaHET8g7hxUz26S5gumWBE8d6eW6P/XYWHYiHh6xpSSsBS5cgHobpE5vvS
	/iWTgTxXt/08JjrKlXy8Unqaiqp8B+hs2/cxw1oMmiXxC04ACqwxyVBK3unnjpGppZjFePga2MGuX
	TQbrffMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjvaf-0000000EGYa-41l6;
	Wed, 15 Jul 2026 09:07:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjvaf-0000000EGYR-1D5g
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 09:07:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 845FD600BB;
	Wed, 15 Jul 2026 09:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B21F00A3A;
	Wed, 15 Jul 2026 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106460;
	bh=mrlKzFTfv/+m66dDVgOOeUrH860KZnSXvWz00SqWw44=;
	h=From:To:Cc:Subject:Date;
	b=l07mtu8SC12hFt1JUvZipx5uQlJDKdnlhzLd2mJEU7OAbl3u+eyS+WhblWOHuLuEN
	 HQrJF4tjtEzqq7IANlxdP0mpfG/UHzp56LRz+efHUnj1fSGmz+QJflLVosGgy5Aza7
	 gqe8tr0jJ/qyXH5TMbLD6hX3wWMWB5fqwhfmwLHOBo2B75LADcr1wrGbqsr8RkhukJ
	 eqUiDMdWcqlIo5r9ji4gofoLDyN9X5KiDxdDJSiYUonQHv8PGJkqKQZVnpTayMpLuh
	 y74h68dwmzZ7/7g+otR5QMh/jy0mcJdRl+u8tkM+9r+fAPLXeIrj32cUBdS6Lfxu05
	 BJHZwRQfGF+3Q==
From: Hannes Reinecke <hare@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3] nvmetcli: store DHCHAP attributes
Date: Wed, 15 Jul 2026 11:07:33 +0200
Message-ID: <20260715090733.94695-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DHCHAP authentication attributes is stored under hosts/, and starting
with 'dhchap_'. So add a 'dhchap' attribute group for the host object
to correctly save and restore DHCHAP values.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 nvmet/nvme.py       | 2 ++
 nvmet/test_nvmet.py | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index faf1eb2..a9b78df 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -1013,6 +1013,7 @@ class Host(CFSNode):
         '''
         super(Host, self).__init__()
 
+        self.attr_groups = ['dhchap']
         self.nqn = nqn
         self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
         self._create_in_cfs(mode)
@@ -1034,6 +1035,7 @@ class Host(CFSNode):
         except CFSError as e:
             err_func("Could not create Host object: %s" % e)
             return
+        h._setup_attrs(t, err_func)
 
     def dump(self):
         d = super(Host, self).dump()
diff --git a/nvmet/test_nvmet.py b/nvmet/test_nvmet.py
index 13e2f6c..1d1c592 100644
--- a/nvmet/test_nvmet.py
+++ b/nvmet/test_nvmet.py
@@ -426,6 +426,7 @@ class TestNvmet(unittest.TestCase):
         root.clear_existing()
 
         h = nvme.Host(nqn='hostnqn', mode='create')
+        h.set_attr('dhchap','dhgroup','ffdhe2048')
 
         s = nvme.Subsystem(nqn='testnqn', mode='create')
         s.add_allowed_host(nqn='hostnqn')
@@ -475,6 +476,8 @@ class TestNvmet(unittest.TestCase):
         self.assertEqual(n.get_attr('device', 'path'), NVMET_TEST_DEVICES[0])
         self.assertEqual(n.get_attr('device', 'nguid'), nguid)
 
+        self.assertEqual(h.get_attr('dhchap', 'dhgroup'), 'ffdhe2048')
+
         self.assertEqual(p.get_attr('addr', 'trtype'), 'loop')
         self.assertEqual(p.get_attr('addr', 'adrfam'), 'ipv4')
         self.assertEqual(p.get_attr('addr', 'traddr'), '192.168.0.1')
-- 
2.51.0


