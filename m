Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD66C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=RYvjiJ/ojri6MC10aisCWFORu9
	yIkfQm5BN5fpLgZriTbF1nzI/zi0jzyxi9xqdkIILIpBWG4Rra32piQEjbM5jj6h9XnI6o/FdbsHE
	Ue0dUXpsUNS5Rl5h0BvNIbtU6LpCRyPMhAvQKRCjXl/Xcxu4MsR+oNUP8NQJnmWNcPq5rKtH7yes5
	iuciIpD0V1rdIhlwFQH7KB6UqwX9UDIecGa/SQ69v4vuwZfvwjRBa8PIkXClkBBtIVvYEGfqGiasT
	KIr1vJuzAIXYblpnriCYwYlkiIbJcV1KPoJSOUsuX3RpvBzZbB3Ab4JERRHPAyIcrDalJi4WP1TCO
	9/IVmvSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricz4-0000000A8ht-3roj;
	Fri, 08 Mar 2024 16:22:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricyx-0000000A8e9-2YAz;
	Fri, 08 Mar 2024 16:22:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CA20F60CF9;
	Fri,  8 Mar 2024 16:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07AAC433F1;
	Fri,  8 Mar 2024 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914922;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKMl43ENQX2qCLbqhcdxYm18rFTN3J2xk1iLYB9T7z326Q+zdsuDw+WCUOlr7fa46
	 zq1wqHbxNrvotvJ7D0DQcf1OG/PPon7IeIyUyXLO5cdnZ1jvrHAC1UY9UNvFvJhBMu
	 g0Kjbjlsv76rCe2wUXchWPSTU512naV8r9kxaL5jvpm/onAedusnEQf2d09rtGZkUX
	 /8E7xBNpRTOVeNhHx/VR7TMXZNK+bWenKk1tlSskNk6UYBbwIlQDbO0nXGrTVdcSgx
	 5Qd88Z2Z/v6yzzCBTEhTFcJJDfj5wqDaJYGNNbRJt33csSb42XQHzxjMwKYH+ynNx+
	 JcgNGaUwovoPg==
Date: Fri, 8 Mar 2024 09:21:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] nvme-apple: Convert to platform remove callback
 returning void
Message-ID: <Zes7JyArYIajiHtP@kbusch-mbp>
References: <c035aaf3bffc16018d657dd3dab37751da9f3564.1709886922.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c035aaf3bffc16018d657dd3dab37751da9f3564.1709886922.git.u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_082203_772906_154AD91B 
X-CRM114-Status: UNSURE (   6.21  )
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

Thanks, applied to nvme-6.9.

