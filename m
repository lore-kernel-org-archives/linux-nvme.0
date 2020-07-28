Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA34AC433E5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:37:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8855120786
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="piIoN/IR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8855120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gJdfb/Vbrg+ZVAmOYNkMPeSR4AVSkdHvQ6geL9jL8z0=; b=piIoN/IRA4Mig09iKMqTFRVHW
	9aZMGygu1Kbp8z3XIGNgf5y6taujhyIDuQT/OqIPtLnZSHy6Wv1iuO4C7W5x6WcwBbSKn4IqHslZ9
	pbnWpT/jzN4pQCYPRirkhRrRKqg0MbNs/zd6/qlm33jM/HLea2TgC4a7WW7MLAC+DpWenJ6FNkvaE
	pN6tCac2Miy3DNd/Wt6zfkN7iUqNeOsi12kVp/GQo+J7CKWLKEgPnu9tr3AbNuEgVKsOPwrbYfP8B
	gMp7gozdFJP/JiFY+HWVxgn55fuGUWYwnWStJwJQ+R2tiK9GyqAf1s9+vPXG5Tjf+AdTz79V4k42m
	acc75UW1g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0M30-0001oc-D1; Tue, 28 Jul 2020 09:37:22 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0M2w-0001nQ-UQ
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 09:37:20 +0000
Received: by mail-pj1-f68.google.com with SMTP id lw1so2487502pjb.1
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 02:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qc6XHMOfo5wnNZ/diCVPFqd6BfCfCaGvZVkP6ubbDA0=;
 b=nRTtqwYN/k/uelqqdABgrYhMm56QWST20DRyeb2wYx5AauQTJTvaFDG4HflLcmUaw5
 9a6BhwnPTXVlzHzTQ8GsQNkG1M2neP3X4VuCTc1fmgctM2hSDrQpQ52knMcvqI0U7tOZ
 u1xxAkwsnxAtHDaG69g55FviWpegtopzFw5nnaaZmrGhFyk8DZ+ALGEwUe4o1UddAITh
 Czb8Uk3hgy1xwMpPHbaQjPJKVqyp4LA7BUG9NxwpOhwPvxhBuq4BYV/AQnSgu3OzMS+b
 2Lib7/apxcT3VCcxcVEGRsclXRJMdksI34w3awvelsyyBH0E1mjel8KsFIWkkzaAYw60
 ZrXA==
X-Gm-Message-State: AOAM530KpFcFCqA9aI8vpLhQrfmk08j8Bji7SNGnNx02VywXjMVc1DZ4
 7fftvbRBkEs1JyMor33tUMk=
X-Google-Smtp-Source: ABdhPJyEv3KzVF7kG4ylniufEJRENgpIEiqrzqVmF5DzxWz4M0h5ZwA3KuSAj1F6qKD9rpjGnQLXoA==
X-Received: by 2002:a17:90b:355:: with SMTP id
 fh21mr3616808pjb.46.1595929037893; 
 Tue, 28 Jul 2020 02:37:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id k29sm9885530pfp.142.2020.07.28.02.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 02:37:17 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
Date: Tue, 28 Jul 2020 02:37:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728093326.GC1326626@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_053719_064169_D136D474 
X-CRM114-Status: GOOD (  18.43  )
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
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>> allocation and wait doesn't seem very scalable.
>>>>
>>>> Paul, do you have any good idea for an interface that waits on
>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>> global completion and counter, and each call_srcu would just just
>>>> decrement it and then the final one would do the wakeup.  It would just
>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>> counter on stack to avoid an allocation.
>>>>
>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>> the rcu_head in the hw_ctx.
>>>
>>> I think we can do that, please see the following patch which is against Sagi's V5:
>>
>> I don't think you can send a single rcu_head to multiple call_srcu calls.
> 
> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
> rcu_synchronize into blk_mq_tag_set.

I can cook up a spin, but I still hate the fact that I have a queue that
ends up quiesced which I didn't want it to...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
