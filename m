Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DDC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 15:44:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792882075E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 15:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASi5EkvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792882075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8Pf131SOjYaKbV3YWeSx8j/Xb9eUrNaDTjXUhW2Rsq0=; b=ASi5EkvKVm4Mh3QasiZiXro6Y
	VPLLb1oAH4skrfEZ/w17SXotc5eiYUJVIJHdn+afT4jvVloI3q/Pjq5avHNVgLUhUrZPQ2qoAOSc3
	69O6rC5+bi1nESZ8WtNE2WwALMClBrsBBOl65+JV0+52Ez4oCww8O/vRDdQGHtvd86VUp3KrzXp+m
	NUjgMq/IzjEhtIkbIuBmh5/oGiE+RTHia9YN5BnQY8MNyozMohG5WoohFsSWzyZpq6gvXw6UhX970
	nBCvBHZWChGjHe5dgsqJjoZUostuS5biqh2hS88k2bHsa6UeL9dioIpm3Gx6/4PVCRrbkptAee0Dj
	lfT7002Bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8mjj-0002pF-49; Thu, 20 Aug 2020 15:44:19 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8mjg-0002og-Pg
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 15:44:17 +0000
Received: by mail-pg1-f193.google.com with SMTP id m34so1310684pgl.11
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 08:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u8Sn+Pfg49VpUlwagz5wgkuY6jeYasKi2tCKCMPTqfo=;
 b=aKB4c5qq5rOWHaZsn18AScKR99PHGx7jvcKN9u89AYgqXpvgnhZAfQ5hN1Cp48n3IB
 7zAt5fUwc26cOUs6lCvpRn8HwsQLMGC4hXWSpxtrVEs6sNk6Lu7ko05crD+b/yvsMmnO
 BiPJXY50nzhZqkbpqH8r40Hs1/PSTucmT1dRTyMVMP08VZQfY10GCgKMGD8qCIKtkNCN
 pthHNmy1kETo/z8w6QIowSMHXyREMykvCc1mBsWtw/30Nbqd6sM6JMADTworlmFYn1rJ
 ZUEWNRz8qiuBCF86hEBingQEB/XrcRxMGEK2NCG0y6BuiHN/eTPolj4JNIJHPYo/B3mQ
 JfCw==
X-Gm-Message-State: AOAM530l9NmkxR7JAEm5gTB0KShjIw80wY56kKftuI1nEWcZgUjPre00
 cgMZm+GOobjDz6O3MA2TVXA=
X-Google-Smtp-Source: ABdhPJw747cbKTtuaMrv2e29HAE9Ea/H1YS+qlJLyS6e+z6x/elBGl/Gp+tkBW/5wAAnb0EiGSxkbw==
X-Received: by 2002:a63:e154:: with SMTP id h20mr2844731pgk.428.1597938255508; 
 Thu, 20 Aug 2020 08:44:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id r28sm3278280pfg.158.2020.08.20.08.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 08:44:14 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To: Christoph Hellwig <hch@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
Date: Thu, 20 Aug 2020 08:44:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820082918.GA12926@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_114416_864700_E4478CC3 
X-CRM114-Status: GOOD (  21.43  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>, axboe@fb.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> We really need to take a step back here, I really don't like how
>> we are growing implicit assumptions on how statuses are interpreted.
>>
>> Why don't we remove the -ENODEV error propagation back and instead
>> take care of it in the specific call-sites where we want to ignore
>> errors with proper quirks?
> 
> So the one thing I'm not even sure about is if just ignoring the
> errors was a good idea to start with.  They obviously are if we just
> did a rescan and did run into an error while rescanning a namespace
> that didn't change.  But what if it actually did change?

Right, we don't know, so if we failed without DNR, we assume that
we will retry again and ignore the error. The assumption is that
we will retry when we will reconnect as we don't have a retry mechanism
for these requests.

> So I think a logic like in this patch kinda makes sense, but I think
> we also need to retry and scan again on these kinds of errors.

So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
cancelled requests and have the scan flow assume that these are
cancelled requests?

At the very least we need a good comment to say what is going on there.

   Btw,
> did you ever actually see -ENOMEM in practice?  With the small
> allocations that we do it really should not happen normally, so
> special casing for it always felt a little strange.

Never seen it, it's there just because we have allocations in the path.

> FYI, I've started rebasing various bits of work I've done to start
> untangling the mess.  Here is my current WIP, which in this form
> is completely untested:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup

This does not yet contain sorting out what is discussed here correct?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
