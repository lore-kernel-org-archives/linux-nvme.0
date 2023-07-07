Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09584EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2HsqxOe5loAP5LPrdJ/BTaueXxa+4EwOIboAeohNz/Y=; b=MkoZPgzZHCbOHeAUbxIjlROMkx
	absRtBLqEDX32hPQTzvpJpoBFCTs/eKhGxV+rovDpnPz+b6S9XgLBMt9fXQbKnc0sIlHmx3AQzc8j
	r1YNIH/qtgz8/qUNuJSakhYbyGWdzWXxR/nZLgri8fURN+aQTDXj/erEvZVey18BSCGikV111UFes
	7Nhag4OsaLbnmM7WqbGIaOQ8moXXGsqlELpFYEQSfIyHaWwHKCeYWmRYFWKJpCY6V6prllvrTm+Pg
	8ekXKXbBrulAeHNh0vzXGBXti30m4Q8qLNmCsq1AimYvK48/zYfIQ9UJsfUIBxV44dve0BWfPdBtG
	/RYx76dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2n-0049hG-24;
	Fri, 07 Jul 2023 09:46:29 +0000
Received: from [89.144.223.112] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2l-0049gn-2T;
	Fri, 07 Jul 2023 09:46:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: fix discard limits
Date: Fri,  7 Jul 2023 11:46:12 +0200
Message-Id: <20230707094616.108430-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

this series fixes a few issues related to max_discard_sector limits
in the block layer and nvme.

Subject:
 block/blk-settings.c     |    4 +++-
 drivers/nvme/host/core.c |   35 +++++++++++++----------------------
 drivers/nvme/host/nvme.h |    3 +--
 3 files changed, 17 insertions(+), 25 deletions(-)

