Return-Path: <SRS0=Tdqk=DE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B062BC4346E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33033208FE
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 12:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0zC1V3yc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtJG2gRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33033208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LhuqfdrBx5UZEzYjUnABzCTctulplMVf3j1kofoe1c8=; b=0zC1V3yc4rUlDg6OS1qpalLNJ
	tjX0RwO5n9mFpCOTTWpV4IOLJlezQCEHxSJcxZynumjrheFWYcqxiB9CnGVxvwW5FTYoZybRnI9vo
	2AO5Ynx9/YVT2i1GaQx30XPjHCoEvWOvAKqfMVaGvvuojAo0rXHl6W7iPjgl62Hgaz50LE3EdOgm2
	O7/TbfPhDpeyZfR5LcuzKO1k1uYRlhm9Tu9fcAd3Nvc1/jX3SUBrveRWsCZxiu038zq1urezyWEmv
	4pUmMFDHLqPJ0JkjjreN9pfr91QMzIIiX5D0sYlj/XUsdDDsaHNEeXRYAh9zWtxxZDkJ5cWkeDZSk
	NQGEL48AA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMVfy-0001bE-Nn; Sun, 27 Sep 2020 12:21:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMVfv-0001aT-Bh
 for linux-nvme@lists.infradead.org; Sun, 27 Sep 2020 12:21:08 +0000
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74316208FE;
 Sun, 27 Sep 2020 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601209265;
 bh=FdSjEiIOfosty1A1hNpYjx+LCe0c93peV/xVsFD6r/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FtJG2gRJohbsXmjTGZLvssQG1XF1/EDPa+Sxt7uDN386HN/YFfrvpzrv4+5S2OGee
 WwgbRJn5W6gVfWdvXi4OwSNypTgoQvpwd2ypZNN7rw+jr66jN5W1yoJ984HbBn313O
 5EwO+4+ECjBUiIjNR1+7fPf+BlbKDjiL9nYij4XI=
Date: Sun, 27 Sep 2020 14:21:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v8 1/7] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200927122115.GA178781@kroah.com>
References: <20200925150119.112016-1-colyli@suse.de>
 <20200925150119.112016-2-colyli@suse.de>
 <20200925151812.GA3182427@kroah.com>
 <7b0d4f63-2fe5-9032-3b88-97619d8c5081@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b0d4f63-2fe5-9032-3b88-97619d8c5081@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200927_082107_566152_3889F2AA 
X-CRM114-Status: GOOD (  32.52  )
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
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, stable@vger.kernel.org, ceph-devel@vger.kernel.org,
 open-iscsi@googlegroups.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 26, 2020 at 09:28:03PM +0800, Coly Li wrote:
> On 2020/9/25 23:18, Greg KH wrote:
> > On Fri, Sep 25, 2020 at 11:01:13PM +0800, Coly Li wrote:
> >> The original problem was from nvme-over-tcp code, who mistakenly uses
> >> kernel_sendpage() to send pages allocated by __get_free_pages() without
> >> __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> >> tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> >> from a corrupted kernel heap, because these pages are incorrectly freed
> >> in network stack as page_count 0 pages.
> >>
> >> This patch introduces a helper sendpage_ok(), it returns true if the
> >> checking page,
> >> - is not slab page: PageSlab(page) is false.
> >> - has page refcount: page_count(page) is not zero
> >>
> >> All drivers who want to send page to remote end by kernel_sendpage()
> >> may use this helper to check whether the page is OK. If the helper does
> >> not return true, the driver should try other non sendpage method (e.g.
> >> sock_no_sendpage()) to handle the page.
> >>
> >> Signed-off-by: Coly Li <colyli@suse.de>
> >> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >> Cc: Christoph Hellwig <hch@lst.de>
> >> Cc: Hannes Reinecke <hare@suse.de>
> >> Cc: Jan Kara <jack@suse.com>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >> Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
> >> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> >> Cc: Sagi Grimberg <sagi@grimberg.me>
> >> Cc: Vlastimil Babka <vbabka@suse.com>
> >> Cc: stable@vger.kernel.org
> >> ---
> >>  include/linux/net.h | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/include/linux/net.h b/include/linux/net.h
> >> index d48ff1180879..05db8690f67e 100644
> >> --- a/include/linux/net.h
> >> +++ b/include/linux/net.h
> >> @@ -21,6 +21,7 @@
> >>  #include <linux/rcupdate.h>
> >>  #include <linux/once.h>
> >>  #include <linux/fs.h>
> >> +#include <linux/mm.h>
> >>  #include <linux/sockptr.h>
> >>  
> >>  #include <uapi/linux/net.h>
> >> @@ -286,6 +287,21 @@ do {									\
> >>  #define net_get_random_once_wait(buf, nbytes)			\
> >>  	get_random_once_wait((buf), (nbytes))
> >>  
> >> +/*
> >> + * E.g. XFS meta- & log-data is in slab pages, or bcache meta
> >> + * data pages, or other high order pages allocated by
> >> + * __get_free_pages() without __GFP_COMP, which have a page_count
> >> + * of 0 and/or have PageSlab() set. We cannot use send_page for
> >> + * those, as that does get_page(); put_page(); and would cause
> >> + * either a VM_BUG directly, or __page_cache_release a page that
> >> + * would actually still be referenced by someone, leading to some
> >> + * obscure delayed Oops somewhere else.
> >> + */
> >> +static inline bool sendpage_ok(struct page *page)
> >> +{
> >> +	return  !PageSlab(page) && page_count(page) >= 1;
> > 
> > Do you have one extra ' ' after "return" there?
> 
> It should be fixed in next version.
> 
> > 
> > And this feels like a mm thing, why put it in net.h and not mm.h?
> 
> This check is specific for kernel_sendpage(), so I want to place it
> closer to where kernel_sendpage() is declared.
> 
> And indeed there was similar discussion about why this helper is not in
> mm code in v5 series. Christoph supported to place sendpage_ok() in
> net.h, an uncompleted piece of his opinion was "It is not a mm bug, it
> is a networking quirk."

Ah, nevermind then, sorry for the noise :)

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
