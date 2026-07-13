Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6670C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7nKmdJsZXj3PQNWY4N5hkaiukT/lD+jmSZiBy2imvhw=; b=LG+krY9fr6VWqliMaBdzs6HD87
	Zo0NdYRZcYL2SzwJna9e/sf1ldokKYSTTSowaJZd2o0u+Bcl48a50dr4pdgBtFX9qAcVoSqi6ng9F
	YmYuhIiqV4WVCOQdgJbDzBjiQXjNa98t+tOWNCPI52RcD1Hem2VsMslzKEYVYpRL0WHmBTkCLUoVX
	OhWo4Ng55hqovRLVoH5iVYmcSIzlWEZRpzPuiu/DBlE+yYxVJtD7fNHGnoLR3De1Ba33A1VWJ/N5C
	hJtDm2YNwEpfw2zYUSTNyFvXnQSZ+Clm4/Q6UZHn9MKlfj21ydSf4RJbqyM7TQ8tn/i5YYmNyx4KI
	8zgNO0bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjH68-00000009ScV-2mrj;
	Mon, 13 Jul 2026 13:53:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjH66-00000009SbK-1sRE
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 13:53:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBE8960120;
	Mon, 13 Jul 2026 13:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077B51F000E9;
	Mon, 13 Jul 2026 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950805;
	bh=7nKmdJsZXj3PQNWY4N5hkaiukT/lD+jmSZiBy2imvhw=;
	h=From:To:Cc:Subject:Date;
	b=XqGxzhxOHVCN1NMQtmKPGM+6eFnyiBevLacxYJN2VvwJqBzLwhyHXOZBIQ5As+qr9
	 qRPEVe9mGRjUG2l9SlBUH93Qp60rwt7cTX5rx9HfbS/jE8O0ZCefB85j4ds8dRk7pm
	 GBOPe9UoOu9ir18SJhC+uk/roViSiU4e26mGx7u/bL75uWoLB3rvGdu1LE2CvVKiYv
	 81nWK1aJ6qJW5L/wyLaTAWIkloHfumNxHxXclLTx5cwgfOixszrQHkqnO9cHR5xk15
	 jVBzPkuumiVBTEdin/MsgvGvNr7oZvwb7RMWtM41GiwrrUV/mqcREOS6kA8vn0owS2
	 m4/tJCZQqcz2w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2] nvmetcli: store DHCHAP attributes
Date: Mon, 13 Jul 2026 15:53:18 +0200
Message-ID: <20260713135318.125238-1-hare@kernel.org>
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

The DHCHAP authentication is stored under hosts/, and are starting
with 'dhchap_'. So add a 'dhchap' attribute group for the host object
to correctly save and restore DHCHAP values.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 nvmet/nvme.py       | 1 +
 nvmet/test_nvmet.py | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index faf1eb2..80d3953 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -1013,6 +1013,7 @@ class Host(CFSNode):
         '''
         super(Host, self).__init__()
 
+        self.attr_groups = ['dhchap']
         self.nqn = nqn
         self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
         self._create_in_cfs(mode)
diff --git a/nvmet/test_nvmet.py b/nvmet/test_nvmet.py
index 13e2f6c..086d7bc 100644
--- a/nvmet/test_nvmet.py
+++ b/nvmet/test_nvmet.py
@@ -426,6 +426,7 @@ class TestNvmet(unittest.TestCase):
         root.clear_existing()
 
         h = nvme.Host(nqn='hostnqn', mode='create')
+        h.set_attr('dhgroup','ffdhe2048')
 
         s = nvme.Subsystem(nqn='testnqn', mode='create')
         s.add_allowed_host(nqn='hostnqn')
@@ -475,6 +476,7 @@ class TestNvmet(unittest.TestCase):
         self.assertEqual(n.get_attr('device', 'path'), NVMET_TEST_DEVICES[0])
         self.assertEqual(n.get_attr('device', 'nguid'), nguid)
 
+        self.assertEqual(h.get_attr('dhchap', 'dhgroup'), 'ffdhe2048')
         self.assertEqual(p.get_attr('addr', 'trtype'), 'loop')
         self.assertEqual(p.get_attr('addr', 'adrfam'), 'ipv4')
         self.assertEqual(p.get_attr('addr', 'traddr'), '192.168.0.1')
-- 
2.51.0


