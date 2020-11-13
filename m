Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCAC6369E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEBE2224A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VqojXNK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEBE2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xYYyQIUzhZwJsz9uFQvrjsTjeTyC063XFPSgIQXm+oA=; b=VqojXNK00E6uBSqzywbIX3yD5
	fMD8FstRJ3QOLhLB/KvrC1Kaag752V4HLI8ZuDsyF4YhbKn4WQSM5RHcy7D1zV5kuG8M0a8QH4I9V
	EppZz4jvKJv8cSrFgbOoXdWEbIISINCMCGFT6Gh3Dqzl0kZto/c2IBnK0j55GvIT20z/s34RuTKda
	z+xkTf6EFshGiJXcHKwDHPQwFRUa4jvTztkrzIfLPe7ly2j9XEFCf8d+Z1GQcDV89Ra2G1Rpzl048
	rDKRkfB0wT3EEh0orgmkoy5pNZL5ECffDtwlNYhepdRkDPmoryjQcZJDq834AWXWcRrfAsNgwJgyL
	HgwYkjFIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdg9B-0007ch-8t; Fri, 13 Nov 2020 20:58:17 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdg98-0007bx-5m
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 20:58:15 +0000
Received: by mail-pf1-f196.google.com with SMTP id g7so8669173pfc.2
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 12:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eqiW5WCeO56holm7RXoi3eQgmDv2WVSj1ocHaA+r/9M=;
 b=pbNOIjWgtHeRg4sGySEocCBTgz4+MnTZ5g316btLM0QgBRud03R3C18//MUyduXqls
 rnEPYUGro+jD//B/L97CWwppn9UTEFe9NXr3QOFf12W2JUdn84pzsuUH0PACZaDTb9wv
 x2Yeva9Y/TPigAjy2hXWbuUwm+Gus6GM/jEIS6vzTNCdOimuWGaP+CcrGzqvHKCc1ZtT
 w+V50aPG7/FIEbVXYz80jlpFDTqxAmuSIAwH8tLoPM1nLJBIVox9o+fFcLPn8dtbzItN
 XH81f1SF0Jv2igYMpK9Ba20+q9ueccGYXWpeoDSKH4rFvCAz/XWJz6xlDUgeFlZTvQXr
 tkaQ==
X-Gm-Message-State: AOAM532kObdrhuVW1rDUQ18CMRnkPZnbKaQkKHY5sw0h/tYrf/u89hUX
 D2ewTBl+pmqfMu4ZfF7CkCA=
X-Google-Smtp-Source: ABdhPJwn08QDfPoq2VTpcaBPIWAw389P+6FOdpXkdFrwjnNGlFh6XICRT0Yz5zZUNeeVgaqEo7SODw==
X-Received: by 2002:a62:7bcc:0:b029:18b:5859:d5e1 with SMTP id
 w195-20020a627bcc0000b029018b5859d5e1mr3398498pfc.40.1605301092806; 
 Fri, 13 Nov 2020 12:58:12 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c?
 ([2601:647:4802:9070:be97:ffd:339d:919c])
 by smtp.gmail.com with ESMTPSA id r127sm10585552pfc.159.2020.11.13.12.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 12:58:12 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Ming Lei <ming.lei@redhat.com>, Rachit Agarwal <rach4x0r@gmail.com>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <20201113145912.GA1074955@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <44d5bcb0-689e-50c8-fa8e-a7d2b569f75c@grimberg.me>
Date: Fri, 13 Nov 2020 12:58:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113145912.GA1074955@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_155814_289895_681DB1CB 
X-CRM114-Status: GOOD (  21.11  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Rachit Agarwal <ragarwal@cornell.edu>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Qizhe Cai <qc228@cornell.edu>,
 Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> blk-mq actually has built-in batching(or sort of) mechanism, which is enabled
> if the hw queue is busy(hctx->dispatch_busy is > 0). We use EWMA to compute
> hctx->dispatch_busy, and it is adaptive, even though the implementation is quite
> coarse. But there should be much space to improve, IMO.

You are correct, however nvme-tcp should be getting to dispatch_busy > 0
IIUC.

> It is reported that this way improves SQ high-end SCSI SSD very much[1],
> and MMC performance gets improved too[2].
> 
> [1] https://lore.kernel.org/linux-block/3cc3e03901dc1a63ef32e036182521af@mail.gmail.com/
> [2] https://lore.kernel.org/linux-block/CADBw62o9eTQDJ9RvNgEqSpXmg6Xcq=2TxH0Hfxhp29uF2W=TXA@mail.gmail.com/

Yes, the guys paid attention to the MMC related improvements that you
made.

>> The i10 I/O scheduler builds upon recent work on [6]. We have tested the i10 I/O
>> scheduler with nvme-tcp optimizaitons [2,3] and batching dispatch [4], varying number
>> of cores, varying read/write ratios, and varying request sizes, and with NVMe SSD and
>> RAM block device. For NVMe SSDs, the i10 I/O scheduler achieves ~60% improvements in
>> terms of IOPS per core over "noop" I/O scheduler. These results are available at [5],
>> and many additional results are presented in [6].
> 
> In case of none scheduler, basically nvme driver won't provide any queue busy
> feedback, so the built-in batching dispatch doesn't work simply.

Exactly.

> kyber scheduler uses io latency feedback to throttle and build io batch,
> can you compare i10 with kyber on nvme/nvme-tcp?

I assume it should be simple to get, I'll let Rachit/Jaehyun comment.

>> While other schedulers may also batch I/O (e.g., mq-deadline), the optimization target
>> in the i10 I/O scheduler is throughput maximization. Hence there is no latency target
>> nor a need for a global tracking context, so a new scheduler is needed rather than
>> to build this functionality to an existing scheduler.
>>
>> We currently use fixed default values as batching thresholds (e.g., 16 for #requests,
>> 64KB for #bytes, and 50us for timeout). These default values are based on sensitivity
>> tests in [6]. For our future work, we plan to support adaptive batching according to
> 
> Frankly speaking, hardcode 16 #rquests or 64KB may not work everywhere,
> and product environment could be much complicated than your sensitivity
> tests. If possible, please start with adaptive batching.

That was my feedback as well for sure. But given that this is a
scheduler one would opt-in to anyway, that won't be a must-have
initially. I'm not sure if the guys made progress with this yet, I'll
let them comment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
