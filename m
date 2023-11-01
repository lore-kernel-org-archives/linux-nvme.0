Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A8C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cuysv23fumWv7oWlO0yFGWHju6pHKifkDwuk8enBw3g=; b=dkv/Nv1fb/k5wd+27rvj1BMn1G
	wFtv15U1EB2pKKYWpzpWEEc5N9McUgQcUPscrtDC1HpI3wRwMQlATXYjl0XMbzWaL3beIANv+MUkX
	Npxo1HUFMxx7739P8LgV87ivyKyOOcnDwQDLgzHhewG0J/NtG1DnZGAEzYNn2NBROxmNv5GL+bLK4
	Q8GijPV/3lmOX1YEfZcgiQmAec0fv+uLyy8aVlwGkQZ2Xmyhe9a5FqrgBXnMqw3YyLuadpqhyOZrA
	TQMay0hEIgwwcXPSeYpv8kKctPSE+QJeJtlQgAlHFJsgwe9aJwoNljZwCThnCIGsKjSHXOFpTRWoK
	v9bfkQ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8Wc-007C96-1O;
	Wed, 01 Nov 2023 10:32:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8WX-007C7d-0R
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 10:32:37 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C7C02218A0;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698834749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cuysv23fumWv7oWlO0yFGWHju6pHKifkDwuk8enBw3g=;
	b=dANvCvGlz7vZWtQB4WW1PTdhGLFnLM9ntjP9bdirLf6Pt1OigMBh2snd6BJS1y9BG+k3EL
	yYb3Nd3LMvdqegsGCVpWh+rMMgg6O3Q9hTh97qzcgMurRAg5C8Gef9X7az3lEvuiXWwmis
	/3q3v31idSB16THSlhevp5OT9f2eFMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698834749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cuysv23fumWv7oWlO0yFGWHju6pHKifkDwuk8enBw3g=;
	b=EjPgNv/wf1xfBqrz8yqqL1Y48RvXkUX4+8bUQt2T3MzhBpPDm3WIGfTF8gWAj1hno32i/j
	BG0QnTK2yTbwjNCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 803412D018;
	Wed,  1 Nov 2023 10:32:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id B05DC51ECA07; Wed,  1 Nov 2023 11:32:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvmet: avoid circular locking warning
Date: Wed,  1 Nov 2023 11:32:26 +0100
Message-Id: <20231101103228.136570-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_033233_319706_F0FA4665 
X-CRM114-Status: UNSURE (   8.88  )
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

nvmet-rdma and nvmet-tcp trigger a circular locking warning when
tearing down; reason is a call to 'flush_workqueue' when creating
a new controller which tries to cover for the fact that old controller
instances might be in the process of tearing down.
However, this is pure speculation as we don't know (and don't check)
if there really _are_ controllers in shutdown.
And even if there were, that should be short-lived, and would have been
resolved by connecting just a tad later.
So this patch returns 'controller busy' if we really find ourselves in this
situation, allowing the caller to reconnect later.

Hannes Reinecke (2):
  nvmet-rdma: avoid circular locking dependency on install_queue()
  nvmet-tcp: avoid circular locking dependency on install_queue()

 drivers/nvme/target/rdma.c | 14 ++++++++++++--
 drivers/nvme/target/tcp.c  | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.35.3


