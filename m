Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09508C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:36:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B45764EAA
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B45764EAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iZfyvZiHyRqFQ7sVNIjXBXe1ZO6eFUM71fVhvUd5lqs=; b=aRemUjuDjMosOIIk3ezev4iYW
	c/6CQudKE2fc42GFOT3JcRTUIph40O/EEzfmtoliC7amVtS0B0PCoAjS9X0WSaKdOfQnZB3qFSivx
	vqJG1h+NWFAAJ+h8ZSh7DdspDctWRCyBFEN5uvZVrmZaMNtFaYoGsRkINX+BGq0xBHvwfW0aisx2V
	nZ000Lu3vOdOkOHv8/Lxdb9zv7st+gPhM3N2sTrcGYDIVzj5N0lAaOmtUsbIR7iLP3XgCwNq9LYPe
	HcGMg/PrCo8aPCv2Ktegp9fK0Dr4FThAXQ96Z1KV5Y9yjytnRJOz8jLpMiP50IHLiBgYbETBpwH11
	B7MItuRnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6d7C-00077K-Kw; Mon, 01 Feb 2021 17:35:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6d7A-00076r-Gb
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:35:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C74656736F; Mon,  1 Feb 2021 18:35:48 +0100 (CET)
Date: Mon, 1 Feb 2021 18:35:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Boris Pismenny <borisp@mellanox.com>
Subject: Re: [PATCH v3 net-next  01/21] iov_iter: Introduce new procedures
 for copy to iter/pages
Message-ID: <20210201173548.GA12960@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201100509.27351-2-borisp@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_123552_666410_19B80CAE 
X-CRM114-Status: GOOD (  15.78  )
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
Cc: smalin@marvell.com, sagi@grimberg.me, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, linux-nvme@lists.infradead.org,
 davem@davemloft.net, axboe@fb.com, edumazet@google.com, netdev@vger.kernel.org,
 viro@zeniv.linux.org.uk, dsahern@gmail.com, kbusch@kernel.org, kuba@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 12:04:49PM +0200, Boris Pismenny wrote:
> +static __always_inline __must_check
> +size_t ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	if (unlikely(!check_copy_size(addr, bytes, true)))
> +		return 0;
> +	else
> +		return _ddp_copy_to_iter(addr, bytes, i);
> +}

No need for the else after a return, and the normal kernel convention
double underscores for magic internal functions.

But more importantly: does this belong into the generic header without
and comments what the ddp means and when it should be used?

> +static void ddp_memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)

Overly long line.  But we're also looking into generic helpers for
this kind of things, not sure if they made it to linux-next in the
meantime, but please check.

> +size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
> +{
> +	const char *from = addr;
> +	if (unlikely(iov_iter_is_pipe(i)))
> +		return copy_pipe_to_iter(addr, bytes, i);
> +	if (iter_is_iovec(i))
> +		might_fault();
> +	iterate_and_advance(i, bytes, v,
> +		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
> +		ddp_memcpy_to_page(v.bv_page, v.bv_offset,
> +				   (from += v.bv_len) - v.bv_len, v.bv_len),
> +		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
> +		)
> +
> +	return bytes;
> +}

This bloats every kernel build, so please move it into a conditionally
built file.  And please document the whole thing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
