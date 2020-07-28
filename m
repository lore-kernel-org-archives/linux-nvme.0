Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223CC433E5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:26:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5D820663
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WchRioWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5D820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wGr+xHVF9rqQ49Uh6bVKJITEN4rgcG4Et6E8CUgIYls=; b=WchRioWxFtayrVgcYCrmYVlzK
	qonCrROh41e+y4O7oIuBVzLPVx8C6PCPDIfn7WESOU1JYaIdf/crLmH18AfblAF4SVxa1q4c/JIxW
	g8T34e0qDthm/a05JNN6YeYNYcSi2J8GiT9oqY13mIOloCeULa8z+EbYseBPhL1It8gMw3NsdDhUA
	Wx4IqVK1sAlyvNGXVBDRc98Xv+d5dzpOflQC3RpoyqW7B943R+MXVgNqHaAlO542EbbENTCyB9xjp
	1PxKiXtyztSMni3pWgnbAhBqjk5guLSazjq+vh5WQpECa+Zx6t85u6UfA5ZviPik2gpYliuNVp3r7
	WVqS838xw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0SQS-0003d7-6o; Tue, 28 Jul 2020 16:26:00 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0SQP-0003cY-Mk
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 16:25:58 +0000
Received: by mail-pf1-f195.google.com with SMTP id 74so2949031pfx.13
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 09:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XNOrn1wxXoARqqWPAobzKyIN7n1CjQyqgnGF84sHvtk=;
 b=R8KcPU6VEh/yIxAxLP1Oc/87cFRPqCoxV5uvU2UbfaR5bvjW799vadctKb+aMcXZwi
 qlJk5gr1ez9Nfz01I+TV41aSOQBTzg5XYvBOi14G3XMjlGNDP4sT9HDukvWzCWmnfTgw
 bJEAsOUFfD/jQVJsF5Q5U78IZG/UFrtZ7pu/+iD9JJr8yXkLNwkdIU3nIPfGssZh30vF
 7D5xFwYtI79EqJD6Qj/Xmfg0MXXEYegxTsdd/CmIiv75vsrfPFLoLoiOh9Xy5TY1KBDy
 DnjFvCGszSPMwDaM7Vr5l55lQQsKBCcEmZjaPq0qdP6oVDEJDLWbMG2Ikpzbgqi3+Akq
 +2mw==
X-Gm-Message-State: AOAM533y4pmfBD3xphiByjbSuLQLBEo7Hta/U/t58Y4JtamUMIg9RuUW
 xOCnc8ooRkUqOCam1Ts1bkE=
X-Google-Smtp-Source: ABdhPJzFtFKjhcllQyen4XXXO249Ran65y3aphY4NyGxJv5geHu8um1lAyRIMHBZyloWB8pYx7s2Qg==
X-Received: by 2002:a65:63ca:: with SMTP id n10mr25736021pgv.252.1595953556413; 
 Tue, 28 Jul 2020 09:25:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id 204sm19145734pfx.3.2020.07.28.09.25.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 09:25:55 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Christoph Hellwig <hch@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728093326.GC1326626@T590>
 <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me>
 <20200728105823.GB29763@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f76c2b1c-d035-04dc-9100-fefde659896c@grimberg.me>
Date: Tue, 28 Jul 2020 09:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728105823.GB29763@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_122557_795458_3D7E2CF1 
X-CRM114-Status: GOOD (  21.73  )
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
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>> I like the tagset based interface.  But the idea of doing a per-hctx
>>>>>> allocation and wait doesn't seem very scalable.
>>>>>>
>>>>>> Paul, do you have any good idea for an interface that waits on
>>>>>> multiple srcu heads?  As far as I can tell we could just have a single
>>>>>> global completion and counter, and each call_srcu would just just
>>>>>> decrement it and then the final one would do the wakeup.  It would just
>>>>>> be great to figure out a way to keep the struct rcu_synchronize and
>>>>>> counter on stack to avoid an allocation.
>>>>>>
>>>>>> But if we can't do with an on-stack object I'd much rather just embedd
>>>>>> the rcu_head in the hw_ctx.
>>>>>
>>>>> I think we can do that, please see the following patch which is against Sagi's V5:
>>>>
>>>> I don't think you can send a single rcu_head to multiple call_srcu calls.
>>>
>>> OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
>>> rcu_synchronize into blk_mq_tag_set.
>>
>> I can cook up a spin, but I still hate the fact that I have a queue that
>> ends up quiesced which I didn't want it to...
> 
> Why do we care so much about the connect_q?  Especially if we generalize
> it into a passthru queue that will absolutely need the quiesce hopefully
> soon.

The connect_q cannot be generalized to a passthru_q, exactly because of
the reason it exists in the first place. There is no way to guarantee
that the connect is issued before any pending request (in case of reset
during traffic).

We can use this API, but we will need to explicitly unquiesce the
connect_q which is a bit ugly like:
--
void nvme_stop_queues(struct nvme_ctrl *ctrl)
{
	blk_mq_quiesce_tagset(ctrl->tagset);
	if (ctrl->connect_q)
		blk_mq_unquiesce_queue(ctrl->connect_q);
}
EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
