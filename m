Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99565C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5uMi86yn02niuwFM1GyAQswdeU+0F+3pXuxj+WoWF8=; b=qO2lGDAFYIht5I3fPirPV8J3sR
	La0mTzkNm17JC30xn7sbkwJL0Tw/vIKzFjZMa+QUiYcCAotz7Ocl9Qb/oL/EGiXNiY5gUwJYgmBEM
	n8TJC9Q5BKu9xVMXucL5o/5ybztbLO/+RkR7Dt0vfqugJJG1dcR6RmOhyswOIFkEEEHyViinc3B9Q
	8gIestOy8y6MAc9uuP1qSAh6UPM71dRjnMmC8huq3xg4YDrtqMK+0gjEwHs8HCdpcl8ckEA5nDPQX
	laWxhzOq4ueknMjNIo6CT8r10Bhtkxq9X0D93fu2Q0tBxh7P1zNyhayujc/7QaPQIzSy6LybfCYiX
	XaZgBUYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbPFk-00FjXf-1t; Mon, 04 Apr 2022 16:08:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbPD2-00Fi1W-RD; Mon, 04 Apr 2022 16:05:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9747568AFE; Mon,  4 Apr 2022 18:05:36 +0200 (CEST)
Date: Mon, 4 Apr 2022 18:05:36 +0200
From: "hch@lst.de" <hch@lst.de>
To: Sven Peter <sven@svenpeter.dev>
Cc: "hch@lst.de" <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220404160536.GA9948@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de>
 <cc74471b-8077-4c52-8607-eb7d2ecccd7a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc74471b-8077-4c52-8607-eb7d2ecccd7a@www.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_090541_067488_95FA5D6E 
X-CRM114-Status: GOOD (  10.94  )
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

On Mon, Apr 04, 2022 at 06:03:28PM +0200, Sven Peter wrote:
> fwiw, I wrote that code and I just forgot to check the line length
> after some last minute changes again.
> It's already been reduced to 80 chars in my local tree.

Awesome!

