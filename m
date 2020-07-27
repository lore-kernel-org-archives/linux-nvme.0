Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB9C433E4
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:38:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CFB20729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mQeEUkHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CFB20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZZQTNNR/vnJsgVDND8MudoOmRlF4ehPa7o2rNlRlvCA=; b=mQeEUkHPtKI4yhxMoz/yjpRJ7
	nHOetCznSg6m69M84T5DC2hfHfrkkOb++plDUmXynwHWGrU14EG2ZhFfSF3a7oYIgtgUBVfvd/ybF
	3Tbd6Mr+/SdZ2V/qg3jOLboORit+judtYpmM0xygha8xeg6GUrTqgQMzI75S/fZEB4a4KAuArJnvL
	SEaIxeuwWnftXlwhk3LlwT6CoojOgA71ZyKMQveWuhXpaYd2lbeoT0zQA4Nea1KwLDpvwiba8RSJ3
	LyeNcBBSoSloPwgUzRmYn9qdFSg/+VXE4/2o5k10x9yCuxHPk1dsXKvp/CXjbOXcte/A8ijkvwHC0
	Q3HZ+yUog==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0819-00005g-B6; Mon, 27 Jul 2020 18:38:31 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0816-00004s-Ie
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 18:38:29 +0000
Received: by mail-pf1-f193.google.com with SMTP id m8so2699976pfh.3
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 11:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nh+OsIVvLKpFN+3Qhgvq25K37TE7YLi6IxL8rajsPT4=;
 b=ACL31/XqFQBxnRjgPizs5EYm1q0DSFAlXgeGrFRIU8BsjbVkmZYjmQMqj1FeNL7/jS
 nFcnj2ve5aPPZR1ZYE6eQw9BOL1kZfJoGzBjB4SbZ5E/pEHgdirQpqyod5TRLZ8DRHr9
 8aSttG+/0duH32Bs5tz3ANGeqfnQDOxYAS4WyBKm7z7+o/w7fHGEbq5QxdXiO8cL6gCg
 H3JOXxjzX/B195o6f7uV+PzLQj/32imHfHVJCc26GL9C/RGJ8VRqFMOnaKnrYl53Ew+e
 TNTK/SOt2EX/589FrZFTQc6zG2Do121CcRRqlVSFFbvwDNcbABMLKJIT1Wtcl9meduj1
 NzHQ==
X-Gm-Message-State: AOAM530wEyT9V+z6Y+4+Ec5V24WppX0kTkEruUCf60ccoy/Mek+VwttE
 yaO4NtVUNI89rZhP3K6ij+x15WR6
X-Google-Smtp-Source: ABdhPJzD7/cr7OUej7K+jSeHTwN1VyUg5j4U2E3rOwz2+LC65MvE2g+TBJSi1qJhETkxRsUrMr34xA==
X-Received: by 2002:a63:338c:: with SMTP id
 z134mr20574979pgz.245.1595875107026; 
 Mon, 27 Jul 2020 11:38:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id a2sm15638799pgf.53.2020.07.27.11.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 11:38:26 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c27dab04-81e3-d2bb-351d-d934282147b4@grimberg.me>
Date: Mon, 27 Jul 2020 11:38:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727035033.GD1129253@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_143828_700712_4B2DF543 
X-CRM114-Status: GOOD (  17.41  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> On 2020/7/27 10:08, Ming Lei wrote:
>>>> It is at the end and contains exactly what is needed to synchronize. Not
>>> The sync is simply single global synchronize_rcu(), and why bother to add
>>> extra >=40bytes for each hctx.
>>>
>>>> sure what you mean by reuse hctx->srcu?
>>> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
>>> to each hctx for just simulating one single synchronize_rcu().
>>
>> To sync srcu together, the extra bytes must be needed, seperate blocking
>> and non blocking queue to two hctx may be a not good choice.
>>
>> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
>> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
>> not need if which do not need batch sync srcu, I still think it's better
>> for the SRCU to provide the batch synchronization interface.
> 
> The 'struct rcu_synchronize' can be allocated from heap or even stack(
> if no too many NSs), which is just one shot sync and the API is supposed
> to be called in slow path. No need to allocate it as long lifetime variable.
> Especially 'struct srcu_struct' has already been too fat.

stack is not possible, and there is zero justification for this to go to 
every srcu user out there...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
