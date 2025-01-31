Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A5C02193
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqG4CxDWBvBBn3RpBg4y57WRbrobiMNRXA59zwyxECA=; b=YwLoKGTvNQ7WoNY9x0n4SAnfeN
	xym/YsI/i6AR2BEjmHHpMnJ5zpf9zIwOxeRkVBJg1ZavYwwNsRYnYLd/rfi71aST2yFNh6UAYwifB
	1JA4rh3sJ65gOxsocIYZUlemrVXDmZ+Wl5UAtO2qgivzYfcTWh4xBxZWXTo3pT6y2G/8qI8EUJWmF
	ORZ+WM4+MdUJkDWlq5XUBnndNA2jr1OTf/slxoG4WvRIsefw3tYlwzqXvW6cERcFUOoRC9Hb3iS4B
	hyrN7PqNa1e7uVCpu66xeRN7Xbd6AY+4ArIrrPtg3bbd9XNzJZ/VyM3qFPaA+FRJQKHer9qqh6HT9
	WGGgLJ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmn0-0000000AFXB-1alZ;
	Fri, 31 Jan 2025 08:54:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdmmx-0000000AFWn-0lmT
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 08:54:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C83E568B05; Fri, 31 Jan 2025 09:54:01 +0100 (CET)
Date: Fri, 31 Jan 2025 09:54:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-mq: fix wait condition for tagset wait
 completed check
Message-ID: <20250131085401.GA17935@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-3-40c586581171@kernel.org> <b53dad99-6a8e-402e-9330-597289ecd8fd@grimberg.me> <04ca03dd-d240-458a-a049-8cf0ea7f9dcc@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ca03dd-d240-458a-a049-8cf0ea7f9dcc@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_005411_368065_165A0479 
X-CRM114-Status: GOOD (  13.65  )
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

On Fri, Jan 31, 2025 at 09:46:46AM +0100, Daniel Wagner wrote:
> The problem I am running into with my wip tp4129 patchset is that
> requests are pending an newly introduce requeue_list queue and never get
> canceled because these requests stay in the COMPLETE state at the
> moment. This blocked the shutdown path.

I'd recomend to not bother impemebting 4129 as it's a fucked up mess.


