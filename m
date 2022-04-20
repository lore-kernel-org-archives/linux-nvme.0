Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C137FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xutcKhJGrUKjXU6tIOPfF6g1DOBFkMP0qad5Ii+qTaU=; b=XB844GMVKlJBaOf9VjamyZYbGV
	awTl0/zd2swhSNBI9c0r6Y88dybswbLeumriCY660gSOZe5ZZb4RDEUntOQW61ZlCst6wYA07gYU5
	ucaXPC5USbu4RtKHzKrGws4RjzM4MCf0uWWtA+Nhw9IYeIcnBzXQsI3wybWKKIr7drdNF0EHUF5/I
	eJt4i3RPadRXOwTVQNaPGejnc3zZt9AnzDtz3f7QMD4eRBEL77Yn43wGfZbj/k/wiAXRFyT5UR5PL
	sB8qasmvb3kWlQW+0NcgEGqoOS1IXJDEFBDe9JFQTtfXtc1//66BEUZqREd6/EmRd5iEUfQhK2ocM
	PfThO4ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh6cl-008KNf-9K; Wed, 20 Apr 2022 09:27:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh6ch-008KJu-Cv
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 09:27:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8AA851F74E;
 Wed, 20 Apr 2022 09:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650446858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xutcKhJGrUKjXU6tIOPfF6g1DOBFkMP0qad5Ii+qTaU=;
 b=HaQJ7D7n2DBIilz086y/vxSOcy/bdImzJrsvM8bI6j1BCKa4kKR0cnAqMFZLa2tlwLeJEq
 edBpz++/bw+FN2PB7SrmqF8KPeVB8DClMjFOS9IojSokQ6wAW7L1jdtxwqOkH83d7uWy9i
 nFDHw2XMbPNKR0ozDI0pWXiFowa7o/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650446858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xutcKhJGrUKjXU6tIOPfF6g1DOBFkMP0qad5Ii+qTaU=;
 b=OC3p76DoZfYwcGJBpRL5dvhfea0gCZxSBwp9ZZNLJ/X5bfpS6rwYYHkmyD3yui3QcxVrkz
 v5BPNWB2qUOSmFAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 83A392C145;
 Wed, 20 Apr 2022 09:27:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 73FBA5193E7A; Wed, 20 Apr 2022 11:27:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv6 0/4] nvmet: unique discovery subsystems
Date: Wed, 20 Apr 2022 11:27:26 +0200
Message-Id: <20220420092730.35101-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_022743_600997_A387DCD2 
X-CRM114-Status: GOOD (  14.76  )
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

here's my next attempt to support unique discovery subsystems.

As per suggestion from Christoph this patchset allows to have a per-port
discovery subsystem. For that a normal NVMe subsystem needs to be created
via configfs, the type needs to be changed to 'discovery', and then linked
into the port where this discovery subsystem should be visible.

Once that is done the discovery log page output will include all ports
into which the same discovery controller is linked.

If the discovery subsystem is unlinked the default behaviour is reinstated.
Additionally a module parameter 'expose_discovery_subsys' is implemented,
which will allow (or, rather, require) the creation of the default discovery subsystem via configfs, too. Once that option is enabled only ports into which
a discovery subsystem is linked will be presenting a discovery service; on
other ports a discovery attempt will fail.

As usual, comments and reviews are welcome.

Changes to v5:
- Implement 'expose_discovery_subsys' module option to allow the creation of
  the standard discovery subsystem via configfs.
Changes to v4:
- Unset disc_subsys pointer when unique discovery subsystem
  gets unlinked
- Improve documentation
- Use port count to determine if a subsystem is linked to ports

Changes to v3:
- Rework to use per-port discovery subsystems as suggested by hch

Changes to v2:
- Heavily rework after discussion on the mailing list

Changes to the original submission:
- Include all subsystems in the discovery log output

Hannes Reinecke (4):
  nvmet: make the subsystem type configurable
  nvmet: per-port discovery subsystem
  nvmet: include all configured ports in the discovery log page
  nvmet: expose discovery subsystem

 drivers/nvme/target/configfs.c  |  80 ++++++++++++++++++++++-
 drivers/nvme/target/core.c      |  15 ++++-
 drivers/nvme/target/discovery.c | 108 +++++++++++++++++++++++++-------
 drivers/nvme/target/nvmet.h     |   2 +
 4 files changed, 176 insertions(+), 29 deletions(-)

-- 
2.29.2


