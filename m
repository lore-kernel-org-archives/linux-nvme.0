Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC99C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OzIJBJiM1L0ySp+s+RRn2u9kOsImz5mXiqQWvhdoyog=; b=nXYYjFGN4J3hRZWS3wTaBmjjIc
	kNnvOJ1a9HU6LFUPTGhA06a53AcCD3QOaNS4LClqUABey2Y6hqxhfbjZMivwIBMpy7Zf/sgidqHMF
	Uxusjan2QdFlkGBPJ+QeRs58xTF8xElDh78vnCV6g+b0t3MiRVrH6nH0GjPfM7UVOF9lcubS8QU7F
	4z0xu0WLDrgicmmQ9byblH+OwToHzYikvkB9RnqROT7ctfsCC0itn6lbsjH6H8zA6/n9TobturnWx
	BKaV78QMrsi3BzH8BVW+Sx6pgYXKJWBsVkFWuXR4oqL+AVxr+1+adPY2BNvlfKnFpsMR6VaCnhDpt
	BoRj/MBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nciar-00FNwr-LA; Fri, 08 Apr 2022 06:59:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncian-00FNuc-Uj
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 06:59:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9FD4721600;
 Fri,  8 Apr 2022 06:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649401175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OzIJBJiM1L0ySp+s+RRn2u9kOsImz5mXiqQWvhdoyog=;
 b=vuRRffeLhqJ9t8quX5DmyuFrc7hBdW76N71KV3fqHIkn3QjvBmNkIEoaJo0Ux5ApRv0+W9
 mofTspLaYGpvzmnRNjWwe7EkqzwjqtSZkhFV71Bnc+DjE7XyndGY9MFL8WGTpoQSXOn4Mb
 tczKFRUVIAOgVjg8amVrGI+3BY69OF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649401175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OzIJBJiM1L0ySp+s+RRn2u9kOsImz5mXiqQWvhdoyog=;
 b=DscK8o2J4rybUTeYW0Lz+iYc4DDzC5CzGp1h6Ol18W01b0Y+keP0LF5NF5P6pdIkXUer95
 Sm4WsB1MHT0YKlCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 91E48A3B89;
 Fri,  8 Apr 2022 06:59:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id B37FD5193C05; Fri,  8 Apr 2022 08:59:34 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 0/3] nvmet: unique discovery subsystems
Date: Fri,  8 Apr 2022 08:59:27 +0200
Message-Id: <20220408065930.123015-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_235938_199712_5993651B 
X-CRM114-Status: GOOD (  12.18  )
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

As usual, comments and reviews are welcome.

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

Hannes Reinecke (3):
  nvmet: make the subsystem type configurable
  nvmet: per-port discovery subsystem
  nvmet: include all configured ports in the discovery log page

 drivers/nvme/target/configfs.c  | 70 +++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 15 ++++--
 drivers/nvme/target/discovery.c | 92 +++++++++++++++++++++++++--------
 drivers/nvme/target/nvmet.h     |  2 +
 4 files changed, 154 insertions(+), 25 deletions(-)

-- 
2.29.2


