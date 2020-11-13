Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0705C55ABD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:27:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC6122255
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="04gc1gxe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Xce78mtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC6122255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TEKi5fRUzzRXMPwCNN1IfJUFsBoxSVY3e580j8fWFq0=; b=04gc1gxeoBwGPDLqpXCXAPGPS
	Vzgc2GChDmMutB1D1WknylKUdubxahWckObXKjbwUDTyzNLFS5V+nnEiiGDUwTkHUjx4ibnX5p4Cw
	0soZkA2Ga/4v9OwlW0QzgFRg24hexRamJHbF7eeJqKBsW6uvAtKdsMWsU3PDfbJxcM9ZQeWQk2FF1
	WMcQ/KcoZ/Vpf2PzGNQciEPUZDaEzfhIQoDdBF7ZE8TOx8Mql0DmL94w3s1Ne2phoiCLW7e/2JaU4
	jJQFpLqcXxX/GCBweP702T6DL3eRcBlLhvmopw2J2Krdx31cqJ5Gd8Pw2GWWTTNIsAGCLc5XQ6Nwi
	F9ZH+xg2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdgaw-0002OE-6v; Fri, 13 Nov 2020 21:26:58 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdgat-0002NL-FU
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:26:56 +0000
Received: by mail-pg1-x541.google.com with SMTP id 62so8112693pgg.12
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7J5Rp08GL5X3H15jor7CE7t4jnfk1M9RUzFFtD2jiKs=;
 b=Xce78mtOzxG3MZwuIJ6qhBt9FLVIM6ylEG2N7m9qPfAKeCBzNXnKXpIoT7S1oqAebk
 DPc5vJTliZWgA1EnHQA+6VAoEKQN/NITCCn0yOx30u7w1/xl99+Clk/8pZnXBLBcqP4E
 47uqMIb1Av42Km/ps04jAlp1BSHPz8mOl++EklM0DZKonYVsT0Eay+eRAM5QE5u5ll2W
 5HlsDWzXXdsN88Z59eLHWxkHZrNT4urZnIXC/4BoRNFDKA/30Sh+xw5FgzPIuD3lULJK
 piJ/IsnPtsMeFjBPoggYPMc9bkvL7GyZroxnzvz61jvC198xGTGQ+u5s1Fexm6dmRbGZ
 GjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7J5Rp08GL5X3H15jor7CE7t4jnfk1M9RUzFFtD2jiKs=;
 b=KwBgZIqqUnFTSkkbQheAA1P2+vox8wVTQN4KliTvYPy+F601TXwSMwUrRM6Q52vVhm
 47WvHmzpmnc1LItOLv2M33LxDBrpBiHOzR2uks656PFzWoVda1Dysf+stvjvhicqPB6C
 ifdn3GGhUAQ/CeCYpVkUJ7kEMdzP1P+0hiGCxgarebMD/ZssS+dNDBwmof7CjkPioUGo
 MXBvGRhq7s7+XiNgWbcOQB2nC8meZeT4PptslCD4KCO8Plma2RdoZ89fkWDi40tzqCML
 7xgdaaNbHp4w2glV1bi98Z6B5slbPHnYOKuadqEu4sqRHRuBiW/RJrnd0ccSOJBjR6io
 D2/w==
X-Gm-Message-State: AOAM5332qLbeqyNKH4iT26R7GKW09gHD3N8K4p/7XGFVRoWjQbu/FbZ1
 a64oI63ul8MO81UhhC6QzPTBqg==
X-Google-Smtp-Source: ABdhPJwYKJWZ1egWWe92pGhU7NVyiLO88PgU+olcTBqFCmhwVwr0VM5zW/hb5u94Ganu/x4rHmyO5A==
X-Received: by 2002:a17:90b:4683:: with SMTP id
 ir3mr5040531pjb.212.1605302812924; 
 Fri, 13 Nov 2020 13:26:52 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id e22sm11517673pjh.45.2020.11.13.13.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:26:52 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Sagi Grimberg <sagi@grimberg.me>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
Date: Fri, 13 Nov 2020 14:26:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_162655_548339_CF9F00DB 
X-CRM114-Status: GOOD (  25.90  )
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

On 11/13/20 2:23 PM, Sagi Grimberg wrote:
> 
>>>> I haven't taken a close look at the code yet so far, but one quick note
>>>> that patches like this should be against the branches for 5.11. In fact,
>>>> this one doesn't even compile against current -git, as
>>>> blk_mq_bio_list_merge is now called blk_bio_list_merge.
>>>
>>> Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
>>> before submitting.. Sorry about that.
>>>
>>>> In any case, I did run this through some quick peak testing as I was
>>>> curious, and I'm seeing about 20% drop in peak IOPS over none running
>>>> this. Perf diff:
>>>>
>>>>       10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>>>>        2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock
>>>
>>> You ran this with nvme? or null_blk? I guess neither would benefit
>>> from this because if the underlying device will not benefit from
>>> batching (at least enough for the extra cost of accounting for it) it
>>> will be counter productive to use this scheduler.
>>
>> This is nvme, actual device. The initial posting could be a bit more
>> explicit on the use case, it says:
>>
>> "For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
>> terms of IOPS per core over "noop" I/O scheduler."
>>
>> which made me very skeptical, as it sounds like it's raw device claims.
> 
> You are absolutely right, that needs to be fixed.
> 
>> Does beg the question of why this is a new scheduler then. It's pretty
>> basic stuff, something that could trivially just be added a side effect
>> of the core (and in fact we have much of it already). Doesn't really seem
>> to warrant a new scheduler at all. There isn't really much in there.
> 
> Not saying it absolutely warrants a new one, and it could I guess sit in
> the core, but this attempts to optimize for a specific metric while
> trading-off others, which is exactly what I/O schedulers are for,
> optimizing for a specific metric.
> 
> Not sure we want to build something biases towards throughput on the
> expense of latency into the block core. And, as mentioned this is not
> well suited to all device types...
> 
> But if you think this has a better home, I'm assuming that the guys
> will be open to that.

Also see the reply from Ming. It's a balancing act - don't want to add
extra overhead to the core, but also don't want to carry an extra
scheduler if the main change is really just variable dispatch batching.
And since we already have a notion of that, seems worthwhile to explore
that venue.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
