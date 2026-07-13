Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1EC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=v4cU/NZK01rE5/nCeoLExSdFIt
	EybX1Aww0Ic9pHSjNNhmYkVTn7mNppa/BgT0clY5K3eoDNwmBUbb8c7x8cgX4vaek5A2gzDKHjfG6
	cZx/LRrK7+8hssI09DBMvhYDdrbVqotQvBDKT899DfHe87n8JHSyeqqVXkG5urwcKDArR2+3zGzmK
	dF369mRBUzKEGkOGQR0Ok903EEEAJMzjUZHWxSj4Brn+I5641idSkw1Tq6cMwak0KXuHk9iIxW163
	K0QTZ9wCveHATED5oRmTzSvCILdQwL2wgrMtc7ubg+l+21Bo+qVK4GUKSB6NrkLhonHY+RaeSXi+d
	pwgBA8kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAO5-00000008IIb-1Rcy;
	Mon, 13 Jul 2026 06:43:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAO2-00000008II4-2PsV
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 06:43:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5CD368BEB; Mon, 13 Jul 2026 08:43:27 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:43:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme: clamp FDP nruhsd to allocated RUH status
 descriptor count
Message-ID: <20260713064327.GD29416@lst.de>
References: <2026070931-stopping-cost-239a@gregkh> <2026070932-fried-frying-9c36@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070932-fried-frying-9c36@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_234330_781790_4F002494 
X-CRM114-Status: GOOD (  10.33  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


