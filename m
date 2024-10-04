Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E516ACFA749
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5o3T5RyacadqNdFdXd1+rCRnTJLj+4F4aL6truNMKEs=; b=jUySbmCZoIEKsPXiJ+iv6NCSV6
	8CZFplNaUUHx1ptm3+13EERgkeZZQNui37ZwN32ig2RhQm9jaeMvSePzmjc780ILK+qc7Ad8CkCl6
	w4DeqS/5FRHj+ppst7VE49cPMhfK64hR+wCQBT6ew66TSL+lSpieUj8FQcW6V+kRE1bAKVq31PXTO
	wYg46EjtkX3oDSd7TDjbcXVR1K7Wf1ltsY8Ttf6kDwTg5BAVYoPngM9uru406uMbX8Wimqn/vCPfl
	9du5CgDXiSd8RQ+JOd9HXdM2HW+ZBR6fQei1viKpUy7QdUJIeYY99ke52w2v6mZyKYhhjL1vcMiE4
	GVxNPjaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swbjl-0000000B7sl-23uX;
	Fri, 04 Oct 2024 06:24:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swbjj-0000000B7rX-0ar4
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 06:24:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44FFD227A87; Fri,  4 Oct 2024 08:24:16 +0200 (CEST)
Date: Fri, 4 Oct 2024 08:24:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241004062415.GA14876@lst.de>
References: <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org> <CGME20241003125523eucas1p272ad9afc8decfd941104a5c137662307@eucas1p2.samsung.com> <20241003125516.GC17031@lst.de> <20241004062129.z4n6xi4i2ck4nuqh@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004062129.z4n6xi4i2ck4nuqh@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_232423_344212_DECCDB25 
X-CRM114-Status: GOOD (  13.39  )
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

On Fri, Oct 04, 2024 at 08:21:29AM +0200, Javier González wrote:
>> So I think some peoples bonuses depend on not understanding the problem
>> I fear :(
>>
>
> Please, don't.
>
> Childish comments like this delegitimize the work that a lot of people
> are doing in Linux.

It's the only very sarcastic explanation I can come up with to explain
this discussion, where people from the exactly two companies where this
might be bonus material love political discussion and drop dead when it
turns technical.

I'm probably wrong, but I've run out of other explanations.


