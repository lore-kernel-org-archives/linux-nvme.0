Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF9C63697
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 20:35:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF682224A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 20:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UbEzoOeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF682224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MmCjDTRB984WvW9EIe6VuBdY72N39Ge+ulIDzXoINis=; b=UbEzoOeIVyhIY/wZLaKG6K7HA
	SjH9yNCEpZoxzVbKLgFlst8mWYs2d4cndSt/wyUQZl5yu2OzLkXNE8mDvUBT9N9abnivDn9mRUuSw
	/IJcy61OSqHY10y8qLVRFqLQ6RgbqlOqrKv7FSufmHmLo816jGxJctNk5TJ1w1JxX1wNKrvKnQQH0
	vcJ2qFideA5WMQaA8akv4HlalCzpOg+djS2TuLip50lOUMHL+X4+U7C/XIzJ5mkJ+o0ma3EA0eVpN
	4XqL6LhcGnqzWhqetZhSp1fcxgjVydZLjaiq4RPSXFBen8ExOlGIm/+LW0Am/lfB44fX11xsUqJ/a
	b44awiO5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdfmj-0005nA-VR; Fri, 13 Nov 2020 20:35:06 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdfmh-0005mE-AA
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 20:35:04 +0000
Received: by mail-pf1-f193.google.com with SMTP id w14so8599675pfd.7
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 12:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fxjgOhyybNYpZSYX+6Oz1HIqCUNxG8ovneGfaNCfF7M=;
 b=Kn4Ns9qRBqL0rco25xkka+ignhZW9XbcgwD7awhmI3xp1rtxZF5oGMoBcg2Irsp71+
 VEnhETJnzf1p/AFNTjq923qAkYV2hO/6HSntAkiXRtRPkPS55SJ1JgLkyzrvMtTEYI/W
 SARQ864g6sRFGpTJdcckdLEqBC4zcsfpxAOVn+gSbliz7GE0iYVjM1lTKOIebyDI5Saq
 EQ7eDL7xTN1U7hvtR2FwL3js8AHnP8PA4elx2yPd6ObP4asZL/0cJXRCKiOs3jAHKPWi
 Qsqv3CMdeZVmN4rHj0CYaio5HoGH3gmTmAEyxmgriCX3OVbVAuPPc4fAAfI+G5upC1Eq
 vghw==
X-Gm-Message-State: AOAM5330XHeCoesHYKBKNMnRa+2meaqTtEqfc/7ub6h9faVNxSmSAfrl
 DYEcqPpBMLXhWta2+dKC3WY=
X-Google-Smtp-Source: ABdhPJy42BorG2pmGsmgyPntSK/vRijj7t5aWnUYg3nJvkgQnbWSa/nNQ4gJ0u4rpJEGYtI1RRcikA==
X-Received: by 2002:a62:dd16:0:b029:18a:b228:649 with SMTP id
 w22-20020a62dd160000b029018ab2280649mr3540822pff.33.1605299698294; 
 Fri, 13 Nov 2020 12:34:58 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c?
 ([2601:647:4802:9070:be97:ffd:339d:919c])
 by smtp.gmail.com with ESMTPSA id t64sm11036186pfd.36.2020.11.13.12.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 12:34:57 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
Date: Fri, 13 Nov 2020 12:34:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_153503_388567_5B2227D4 
X-CRM114-Status: GOOD (  18.75  )
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


> I haven't taken a close look at the code yet so far, but one quick note
> that patches like this should be against the branches for 5.11. In fact,
> this one doesn't even compile against current -git, as
> blk_mq_bio_list_merge is now called blk_bio_list_merge.

Ugh, I guess that Jaehyun had this patch bottled up and didn't rebase
before submitting.. Sorry about that.

> In any case, I did run this through some quick peak testing as I was
> curious, and I'm seeing about 20% drop in peak IOPS over none running
> this. Perf diff:
> 
>      10.71%     -2.44%  [kernel.vmlinux]  [k] read_tsc
>       2.33%     -1.99%  [kernel.vmlinux]  [k] _raw_spin_lock

You ran this with nvme? or null_blk? I guess neither would benefit
from this because if the underlying device will not benefit from
batching (at least enough for the extra cost of accounting for it) it
will be counter productive to use this scheduler.

> Also:
> 
>> [5] https://github.com/i10-kernel/upstream-linux/blob/master/dss-evaluation.pdf
> 
> Was curious and wanted to look it up, but it doesn't exist.

I think this is the right one:
https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf

We had some back and forth around the naming, hence this was probably
omitted.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
