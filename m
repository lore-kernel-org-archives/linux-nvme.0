Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD5C47423
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:18:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9576A20878
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uts/Hgs6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0I0jvTv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9576A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nA2xEXdIRYf/oCvt4Flfdf0XrTQ59whlGThbMPbLly8=; b=uts/Hgs63gY9ywPHWcRn3bBxY
	jAqoF0Iwmjh8n0ESjUe1f0S9c2kC7QOe7hTXDLTBqQWYrkeegBqIww0mW3FgBDLZAm38PByCXLeKK
	ldbyOD5NbleciEemSp1w6jISMrAxAUzODO/pQXqcP/7g0jWQBi3eqX0ds3mTMX8FUf/ey60IpHL5r
	P3KpV3ittQyHVbgtBiZGpG6eoBBk0JvOOqJom+aaxfwWI/OulLy5sRBNkktn6bv1QRGiEyMmsHCWs
	sV0eC/M8Zx3cjnFV5CbP1C3mYkLRvATuRp6Qchp7YDRDQSiCvDWqOFCUD07KvT5ByeZmV/4n72Af2
	PBBFe9FtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLpU1-0005c7-NQ; Fri, 25 Sep 2020 15:18:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpTz-0005bT-2X
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 15:17:59 +0000
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B44E920878;
 Fri, 25 Sep 2020 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601047078;
 bh=Memmat2QMSKm4nwC6E/N+LYsT2VSLAWg4jqrX9rOxRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0I0jvTv72ihg9+bzMure3BX1lc+87CO5bL9392leVtXnedqMSe5ygE5G4jcX2w1qW
 xoHSyqw+O8y4wGORU/iFtjKf17BUhMzTBzKdn1CSNW/QQG4RWwA0fbFWc2yeKlC8z5
 AE3L4akyOt44u/YxCsUo0F4LAURd4D62LpCDsAXE=
Date: Fri, 25 Sep 2020 17:18:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v8 1/7] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200925151812.GA3182427@kroah.com>
References: <20200925150119.112016-1-colyli@suse.de>
 <20200925150119.112016-2-colyli@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925150119.112016-2-colyli@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_111759_245498_7EC736E8 
X-CRM114-Status: GOOD (  26.16  )
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

On Fri, Sep 25, 2020 at 11:01:13PM +0800, Coly Li wrote:
> The original problem was from nvme-over-tcp code, who mistakenly uses
> kernel_sendpage() to send pages allocated by __get_free_pages() without
> __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> from a corrupted kernel heap, because these pages are incorrectly freed
> in network stack as page_count 0 pages.
> 
> This patch introduces a helper sendpage_ok(), it returns true if the
> checking page,
> - is not slab page: PageSlab(page) is false.
> - has page refcount: page_count(page) is not zero
> 
> All drivers who want to send page to remote end by kernel_sendpage()
> may use this helper to check whether the page is OK. If the helper does
> not return true, the driver should try other non sendpage method (e.g.
> sock_no_sendpage()) to handle the page.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jan Kara <jack@suse.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Vlastimil Babka <vbabka@suse.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/net.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index d48ff1180879..05db8690f67e 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -21,6 +21,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/once.h>
>  #include <linux/fs.h>
> +#include <linux/mm.h>
>  #include <linux/sockptr.h>
>  
>  #include <uapi/linux/net.h>
> @@ -286,6 +287,21 @@ do {									\
>  #define net_get_random_once_wait(buf, nbytes)			\
>  	get_random_once_wait((buf), (nbytes))
>  
> +/*
> + * E.g. XFS meta- & log-data is in slab pages, or bcache meta
> + * data pages, or other high order pages allocated by
> + * __get_free_pages() without __GFP_COMP, which have a page_count
> + * of 0 and/or have PageSlab() set. We cannot use send_page for
> + * those, as that does get_page(); put_page(); and would cause
> + * either a VM_BUG directly, or __page_cache_release a page that
> + * would actually still be referenced by someone, leading to some
> + * obscure delayed Oops somewhere else.
> + */
> +static inline bool sendpage_ok(struct page *page)
> +{
> +	return  !PageSlab(page) && page_count(page) >= 1;

Do you have one extra ' ' after "return" there?

And this feels like a mm thing, why put it in net.h and not mm.h?

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
