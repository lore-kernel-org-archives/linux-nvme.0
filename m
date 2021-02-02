Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F092C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:33:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7396864EDE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 09:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7396864EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7LjnUK2HDWHMIoI51VUDzx9naHEjqqQTeY3LJToIC/4=; b=dIf9kEhwtaI9otlnLiadWU6Gsm
	J7NuQXt5Zl1fYWwfSQl8QvC+n43mFp61QAlzm6C6Ce1wm91i/vOdjb1K2Rx66VC/2kv1c1Gq0Cbjb
	X0OdQChPvsEq83j/hIQ0HWn9HvncmeIaDxPYjzqi4o8WrwMwDsIaECq+mtxPTnkCofnTMa7V3z/Xa
	VaOwABgI2fga7PWEFjFFbJVb9zoOeOoUod+ANmz97tx1e6WNLRuPhqasvmARQcncUNEP2/tv8ofcw
	YS8sK3ATaYW+Nw5MMfSpPr8A7UftbSigf0JeuRXEAd+qnZLr3Lcll9rA4mlNDNUleZITMajAlVTdA
	SqFOZvYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6s3q-0001nP-Oo; Tue, 02 Feb 2021 09:33:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6s3o-0001nC-Vj
 for linux-nvme@merlin.infradead.org; Tue, 02 Feb 2021 09:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=iRa22Ar6Ooo4KG4nCBybV9MasxMnSD0i/XFg7+z6V9c=; b=XBX4R5nr7Y+Tq6eLOpYkJUk5du
 +cyQVydaTjHlbpwd00xL0eH5z5836s45CJfuEGrGBh3WJUmjCobKiUyxNCXPptPxGE7/Fnm9DFoWW
 AJIW4zEesEOlVjI/bqdBRHR2u3kjz5z6bLo4SoMKjbRBRPVHeobY7GUZqhv8vfr7wbhh4JZfGFwwV
 21/ApjLR42XWJZlHT8AgZfmj9k9J2AHYU8BSaJEZl717/l9gayBFXOQn2R2LWtblV/KAolkzgGDoI
 rv4Fe7qsIybU+Tk9/VzbdB8oZBCWViAvJa8VanvaUU7yBH0j6Mm9HdWl8owywkkYugVU4ZsK8zBp0
 yFbYQKTg==;
Received: from [2001:4bb8:198:6bf4:7f38:755e:a6e0:73e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l6s3l-00EzXn-Jk; Tue, 02 Feb 2021 09:33:22 +0000
Date: Tue, 2 Feb 2021 10:33:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] first round of nvme updates for 5.12
Message-ID: <YBkcYFf7hJfpK+vl@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit e8628013e5ddc7cf78cc2f738ab760e8c0fa8559:

  drbd: Avoid comma separated statements (2021-01-31 08:05:36 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.21-2020-02-02

for you to fetch changes up to 563c81586d0ab2841487a61fb34d6e9cd5efded7:

  nvme-tcp: use cancel tagset helper for tear down (2021-02-02 10:26:13 +0100)

----------------------------------------------------------------
nvme updates for 5.12:

 - failed reconnect fixes (Chao Leng)
 - various tracing improvements (Michal Krakowiak, Johannes Thumshirn)
 - switch the nvmet-fc assoc_list to use RCU protection (Leonid Ravich)
 - resync the status codes with the latest spec (Max Gurtovoy)
 - minor nvme-tcp improvements (Sagi Grimberg)
 - various cleanups (Rikard Falkeborn, Minwoo Im, Chaitanya Kulkarni,
   Israel Rukshin)

----------------------------------------------------------------
Chaitanya Kulkarni (5):
      nvmet: remove extra variable in smart log nsid
      nvmet: remove extra variable in id-desclist
      nvmet: remove extra variable in identify ns
      nvmet: add lba to sect conversion helpers
      nvme-core: get rid of the extra space

Chao Leng (5):
      nvme-core: add cancel tagset helpers
      nvme-rdma: add clean action for failed reconnection
      nvme-tcp: add clean action for failed reconnection
      nvme-rdma: use cancel tagset helper for tear down
      nvme-tcp: use cancel tagset helper for tear down

Israel Rukshin (2):
      nvmet: Use nvmet_is_port_enabled helper for pi_enable
      nvmet: Fix nvmet_is_port_enabled indentation

Johannes Thumshirn (1):
      nvme: add tracing of zns commands

Leonid Ravich (1):
      nvmet-fc: use RCU proctection for assoc_list

Max Gurtovoy (1):
      nvme: update enumerations for status codes

Michal Krakowiak (1):
      nvme: parse format nvm command details when tracing

Minwoo Im (2):
      nvme: support command retry delay for admin command
      nvme: refactor ns->ctrl by request

Rikard Falkeborn (1):
      nvme: constify static attribute_group structs

Sagi Grimberg (3):
      nvme-tcp: fix wrong setting of request iov_iter
      nvme-tcp: get rid of unused helper function
      nvme-tcp: pass multipage bvec to request iov_iter

 drivers/nvme/host/core.c          | 37 +++++++++++++-----
 drivers/nvme/host/fc.c            |  2 +-
 drivers/nvme/host/nvme.h          |  2 +
 drivers/nvme/host/rdma.c          | 30 +++++++++------
 drivers/nvme/host/tcp.c           | 55 +++++++++++++-------------
 drivers/nvme/host/trace.c         | 53 +++++++++++++++++++++++++
 drivers/nvme/target/admin-cmd.c   | 71 ++++++++++++++++------------------
 drivers/nvme/target/configfs.c    |  6 +--
 drivers/nvme/target/fc.c          | 81 ++++++++++++++++++---------------------
 drivers/nvme/target/fcloop.c      |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  8 ++--
 drivers/nvme/target/nvmet.h       | 10 +++++
 include/linux/nvme.h              | 30 ++++++++++++---
 13 files changed, 243 insertions(+), 144 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
