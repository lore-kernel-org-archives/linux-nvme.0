Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792DC433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D70206F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YBvWupa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D70206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=24GwUEmRRSsbIREdqtqz1XHr8LHb8Tktc19g1qepM9Y=; b=YBvWupa6CEMpqZ0LmnR1biMou
	tXXh2Rp8voaqk3JLbGpEIpoG7a/PW6FSya9UQHHJL4MklAe40jdaHdGdu7Mui5a1QlTU/N8sunbsQ
	2vcZZyvqVwitkxCyMOnDMq4FQRfQaIQb9X1s46pmybo54VIyzwq9rjxmLekI26vIF2PpLkuXGF30n
	4l4DPoLpzjkTpM37PsZnPZBD0TCpe+iXv32SkMbn0g2rzHVFFzS0Zr2MilZhB4c3C+AaGnT35ifRs
	VwokpY7aY8ET+1blb3c4mNioAONdWR3Z8azesLZCpp90U+MsyzGw8F3d031bMn2OCd2y4aVErY86c
	fyOIxkn9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Lql-0007Y7-FV; Tue, 28 Jul 2020 09:24:43 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Lqj-0007Wu-9Q
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 09:24:42 +0000
Received: by mail-pg1-f196.google.com with SMTP id o13so11548178pgf.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 02:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xL/B9gY8iip3iVNIPktCRqfoRqM3/8PUZ5p5fFHBhHg=;
 b=sufFhXt7Ep3XljnXy+/D3QHeaMcrGTV2qujUiB7aH43Eikee/0HT8t/TM2L6o/aIBS
 cqUUdT2wQWqO2KThOox7xqcka5+37lIWWdW3VGXJh2HeKJHHyphdfWi8TlZ/h2S7GrHc
 93T5hLm8QQnBtsqmQPZIVAYtYGgdU5GM55XttY+6w00wRRWaPbxQFR4kbRD6mvSwSHCa
 zU/B5T857XFZgh6YM/jPHGOndVUfh14JmsPQqOYHQAVlawqtKM+obh6dMNWOMr3hEFxS
 ZOO/DEkzlnYUsN//zmntlu+4t+rBWUuUBlGzZuoll/UoFXE3cmCUqvbpEt/toPo/11tf
 rpgA==
X-Gm-Message-State: AOAM532L+adxQtES1e50cAjjKBTX7eVi+nH0pv9DQu3vt3ueHN0M049r
 2s/6RBSRZhXve9POF7fYx3g=
X-Google-Smtp-Source: ABdhPJxVa5rYu2TnTkAe+FZGgFK6TELYiTpOSPNAxllgBKznCmx9Kt4Xk0+RuZuwDbxN8Ag9YuxMEA==
X-Received: by 2002:a05:6a00:10:: with SMTP id
 h16mr23685918pfk.214.1595928280149; 
 Tue, 28 Jul 2020 02:24:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id g19sm17952974pfb.152.2020.07.28.02.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 02:24:39 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
Date: Tue, 28 Jul 2020 02:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728091633.GB1326626@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_052441_461104_30A22142 
X-CRM114-Status: GOOD (  18.65  )
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
 Ming Lin <mlin@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I like the tagset based interface.  But the idea of doing a per-hctx
>> allocation and wait doesn't seem very scalable.
>>
>> Paul, do you have any good idea for an interface that waits on
>> multiple srcu heads?  As far as I can tell we could just have a single
>> global completion and counter, and each call_srcu would just just
>> decrement it and then the final one would do the wakeup.  It would just
>> be great to figure out a way to keep the struct rcu_synchronize and
>> counter on stack to avoid an allocation.
>>
>> But if we can't do with an on-stack object I'd much rather just embedd
>> the rcu_head in the hw_ctx.
> 
> I think we can do that, please see the following patch which is against Sagi's V5:

I don't think you can send a single rcu_head to multiple call_srcu calls.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
