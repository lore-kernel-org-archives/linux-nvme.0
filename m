Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED94C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ptEcs74jg7JXVCFnq9EvP8cDmSWilpR23/XJsWuuo+o=; b=bwR+rZMoGOPsUBTeo/658oeC/N
	iGPPQyN0TVO6isBELXVGm27E1JLixv+NruL9JXm3pdO06bzdwL1lJcD2iN5x48oSCiaf7m6N+oJqK
	890PEzrWW+xkKLGNzNQJ95j8r4mKFUo45X83hd7CXwxQvWckuE8CY02j2/6eCD6iE0eeWEtC+y39g
	qPF+qv1QRmeRuuWByy9uBOSWKvovzods6l8IYrgZ80Jm3HUpVOhWcRSdNWebOrit/Zrn+LgF89Y8y
	D50gCKqXlQZCT0VpXVMC9l4Zdhg1CTfkKx7Zd4ia6Pub0s8GhNlNkIJSjT9Dpq4AcCBoRRgTHzVdR
	ZseplwTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqFMq-007l1A-Bk; Thu, 25 Nov 2021 14:04:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqFMo-007l04-JI
 for linux-nvme@bombadil.infradead.org; Thu, 25 Nov 2021 14:04:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=ptEcs74jg7JXVCFnq9EvP8cDmSWilpR23/XJsWuuo+o=; b=ocieuV+Zu2gxYyTLvXmR9ER4MK
 CbzUfLoSpOsn71He4D44KX3aQin603TvLfOgomAmtcNJ78ea3mvDbFwlFHzoEixEl6REramUFCOet
 AsVqmLry/eUQ+zTPZUdy3Zs3CbRSdce7+6OoyIgFllg8a20wsTDEpuGf2yvhIl9W6+Pkc2rElAxgG
 M5efugb/cW9EPGDpYUQjvic1dEuayM0tZepPKMbaEIpwTGCEkCwDtoMGvzJUMDS6GWr8CATEj6ESa
 MmYcEricJgZrlJheyMpNQt+4sT0Atl5ivee3jT1isFKiaIG6XLf825yeWo/Ab6vUrX+XPVI59GRx3
 kI6IUBtg==;
Received: from [2001:4bb8:191:f9ce:91e3:dc54:365:7d33] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqFMk-006YBt-T7; Thu, 25 Nov 2021 14:04:47 +0000
Date: Thu, 25 Nov 2021 15:04:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YZ+X/qGC6/w3bp2c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit efcf5932230b9472cfdbe01c858726f29ac5ec7d:

  block: avoid to touch unloaded module instance when opening bdev (2021-11-22 18:35:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-11-25

for you to fetch changes up to 95ec70a9f3f9133304a0295af58d4f05ed27661c:

  nvmet: use IOCB_NOWAIT only if the filesystem supports it (2021-11-23 17:22:43 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.16

 - add a NO APST quirk for a Kioxia device (Enzo Matsumiya)
 - fix write zeroes pi (Klaus Jensen)
 - various TCP transport fixes (Maurizio Lombardi and Varun Prakash)
 - ignore invalid fast_io_fail_tmo values (Maurizio Lombardi)
 - use IOCB_NOWAIT only if the filesystem supports it (Maurizio Lombardi)

----------------------------------------------------------------
Enzo Matsumiya (1):
      nvme-pci: add NO APST quirk for Kioxia device

Klaus Jensen (1):
      nvme: fix write zeroes pi

Maurizio Lombardi (6):
      nvmet-tcp: fix a race condition between release_queue and io_work
      nvmet-tcp: add an helper to free the cmd buffers
      nvmet-tcp: fix memory leak when performing a controller reset
      nvme-tcp: fix memory leak when freeing a queue
      nvme-fabrics: ignore invalid fast_io_fail_tmo values
      nvmet: use IOCB_NOWAIT only if the filesystem supports it

Varun Prakash (2):
      nvmet-tcp: fix incomplete data digest send
      nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()

 drivers/nvme/host/core.c          | 29 +++++++++++++++++--
 drivers/nvme/host/fabrics.c       |  3 ++
 drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
 drivers/nvme/target/io-cmd-file.c |  2 ++
 drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
 5 files changed, 93 insertions(+), 46 deletions(-)

