Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE0CF6D36
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Nqd2jRxm6cKzWmypd9JYzgLRQ5iJnigswL4zpe6vMo=; b=S4kJEtMCHRIpzrn6oyvjhvlaaX
	Vgk8mGDHLngAEZ83WchrKmK+ArV9zEIrKx0PwUcYOtoKdu8j4WEsYkL0mqbi3oZdrdvaC+AWG5gkP
	Y8rH3vsSu1DQBECpNkojQ8HhZJyjP9nlKfKnMSsjWu+34qjKhhpWpzN6daDlqMPH5npgwvnj8I9l/
	Xi9KmvDSDuHMDPE+AcABhuWGfznRZy9XC1J2N//fv26Pr3/Gpd32gxVjs+xRutfqNSQJ+a0+xs5C3
	mkAcuapBHnP8Aw6INtdMrwHnNEF8HY/BQtHQUJZS0KeXfCaYYFL3ZA775GFjyno/Rj3Zvg0GMc8F2
	sGB0GGcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw14J-00000006a4G-1LtN;
	Wed, 02 Oct 2024 15:15:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw133-00000006ZmW-2vea
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:15:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C558B227AB1; Wed,  2 Oct 2024 17:13:44 +0200 (CEST)
Date: Wed, 2 Oct 2024 17:13:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241002151344.GA20364@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_081353_907916_FA31BA4D 
X-CRM114-Status: GOOD (  17.77  )
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

On Wed, Oct 02, 2024 at 09:03:22AM -0600, Jens Axboe wrote:
> > The previous stream separation approach made total sense, but just
> > needed a fair amount of work.  But it closely matches how things work
> > at the hardware and file system level, so it was the right approach.
> 
> What am I missing that makes this effort that different from streams?
> Both are a lifetime hint.

A stream has a lot less strings attached.  But hey, don't make me
argue for streams - you pushed the API in despite reservations back
then, and we've learned a lot since.

> > Suddenly dropping that and ignoring all comments really feels like
> > someone urgently needs to pull a marketing stunt here.
> 
> I think someone is just trying to finally get this feature in, so it
> can get used by customers, after many months of fairly unproductive
> discussion.

Well, he finally started on the right approach and gave it up after the
first round of feedback.  That's just a bit weird.


