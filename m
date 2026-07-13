Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC11C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 10:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vsIiP014dpiBHxdi1djvvsF06kHQ9BuwxD4utiVOcAo=; b=pR+98rJKMhoXPSGQZPBuX4Q0o8
	+0+Vevxm/0l0U9T2nn6ebSdgY14TVvaoUVjFbND6yZUZhFXfsoJPYXzpS6pGyMt0Ihjic+7eMC0Ra
	KouG1Mvs9egiasjKgC/8GwZ9OI8n1m6QL2Q6adIgudRUJe1pWStfQY486uo+MNjGVX0nDtIT2ddi/
	KdZge/IRNSTDewpjnaKuxfZbDlBl5QXzrl4KF5znPYjfTfIkcRk3M+RXv/W0X0QK5pLufTgOfzyOR
	WalHP7Ui3qbYADpP8IB9l2alAsdgeLn+H7IV003G0U0XPxh55ToiNF24OPUvzMpKdGLOI/s5JtnXw
	KhqAX6HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjEBp-00000008vPb-3Vfy;
	Mon, 13 Jul 2026 10:47:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjEBo-00000008vPV-1JXz
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 10:47:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BD90841777;
	Mon, 13 Jul 2026 10:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4E41F000E9;
	Mon, 13 Jul 2026 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783939627;
	bh=vsIiP014dpiBHxdi1djvvsF06kHQ9BuwxD4utiVOcAo=;
	h=From:To:Cc:Subject:Date;
	b=QL+WB6QYPRxyrqq+jPPJXzG+EwrSlQXjOLEpBbfoHYg68ob20llz06j5LrgSNr7F1
	 fQsgdSezqHZ0pQnoVrZ6QUcKvN6zPoBzPWMnetsL5J2PiuAa8oRwe2qJ9fNdBPdl4R
	 Iq65wc1xYERWKsPfLgnidVxPJHQ3o342RI32RxocFa3Dpns6LK7MQfJq1R0+5rxqa4
	 lj4rAT36fRhNSPfkedHTtzUloG+ka5BbR2cuatZsxcHPbJ8eWcV+AGDO+BvleY3nSF
	 bu1ngrYL86D2gacDY/x1uq5+sqcNRO6G0PQeex8UFWe0yM0GAVPSo51rMtELpnemrl
	 /MarfOT3Vu8NA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <wagi@kernel.org>,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmetcli: store DHCHAP attributes
Date: Mon, 13 Jul 2026 12:46:57 +0200
Message-ID: <20260713104657.121217-1-hare@kernel.org>
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

From: Hannes Reinecke <hare@suse.de>

The DHCHAP authentication is stored under hosts/, and are starting
with 'dhchap_'. So add a 'dhchap' attribute group for the host object
to correctly save and restore DHCHAP values.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmet/nvme.py | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.51.0


