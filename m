Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989F8C54F51
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHPfV3RD6vW2cC87Nx8I0nem5pmDVBJJlTYT0fbqMW0=; b=qlpa/LLmNVPihxbilIQVoYYYpy
	QcZITG6qlBeR1wNRqvFUNdM25CqQTSYrCTzC4/lbB44QYWvbtftdtpTXXZlFntuvBMY0yE8/jk1Io
	ngf4a/4Q9PUQJ01ynaduQRdGmJyvXtQvBRLQ90CPlTAOW2dTolkYTzZFhbQM7Jwtw86A3Qv3T4mRu
	JMQcYJ8WuJXV4NGQ+4+0VkdFDQhmbZgK8Tf+ECFeGaQH3ZBNmSwFhqvnXr4juCb5GzY/Yv5W+8i7h
	mN7px7WsYM8JazRvCO6jTYpPNOCynA14YAYr0nvTjMn1v8fZbwtTVofnURTYeb+O6OTrk0/D6wzg+
	H4S1dXjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wop0E-00000006FzP-17NB;
	Tue, 28 Jul 2026 21:06:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wop0C-00000006Fyx-2If8;
	Tue, 28 Jul 2026 21:06:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 005F4418D1;
	Tue, 28 Jul 2026 21:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ABE1F000E9;
	Tue, 28 Jul 2026 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785272775;
	bh=JHPfV3RD6vW2cC87Nx8I0nem5pmDVBJJlTYT0fbqMW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RTD4V4dmICcZrQHmHCByRSVOM4g7FmD4Rlx8Tc/7WrZ7Ocg6K08loPzrZupR7Vqum
	 8xh8QIKhzs8r+1tC6mY+duoCntPjASXlplGkK0QO/7o+PZ+HEaMM95FA5qNAXKi4zw
	 PFrZaYptH2Tbo2Bu0XBHC9pET8ZNbD8hLy+SuHovpGrNRYxequR4boeD3026UAzpd/
	 uyJFpMiEneuuIFbkN+Mpc1Xems9fkDF1AzXSkn0fk8jivs9HVwWP6lm0Stxa5C5P3u
	 ZTPmIXThwWAfhsxrB2av+b+RqJXPZ7koCPsyyFlaghz4E91aqYrgVkCF5jXcdAgTMX
	 uH5b4rI8hs+ZQ==
Date: Tue, 28 Jul 2026 15:06:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:ARM/APPLE MACHINE SUPPORT" <asahi@lists.linux.dev>,
	"moderated list:ARM/APPLE MACHINE SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-apple: Remove redundant dev_err_probe()
Message-ID: <amkZxmW3hGbRvUa4@kbusch-mbp>
References: <20260716033301.212797-1-panchuang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716033301.212797-1-panchuang@vivo.com>
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

On Thu, Jul 16, 2026 at 11:33:01AM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err_probe() calls.

Thanks, applied to nvme-7.3.

