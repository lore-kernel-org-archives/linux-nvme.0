Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F6C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F5C60E52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 15:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6F5C60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WkwrD0ZeRHUWIn2HGDzo7oHsCoG82+GwUHE8JLIAVNM=; b=UbKwGtNf7xIzH5IYeiDE7/I03M
	jBPepXcS6LB1on4jtg0ROqFnAz2yta3GkcIgKLMMzEb+D4dfAfZZBZWBbny8QIcLHJ8eZXqq1MN2v
	nRdzXPR+H4Dt2vNBD8vjdkcxANW0YUGt18mtql8Bee5419yCVuANZnSHRg0iLQPewAWwZ2SoSHMWV
	f0x0GYt8e6p8Aqlf+kD7r2OspE6sJJNZ/blYJFL9XaveGu8kN6yWujqoQLU7dorKlTxQgiQQC7TvA
	QQmFp4qDGDZHUb79FBZhj+dd0S6Aj5qbmJx7vmii7AYdFnUEda5CaFA1M1vKfG/AA3+wwHe/iswua
	9n+hFmLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcUSP-00GHgV-O4; Mon, 18 Oct 2021 15:21:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcUSM-00GHeW-Iy
 for linux-nvme@lists.infradead.org; Mon, 18 Oct 2021 15:21:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6A81F21961;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634570499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WkwrD0ZeRHUWIn2HGDzo7oHsCoG82+GwUHE8JLIAVNM=;
 b=zXeLX8geb7/VepBi0mB2yUJIzEubWEbWWRwLmHz4fvEsHDSqT4HjkBDUbUaMInQQcyWyyJ
 f9XH7cq6UI1v+p7dHvu1Pq09CCFPj9ryjMR8JBka0NLNmvBa6MiZBbIlQK7RLGEAJOza7a
 uhg4oGX1OAij51Cf+I4pmVRAn179zhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634570499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WkwrD0ZeRHUWIn2HGDzo7oHsCoG82+GwUHE8JLIAVNM=;
 b=tdlXm8CLzpl5/Az+E7QXT9Sfa6L0eOXn3g9rLvcZ4MtXNhQ+JiS3gXh64Kl6IfqVFlUBPI
 8V/EjLF4jcicjUBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 38BC8A3B91;
 Mon, 18 Oct 2021 15:21:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 1DC22518FBBD; Mon, 18 Oct 2021 17:21:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] nvmet: discovery controller discovery support
Date: Mon, 18 Oct 2021 17:21:35 +0200
Message-Id: <20211018152138.2128-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_082142_827339_C670C1DA 
X-CRM114-Status: UNSURE (   9.02  )
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

TPAR 8014 (discovery controller discovery) adds a new discovery
log page entry type '3' to describe the current discovery controller.
This patchset adds support for this to the nvme target.

As usual, comments and reviews are welcome.

Changes to v1:
- Rebased to nvme-5.16

Hannes Reinecke (3):
  nvmet: switch check for subsystem type
  nvme: add new discovery log page entry definitions
  nvmet: register discovery subsystem as 'current'

 drivers/nvme/target/core.c      |  2 ++
 drivers/nvme/target/discovery.c | 13 ++++++++-----
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            | 12 ++++++++++--
 4 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.29.2


