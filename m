Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFACCFD2F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kkqLiWMaLIkpc3op8zLaM1FmTjK/y/owL8L50nZDjIM=; b=zGAZuxSUrmnXXT+NbYFpEJ5pO5
	EN9qlkkPCV+xTkC3afWitkzePKlY+v8nPxIa/KU877UcBB9ZqqiBJp53ayz6SHZXAanhiLfc20i3l
	3liwQkSLsIjQnCe7Vavaii6zYjKAk6fpC4AU/MQzIv7ILDLHPEPS/kMnAeLcpkMNAyguffEE91hI7
	mK6VhkSa7rmdYUFMLo9/gbRb/MCz+d0HmQOGNvzw4hf5BOGyjl5Fs+1nzGO3EX0BOWwoGE1K0MR5f
	TPsRwxv6/x9yOAYlG2XXLhZFPsI5q5Def892CxVaev1tUbmXQuiKk2fIkswMNg+a6IbyVpY8zQ7QJ
	4fRpf+NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBUO-0000000Fl2B-1wdt;
	Fri, 11 Oct 2024 08:59:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBUL-0000000Fl1Q-2jxW
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:59:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBA6F227AB3; Fri, 11 Oct 2024 10:59:04 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:59:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Hans Holmberg <hans@owltronix.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	"vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241011085904.GB4039@lst.de>
References: <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com> <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local> <CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com> <20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local> <CANr-nt2=Lee8B94DMPY6yDaGaBD=Lt9qdG2TzGhAwU=ddZxckg@mail.gmail.com> <CGME20241010122734eucas1p1e20a5263a4d69db81b50b8b03608fad1@eucas1p1.samsung.com> <20241010122733.bv7vxemqnxr573pz@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010122733.bv7vxemqnxr573pz@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_015909_856069_55216332 
X-CRM114-Status: GOOD (  13.09  )
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

On Thu, Oct 10, 2024 at 02:27:33PM +0200, Javier Gonzalez wrote:

[full quote snipped, it would be really helpful to only quote what you
actuall reference per the usual email rules]

>> Data placement by-file is based on that the lifetime of a file's data
>> blocks are strongly correlated. When a file is deleted, all its blocks
>> will be reclaimable at that point. This requires knowledge about the
>> data placement buckets and works really well without any hints
>> provided.
>
> But we need hints to put files together. I believe you do this already,
> as no placement protocol gives you unlimited separation.

The per-file temperature hints do a reasonable job for that.  A fully
developed version of the separate write streams submitted by Kanchan
would probably do even better, but for now the per-file hints seem
to be enough.

> Maybe you can post some patches on the parts dedicated to the VFS level
> and user-space API (syscall or uring)?

It's just using the existing temperature hints.


