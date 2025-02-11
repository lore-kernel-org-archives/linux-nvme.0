Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155AFC0219E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2025 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dROJ93SmGf9kZKqyuSupEaRXlVxtcG3/R9t0NyoM3J0=; b=V/RuPAYd1ZRF3w1RIMoiGomAAI
	p//cs2YoSjhWiWc3Rpii5bHS2PNY0mYhId0jyVZofFqQ8t/M5DTS/vB34XDGUGQ/QrVPQLhXCfFTD
	OJtRpmcThOzNMrb8QEtHiJtaKMNI+i99ymvscH8l1fp8yL+zsqjj432bSpr5txd7KgIQd8wyBksvg
	W9Wqa2WGGn3IeCuD8g82mtZTxl97NQLvgdI98VJexJ+aF4+QEGI/UQWTnhWx68/TxF7QiuK7/5G3P
	mhrTFi1RqNySpeCS9nF0Wyg+E1wGEyC39UWex62idQuqcRlf+hTRlN/zDLd87ZLoVXaYjbNH/Dxff
	HerQyiyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thvId-00000004tw3-2qrG;
	Tue, 11 Feb 2025 18:47:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thv9M-00000004ryY-1NJX;
	Tue, 11 Feb 2025 18:38:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC50B5C4949;
	Tue, 11 Feb 2025 18:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CCFC4CEDD;
	Tue, 11 Feb 2025 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739299103;
	bh=9d6jju/AIBaHpo4CcHOAS0x1UR/bdfVSyRx15+juWkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KM4EUBoMjRN48xcaieQjd0BFqnOJuWcuSbQtEJHC5hn90/M9bzWaCsy+NfatKadD5
	 wzYebE/Daz96X02ZYwZO/u7UA4Isg1XE8pzUej0EpmicEW9MSn2gMzR83dOlOXLcJy
	 jPOZ9OIahCPBkd2d1KDBubdKO8twfNjmRdEDCEhgFtxI69ad9Ea3KTzxSlFmMjlpaQ
	 kDrL8M5vH5HJwy0kQRYDH8KUIvntS7ecZNLjcdd6AfWNc+ROBuLTIBeYJbccI9ym/z
	 4T1hXfsOtpEP6QOMa1EsLNq5QoYiZohM1tlVvKkW70jVhc7kOx0PqYSWsstrLu4bTz
	 58+lRzskHQbDA==
Date: Tue, 11 Feb 2025 11:38:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] apple-nvme: bug and perf fixes
Message-ID: <Z6uZHKwyMCWgM1a4@kbusch-mbp>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_103824_410189_C76061D4 
X-CRM114-Status: GOOD (  13.55  )
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

On Tue, Feb 11, 2025 at 01:25:56PM -0500, Alyssa Rosenzweig wrote:
> This small series fixes three unrelated issues with the Apple NVMe
> driver.
> 
> * fix NVMe on firmware/machine
> * fix a power domain leak
> * fix pathological driver performance with random writes
> 
> The first two are strict bug fixes, the last is technically an
> optimization but given the measured 200x performance difference I do
> consider to be a fix ;-)

The last two patches look good to me.

I don't know anyone qualified to review the first patch, so I'll take
your word for it if no one replies in the next few days. :)

