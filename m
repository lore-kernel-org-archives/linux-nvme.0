Return-Path: <SRS0=Ni0e=M5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7230AC4338F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD5E60F44
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Aug 2021 19:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AD5E60F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEXJtEuL5TpzzE++4Pxxr9IJk+3ods0vbF5dnuEEvzQ=; b=Oh7akqNcIJfVXaUjDwMYb23cPP
	vGjHH5NVfktn1IuSR4XGkot1bSXaZ2LUPdjwe+VxZj+QV5pNUzvpkROfJnddFSVhuKT4Z5EO6X/zN
	nhnmwnIBeJYEx5I8DYPB+MmOKVpSpEqqmaHRnwQPgRJj4O0LFEz36booCMxFEmWkexjmuP0MBT041
	RwSBRX+a9uSxe8+QjG74tJidHDP5wEQAHYigpVhWFqKPmHizizJkDXXSyclC2FHKVZlq3nSA6Etzh
	pUhH1Uc5BtmzkWRBiaJGRrzsOD7iX6Eyx4WmLUsQlUeQm22ROYQQbAbnD8yjKxjvC2d3CBl4Vh/AU
	UOevmmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mC5no-00DM8D-El; Fri, 06 Aug 2021 19:46:44 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mC5nk-00DM6L-Vh
 for linux-nvme@lists.infradead.org; Fri, 06 Aug 2021 19:46:42 +0000
Received: by mail-pl1-f179.google.com with SMTP id k2so8425114plk.13
 for <linux-nvme@lists.infradead.org>; Fri, 06 Aug 2021 12:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BX+yhZsge6xsr6SQsZC5CJS2tj6uRVB9UJOJkyIuvx4=;
 b=jmzQHsnf/E+ZDtj6U9v1w51Uku2U+cH28/dVBKOEwwqiDk4gOyJYzD7LmT1H79oan0
 DDGoPt6UwAWmFiQXFAT4RtvHTdDaquvX1bDeDieulg6KK28f3SGZuvPh5jayhQneYxL4
 Yqmo6+wkvKS6lCJD/R7TkcO5cTun0CERT4qQCDNWYoGEwhxeADSCd9nhW34GjnitLuTT
 /LstylmPfcHwIRs1NDFY2ij/Gb4EqZem9ZCS+ix9SQyjjYbIbnqwN9f6iXSt5j9Ta0WE
 3tgkETTctQ+LA7hDjxYTHfjTJ3lxpkA30hULiIA9tTEvj5tcRvdG8dc3Mi0zMBeldskv
 w6tg==
X-Gm-Message-State: AOAM530cbn5GKK2BKmBsaO9yFfB0y8qVUeLla9yKukVscdqrOeCWB8Ms
 IdqYuIl1ukJ8A3Jx6ukg8tc=
X-Google-Smtp-Source: ABdhPJws+bOGHVVbKilHYfcIRdp/qccAQ/++ydXiWQCJs6aUz+cYXNXELCRbiJW6OmP3Yf6JtT3NQw==
X-Received: by 2002:a65:62da:: with SMTP id m26mr178554pgv.370.1628279199840; 
 Fri, 06 Aug 2021 12:46:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4a77:cdda:c1bf:a6b7?
 ([2601:647:4802:9070:4a77:cdda:c1bf:a6b7])
 by smtp.gmail.com with ESMTPSA id y23sm12357295pgf.38.2021.08.06.12.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Aug 2021 12:46:39 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 00/36] nvme-tcp receive and tarnsmit offloads
To: Or Gerlitz <gerlitz.or@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>,
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Eric Dumazet
 <edumazet@google.com>, Shai Malin <smalin@marvell.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 Linux Netdev List <netdev@vger.kernel.org>, benishay@nvidia.com,
 Or Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 Boris Pismenny <borisp@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210723055626.GA32126@lst.de>
 <02c4e0af-0ae9-f4d9-d2ad-65802bdf036a@grimberg.me>
 <CAJ3xEMjzRqrj-EN7gbqKmD5txAV-gZn828V+6QAf5wfwYsqySQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1d461a0d-cda5-2086-ec17-c5bb3a80846f@grimberg.me>
Date: Fri, 6 Aug 2021 12:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMjzRqrj-EN7gbqKmD5txAV-gZn828V+6QAf5wfwYsqySQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210806_124641_100229_7516B709 
X-CRM114-Status: GOOD (  21.65  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/4/21 6:51 AM, Or Gerlitz wrote:
> On Fri, Jul 23, 2021 at 10:59 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>> [.. ] It is difficult to review.
>> The order should be:
>> 1. ulp_ddp interface
>> 2. nvme-tcp changes
>> 3. mlx5e changes
> 
> .. and this is exactly how the series is organized, for v6 we will drop the
> TX offload part and stick to completing the review on the RX offload part.
> 
>> Also even beyond grouping patches together I have 2 requests:
>> 1. Please consolidate ddp routines under a single ifdef (also minimize
>> the ifdef in call-sites).
> 
> ok, will make an effort to be better in that respect
> 
>> 2. When consolidating functions, try to do this as prep patches
>> documenting in the change log that it is preparing to add ddp. Its
>> difficult digesting both at times.
> 
> to clarify, you would like patch #5 "nvme-tcp: Add DDP offload control path"
> to only add the call sites and if-not-deffed implementation for the added knobs:
> 
> nvme_tcp_offload_socket
> nvme_tcp_unoffload_socket
> nvme_tcp_offload_limits
> nvme_tcp_resync_response
> 
> and a 2nd patch to add the if-yes-deffed implementation?
> 
> This makes sense, however IMHO repeating this prep exercise for
> the data-path patch (#6 "nvme-tcp: Add DDP data-path") doesn't
> seem to provide notable value  b/c you will only see two call sites
> for the two added empty knobs:
> 
> nvme_tcp_setup_ddp
> nvme_tcp_teardown_ddp
> 
> but whatever you prefer, so.. let us know

I was more referring to routines that now grew the ddp path
and changed in the same time like:
nvme_tcp_complete_request
nvme_tcp_consume_skb
etc..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
