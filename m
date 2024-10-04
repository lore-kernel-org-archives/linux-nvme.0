Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A90ECFA773
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gbeMhdsGHGuI5XN2WSjDKqZCAnl+iJLPZBfPI6RRK6s=; b=X6bS1GeMQApOqdcoXfqUpUR96e
	gBJWSa2qezSXXxf4i1gxjtzh+xVzKB5yPrsE9gyzbRDKsSlElW7INnM6Eyhnw6qrll30qHaFqmLyV
	kKm10jA7xZeTH22k2RYZW/1cT/7laiH0Par8kWgNIRhYGEzMiUcct48AfSNpZ2Cj9i6ggjrsrXEEa
	8gY8P29VWlaQ/dmna1xnbO/L1mUbLwFAGoO6awQ6qDqZ8YqBJs/ovWv9lu25+zo2+5IRlVfGUB4zK
	z7HK6RS38OZVpbqKX1L2cG8QJfzuMW4wOq7fZjjw/28R+Ir0VRptmb12Z1XPujpQ2knjmXbw4uYtM
	6noUTWHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swhS7-0000000CJHg-3qqL;
	Fri, 04 Oct 2024 12:30:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swhS5-0000000CJGy-2bRI
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 12:30:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 225E6227A88; Fri,  4 Oct 2024 14:30:28 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:30:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004123027.GA19168@lst.de>
References: <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk> <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com> <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local> <20241004062733.GB14876@lst.de> <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_053033_827449_DAF8D016 
X-CRM114-Status: GOOD (  24.23  )
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

On Fri, Oct 04, 2024 at 08:52:33AM +0200, Javier González wrote:
> So, considerign that file system _are_ able to use temperature hints and
> actually make them work, why don't we support FDP the same way we are
> supporting zones so that people can use it in production?

Because apparently no one has tried it.  It should be possible in theory,
but for example unless you have power of 2 reclaim unit size size it
won't work very well with XFS where the AGs/RTGs must be power of two
aligned in the LBA space, except by overprovisioning the LBA space vs
the capacity actually used.

> I agree that down the road, an interface that allows hints (many more
> than 5!) is needed. And in my opinion, this interface should not have
> semintics attached to it, just a hint ID, #hints, and enough space to
> put 100s of them to support storage node deployments. But this needs to
> come from the users of the hints / zones / streams / etc,  not from
> us vendors. We do not have neither details on how they deploy these
> features at scale, nor the workloads to validate the results. Anything
> else will probably just continue polluting the storage stack with more
> interfaces that are not used and add to the problem of data placement
> fragmentation.

Please always mentioned what layer you are talking about.  At the syscall
level the temperatur hints are doing quite ok.  A full stream separation
would obviously be a lot better, as would be communicating the zone /
reclaim unit / etc size.

As an interface to a driver that doesn't natively speak temperature
hint on the other hand it doesn't work at all.

> The issue is that the first series of this patch, which is as simple as
> it gets, hit the list in May. Since then we are down paths that lead
> nowhere. So the line between real technical feedback that leads to
> a feature being merged, and technical misleading to make people be a
> busy bee becomes very thin. In the whole data placement effort, we have
> been down this path many times, unfortunately...

Well, the previous round was the first one actually trying to address the
fundamental issue after 4 month.  And then after a first round of feedback
it gets shutdown somehow out of nowhere.  As a maintainer and review that
is the kinda of contributors I have a hard time taking serious.


