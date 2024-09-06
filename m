Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47D5E6FE34
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p8CO2nBsSgpuSLqw9ZoWYcHaZOrNxsSYOUaWVDHhjDk=; b=Qu10TvZWmNG/WIAh263n+Fa1hE
	63+/W4yED+3H6oqFNZbjmqg6ILEwyVnLe0534go7+JAxk6ZThg2tSXvI4nVKtAD9Ovdfl9yJxiCfk
	xz76ce44eXTNHPtLTuxOCZ84FhCvoEU5rjojvJHK7OE1kxoyrNUt989TygO2lZCgCbaJlqAfewhwu
	tIU0fwnLqa8RKQxFo4FJmDlfL8mOsfcVKYH44K2/SI2zX7xGENuIs2eAg8WDfRlQoElj4QeJ17Omg
	iJ+TBiu9kwaxre9yXnbH6tnO7AR2b5/4E0473vx5VP0pEB8Mcxo2aXlG3Sf1VrtnZhL9accdVhhJw
	YmVxmVGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smceE-0000000D6O8-36EO;
	Fri, 06 Sep 2024 17:21:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smceC-0000000D6NR-1RjP
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 17:21:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6EB625C53A4;
	Fri,  6 Sep 2024 17:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC47C4CEC4;
	Fri,  6 Sep 2024 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725643282;
	bh=6je66mF+8VTAuPS9HZDLSvGpxLwILlvY45sCs7iARgk=;
	h=Date:From:To:Cc:Subject:From;
	b=N96UANpISiir74AlYqJhVegCiC508bqxUZ1y2pV277i1+GBKYwyBIL2GBcgVZWWXK
	 00t1Qx4XAUbt13zm21LDJx55ZTsSF0CpuhC9nbBBneceM3fxayYUsFTdKn794rObOR
	 EdfX6qb1icemUFK8+94SkX+V3qvaU7dJcuZ4vfTPqTMaH1pL9WByVV1+Fyw88m7VKQ
	 G/d9yQS9MrxpkwMW8IHnrIwej8P2Eb9COmjVaJRismjjI6V9DzOilQYTZFydAPEwrB
	 paiPu8LaeBpDVM9LQJjB+8JCQZ9fdN89D/9y7HhoyhDjCDe7szKiy7ggHWuRPyTBPO
	 yjDphEJbrdy8A==
Date: Fri, 6 Sep 2024 11:21:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 6.12
Message-ID: <Zts6EDOzCgJrkFN2@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_102124_448202_2878469B 
X-CRM114-Status: UNSURE (   8.76  )
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

The following changes since commit b2261de75212910e2ca01fa673c8855a535d8c60:

  blk-cgroup: Remove unused declaration blkg_path() (2024-08-16 15:07:27 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-06

for you to fetch changes up to 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9:

  nvme: fix metadata handling in nvme-passthrough (2024-08-30 07:50:29 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.12

 - Asynchronous namespace scanning (Stuart)
 - TCP TLS updates (Hannes)
 - RDMA queue controller validation (Niklas)
 - Align field names to the spec (Anuj)
 - Metadata support validation (Puranjay)

----------------------------------------------------------------
Anuj Gupta (1):
      nvme: rename apptag and appmask to lbat and lbatm

Hannes Reinecke (9):
      nvme-keyring: restrict match length for version '1' identifiers
      nvme-tcp: sanitize TLS key handling
      nvme-tcp: check for invalidated or revoked key
      nvme: add a newline to the 'tls_key' sysfs attribute
      nvme: split off TLS sysfs attributes into a separate group
      nvme-sysfs: add 'tls_configured_key' sysfs attribute
      nvme-sysfs: add 'tls_keyring' attribute
      nvmet-auth: allow to clear DH-HMAC-CHAP keys
      nvme-target: do not check authentication status for admin commands twice

Niklas Cassel (1):
      nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private Data

Puranjay Mohan (1):
      nvme: fix metadata handling in nvme-passthrough

Stuart Hayes (1):
      nvme_core: scan namespaces asynchronously

 drivers/nvme/common/keyring.c   | 58 +++++++++++++++++++++-----
 drivers/nvme/host/Kconfig       |  1 +
 drivers/nvme/host/core.c        | 45 +++++++++++++++++++--
 drivers/nvme/host/fabrics.c     |  2 +-
 drivers/nvme/host/ioctl.c       | 26 +++++++-----
 drivers/nvme/host/nvme.h        |  2 +-
 drivers/nvme/host/rdma.c        |  6 ++-
 drivers/nvme/host/sysfs.c       | 90 +++++++++++++++++++++++++++++++----------
 drivers/nvme/host/tcp.c         | 55 ++++++++++++++++++-------
 drivers/nvme/target/admin-cmd.c |  2 -
 drivers/nvme/target/auth.c      | 12 ++++++
 drivers/nvme/target/rdma.c      |  4 +-
 include/linux/nvme-keyring.h    |  6 ++-
 include/linux/nvme-rdma.h       |  6 ++-
 include/linux/nvme.h            |  8 ++--
 15 files changed, 250 insertions(+), 73 deletions(-)


