Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF625C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Dec 2021 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0hnaJET3hwZ2jGvK632Sz8P5rXvQJFDNFzu4B3INbiE=; b=S7RUr6lF9+bgLtegqgZVaTBu1Q
	EjIbP0HHi0WjdrhuD7hWIXcRGYbWeFsQG+TtrtLCg6dAyAro5EVslXdCWZh195sljfnrcZdd6yvJD
	HyOymZzEdGuBMrJWgS7ywxslb51CGfSJNuioD7uDo08f8zrNxGsTeGYH9t8h4HfhPgZkX2pyAk+nV
	to68wkmgXf091X62JIyFfAEbPauSYpxtYB9pJEDdRZaBzP22JBSeK67OCo70slfn/fLONWZjjsiSU
	h8XZJFWIYJSeIlYYDS6bbxWffNcA7JTM0ppMs1iRnD0IxXw6bMI+Xz5T6zxU7pACbbIHYrgunSso7
	3jSUR2Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n2cPf-003Az5-Gj; Wed, 29 Dec 2021 17:06:55 +0000
Received: from [2001:4bb8:188:43d3:df02:51d9:650c:3c4d] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n2cPd-003Ayt-MG; Wed, 29 Dec 2021 17:06:54 +0000
Date: Wed, 29 Dec 2021 18:06:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 5.17
Message-ID: <YcyVq0hj1dPtRiGp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


The following changes since commit 3427f2b2c533d97bcc57b4237c2af21a8bd2cdbc:

  block: remove the rsxx driver (2021-12-16 10:57:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2021-12-29

for you to fetch changes up to e3d347943919f35ccdeed8d2cc62e8c6c12b36cd:

  nvme: add 'iopolicy' module parameter (2021-12-23 11:22:46 +0100)

----------------------------------------------------------------
nvme updates for Linux 5.17

 - increment request genctr on completion (Keith Busch, Geliang Tang)
 - add a 'iopolicy' module parameter (Hannes Reinecke)
 - print out valid arguments when reading from /dev/nvme-fabrics
   (Hannes Reinecke)

----------------------------------------------------------------
Geliang Tang (1):
      nvme: drop unused variable ctrl in nvme_setup_cmd

Hannes Reinecke (2):
      nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
      nvme: add 'iopolicy' module parameter

Keith Busch (1):
      nvme: increment request genctr on completion

 drivers/nvme/host/core.c      |  7 +------
 drivers/nvme/host/fabrics.c   | 22 +++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 41 ++++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  8 ++++++++
 4 files changed, 66 insertions(+), 12 deletions(-)

