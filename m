Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640FC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 06:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y1GifFop1lI4anosO8Rh54/FVEpscbbAal1X0GxOX/E=; b=z3frlVci7x8Qt0Gpow27pez8T6
	JxkO4kTBCdb+N9oKVhnxrTM/4qMlQjoKtiUDRqU5V1yN0QDvFk4BKzjWwtx5E9KsnPvJ2hqyN32FV
	IY/REfkH4AR0R9Ka7hYWG3R/bf3CYsLtoo9n2RC9x4Lt/hR35SCajgbT/jNh14twBk9yqUodk1zXO
	DA8gwtBx5UJTQYVLTURFC+MjLUrGm0O6EGHxGmSOPOPohulL1mebcPr7FB6BGEh4ujNeYPONeyl9H
	e6CeaMxWSvssvw9Jffp/mAwZyCKAMVjbA+uZiALJg61EeCt+uI9260k5d+yA7r0yvnBD455D+et+E
	jDU9XMUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvZCJ-000rQs-Sm; Fri, 10 Dec 2021 06:15:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvZCH-000rQe-Jh
 for linux-nvme@bombadil.infradead.org; Fri, 10 Dec 2021 06:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=y1GifFop1lI4anosO8Rh54/FVEpscbbAal1X0GxOX/E=; b=f83fmZYOyCH+kyHIV84Z1CXEkB
 PIr0SKo3YUtgfpikWRQpu+h5GDvHcdnVoucaHJntVyGySz0y7M8PYCI/uKUeSnyaMzsVGI2+UiJne
 Adg3c8W2VuQ7dfkBi+uMAPNKjgV3dSl+NcKywLIorMmFosR5OA26B4JxwG4ZZde+OohviDqAPgnfw
 dt8W/L3MyJJfxGSGeByUUqOuOdwlbo69Q/b1l3dneirHeuKtyvYHIj0R+FZHrlj44sgArIcKpAvk/
 BecJT/r5x1EYnO23Q8Jyd8CbiK1U1aFlQSpg958h+fDItiVuAbKQ+MkNcfl1ULcAgnZgW1RT9AL/Z
 nLP1n0og==;
Received: from [2001:4bb8:180:a1c8:de14:d573:bcd:1136] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvZCE-00A4qW-RU; Fri, 10 Dec 2021 06:15:55 +0000
Date: Fri, 10 Dec 2021 07:15:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.16
Message-ID: <YbLwmaLqilKEW0Q/@infradead.org>
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

The following changes since commit e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584:

  loop: Use pr_warn_once() for loop_control_remove() warning (2021-11-29 06:44:45 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.16-2021-12-10

for you to fetch changes up to 30e32f300be6d0160fd1b3fc6d0f62917acd9be2:

  nvmet-tcp: fix possible list corruption for unexpected command failure (2021-12-08 16:36:58 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.16

 - set ana_log_size to 0 after freeing ana_log_buf (Hou Tao)
 - show subsys nqn for duplicate cntlids (Keith Busch)
 - disable namespace access for unsupported metadata (Keith Busch)
 - report write pointer for a full zone as zone start + zone len
   (Niklas Cassel)
 - fix use after free when disconnecting a reconnecting ctrl
   (Ruozhu Li)
 - fix a list corruption in nvmet-tcp (Sagi Grimberg)

----------------------------------------------------------------
Hou Tao (1):
      nvme-multipath: set ana_log_size to 0 after free ana_log_buf

Keith Busch (2):
      nvme: show subsys nqn for duplicate cntlids
      nvme: disable namespace access for unsupported metadata

Niklas Cassel (1):
      nvme: report write pointer for a full zone as zone start + zone len

Ruozhu Li (1):
      nvme: fix use after free when disconnecting a reconnecting ctrl

Sagi Grimberg (1):
      nvmet-tcp: fix possible list corruption for unexpected command failure

 drivers/nvme/host/core.c      | 23 ++++++++++++++++++-----
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/zns.c       |  5 ++++-
 drivers/nvme/target/tcp.c     |  9 ++++++++-
 5 files changed, 33 insertions(+), 9 deletions(-)

