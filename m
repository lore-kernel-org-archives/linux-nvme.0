Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD30CA0FE8
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VHxMTzkUIbVKikrJQNkkoHKirdFIyvt72cMWjr910fk=; b=Ebu8vew0chlr1XMT5YX9BnZav+
	hFLoroJNMDlkay0xJ2qJ40Ww271Au3jFfZnbgiuB6nPQV/5bJlC5NKxHX2qfeeX1aENjMWyXrMAfT
	D7djelgiOxq9iZOfS6d1VzceQvbQehuS0gQLJJPpRF8GIDBNbBXvCcgVtT+lg3q1s+VafzUd4zE+r
	DFIRe/rRny+XyaFrWG0bT5z51kifWuSPAFGmV0BmXwLHwAkTVYFoT84FOQNQwTYpvmmb8IZYmvvPL
	jkl185BCDuF4u5nP+l/vIObIozJJFOA4uBbIXu6HZ5sFFnvqXLh7iuiiCKwty1hok0fW5PSP3773w
	1okUPyqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphju-00000003w6H-23jR;
	Sat, 23 Aug 2025 06:28:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upQJP-00000002Oue-06Nf
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 11:52:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 72A5C60266;
	Fri, 22 Aug 2025 11:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC788C4CEED;
	Fri, 22 Aug 2025 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755863522;
	bh=DxAac59FWG7hW/TIqZp9FxyCyzPNoi04gg2Ox1GK6Jc=;
	h=From:To:Cc:Subject:Date:From;
	b=vGmYHmQoMaRqCpgRZZFuYH75ZtSD2OLozaJGKDpvxOHE8LxGW+nhDKwYbMkJIxrY3
	 3hENZgOSA84TYUNJFpFWOS64Dj2edt6qrpLEwVyEQqpZJqIIm6tNKRti37jzJJm2H6
	 uer59C5pw9Z0GmEMuE1WDXEVjToCW4L0QTtWhV7jpPKHWhvhkz2A7e9KG2oDiQmpSa
	 HI7xaPVet78WqxY/AEv+q2453PSRiMBxUJzJBYQvis08rA3EcON7Ng2MjmunGsDVME
	 W7Fwh0FP08Hpsus3UKpZQaINnvDbBWTGoS0a998NZ7Tvl6Gh6Q+aZ032JLVO34Xmib
	 AMjROKU2th0WA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH nvmetcli] nvmet: store DHCHAP attributes
Date: Fri, 22 Aug 2025 13:51:55 +0200
Message-ID: <20250822115155.95097-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Hannes Reinecke <hare@kernel.org>

The DHCHAP authentication is stored under hosts/, and are starting
with 'dhchap_'. So add a 'dhchap' attribute group for the host object
to correctly save and restore DHCHAP values.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 nvmet/nvme.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5..679116e 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -892,6 +892,7 @@ class Host(CFSNode):
         '''
         super(Host, self).__init__()
 
+        self.attr_groups = ['dhchap']
         self.nqn = nqn
         self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
         self._create_in_cfs(mode)
-- 
2.43.0


