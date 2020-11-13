Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBAC4742C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:24:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B4D22252
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T/t+XWvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B4D22252
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ypq3YjLOmNH6T+bfE49Ci/dKj3diZV1PYkzZOUh7sOM=; b=T/t+XWvsdarkHlbt35SYYdyt9
	lBrl9j4Pj29r70oXZLCvnA/x57VNPTfjW0/l1UOxqVoj3Ut69spXP+kEIBppjw5dUVLW89vral/13
	E4q/5GwhSoQHiDRMCu+gkj4O3d9Apf1cWHWcIUcRnYIim3wv445/NTBvwNwj851FmQPgwFGzq8ML7
	vxiaiF3iA2vPYmdSFyO/p0lOS9UFpuOENPzlMECNAL5Z1TK+7OtNvcPPv/KGgaAeEYU/t8NE6drjg
	632/rDZA9BsT6zj4SE+F7Ua64TP/Ip9Ui6bzGDGpnx/FUikDiECA2Pbj/eaBy89VwIk4LX6b51kQc
	4Ea5a9gHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdgY1-00022l-Dg; Fri, 13 Nov 2020 21:23:57 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdgXz-00021w-7k
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:23:56 +0000
Received: by mail-pf1-f179.google.com with SMTP id c66so8718000pfa.4
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zDMkxDEKUwigLJNHN3ydwhNR21emZ0w4/kWJ79+z1uM=;
 b=GLRDa8/PpkOk1IirXgg9Jz4VmmYkVp3FzYP1tutHK0r82m8eV2alXzsTDb9RLqpw6q
 u/6VH2L9muddZxThADxWErrXnVSsppt4TCbhA3Su5l4i9DQRFl7EH9/gLTjxjxKT33xs
 7Kk1HD8YbaViGcWcUt482hjkNjvVU9MuJ9soryQY714gUj4lfzhhc8AlT7TIUgW7pM3h
 g8JIfPVyLqXX5MZEN2ryvadZ4jGZPFMYrDS1jZfEwY/2+ZsebYHvpDHpJRJptxZHKXwz
 Vv2KcLXZxNRfTXYmxXRrk2QgK7FHZjRYz99rw4WDfPA0q1rCIakxVWXhQnaeBadJMW1V
 LzTw==
X-Gm-Message-State: AOAM531Cv4/PMekkozHmkGLaT+Oz2o85QG5AqYzB3tZwESj1ZY1+/iGB
 iYlaAbP1kHGaklLr0WpnNJg=
X-Google-Smtp-Source: ABdhPJwuXR2Fvvsb1vzusQKpDgFzaJ8sjH07TtQxH9xHaExt8QMes7iZteziR5hWvSS164xJrGHlNg==
X-Received: by 2002:a05:6a00:225c:b029:18b:d208:a366 with SMTP id
 i28-20020a056a00225cb029018bd208a366mr3668921pfu.5.1605302633812; 
 Fri, 13 Nov 2020 13:23:53 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c?
 ([2601:647:4802:9070:be97:ffd:339d:919c])
 by smtp.gmail.com with ESMTPSA id e17sm10613872pfm.155.2020.11.13.13.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:23:53 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
Date: Fri, 13 Nov 2020 13:23:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_162355_299696_9CB17EDA 
X-CRM114-Status: GOOD (  26.84  )
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
Cc: Qizhe Cai <qc228@cornell.edu>, Rachit Agarwal <ragarwal@cornell.edu>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> I haven't taken a close look at the code yet so far, but one quick note
>>> that patches like this should be against the branches for 5.11. In fact,
>>> this one doesn't even compile against current -git, as
>>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
>>
>> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
>> before submitting.. Sorry about that.
>>
>>> In any case, I did run this through some quick peak testing as I was
>>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>>> this. Perf diff:
>>>
>>>       10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>>        2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
>>
>> You ran this with nvme? or null_blk? I guess neither would benefit
>> from this because if the underlying device will not benefit from
>> batching (at least enough for the extra cost of accounting for it) it
>> will be counter productive to use this scheduler.
> 
> This is nvme, actual device. The initial posting could be a bit more
> explicit on the use case, it says:
> 
> "For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
> terms of IOPS per core over "noop" I/O scheduler."
> 
> which made me very skeptical, as it sounds like it's raw device claims.

You are absolutely right, that needs to be fixed.

> Does beg the question of why this is a new scheduler then. It's pretty
> basic stuff, something that could trivially just be added a side effect
> of the core (and in fact we have much of it already). Doesn't really seem
> to warrant a new scheduler at all. There isn't really much in there.

Not saying it absolutely warrants a new one, and it could I guess sit in
the core, but this attempts to optimize for a specific metric while
trading-off others, which is exactly what I/O schedulers are for,
optimizing for a specific metric.

Not sure we want to build something biases towards throughput on the
expense of latency into the block core. And, as mentioned this is not
well suited to all device types...

But if you think this has a better home, I'm assuming that the guys
will be open to that.

>>> Was curious and wanted to look it up, but it doesn't exist.
>>
>> I think this is the right one:
>> https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
>>
>> We had some back and forth around the naming, hence this was probably
>> omitted.
> 
> That works, my local results were a bit worse than listed in there though.
> And what does this mean:
> 
> "We note that Linux I/O scheduler introduces an additional kernel worker
> thread at the I/O dispatching stage"
> 
> It most certainly does not for the common/hot case.

Yes I agree, didn't see the local results. Probably some
misunderstanding or a typo, I'll let them reply on this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
