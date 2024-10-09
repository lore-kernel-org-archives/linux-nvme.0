Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553FECF044A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 10:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRi1xw9x2G21+lgKlQuTS5aW8+TQ8D2sU2bGhSsLwvk=; b=hnFXUz7ZLMZvsV2QtYCTvgisgm
	5yJkIrR6gGx3LYQ4WasDnaDw8Ga0w5zqvrRwxEeAP07na+lewbBDOBaUaohoxTDkpIiN1AAAAw8Uu
	5vII/+5xGZek9oksBTHATmX8kvretMQDUze+Y9xCuHrEVUpc6wkpqId2Hh11FHhSLsM83T4kQxcB/
	k7BIQAblsr+m9rh8Z96+HJWuVG1M6cG6WYyN3V0zzuqb9WvrZTgSGjIjqmWxhTpvlvhQBVOJkfkAq
	5rWqMEtdBC68/zc9nEGtSbe73iZKAMoEM8fynAaJoltP9ZBcko7mB4YKY/YBf1s7DxJEv3XJASkE9
	NrP4uy5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syTxv-00000008tCY-3pi7;
	Wed, 09 Oct 2024 10:30:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sySzg-00000008g64-3kmn
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 09:28:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B9C2227A8E; Wed,  9 Oct 2024 11:28:28 +0200 (CEST)
Date: Wed, 9 Oct 2024 11:28:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241009092828.GA18118@lst.de>
References: <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk> <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com> <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local> <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwVFTHMjrI4MaPtj@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_022833_106106_44793BD4 
X-CRM114-Status: GOOD (  12.57  )
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

On Tue, Oct 08, 2024 at 08:44:28AM -0600, Keith Busch wrote:
> Then let's just continue with patches 1 and 2. They introduce no new
> user or kernel APIs, and people have already reported improvements using
> it.

They are still not any way actually exposing the FDP functionality
in the standard though.  How is your application going to align
anything to the reclaim unit?  Or is this another of the cases where
as a hyperscaler you just "know" from the data sheet?

But also given that the submitter completely disappeared and refuses
to even discuss his patches I thing they are simply abandonware at
this point anyway.

