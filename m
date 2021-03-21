Return-Path: <SRS0=79y3=IT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE69C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 06:49:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F826192A
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 06:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F826192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rv3N6WjvVONR7F14Vh4dAJ/wssTXbpLuCYTwDh1TAxg=; b=eC0HN8h84h673y6rhhLRFPtyT
	KEkNXxx1olEFW7BZo6Blj6gNi2LtwL1/SUQGSse0YYO8W1IUIOBGuTJ+VOS7ohZF4wWWkrnhxdq2H
	0YgvvaZp6ZyFaXUu5OMcasULZrW3sjdoGVhB64qUWc3mU7MVpeiaEI5Ow5AfrjQx9tFNXSA8QOFtX
	cZ1eYOljOW876a2wMgcMWrEuVLQsV1vEDWUHQ/FyU4TZwyLU5InS7+1UiJ9NyeDzHmZTxcCPXDjC2
	uf9qr0WjTDLmTRVTucqI3ld9E2sY7dhRBp8ap0uyrJZTa9922PNyFmajh+6/aPn496BGhQj3225sW
	lHsL1KGAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNruC-009fzt-4P; Sun, 21 Mar 2021 06:49:44 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNru8-009fzT-H2
 for linux-nvme@lists.infradead.org; Sun, 21 Mar 2021 06:49:42 +0000
Received: by mail-pf1-f176.google.com with SMTP id l3so8809720pfc.7
 for <linux-nvme@lists.infradead.org>; Sat, 20 Mar 2021 23:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YyKMSZaeNDlRJG/9EIb78YwkeTXo428/Ph6XRi4+e4c=;
 b=bpInCarCyA8emgtlz/3qBj2n5qBJZTBSi/srA2xXrmp1CdX+jHIzIH2hTt85WpH6nX
 Y9X0IEhlPmTCSLBvRev5osTD3yYUaf7yeQPZNCXT/M0l9sepCO7LYCou3eGKB12H0nLp
 fpLLt7HMPG/NPV7R42ux7CcJ/WdB+Q5+3uxigNLUJCMLFKr69MAtdPiFtPtqNrSuNg+M
 6KuP0fC73wqVulOpec6M/LgqxLUU1JmrrppKoJUDaybma74PxPt7S8Ip6LcGs9UidOyv
 Wp3dpifE0C+/LCVv8UcDyXV9AkWt9145l+zpJRq2qwZciS6ttU2QIcQ0PBpTJi5M5UdA
 OlVw==
X-Gm-Message-State: AOAM531ouIefsAG0JF8Pag3jIFnn6sit8wYP3QlLrjVIgJCLmf9PaWw4
 WFvcL1dTFEb/Vblni35wSro=
X-Google-Smtp-Source: ABdhPJzHIaFA282KzhDTqotR5VhvKKy8dSYYe251aR2kERgomRGrQZXreIPiswV+cwvhxDbsIzJy2Q==
X-Received: by 2002:a65:538f:: with SMTP id x15mr18184596pgq.429.1616309378141; 
 Sat, 20 Mar 2021 23:49:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b1ab:c8be:b97:f20c?
 ([2601:647:4802:9070:b1ab:c8be:b97:f20c])
 by smtp.gmail.com with ESMTPSA id ft22sm9598655pjb.8.2021.03.20.23.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Mar 2021 23:49:37 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
 <20210319140532.GA7019@lst.de> <20210319172817.GA23660@lst.de>
 <ac05c7cc-3613-ec8c-a718-6f3e74710b42@grimberg.me>
 <20210320061123.GA20852@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6c83c0c6-0f00-0163-40f3-0ce2b2b2cc32@grimberg.me>
Date: Sat, 20 Mar 2021 23:49:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210320061123.GA20852@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_064940_869687_6C003EA8 
X-CRM114-Status: GOOD (  16.28  )
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


>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index a1d476e1ac020f..92adebfaf86fd1 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -309,6 +309,7 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>>>    	 */
>>>    	blk_queue_split(&bio);
>>>    +retry:
>>>    	srcu_idx = srcu_read_lock(&head->srcu);
>>>    	ns = nvme_find_path(head);
>>>    	if (likely(ns)) {
>>> @@ -316,7 +317,12 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
>>>    		bio->bi_opf |= REQ_NVME_MPATH;
>>>    		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
>>>    				      bio->bi_iter.bi_sector);
>>> -		ret = submit_bio_noacct(bio);
>>> +
>>> +		if (!blk_mq_submit_bio_direct(bio, &ret)) {
>>> +			nvme_mpath_clear_current_path(ns);
>>> +			srcu_read_unlock(&head->srcu, srcu_idx);
>>
>> Its a bit unusual to see mutation of a data protected by srcu while
>> under the srcu_read_lock, can that be problematic somehow?
> 
> Hmm.  I don't think head->srcu is intended to protect the current path.
> We also call nvme_mpath_clear_current_path from nvme_complete_rq or
> nvme_ns_remove, which has no locking at all.  The srcu protection is
> for head->list, but leaks into the current path due to the __rcu
> annotations.

OK, care to send a formal patch that I can give a test drive?

Also, given that this issue has gone back to stable 5.4 and 5.10 we will
need to take care of those too. We should make sure to annotate the
fixes tags in this patch and probably also understand how we can create
a version of this to apply cleanly (for sure there are some extra
dependencies).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
