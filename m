Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EC6C44501
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lV8qSQPQMKExral5jcuzL4Ze+TskJln6WWCwKG1lwKQ=; b=zD7NT1KM3k0trT7Yqg7ktlu3o/
	rOI/rIAW7XbJXL7OMFwm7HaEOYd1QLjILB+T8xAT/lA1HT+AcLpD7rQ08Y7QJXi24N3JH9ykdiO4k
	W7Qx97SLh0bsKZXqZJBLvCZ5jVgA9C1wk54A2MuVg+cULSh6QWE53Be6Mo8LVWk3PhIN6+bFFCyOF
	IKfNWSu12/wRiqadL4DOJGU+raN/uKqlbh1kXVG2ZIY/DM6hH/4bB0pnQDKhY22roRYD+nSX4mEpe
	TBYtKiapwElamFSSxxX9+tiEvBMJ2elVcz2fk2izxVjT+RpyfspbM1T9udW6Q+3LLEFwr2JGl5NF9
	x9nLFGpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi2N-000000017xE-0j5U;
	Thu, 09 Jul 2026 06:15:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi2K-000000017wr-2vPO
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:15:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FED568CFE; Thu,  9 Jul 2026 08:15:01 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:15:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/17] block: support non-blocking bio
 allocation with a bdev
Message-ID: <20260709061500.GE16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-8-yukuai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-8-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_231504_907155_EDCC7861 
X-CRM114-Status: UNSURE (   9.55  )
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

Maybe we should just move the blkcg allocation back to bio_submit where
we know we can sleep?


