Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA242070B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 04:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y53dPyCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA242070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BuTEsm6nzC/oUoAPbfpAB1ZZN4doUyQ4jHtphbWmnyg=; b=y53dPyCBh//olJOVfqXqTU7Y+
	z30/qdfSzia8V92sRvAXsl/ASRFOn5chYNAAaEURRNsj21JljkR/8w59L0tvvb/pgWRrBMktCb8sZ
	8Kf04gukWD6pL07B36pYFwa6XR+2Wp0Kc21U+Rr9IcVBVNJmbg8BbyBETOsOlobJ9hpbNE1eQrgZL
	U2Gqa8hNTXGogEBeTSFav7H/QZbBsiCusGQaI0mXFBImrsvuTF7PP3SXnvfZvTVTHDcbZE4CzsOUJ
	iw5kPgm7IhlE/aj6gUL6WnSi6Ej6wWnK9V2v1v9v2K0LQ+9+vHVHd8e868x2XFcQAniVP/WhlWmgJ
	nUx47p/HA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0dqL-0008WO-7i; Wed, 29 Jul 2020 04:37:29 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0dqI-0008VW-8R
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 04:37:26 +0000
Received: by mail-pj1-f66.google.com with SMTP id k1so1285215pjt.5
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 21:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XU31FClko5F8gicbnWPOCsqy42fRTkYxwgHqqzVb+Ho=;
 b=CQdJRVBSDItJToCX6dz5cTnUlKH4okU0OcWOz4CKbpZU/o286ZVrJfS5cqMglHAg6k
 MFgCgQrt2r85i66apDxUdw4JMb5qOVCTzrelgrqP5jWSOmhsx1sm2PROwG0W/IKNISOq
 jOKFFGNIGPMl/3IFYqpoZbJn7gi49uNU2s6lvqha39fr8B5WIHKWgl3a3s7w18FnXs+a
 +QXupB4GkY4EJh+ocxzWqVX8d1Otj89SrhN+TIjWd1Vk/jvBEtJrw4pE3mRBFz1kUsPz
 W3lEvVxmDXQocNonxQqG0V0AUBTiVOQfqAND923F24MMGUntuvdjsfFqu0knu9iOLL9e
 n9Dw==
X-Gm-Message-State: AOAM531Vq9yoRj0+ZENPk/NbM5lFIxVJnn8zG2frL2zafPdUtEIkmaR+
 fm2nVHgpwZopnlQGe4hnXubD9mLV
X-Google-Smtp-Source: ABdhPJzrJrVRsxMmyLmDqk439jheErXZ3UST5+jlVprC28TP0ny6Lfwa/+oo3ejMLNGcZL6m1d0O2g==
X-Received: by 2002:a17:902:8697:: with SMTP id
 g23mr25366202plo.94.1595997445233; 
 Tue, 28 Jul 2020 21:37:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fcc5:69d8:6e20:4fd1?
 ([2601:647:4802:9070:fcc5:69d8:6e20:4fd1])
 by smtp.gmail.com with ESMTPSA id a193sm655256pfa.105.2020.07.28.21.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 21:37:24 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: paulmck@kernel.org
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729041004.GV9247@paulmck-ThinkPad-P72>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <57f76f9c-6fb9-b6f1-ba85-1594755e60f3@grimberg.me>
Date: Tue, 28 Jul 2020 21:37:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729041004.GV9247@paulmck-ThinkPad-P72>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_003726_331625_F6C693F1 
X-CRM114-Status: GOOD (  15.05  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> Dynamically allocating each one is possible but not very scalable.
>>>>
>>>> The question is if there is some way, we can do this with on-stack
>>>> or a single on-heap rcu_head or equivalent that can achieve the same
>>>> effect.
>>>
>>> If the hctx structures are guaranteed to stay put, you could count
>>> them and then do a single allocation of an array of rcu_head structures
>>> (or some larger structure containing an rcu_head structure, if needed).
>>> You could then sequence through this array, consuming one rcu_head per
>>> hctx as you processed it.  Once all the callbacks had been invoked,
>>> it would be safe to free the array.
>>>
>>> Sounds too simple, though.  So what am I missing?
>>
>> We don't want higher-order allocations...
> 
> OK, I will bite...  Do multiple lower-order allocations (page size is
> still lower-order, correct?) and link them together.
> 
> Sorry, couldn't resist...

Possible, but I didn't want us to resort to all this complexity and
thought we can find a better, simpler solution.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
