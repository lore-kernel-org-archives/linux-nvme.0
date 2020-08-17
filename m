Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA3C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 05:45:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF82E20772
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 05:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f2m3BsXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF82E20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RqaPvsUu9MwO0URAHiZMNz5tfOWqim4vLTmDeogyHRI=; b=f2m3BsXxWIZpWY4jVcFSrMqj/
	pRnSO2UV8ZSkeV1xucSkDdcjfjacayEJFA53gGGjqLRkYQHLgcItEXd8drP3ioIyjCoNP+tioqXRl
	N+kjVY7aVliFvGEjLec6kejtpd+j3tBfF9Vk6GdTKRJ1gqWBB/hhdPuxWP97yRuD35oK7/OSl0MuK
	rWUFjT9YDqa4R+Nc/4/Y2yXqYmiV7mciDTOeQR8QwLMrSWxjqGM8kcLooldM3wWzYxz2Z0Y/Rurq5
	ucF50PKn9xYgyX5qtQeMqBQdM0wLI4Wyoi9Cl/dlOC3Llf0ihrfMOsVjh6MrWO2YWCCF4K1yGTgPL
	Rg1BoOI9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7Xxr-0007tM-Ap; Mon, 17 Aug 2020 05:45:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7Xxn-0007qi-Uz
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 05:45:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 69E1767357; Mon, 17 Aug 2020 07:45:38 +0200 (CEST)
Date: Mon, 17 Aug 2020 07:45:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200817054538.GA11705@lst.de>
References: <20200816071518.6964-1-colyli@suse.de>
 <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_014544_151290_3F18AAC0 
X-CRM114-Status: GOOD (  23.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Aug 16, 2020 at 10:55:09AM -0700, Cong Wang wrote:
> On Sun, Aug 16, 2020 at 1:36 AM Coly Li <colyli@suse.de> wrote:
> >
> > The original problem was from nvme-over-tcp code, who mistakenly uses
> > kernel_sendpage() to send pages allocated by __get_free_pages() without
> > __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> > tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> > from a corrupted kernel heap, because these pages are incorrectly freed
> > in network stack as page_count 0 pages.
> >
> > This patch introduces a helper sendpage_ok(), it returns true if the
> > checking page,
> > - is not slab page: PageSlab(page) is false.
> > - has page refcount: page_count(page) is not zero
> >
> > All drivers who want to send page to remote end by kernel_sendpage()
> > may use this helper to check whether the page is OK. If the helper does
> > not return true, the driver should try other non sendpage method (e.g.
> > sock_no_sendpage()) to handle the page.
> 
> Can we leave this helper to mm subsystem?
> 
> I know it is for sendpage, but its implementation is all about some
> mm details and its two callers do not belong to net subsystem either.
> 
> Think this in another way: who would fix it if it is buggy? I bet mm people
> should. ;)

No.  This is all about a really unusual imitation in sendpage, which
is pretty much unexpected.  In fact the best thing would be to make
sock_sendpage do the right thing and call sock_no_sendpage based
on this condition, so that driver writers don't have to worry at all.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
