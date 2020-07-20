Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1197C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:47:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A3F2073A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isYeTrd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A3F2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L8PQKylMMS1SATvWoFXZeo7H8gScjUKbYSVMRYe9nKY=; b=isYeTrd87sXxqzN+DfKy7bSQE
	jI2bgVKVREzzpFkoMig6YyimVXjGelA5lJf47csimG9qDnjy7WQtEFnGJ3irt+lAxC7sLGcsVou6i
	Piv1ov/X4B4vUENj+CnQ/TCgfM2aoZtnf8QWALYauNFQvvoOS/oFyS5MlVAt0jTSHjgq1mDgI1vOJ
	4Djh01YL6AznntNNxFVd1/9Xfbrh1PpsKoYy9pZXv8N0Nd1bD5irWth7/IBRp/tTtmIVqBYD9Giwh
	WFgsXyck1mqssNG80yBL1G5CREUTtKWampn7NDxUHMu2QQnPWjJzjjeUlZ/k1Gw8MeAnJ40a+DzzU
	+kfKWXcbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxbkY-0001ye-Kj; Mon, 20 Jul 2020 19:46:58 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxbkV-0001y6-3q
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 19:46:55 +0000
Received: by mail-pl1-f195.google.com with SMTP id x9so9171611plr.2
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 12:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hF8palGIv8TI4BXkf/MtnUqfeyrr+QIHoD4KLAnuRtA=;
 b=RNsmWhdjNeR+NXiler9JlzAouI5Tlxr3+0c9oddbpNhABXQKtLcdKy/OVhcGEodvIz
 FYr5mTAFooa22Iw3UHAE4xZQP8V7YCBy3JjlBS1AfGLkZSuxJ5/lmmVknZ0bw1zT/QNF
 ztrPZz35uZsHuUAA5A2irfwSHKz4sKjH8NSC92UXlgudL+g6PSPL9GodzT+p0GZtr0+o
 cKJ2ZJSqJAwkzIkLpVRJUeX0jgjmMUQNgkmc4aEnf8XaMOu08xEbhxaEhOFKcYZJscYu
 yEGeTixIXVtp+FhyIEzJNfTbQdsTfbnGlzmJkqNgTL+3Ot/LYS8AAjAZmYz2/qI3ZcyI
 HAgg==
X-Gm-Message-State: AOAM533QxVVJyK7Kk/0M7J1qzEfCJEUAl1iLlnIYCFIURZdqTQHe/1+B
 DHt/0qHS2rwSZoo0yCLdqJ4=
X-Google-Smtp-Source: ABdhPJxQ+Wt1oXs2Yt1z/f2sFOZ4lWJvrpfWgApnTaWJqLQpNjFxeO5byMOGFMOtE9bIim1Cgltyxg==
X-Received: by 2002:a17:902:7284:: with SMTP id
 d4mr18116121pll.164.1595274413951; 
 Mon, 20 Jul 2020 12:46:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id f6sm18054206pfe.174.2020.07.20.12.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:46:53 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: don't use sendpage for pages not taking
 reference counter
To: Coly Li <colyli@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, hch@lst.de
References: <20200713124444.19640-1-colyli@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75efd1ba-284d-f5b0-faeb-ca8cefd673c0@grimberg.me>
Date: Mon, 20 Jul 2020 12:46:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713124444.19640-1-colyli@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_154655_191261_82FD6E44 
X-CRM114-Status: GOOD (  28.89  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Vlastimil Babka <vbabka@suse.com>, stable@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/13/20 5:44 AM, Coly Li wrote:
> Currently nvme_tcp_try_send_data() doesn't use kernel_sendpage() to
> send slab pages. But for pages allocated by __get_free_pages() without
> __GFP_COMP, which also have refcount as 0, they are still sent by
> kernel_sendpage() to remote end, this is problematic.
> 
> When bcache uses a remote NVMe SSD via nvme-over-tcp as its cache
> device, writing meta data e.g. cache_set->disk_buckets to remote SSD may
> trigger a kernel panic due to the above problem. Bcause the meta data
> pages for cache_set->disk_buckets are allocated by __get_free_pages()
> without __GFP_COMP.
> 
> This problem should be fixed both in upper layer driver (bcache) and
> nvme-over-tcp code. This patch fixes the nvme-over-tcp code by checking
> whether the page refcount is 0, if yes then don't use kernel_sendpage()
> and call sock_no_sendpage() to send the page into network stack.
> 
> The code comments in this patch is copied and modified from drbd where
> the similar problem already gets solved by Philipp Reisner. This is the
> best code comment including my own version.
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
> Changelog:
> v2: fix typo in patch subject.
> v1: the initial version.
>   drivers/nvme/host/tcp.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 79ef2b8e2b3c..faa71db7522a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -887,8 +887,17 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   		else
>   			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
>   
> -		/* can't zcopy slab pages */
> -		if (unlikely(PageSlab(page))) {
> +		/*
> +		 * e.g. XFS meta- & log-data is in slab pages, or bcache meta
> +		 * data pages, or other high order pages allocated by
> +		 * __get_free_pages() without __GFP_COMP, which have a page_count
> +		 * of 0 and/or have PageSlab() set. We cannot use send_page for
> +		 * those, as that does get_page(); put_page(); and would cause
> +		 * either a VM_BUG directly, or __page_cache_release a page that
> +		 * would actually still be referenced by someone, leading to some
> +		 * obscure delayed Oops somewhere else.
> +		 */
> +		if (unlikely(PageSlab(page) || page_count(page) < 1)) {

Can we unify these checks to a common sendpage_ok(page) ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
