Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBECC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67652073E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LLa3noy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67652073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m3iBDrmJGW35hKAyZmOjzBQ17UiApU2q2eGsst4uGq0=; b=LLa3noy72Q+7J5ZESZy44g0LC
	mw40l/AwkDK37BUNgE6sk6eYuRY1/PMMz0wivvDWJBa8+xgbbanr5K0ow4o6xBtykv70qsnFf+i22
	Ogh9EdFN8Q1nRukjyclFXhM5LFoKZQPG7ojCTQCUpfV4VhPBa4pBgIKslE14BE5a51Et2dl27gFmp
	6ErUV8qynkrA6TPHwRGCfKquynyGPVdvqXGp2RNYWk5naC+ezSri0czwlMpMgkfgMhvmawFwA3hEr
	VljQuMKyD7BXNLozi7tW5oHCUSvcnEvomLq/MaR93CtGB1bEmBWz3T4psHyP9GgdefOnodlPvvwqr
	gbhuNsOVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k095M-0008GR-UE; Mon, 27 Jul 2020 19:46:56 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k095L-0008Ff-CR
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 19:46:56 +0000
Received: by mail-pg1-f193.google.com with SMTP id l63so10485122pge.12
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 12:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zskInBPIBU1CDws6rlRDDq5HLJztXhUDAgIAf0ET0ok=;
 b=lvllF8WMnjBSrKK4BUEZXbx4WU7zMyxAWkOBeLJOqoOjm9Q+0ZGYg2VqZlooeLCJ9u
 CB+5nLI4E9J/G442mrfF9FHQ9HTJwq2lmhmB/pmzWIsOofiEz0sOs0V5SEWQN4uGRZN8
 XPmFFS2PmqE/lNZEb9GVLzM556ly2WnKQirk3G4Z8oRrey2jqc7DrWd5XSpv3YiQsrKl
 M+wih7DdiysB6CEWNoLsoAWtxhd9ihVF2ZLwRRy8bdeoLQ2KoSCYEsjNaZrCdNze7Dt7
 vfkggmEvlfI+tsICLPJN/FFSHKP9ehtBETV5zktPgE09MaDYGAfyMbmzP67GgwpwAVf2
 0p2w==
X-Gm-Message-State: AOAM531Es+g3mtjc7wMyvaCO9oDo42RMMoJVtmTJO55lk/5ePHwikkEH
 TnLnTcVRBksvWAPg0S18Q73jWxZT
X-Google-Smtp-Source: ABdhPJw4b/7BMIGRrIeO/ZYk/cWLRu1ZoARCl76nb1uG82ADKGA5MvHCTXnGdTQxqA64DIBGk0rP0A==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr20760697pga.24.1595879213941; 
 Mon, 27 Jul 2020 12:46:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id y11sm16968920pfp.73.2020.07.27.12.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 12:46:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
Date: Mon, 27 Jul 2020 12:46:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727160803.55683-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_154655_477117_B752763D 
X-CRM114-Status: GOOD (  20.76  )
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
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 7/27/20 9:08 AM, Hannes Reinecke wrote:
> When nvme_round_robin_path() finds a valid namespace we should be using it;
> falling back to __nvme_find_path() for non-optimized paths will cause the
> result from nvme_round_robin_path() to be ignored for non-optimized paths.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/multipath.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fe8f7f123fac..97d3c19b5684 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -272,8 +272,11 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   	struct nvme_ns *ns;
>   
>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
> +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns) {
>   		ns = nvme_round_robin_path(head, node, ns);
> +		if (ns)
> +			return ns;
> +	}
>   	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
>   		ns = __nvme_find_path(head, node);

Maybe instead of the early return put the following condition on else?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
