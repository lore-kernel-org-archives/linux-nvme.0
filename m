Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7FEC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hDssSc3GtQMWyJa9MFOY5+NDJYLooAIm6n5P105s+Wk=; b=by8dvc+8p8jylYijqSCbFj4DXv
	udsW7Rw4LpgLvoroZVwD6Mu0u2bbGoQyQcDCyTL2krkOWDmSdVmXGIQlqqoo211HBp733NwTs2rnE
	VnBmNzOmGLCICsEecNab4Mf/Rx/VkTlQULg8nPZ00gJ3sYw65Ejx0hmX/AIV0ZsffFmYJq8y1olu5
	5/3o3VcN9r/47ouSu2hNq4UiCgAJc8geoeslbOft3aCl46j17F0XJElg6tPJXVcOtNhwo6UEnHaeL
	kql40axk2KtWPOjdNn3qGpcOesPgCxItxk6tBnh05Ew0TPkGE8baQEMmZktgxgUwheDeDuf47KckN
	Rq2z6L8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wK-00000009Hf8-1A89;
	Mon, 04 Mar 2024 14:05:12 +0000
Received: from [206.0.71.24] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rh8wD-00000009He8-3G5f;
	Mon, 04 Mar 2024 14:05:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: convert nvme to atomic queue limits updates v2
Date: Mon,  4 Mar 2024 07:04:44 -0700
Message-Id: <20240304140500.78583-1-hch@lst.de>
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

this series converts nvme to the new atomic queue limit updates, and
as part of that refactors a lot of the setup code.  The first two
patches are block layer patches already sent out as part of the md
queue limits conversion and will hopefully get merged into Jens' tree
soon.

Changes since v1:
 - also set GENHD_FL_HIDDEN on the multipath gendisk for unknown command
   sets
 - use the queue_limits_* API for multipath device stacking
 - update the admin queue limits after reading in the MDTS value

Diffstat:
 core.c      |  393 ++++++++++++++++++++++++++++++------------------------------
 multipath.c |   13 +
 nvme.h      |   11 -
 zns.c       |   24 +--
 4 files changed, 218 insertions(+), 223 deletions(-)

