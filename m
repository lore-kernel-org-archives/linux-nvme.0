Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F6DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bd1mHXcixZh1SwuU4MlNN9k7vqfY8cSiB7+V6+EhsLk=; b=RRNP7t1znMpQ8YSf87kplDhpAB
	5Zf8oxz+0OOpW4IMi4w9oyUxz0GzsDr+dp9cTY/l/x2Es8G5beBnim/W0STsyhx5gnezos3F9nt9k
	+TozovG6Wf/mdIYDfeEXZv9q3VcHKT6b3+PEuevJ823U5C8tjwML/uEv0v4HgVIZTd7ert3s/sa8I
	A0Dh9d8qprUvbTvHcpyhj0i8IR4WxzaGVj04PJDvgUBV6/n2QZUQVEmmOe/D3rbqF0xVTgZWDnr9/
	EhmK9xLbquouViL8zF1ClYN10eFuTTfN+ENjVLd3hWQ4nLFeHJE849gltK7aAWXCq1Bgk/FGA7kcW
	MLc25AXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc6YG-006TTk-20; Wed, 06 Apr 2022 14:22:28 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc6Y6-006TO9-Qe
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 14:22:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7D25A21122;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649254935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Bd1mHXcixZh1SwuU4MlNN9k7vqfY8cSiB7+V6+EhsLk=;
 b=xW0O9lZZyNj7Cq+EwyrKxSe76qfEF56rdq1T/SG7OsQYsH403Dedb3jwVpNPI2dIIbDEjb
 wQtXS632LO939AFvgyh1VrgzCwe/PN4SfIfTUlZCRiuHRhG66fSrpRkQ7AvdZum7ySoOTo
 GmNjNBjTwFEJj++61XOnD6GoEzXwYN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649254935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Bd1mHXcixZh1SwuU4MlNN9k7vqfY8cSiB7+V6+EhsLk=;
 b=BP24gBBBg/B/s+YCThTnZpCZKiMjbzq1kpMUsAy8QDIFrShIpN3GPRM43WsOjXvsiDY1Er
 1PFS/tIsmZt7JmAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 75AA3A3B83;
 Wed,  6 Apr 2022 14:22:15 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 62F105193BAA; Wed,  6 Apr 2022 16:22:15 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/3] nvmet: unique discovery subsystem
Date: Wed,  6 Apr 2022 16:22:07 +0200
Message-Id: <20220406142210.71248-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_072219_093691_E0F3C923 
X-CRM114-Status: GOOD (  14.77  )
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

Hi all,

here's my third attempt to support unique discovery subsystems, heavily
modified from the previous two attempts.

The main idea is to not create the discovery subsystem per default, but
rather require the admin to create one.
As this is an incompatible change I've added a module parameter
'expose_discovery_subsys' to switch to the new behaviour.
The admin then need to configure the subsystem as normal by linking
it into the ports where the discovery subsystem should be visible.
And the discovery log then includes all configured ports to all
configured subsystems, as usual modified by whether the host may
access this subsystem or not.

Currently, there is no restriction on the number of discovery subsystems;
technically one can create any number of them. But this is primarily
because I'm too lazy to check (and we don't have a global enumeration for
subsystems) and not due to a design decision.

As usual, comments and reviews are welcome.

Changes to v2:
- Heavily rework after discussion on the mailing list

Changes to the original submission:
- Include all subsystems in the discovery log output

Hannes Reinecke (3):
  nvmet: make the subsystem type configurable
  nvmet: expose discovery subsystems
  nvmet: include all configured port in the discovery log page

 drivers/nvme/target/configfs.c  |  80 ++++++++++++++++++-
 drivers/nvme/target/core.c      |  19 ++++-
 drivers/nvme/target/discovery.c | 133 ++++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h     |   2 +
 4 files changed, 205 insertions(+), 29 deletions(-)

-- 
2.29.2


