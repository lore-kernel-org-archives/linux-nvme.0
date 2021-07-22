Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B23C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8152960FED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8152960FED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cm2ICKl5IFH+SbTRCNI+CW+4ZmRhy164SCG9haTm6Eg=; b=dQI+GFEUoaOnE7
	2/jJ2puvrcrhdXx8NRm8O8g4XOPQnKBuxYS7Asp7xyJl5gImVifqfK7SmPQwEmOTON4AWX0ptx6S5
	ULzGosJigPegqCArGr9wLF9ksNEA5bXh5p/FceEntJpra+IF8FjnXRni9seMiTDcU4IltFsuJNMoD
	HtNRA7McNg8sKE91TL5XZvkchpnQ07CRmrT0lgnmOslGgCWSemmfDSTifDM/PdQan1mNxtxliZ7R2
	XASsA71cORDMPyCRZDqWWaucWCcNP12j8cLZc+dBkHldcS85ZOaGPnxXTudUXbhld72Tk57wK0iLk
	1oHDZwIeUgfwLY6dMJUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Ywa-001iWx-0X; Thu, 22 Jul 2021 13:40:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Yna-001g6H-VM
 for linux-nvme@bombadil.infradead.org; Thu, 22 Jul 2021 13:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ICspZ4RtR4pacnzopZdqHgYYQgygGGPfu1yVd4wOaSg=; b=rxQjWUNZDon69dFNIgGXn/IUOm
 vYpFphyRtEdN4Yab6lFV8jrj7rGS7RvkA5zy+YsILsQ47ZCZVTU1CQsYMy+YOjQknw30Zzc8ktuCD
 wMbOIEoKfDrIYBoedf+F5FVwDjHsHkjOdpI4CwsuIF2lMTe2r6IQthdj+ugXh3NgWMqxwvVsA0kAt
 g+CfpB0IQE12t0Bv/VU983XsEZ8qQyDx61kCRlg6AKbroK7oq10xnvJlgmuQYNkdg5hB7Viw/UWnj
 oVaM9pWmfHgJyYjln2QQd5BgwKW1rCaclq/NuGF/MwjP4jgB5M1aFZfASTjGpvzRqfDx+SE/kJO8i
 kN7AOq+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m6Yn7-00AIKg-6g; Thu, 22 Jul 2021 13:31:16 +0000
Date: Thu, 22 Jul 2021 14:31:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Boris Pismenny <borisp@nvidia.com>
Cc: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 benishay@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
Message-ID: <YPlzHTnoxDinpOsP@infradead.org>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210722110325.371-3-borisp@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

> +#ifdef CONFIG_ULP_DDP
> +size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
> +#endif
>  size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
>  bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
>  size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
> @@ -145,6 +148,16 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  		return _copy_to_iter(addr, bytes, i);
>  }
>  
> +#ifdef CONFIG_ULP_DDP
> +static __always_inline __must_check
> +size_t ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	if (unlikely(!check_copy_size(addr, bytes, true)))
> +		return 0;
> +	return _ddp_copy_to_iter(addr, bytes, i);
> +}
> +#endif

There is no need to ifdef out externs with conditional implementations,
or inlines using them.

> +#ifdef CONFIG_ULP_DDP
> +static void ddp_memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)

Overly long line.

> +	char *to = kmap_atomic(page);
> +
> +	if (to + offset != from)
> +		memcpy(to + offset, from, len);
> +
> +	kunmap_atomic(to);

This looks completely bogus to any casual read, so please document why
it makes sense.  And no, a magic, unexplained ddp in the name does not
count as explanation at all.  Please think about a more useful name.

Can this ever write to user page?  If yes it needs a flush_dcache_page.

Last but not least: kmap_atomic is deprecated except for the very
rate use case where it is actually called from atomic context.  Please
use kmap_local_page instead.

> +#ifdef CONFIG_CRYPTO_HASH
> +	struct ahash_request *hash = hashp;
> +	struct scatterlist sg;
> +	size_t copied;
> +
> +	copied = ddp_copy_to_iter(addr, bytes, i);
> +	sg_init_one(&sg, addr, copied);
> +	ahash_request_set_crypt(hash, &sg, NULL, copied);
> +	crypto_ahash_update(hash);
> +	return copied;
> +#else
> +	return 0;
> +#endif

What is the point of this stub?  To me it looks extremely dangerous.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
