Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E3CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:38:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E94864E31
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E94864E31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SMdTwBYQWK6Xj+XBbgILSYcnP7LqBkwQJxPYKiT8yJE=; b=RvmQ1J/2Yn+NqB/9chAh445VR
	/7VHjG4aabPfkw7ZYIjvRI5hl4sTOOyFmytFIYGaoMSKzCfZ+XzKuVPtwIytRArVDztKktV3jrlE+
	OoOM8yWFBd6Vpn9ag/P/8RgFgK7pRPbR78TZpRZQEaJqGhvN9gPOdKq6SzbLk+4GudnfvBBxLcr74
	YAJoQnNCWDsDDu2ErVI2+prbjZl3qk48p2Q3kaRFSsmiyurs/swLvsOZEWKsGvSVxmaj/uJMT5iZI
	OGHhc6/EHJ77K434Pnt+7cJW39Vs9TIzo8YUaRKtkJ+rp9FiRrDbNhzKEONA+14t2rOBKhHreP4NV
	4Y/UOk4PA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlMl-004XLn-92; Thu, 18 Mar 2021 05:38:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlMg-004XLC-E1
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:38:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 721C268C65; Thu, 18 Mar 2021 06:38:32 +0100 (CET)
Date: Thu, 18 Mar 2021 06:38:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 3/8] fs: add file_operations->uring_cmd()
Message-ID: <20210318053832.GB28063@lst.de>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-4-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_053834_735229_87644989 
X-CRM114-Status: GOOD (  18.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Mar 17, 2021 at 04:10:22PM -0600, Jens Axboe wrote:
> This is a file private handler, similar to ioctls but hopefully a lot
> more sane and useful.

I really hate defining the interface in terms of io_uring.  This really
is nothing but an async ioctl.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec8f3ddf4a6a..009abc668987 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1884,6 +1884,15 @@ struct dir_context {
>  #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
>  
>  struct iov_iter;
> +struct io_uring_cmd;
> +
> +/*
> + * f_op->uring_cmd() issue flags
> + */
> +enum io_uring_cmd_flags {
> +	IO_URING_F_NONBLOCK		= 1,
> +	IO_URING_F_COMPLETE_DEFER	= 2,
> +};

I'm a little worried about exposing a complete io_uring specific
concept like IO_URING_F_COMPLETE_DEFER to random drivers.  This
needs to be better encapsulated.

>  struct file_operations {
>  	struct module *owner;
> @@ -1925,6 +1934,8 @@ struct file_operations {
>  				   struct file *file_out, loff_t pos_out,
>  				   loff_t len, unsigned int remap_flags);
>  	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +
> +	int (*uring_cmd)(struct io_uring_cmd *, enum io_uring_cmd_flags);

As of this patch io_uring_cmd is still a private structure.  In general
I'm not sure this patch makes much sense on its own either.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
