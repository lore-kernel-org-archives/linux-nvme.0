Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B5FC46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oneim6tpPOoxGS+0ehCutTcCQMBae12oFHQIUvi8u1U=; b=nfxnNgdixHt/aintDwEFljSxQR
	/6xwbLes1Mq43b0MKbSjV6c21VDH8IEoQAeQACXwclfI+VsQNEA/+bzetxvZnUlBXZ7hISfm8Xtis
	NL9uLQTmOXGq46XR14DiiSokPq312e0CAoUcNKcKLRTCQopahWSEvH5D/NsbYB3sEYZ6CQtPdzYGD
	f6IzolCjA5Tx2bK/Uw2pZFb5fS0AEhDhFk6nM02ng3gs6nUvF58WjUOuHa12KKYkdXlr7RXuzHgcb
	DIeGf/CTpRyFi/KhHEEn9cvs1FfZ3TubjvqA3JWKNkw8+Vqq9G54TdqKwZlwFVdHj9k+RMvSf7vcJ
	cuwmW4Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSsn-009YZH-2W; Wed, 11 Jan 2023 04:38:37 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSsc-009YXK-0x; Wed, 11 Jan 2023 04:38:27 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B050842165;
	Wed, 11 Jan 2023 04:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673411903; bh=HfFhuO/foSzEbmya21quSWIKZF8twzaOgyIjDrYqKHo=;
	h=From:To:Cc:Subject:Date;
	b=P8chu566SCCEyb4pTVwA4dMqw4vFrkbsl9qjBm/MzvlDIJeDc/vjNar8nvW82f2Fa
	 7MqX5rOJfyHjU3IOUkuYSN3QD+WiOGBXyp2nceOLmd3PfPilW+4wleApLWjewq2MGc
	 jINYTXgCFgU6VUHeWxSNqA1phlmiBK3HjM6LILNs7ewfDLruFdpI4tulULomJCFX4k
	 NitLYn4zFL13bDuf7cqnRSUUW9ci5pbejzZpiBRPRWBU9uLmo1IoYGMPd+cah930Gh
	 PKF9f2COtxJiPou2h65K5B6FdLx2z17IXuMAhXRdyJAdU7t5MeVg1iA+w/xqswp4bb
	 TnaO+WaEiSaxA==
From: Hector Martin <marcan@marcan.st>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Eric Curtin <ecurtin@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/2] nvme-apple: Fix suspend-resume regression
Date: Wed, 11 Jan 2023 13:36:12 +0900
Message-Id: <20230111043614.27087-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_203826_233976_BFB4FD92 
X-CRM114-Status: GOOD (  11.33  )
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

Commit c76b8308e4c9 introduced a behavior change in the way nvme-apple
disables controllers, avoiding a disable in the shutdown path.
Unfortunately, the NVMe core does not know how to actually start up
controllers in the shutdown state, and this broke suspend/resume since
we use the shutdown command for device suspend in nvme-apple.

Additionally, nvme-apple was also checking only for the disable state in
the reset path to decide whether to disable the controller again, and
just having the controller shut down was triggering an unnecessary code
path that broke things further.

This short series fixes those issues and makes suspend/resume work on
nvme-apple again.

nvme-pci is, to my knowledge, not affected since it only issues a shutdown
when the whole system is actually shutting down, never to come back.

Hector Martin (2):
  nvme-apple: Do not try to shut down the controller twice
  nvme: Handle shut down controllers during initialization

 drivers/nvme/host/apple.c |  3 ++-
 drivers/nvme/host/core.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.35.1


