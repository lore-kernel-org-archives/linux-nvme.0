Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11465C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE9C611C1
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9C611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YFSdx/8EwiumnklxIT+fhjcWtlBuolVlIwkNy8VvslQ=; b=vRxlhFgJ6NJC8S
	tINTHEnxlGov3NRg7EqLYBmzvrxi4r45TGaXJGLKZ3zGG9kwt42czDN/pMEtsPc1wbz8jzEJJkUi1
	edcWd/EJIuEea/WGHa8qSVrApLQy8Mjy+5mBks6YhCkKJ7rQWBTJoXJW42KrVgeWtPo6dh29/P+g7
	rwRw8vKXzUjSJ3ncVZyhweTmnQMSHaJ/tX7DhGrut/3U2FrAoJySYNMEZChmgK4F3QjFg+apxsY/n
	4ymYkZ7DVB5qSV7dH/C4NvpTtdxHeUtV9UcyMyePF5BQUoNcNuLGEgHYxk7c45V4RomUjHjw3yjSA
	C+QKx6fXA8V0c6GqNMdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4LeY-004EBJ-3w; Fri, 16 Jul 2021 11:05:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4Le9-004E5X-Gc
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 11:04:48 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4A6AF22BA9;
 Fri, 16 Jul 2021 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626433482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=C8+jbnRN3YHZZAIvtHiS36Wu7Wdx09uaJz3zYdIkw1s=;
 b=vIFqDPXE7bwsA5y8oE4uoApySSEA9dvwUjInZyHA8oepU4+7uVtuk/zKWVqZJ0dX9UJd24
 TAdfFHaDqox+yj38wBTslvaO2AsoY61hs2gHWFwReBb+CJU+UVgm6epjgzwen9N55mmR6R
 qeQd6mdnyGfrjkIw9B7A47vEJEMCb6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626433482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=C8+jbnRN3YHZZAIvtHiS36Wu7Wdx09uaJz3zYdIkw1s=;
 b=JOZqLDMx7LhKOU1/o2zUNtfW4ik3+5+Wi7KoTx59shvIa+qor4ck/nDWnFV1c4a/o2LkgV
 ibM1ybS0cqarWcDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B2778A3BB3;
 Fri, 16 Jul 2021 11:04:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 70C775171604; Fri, 16 Jul 2021 13:04:41 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 00/11] nvme: In-band authentication support
Date: Fri, 16 Jul 2021 13:04:17 +0200
Message-Id: <20210716110428.9727-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_040445_917043_76D22536 
X-CRM114-Status: GOOD (  17.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

recent updates to the NVMe spec have added definitions for in-band
authentication, and seeing that it provides some real benefit especially
for NVMe-TCP here's an attempt to implement it.

Tricky bit here is that the specification orients itself on TLS 1.3,
but supports only the FFDHE groups. Which of course the kernel doesn't
support. I've been able to come up with a patch for this, but as this
is my first attempt to fix anything in the crypto area I would invite
people more familiar with these matters to have a look.

Also note that this is just for in-band authentication. Secure concatenation
(ie starting TLS with the negotiated parameters) is not implemented; one would
need to update the kernel TLS implementation for this, which at this time is
beyond scope.

As usual, comments and reviews are welcome.

Hannes Reinecke (11):
  crypto: add crypto_has_shash()
  crypto: add crypto_has_kpp()
  crypto/ffdhe: Finite Field DH Ephemeral Parameters
  lib/base64: RFC4648-compliant base64 encoding
  nvme: add definitions for NVMe In-Band authentication
  nvme: Implement In-Band authentication
  nvme-auth: augmented challenge support
  nvmet: Parse fabrics commands on all queues
  nvmet: Implement basic In-Band Authentication
  nvmet-auth: implement support for augmented challenge
  nvme: add non-standard ECDH and curve25517 algorithms

 crypto/Kconfig                         |    8 +
 crypto/Makefile                        |    1 +
 crypto/ffdhe_helper.c                  |  877 +++++++++++++++++
 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/nvme/host/Kconfig              |   11 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/auth.c               | 1188 ++++++++++++++++++++++++
 drivers/nvme/host/auth.h               |   23 +
 drivers/nvme/host/core.c               |   77 +-
 drivers/nvme/host/fabrics.c            |   65 +-
 drivers/nvme/host/fabrics.h            |    8 +
 drivers/nvme/host/nvme.h               |   15 +
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   10 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +
 drivers/nvme/target/auth.c             |  608 ++++++++++++
 drivers/nvme/target/configfs.c         |  102 +-
 drivers/nvme/target/core.c             |   10 +
 drivers/nvme/target/fabrics-cmd-auth.c |  472 ++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   30 +-
 drivers/nvme/target/nvmet.h            |   71 ++
 include/crypto/ffdhe.h                 |   24 +
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme.h                   |  187 +++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  111 +++
 30 files changed, 3961 insertions(+), 9 deletions(-)
 create mode 100644 crypto/ffdhe_helper.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/host/auth.h
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/crypto/ffdhe.h
 create mode 100644 include/linux/base64.h
 create mode 100644 lib/base64.c

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
