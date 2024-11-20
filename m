Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AA0D6E2BE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 06:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTT07AGsWtUkksAwl6a2WFmO5OjYZtapDj+h0Rat7Pk=; b=02qVSxqt6FSkYmQcaWcjqE7Ytr
	eqOCtUcfFUkLuJN5Ics9KAYDOoPYRzbiAMBZQtfOEo4XOBoXBejK/+9KAZBWYnMNsrEBYdrTDAOLu
	zCo/3/kx0Tx518ybT1b2lcB25cliqGWIm2eiMPtE9KBv8GGb3U/WhLTkK3SJ6F8Mj6XJscMVcTMzS
	9tBrAGhsjPhhIzhu3gj2cv/ZH7rKqSi5S/3/pwxO0P5MEbPQBoKVwx4KsFlAISSqVAkmx85b2aNZQ
	7N5Hk6MNtxsrFCTqQbjE6fmBmgFEpcg6IYIHEkQ6eQkNF7G5WFIZtucGnWbPO8CxViYMt32BvcMhs
	F28E/6XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDdoc-0000000ET1b-0QId;
	Wed, 20 Nov 2024 06:03:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDdoZ-0000000ET0Q-1scy
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 06:03:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4926268D8D; Wed, 20 Nov 2024 07:03:40 +0100 (CET)
Date: Wed, 20 Nov 2024 07:03:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme: enable FDP support
Message-ID: <20241120060340.GA10449@lst.de>
References: <20241119121632.1225556-1-hch@lst.de> <20241119121632.1225556-15-hch@lst.de> <ZzzWQFyq0Sv7cuHb@kbusch-mbp> <20241119182427.GA20997@lst.de> <Zz0V6qv3oyKV_Kzp@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz0V6qv3oyKV_Kzp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_220347_629700_4780DDAA 
X-CRM114-Status: GOOD (  13.50  )
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

On Tue, Nov 19, 2024 at 03:49:14PM -0700, Keith Busch wrote:
> But more about the return codes for pretty much all the errors here.
> They'll prevent the namespace from being visible, but I think you just
> want to set the limits to disable write streams instead. Otherwise it'd
> be a regression since namespaces configured this way are currently
> usable.

True, we should probably just log an error and continue here.  I'll
update it for the next version.


