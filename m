Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81DCD65C42
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 05:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FtdXRZttbjDxJ9LYLlgdATOXuxu/X1Z60pIZYKRo5c=; b=KQkv7UUJshtQf+ExLW8LRAS4Ig
	LSDZlbShNpi4Xa4Kvxy6QkeKuUM37FNRynq7QT5jv2BDDfI8b1QYnGx3hgHxJQ7e3Y2fy0QnTVyLh
	7agC42WI1gcwjFxqtZe8pgQS6eIeyQxT7yonjXbQ+XsR8xryue+3k8oYLlcXP96RKxTEk3nbys/sy
	vhwThXjgUILUb+xf/sExr74KOjG1Jl0KWFuvI2bfe+/QZagFCv41ZlPmr6F/Wz59xnlZkljotpw5e
	pVGUpTJvAuEzQ7b8fnKcw0ZNyuXfIzoWPK7n1xU5w0jhU1nMJwPTxEHGIblZkK0t01Mrf130aELHw
	vZyjSjbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSpd-00000008uA0-48rO;
	Thu, 14 Nov 2024 05:55:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSpa-00000008u9Q-3wFQ
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 05:55:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AE5068C7B; Thu, 14 Nov 2024 06:55:45 +0100 (CET)
Date: Thu, 14 Nov 2024 06:55:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bob Beckett <bob.beckett@collabora.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241114055544.GA10948@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTqgXqjN4UrT392@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_215551_140958_CE8B7263 
X-CRM114-Status: GOOD (  13.45  )
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

On Wed, Nov 13, 2024 at 11:05:53AM -0700, Keith Busch wrote:
> Well, he's doing what I suggested. I thought this was better because it
> puts the decision making in the initialization path instead of the IO
> path.

I guess it's fine in that regard.  It just usually expect patch
authors to at least reply to reviews..

