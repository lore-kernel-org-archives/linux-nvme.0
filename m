Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06919C433E8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 17:25:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D029520672
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iLqmc6+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D029520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/AP0Kdjwnkl7Oscvfry5jCx7aWaF3py2QR5U4KcWxSI=; b=iLqmc6+T+4WZyeQUVBUVVnBes
	Vb+1epwOe6Y2I2rLFfn4qb0gm2a2AjvrCCMbnRwXmE2bm/1lF8G7E/2GmT0Yk78tOrZzlgey1OZ7P
	OK4Kbpxp0WIb3TXDw3jJ7zsyenB5nGEcfcISZFKuuYwMHf9bTxiiF6zZpX94lWmVPMDRG3viFYmQn
	3U0+RKFs0c+Ivx77OEyoXxQ5zZtt8hcR8FHX8Yrl76I7YrURoDG9/d4mo8peyi8b/mR1akH6rDl6t
	VaIbOnOIXU0lqhVmgvouh/rGqNVkbxRbhxlUg93jcENfg19MUmeRfq9RsqwSs12EZoj2eV61FMstX
	ISGaHH0DQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k06sc-0007Ci-1v; Mon, 27 Jul 2020 17:25:38 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k06sa-0007Bm-0Z
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 17:25:36 +0000
Received: by mail-pj1-f67.google.com with SMTP id c6so3343710pje.1
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 10:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aNt663yDzifzzB0XK1Rn3vQdJUzIbPRGw9BRhlu+BgI=;
 b=fjvETVud6khJ6nKTfoynUYAYjGMz48bwA7d68WnRmGy2/ae6Z5jyIufeh39LruP4Vj
 RScDtTCJ4Jdn7kNrEAYJn6tB4DjkzmQPxZyD3IU9jxogHkSUe6wa/CtwiL8bcTGYglhm
 asHIzEFwsh3c+Ky7EG3VgWENCE9R5+Yn1/Zaxixn14sjR029sV/QH1GjOENhkiTv/RAg
 abKG87/A7QJpNRSZ/5UEklh0WLPnGszYsQTNkVl0b4g3e9aZkL6U+6u89CgGtIEuOsay
 3Hq2aynvtEwGKp927t+hOmC5TjbziG8OCOYUC1fhvVz8EAs/+R+Hxvflm7nfBURAHtzW
 GGrg==
X-Gm-Message-State: AOAM532Avzny7ER1i/FBH6/fyfiCJpcurRHGMi4WwUc6JCDjyu3qJlwT
 fhvrZjcCKh6R/pbE6uWLUtg=
X-Google-Smtp-Source: ABdhPJwUsW0OrmXzZI8dD+BwqaXmVKJG1zwM2eWYgiCDypR1jFOoZNeU280jcxCdzhCI8GCiXVaXyg==
X-Received: by 2002:a17:902:bc49:: with SMTP id
 t9mr9726393plz.20.1595870731350; 
 Mon, 27 Jul 2020 10:25:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id k23sm15148773pgb.92.2020.07.27.10.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 10:25:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-tcp: use sendpage_ok() to check page for
 kernel_sendpage()
To: Coly Li <colyli@suse.de>, philipp.reisner@linbit.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-bcache@vger.kernel.org, hch@lst.de
References: <20200726135224.107516-1-colyli@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f6cf7563-9d8c-baa8-e8e7-e41f9b13e787@grimberg.me>
Date: Mon, 27 Jul 2020 10:25:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726135224.107516-1-colyli@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_132536_098617_EDF8E2EA 
X-CRM114-Status: GOOD (  33.91  )
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
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/26/20 6:52 AM, Coly Li wrote:
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
> Such check is done by macro sendpage_ok() in this patch, which is defined
> in include/linux/net.h as,
> 	(!PageSlab(page) && page_count(page) >= 1)
> If sendpage_ok() returns false, sock_no_sendpage() will handle the page
> other than kernel_sendpage().
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
> v3: introduce a more common name sendpage_ok() for the open coded check
> v2: fix typo in patch subject.
> v1: the initial version.
> 
>   drivers/nvme/host/tcp.c | 13 +++++++++++--
>   include/linux/net.h     |  2 ++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 79ef2b8e2b3c..f9952f6d94b9 100644
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

I was hoping that this comment would move to the helper as well.

Agree with Christoph comment as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
