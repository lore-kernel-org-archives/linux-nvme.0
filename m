Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A23CFA74A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 06:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1nB2s2trJsqWTEuA9oNUqHWzkAFbhLZNlaVfAk9e+I=; b=UL//IhoYwtVLJa1DqND09ymofK
	OGverRo45AuR5S1iwJH/ctor0kRP8Wwy0Vrp89Ewm2MTo05T7zHgwB5NVjvElkDTtQFOd6cd9EwZN
	Kd2PdudtOT23jf5fATa2YX7ljkO4avvsfN5ETQBSFvltPU9m/PSHX0BPvXQV8UNPfLf6DvHZGjHZj
	+ak1WUbhWWdfWSTKKGtt4MdzL5lDmChL8nR5/NWFBCmhWl+COpogcVoKUkuMt0lS4X8OWje+YYU+Z
	Tz0TeyTtp0fpWVUM7t0yqJmS0i32MqeMXFHYaH4aj/hv0qZ8Is2ZejYrFOMoRC87xmbthwZ7dYTX2
	HZ/Q3JOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swbmv-0000000B8Oj-27iU;
	Fri, 04 Oct 2024 06:27:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swbms-0000000B8OG-1U15
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 06:27:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1B57227A87; Fri,  4 Oct 2024 08:27:33 +0200 (CEST)
Date: Fri, 4 Oct 2024 08:27:33 +0200
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
Message-ID: <20241004062733.GB14876@lst.de>
References: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de> <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk> <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com> <20241004053121.GB14265@lst.de> <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_232738_556095_38F1BD5E 
X-CRM114-Status: GOOD (  16.38  )
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

On Fri, Oct 04, 2024 at 08:18:11AM +0200, Javier González wrote:
>> And for anyone who followed the previous discussions of the patches
>> none of this should been new, each point has been made at least three
>> times before.
>
> Looking at the work you and Hans have been doing on XFS, it seems you
> have been successful at mapping the semantics of the temperature to
> zones (which has no semantics, just as FDP).
>
>    What is the difference between the mapping in zones and for FDP?

Probably not much, except for all the pitfalls in the FDP not quite hint
not madatory design.

> The whole point is using an existing interface to cover the use-case of
> people wanting hints in block.

And that's fine.  And that point all the way back for month is that
doing a complete dumb mapping in the driver for that is fundamentally
wrong.  Kanchan's previous series did about 50% of the work to get
it rid, but then everyone dropped dead and played politics.


