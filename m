Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B086C678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4O7nglR7O8YYBFJO+aAK2WOTd497QXA4VvGjiZbUAY=; b=tIQFHadt3Dr8pj6+Sx7+MCeDh6
	YCQBcH1gWeJqEuFUtbQ5WohB67qhxRHgDlwF2zpXLiSYKxu+ANBo4Tha2WCOZLsRtSC53+swpB7fe
	n3z2FgyiU6Y7m0B+KgBvtWBiJ1JekbC10BjuCCF4ALjR54fHTvIVuUxga7LjmUQ2TGKKVlVDblPbn
	jsscp7/5tkWVBGuelaPcLSnaK8BdUhc8gTc4nfP4ZVUMx9mz+dKxLMyIXJ5qlECfBpafLeyPPfhP5
	zXMQ5otUsnFhXbqzdXqSUUm4Gb2iPyc9OaLTJzO2OoMjpc/yeKKh1/VqMCERIZd+gztG0/LBGu3XH
	DWmw17GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZC9Y-00DQ6P-4u; Mon, 06 Mar 2023 14:49:28 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBiD-00DC0b-Cs
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 14:21:14 +0000
Received: by mail-wr1-f49.google.com with SMTP id r18so9003879wrx.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Mar 2023 06:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4O7nglR7O8YYBFJO+aAK2WOTd497QXA4VvGjiZbUAY=;
        b=Qgx8osqIWJOBtSLQy4nEithzE228ugPfonCEFyuNZj+jB5Px+rEdyA1SbYVj9iIPef
         Xp08HZ7oQYrz4m9FnvqJfVk+hzrATMlZw5GAQA80V1v8Mhctn3wSIpMEipz6GpgTRflh
         JkIAHcaQL7kn/iaoOyvgmG5xPDiSmjhRqMZIgRexqA2u6i2nmSlC6mCum2NDzpTi2hs/
         MI+RrJ2aV/tQgzDoxw6KmstpJrwxdci/nv0aEvDyx1bK8qwSCH43e1KJRQgKasmBqCQn
         +PZPNCNkkK2A70XtyftUO/JwGibZKzYA1daUeTXXG82pAFG0/jxY4ktnXV0ea4CQzE7p
         W5Hw==
X-Gm-Message-State: AO0yUKW2Bsw6w93n5YHNMN1GJf8Tfnaxfz4tfPya1UYaCjYrYw1xbZN9
	jXqTVJUebm6S3AelHeRG44M=
X-Google-Smtp-Source: AK7set/hn+mj3DDuFDNC/fWfNafv2COZcQffLjEGX7e+CXLf0owq1LjHuTVi4n/D6GblZiruBgdlXg==
X-Received: by 2002:adf:e60b:0:b0:2c7:1c72:699f with SMTP id p11-20020adfe60b000000b002c71c72699fmr6945230wrm.4.1678112469957;
        Mon, 06 Mar 2023 06:21:09 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm10010667wru.114.2023.03.06.06.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:21:09 -0800 (PST)
Message-ID: <125e291a-5225-6565-e800-e6bdb6be35f3@grimberg.me>
Date: Mon, 6 Mar 2023 16:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_062113_507193_5EC2269B 
X-CRM114-Status: GOOD (  18.16  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 3/4/23 01:13, Ming Lei wrote:
> When investigating one customer report on warning in nvme_setup_discard,
> we observed the controller(nvme/tcp) actually exposes
> queue_max_discard_segments(req->q) == 1.
> 
> Obviously the current code can't handle this situation, since contiguity
> merge like normal RW request is taken.
> 
> Fix the issue by building range from request sector/nr_sectors directly.
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2730b116dc6..d4be525f8100 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   		range = page_address(ns->ctrl->discard_page);
>   	}
>   
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> -
> -		if (n < segments) {
> -			range[n].cattr = cpu_to_le32(0);
> -			range[n].nlb = cpu_to_le32(nlb);
> -			range[n].slba = cpu_to_le64(slba);
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> +
> +		range[0].cattr = cpu_to_le32(0);
> +		range[0].nlb = cpu_to_le32(nlb);
> +		range[0].slba = cpu_to_le64(slba);
> +		n = 1;
> +	} else {
> +		__rq_for_each_bio(bio, req) {
> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +
> +			if (n < segments) {
> +				range[n].cattr = cpu_to_le32(0);
> +				range[n].nlb = cpu_to_le32(nlb);
> +				range[n].slba = cpu_to_le64(slba);
> +			}
> +			n++;
>   		}
> -		n++;
>   	}
>   
>   	if (WARN_ON_ONCE(n != segments)) {


Maybe just set segments to min(blk_rq_nr_discard_segments(req), 
queue_max_discard_segments(req->q)) and let the existing code do
its thing?

