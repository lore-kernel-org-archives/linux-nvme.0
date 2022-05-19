Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52079C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1ivFVvaH/Bc6oWSN5A3QdGzfic2gASfrHsi7yeEYLXk=; b=I5JdtfVHg42Y/2wUgpBP8HUbuD
	3zMTpLzLGKPxqo+m5K6qNWV7BhwH0LCqXDSndb4I4BpyTrcb/0gPxmeH+LEjW5AV8LfQceExkjdwL
	wiDB+3Z8ekwzV4KJMZXQl0XDdaWGjhsmQ7ZA/GpgRq0H57925NtAUWL02LDP1ShhVnOge1H5+IPJN
	+sH/hPFan5HpgdvIPGAD06xdYJoxyMElcTX5Yv+BPNa3xMpkNRJ3IRKY8DILft3ScDTNQpB8XhHEf
	LR0lQKB9USpjkZvPVDElLpxEjXh3xDUwoRCk8pQ2j1L68puBJ2vhLbMzuNA+PC+JrAo/Aof4kwJFk
	M3uHx1aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrm72-009Abf-JI; Thu, 19 May 2022 19:47:08 +0000
Received: from [2001:4bb8:19a:7bdf:3c5b:8fdd:1000:1647] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrm70-009Ab2-MS; Thu, 19 May 2022 19:47:07 +0000
Date: Thu, 19 May 2022 21:47:04 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.19
Message-ID: <YoaeuNGHGE/t29gY@infradead.org>
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

[note that my GPG key expired today and I had to extent it.  It
might take some time to propagate to all key servers]

The following changes since commit da14f237ceef059ff1a9ee14de283905c2dac11c:

  Merge tag 'nvme-5.19-2022-05-18' of git://git.infradead.org/nvme into for-5.19/drivers (2022-05-18 06:28:04 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-19

for you to fetch changes up to 78288665b5d0154978fed431985310cb4f166836:

  nvme: set non-mdts limits in nvme_scan_work (2022-05-19 21:30:22 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.19

 - set non-mdts limits in nvme_scan_work (Chaitanya Kulkarni)
 - add support for TP4084 - Time-to-Ready Enhancements (me)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme: set non-mdts limits in nvme_scan_work

Christoph Hellwig (1):
      nvme: add support for TP4084 - Time-to-Ready Enhancements

 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      | 95 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/nvme.h          | 31 ++++++++++++++
 3 files changed, 117 insertions(+), 10 deletions(-)

