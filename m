Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB56C4742C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:03:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2342224D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U4mxfej4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SIqtSJpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2342224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bC5prZnfM1CLL1eyBv3+wLXdaFv+poEXJFAVe0YCSGU=; b=U4mxfej4K5A7+dixCG6taERss
	bV6GhCONtJpvFQUlVI1O8UzZIw5AOskqco4qeXZ4n9Zrxru4OoAD9i8oTfBQBRNt/J6CDfiZ0PfGu
	L0bjS1m2iTsXf6fXRvgClJnizgDHbijuiOV/4oQ0L5TUIjy4qhy2wbBdMODGdCZapWdFlidnLjqoW
	bBVeTyUOZoZJzvq+IMphzX9MAA8v4xAvhjcs0BsEaAW5EHxuarHT9wJBP3NhXXmWmTHDgT5Lbz+1h
	Ej7gYGGxTdr6Ls6BsnNc6uuS7yhtyVm1V25gin0/o23R1KbNMLxjSAoLsxTVc35T0HLrz64yBs5tX
	TNXuyunCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdgE0-0008DK-Gp; Fri, 13 Nov 2020 21:03:16 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdgDw-0008Bo-Jb
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:03:13 +0000
Received: by mail-pg1-x544.google.com with SMTP id e21so8064889pgr.11
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
 b=SIqtSJpDMUZf6A0Bp680OWghtTzBxCyFEittkvDw3lqzYn2Ps6IVbUdF4Bf3m1dHhb
 /AsZrlSawXqvZfYZLk1N+1S43FCJPaOfMoqY9qoujbZiA6QWbaEsBAV+otmmbcKGB8uI
 s3C2sYFRUEPz+dC1Kq9kik/qnrNy+NNJPscbllkTJ7YtOLUIz5k0eVizc3mfmSP+sLta
 xJd2RATiOoXhTf+2TvePEngYQ7CNZ7PsTd4FUrL8YoF6TkAMthadpjk6+HVaLmvhsqEJ
 FaPHfuDCO6cHzEUungyCmh3arO6bio30A9vmD/A9kTmX0KS/1Up9Zc2wqdsHsoFMlPk3
 NeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1zoui9BUZXUZOqrTWaBrZykGcY0FRSZnrRzqMJQ8RwA=;
 b=TyAm7AadTJ/rUxgmLlNwHuTs7o6wy7MrNhigAsmGVFDAKTb2hIcfMFT5cK6f1FcrVZ
 K1r+9+T4H4wT6HxQunXmvIVCrLO9gtcwRjzRJj3QK/+AKY9PSknGUMuaG1YKFP8F/qEq
 TaBsBOUxDVERpEOnHGUmngrkjUkNAQQ9TckdA6RlxxIxVcMBInu5je+oTYzlHgsROWGG
 0JA0Zs1YcqfPZghVb1q/0F4r41+m+q4PQMUrA8KBLM+LB2DCgIwni3mFTeugpJLgo2kL
 Ipcc5S2BbhbGTVydmeaPqyvzlzmPVZkMs3SJtZF/ZnbqCXWru3oUClky2QfA3u3ZRJgd
 ThKg==
X-Gm-Message-State: AOAM530LHSb5HFCOM+MFUCp+Wm6En38NFUuSAZypJogWISB39phOE7+7
 g1M+NWTSLKx5w20+psuVelM6Hg==
X-Google-Smtp-Source: ABdhPJy9RxMN3SjWuODbONNveEfQJhguQEGd2j8B+Qx6ue32McdtKQK4nHihEq6cvGxKB+/5V9axzg==
X-Received: by 2002:a63:161a:: with SMTP id w26mr3316313pgl.17.1605301388725; 
 Fri, 13 Nov 2020 13:03:08 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id d2sm11265021pjj.37.2020.11.13.13.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:03:08 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Sagi Grimberg <sagi@grimberg.me>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
Date: Fri, 13 Nov 2020 14:03:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_160312_670015_11CB6932 
X-CRM114-Status: GOOD (  23.28  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/13/20 1:34 PM, Sagi Grimberg wrote:
> 
>> I haven't taken a close look at the code yet so far, but one quick note
>> that patches like this should be against the branches for 5.11. In fact,
>> this one doesn't even compile against current -git, as
>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
> 
> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
> before submitting.. Sorry about that.
> 
>> In any case, I did run this through some quick peak testing as I was
>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>> this. Perf diff:
>>
>>      10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>       2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
> 
> You ran this with nvme? or null_blk? I guess neither would benefit
> from this because if the underlying device will not benefit from
> batching (at least enough for the extra cost of accounting for it) it
> will be counter productive to use this scheduler.

This is nvme, actual device. The initial posting could be a bit more
explicit on the use case, it says:

"For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
terms of IOPS per core over "noop" I/O scheduler."

which made me very skeptical, as it sounds like it's raw device claims.

Does beg the question of why this is a new scheduler then. It's pretty
basic stuff, something that could trivially just be added a side effect
of the core (and in fact we have much of it already). Doesn't really seem
to warrant a new scheduler at all. There isn't really much in there.

>>> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
>>
>> Was curious and wanted to look it up, but it doesn't exist.
> 
> I think this is the right one:
> https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf
> 
> We had some back and forth around the naming, hence this was probably
> omitted.

That works, my local results were a bit worse than listed in there though.
And what does this mean:

"We note that Linux I/O scheduler introduces an additional kernel worker
thread at the I/O dispatching stage"

It most certainly does not for the common/hot case.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
