Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31579C433E4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 08:08:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006D62075E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 08:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Okaol3a5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtufONaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006D62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZQzFovUPpEyWQxIhVRrNbzABuAL/mSv3THsA/RpUOtk=; b=Okaol3a5VPa/y0sO3yDoyOlBV
	llh8LKUM/0InzuGRyR7DNwyVY7SBZxxJz+ZXO/uCJBQArM+IeFUYOCQoLIJR4MN2mKRNNjrq+ZpuT
	Jvpa4THqnqCfaD7VPLtrdWInJ9hIHuXRse24oiirh8R/bxGQyiKA1FZyJHgFkoAa2/dMtcBmnU/cL
	YtmZTPT5lWoKRvbihRzkanIDufbsPz9OTvaGF5Lwx2430Fb+fZel69YJBMo0hGewF9LIdBqwNdYTU
	xJclH666Kpm9vpx1UgAMSJQQgZL+ah0FNB7AHvl+PrzsK2Z7xnZnr4S16etEppH3UQk/aOOKRCCY9
	2agx3gu4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7wfb-0003Gb-45; Tue, 18 Aug 2020 08:08:35 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7wfY-0003GC-MJ
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 08:08:33 +0000
Received: by mail-pg1-x541.google.com with SMTP id o13so9417168pgf.0
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=m313s21wEJmxuhmPKtbGUqqWEllj2MTtaFTQwb2enIE=;
 b=OtufONajKNzIP6gr7YDun/QW3ro9rpD04mkuKT4cs+IerR6bXb0EEfSZrBS86/akD4
 40cKAY+zckJTFvGRxXLDJV5Q6EKJOWF826rEIUXiuWkZ6++GkoSndNCSw9ZU7GBtrnPJ
 i7MJyDe0rLgw2grjYZR04unLuVxIcEUuJWxvksVfW0sRqqkrgLpkzBjI8BfX1/iJSifw
 x6S/P+uJlioFkC+WA1Ir9HVeYPsD6P717k5LZaF9FJcVQv1OrOheoeQGF4fa2YbyLGcB
 lYGWp9L6RNZmuRKTngHOMi8necWZDhCHsD1I5gDGscs5KYPXc22len0n7aTY2UhIP8u4
 hx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m313s21wEJmxuhmPKtbGUqqWEllj2MTtaFTQwb2enIE=;
 b=hfdB4bQm2oKcIAL1+2qABSZnNmqJQoXLdMICEs/voXl1unDnTaQEqar/IFc0ow71QM
 bQDJrI8uwsNFrUqNgr27efpSrHcqV1HBWPWG9imhxsG1ot/hIL88+cPuh2idNTJZA2Yh
 dYRJyoTPbxzWnUpcpfe1YAIcKPzuarbKr7i8cUyBtExBFvOsCsHAL8e6JcZ2ivNweFvH
 CJJKOJWGjkxxMliPjdOCWH9r0gntuZu3c8RlHcMhuVF4G2ERqhVcdopHZ+YcswwT6tXL
 GfRVhOh1iP4Cl/Jx0+SXk10urslNEOsmMcl1b5WNszlbyRHpbWmiyRGFcivUjnYyCLt9
 1d2Q==
X-Gm-Message-State: AOAM530psokNAUXySVkT6s+95EaRfT9ixJKafJliJxree4Wj1HY81JzF
 3i5F15Qxr+gkIqVJluz2dGU=
X-Google-Smtp-Source: ABdhPJwQ0ucHp+nnSbkI/I+/r1bCwZGaElzEDSzF9ufRJ5nFtWB5QNUo904wdRubof6ip0h0WAbsIQ==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr8695071pgh.230.1597738107451; 
 Tue, 18 Aug 2020 01:08:27 -0700 (PDT)
Received: from [10.1.10.11] (c-73-241-150-58.hsd1.ca.comcast.net.
 [73.241.150.58])
 by smtp.gmail.com with ESMTPSA id x28sm23667645pfj.73.2020.08.18.01.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 01:08:26 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
To: Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200816070814.6806-1-colyli@suse.de>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <66b4f454-dc97-a23e-81d6-0c547dced694@gmail.com>
Date: Tue, 18 Aug 2020 01:08:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816070814.6806-1-colyli@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_040832_746946_B79D7634 
X-CRM114-Status: GOOD (  25.94  )
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
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/16/20 12:08 AM, Coly Li wrote:
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
>
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index d48ff1180879..a807fad31958 100644
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
> +	return  (!PageSlab(page) && page_count(page) >= 1);
> +}
>

return (A);

Can simply be written :

return A;

In this case :

return !PageSlab(page) && page_count(page) >= 1;

BTW, do you have plans to refine code added with commit a10674bf2406afc2554f9c7d31b2dc65d6a27fd9
("tcp: detecting the misuse of .sendpage for Slab objects")

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
