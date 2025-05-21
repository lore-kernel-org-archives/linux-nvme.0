Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF4C54E90
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=eqkHYg3+xGf0M7G8PO36UIcslk
	X7F5GyLElxhCRwxxZTIqrTdHCWaytppLvLEubLf/SfDPGHCbW6PKa7VTcu8dqcTNGON5GfxEn5Tpv
	vJAFRPmxkzus3k73WGHPeGb3wYt6mo6rJsPTUoXb6n/AZX7SVYIihaNof7bcYKxusaNGIw/mYG4Ex
	Ceo/pjd1QGqV4MwjSbfv+wsUFJi2HiPe8bJTlU9JTpWG3OJiFdziRcxc3MfNfh+FZmxk1A7R/Fada
	ZqBY0TTyQA9uv6ASa4wzFdMKQADJc8OlFuVvpPY25MTOC4c7sEUqMJk+jPKWusOUnZ/35BujsmcAH
	gVvjxYvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHhMZ-0000000Fasc-0vwh;
	Wed, 21 May 2025 11:11:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHhKc-0000000FaYq-1m0b
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 11:09:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C728268D13; Wed, 21 May 2025 13:09:49 +0200 (CEST)
Date: Wed, 21 May 2025 13:09:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, dw@davidwei.uk
Subject: Re: [PATCH 1/1] nvme: enable vectored registered bufs for
 passthrough cmds
Message-ID: <20250521110949.GB23579@lst.de>
References: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_040954_598607_1FD6A293 
X-CRM114-Status: UNSURE (   8.82  )
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

Thanks,

applied to nvme-6.16.

