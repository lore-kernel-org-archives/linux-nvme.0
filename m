Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731D2CF6D36
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43jg9EgmCssFXt9zAHIWBa/UcdGJCybt5NGaRqKqnXY=; b=A6OEJ7QSuCy4GRHrs2DJZ2fEAS
	LP2igcCQVtT20lOSy7UQR/aYCmyVaDHkcstNAhmCBee3yXL38v2m+iPBsRkHeD7P9GxOMkcwi6l8h
	cHKPJOzs4mKf1jNYzuT6Bx7rdK5GqK9PQNrZhv6IH+eHZJCnZLix11nVLQ9KeHD1q8a6108oNPTD7
	MiyN6F/a8yOLc/bUB98xQPLWAeS5HKM66uupInP98naywM9iZlpFgKhYg36InsoMjxi7pgT8s77Hd
	D+DJEDvhlTB3F3oMZbp1LDCqLRtXXUp+ERXrVyF+OZJF3ve6BwZlenogZiz7ZXGMhXNBDJiMn99Wg
	cOAno8Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw18v-00000006bng-3sT8;
	Wed, 02 Oct 2024 15:19:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw18s-00000006bkv-1BB9
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:19:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 169C6227AB1; Wed,  2 Oct 2024 17:19:50 +0200 (CEST)
Date: Wed, 2 Oct 2024 17:19:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241002151949.GA20877@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_081954_482757_3648AA3B 
X-CRM114-Status: GOOD (  17.23  )
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

On Wed, Oct 02, 2024 at 09:17:35AM -0600, Keith Busch wrote:
> On Wed, Oct 02, 2024 at 05:13:44PM +0200, Christoph Hellwig wrote:
> > 
> > Well, he finally started on the right approach and gave it up after the
> > first round of feedback.  That's just a bit weird.
> 
> Nothing prevents future improvements in that direction. It just seems
> out of scope for what Kanchan is trying to enable for his customer use
> cases. This patch looks harmless.

It's not really.  Once we wire it up like this we mess up the ability
to use the feature in other ways.  Additionally the per-I/O hints are
simply broken if you want a file system in the way as last time,
and if I don't misremember you acknowledged in person last week.

