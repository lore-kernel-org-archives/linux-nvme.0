Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2288CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 19:34:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B69C6196D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 19:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B69C6196D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kW/t2MPaT1MVdgTIuGBvmhNRAnhUZ1r3yFgDdhgkNco=; b=HDHHfDQvrSI6P9DiLzeOn4SHf
	ZGjkpqCKiprYlaSWXjySuRFt8j1c7byUYr1kUrYpnMXsAbC1xqSd96MJSJisGkGUkNfBrwdo5sn6J
	Fqfwp/HmjPFLV/5ilIfJ08aKJWO3y9wc1/felPDKp3ETBzcFFXrei2t6bGVmNTxhFg0N1LbYu01kB
	dBr0Dvh3AIfWp7G5qXNLs25lF9NLB+FqhH1dQBTLPR0PPTQ4LL2AFzoxu265lU82dsNDpJfJVXQ/d
	fgJN7C7F/ZJMkjBe6TWUzaedzcf21D5y3fz8zguAvZlM/bQ8pfyStajzVdKJOA3+eDMDcj1WD6dC2
	HnKTn+3XQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNKtG-0083pB-5c; Fri, 19 Mar 2021 19:34:34 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNKtC-0083oY-W1
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 19:34:32 +0000
Received: by mail-wr1-f51.google.com with SMTP id t9so10213850wrn.11
 for <linux-nvme@lists.infradead.org>; Fri, 19 Mar 2021 12:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oojNrKYpd07oUupKLdQVpJmzPJXCIjExIUbdfsLpmSo=;
 b=LuRHISJ8sSrb21lYYaHY7Oh1Wunyrir9pWGrWx9KMsoG7TLUP5Zss82z2dTOy1FSLZ
 0IiV5lEIbyiQ76Q7ysnJf14oQ1k1a021RXQ+nfe9gIsuV1zp6609vU2+attzZTzDTPT5
 EJfLNNpN2mcX/yftLL4HjKeGGasDiL6uXIMKiLzaKszQqayFpU0xd4Sdeh5BBSue/wuS
 Vq/60JUpt4RVkERw2fq1FtExkjl4YzMzABdpvxO6NztVryGhKcXrT++MTG9Vyd5VEcWs
 Df00m6J9e9qNk2o+8a+7LupRmN3S983NPI4thLSwBykEJ2A1clX5Lk6PIb3BpibF4Inr
 pTYw==
X-Gm-Message-State: AOAM533qUCSmyDWXXDo4wQpavL78UoUPVXJJdRWElHft462LnQLhZE4+
 W/NhYQgHjEVhpl8NM2iKxNQ=
X-Google-Smtp-Source: ABdhPJx8dIM/e8rwOiNl6x9VwdiXmm1yeBmVlCjdOSsqauhHkKejAmA4pZDOQui5CNW/yNkAEXS2+Q==
X-Received: by 2002:a05:6000:120f:: with SMTP id
 e15mr5889626wrx.129.1616182469676; 
 Fri, 19 Mar 2021 12:34:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f88d:8c35:34f6:35b4?
 ([2601:647:4802:9070:f88d:8c35:34f6:35b4])
 by smtp.gmail.com with ESMTPSA id i17sm9135202wrp.77.2021.03.19.12.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Mar 2021 12:34:29 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
 <20210319140532.GA7019@lst.de> <20210319172817.GA23660@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ac05c7cc-3613-ec8c-a718-6f3e74710b42@grimberg.me>
Date: Fri, 19 Mar 2021 12:34:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319172817.GA23660@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_193431_224361_29ECFF40 
X-CRM114-Status: GOOD (  14.60  )
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


> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a1d476e1ac020f..92adebfaf86fd1 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>   	 */
>   	blk_queue_split(&bio);
>   
> +retry:
>   	srcu_idx = srcu_read_lock(&head->srcu);
>   	ns = nvme_find_path(head);
>   	if (likely(ns)) {
> @@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>   		bio->bi_opf |= REQ_NVME_MPATH;
>   		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>   				      bio->bi_iter.bi_sector);
> -		ret = submit_bio_noacct(bio);
> +
> +		if (!blk_mq_submit_bio_direct(bio, &ret)) {
> +			nvme_mpath_clear_current_path(ns);
> +			srcu_read_unlock(&head->srcu, srcu_idx);

Its a bit unusual to see mutation of a data protected by srcu while
under the srcu_read_lock, can that be problematic somehow?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
