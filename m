Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AAFC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 20:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6KzDWV2s9CddCeS2n3xLkn5ljOP7g4ucSnb8sgeU+g=; b=fAXKCB7XctW4deY9HOcVdWe1Dj
	9pXD2toDjX8wZOeGXS6yvwAZKZGQ8csloOMRuxtYRfzyNIkWJ4jo6wbECsElCE5DZK69OvH9/Kgc6
	Bsm1Ye8HhqqPrAHGaTkh3//JXh3+F47V7qs0UCKGKqS9YlRU/oGqyLCEWYvGEvC5N1X/7As4NUgmk
	rUlwKf1ysi5eTHimZddswmDh8VVNnfEwXIlN2teuKi6wVvgUSh+1tkffQpi8xO7kEKitRh4ddGXqz
	QtV9LY5fqCpgXL0Opc4aObiI48NQMhT8eXnOARZNOqQUpm2VlrQlRN98q8z2iW2xbxB0CkR8HMsQx
	oiw4+l2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntEWn-005nOn-Tu; Mon, 23 May 2022 20:19:45 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntEWk-005nNd-Dt
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 20:19:44 +0000
Received: by mail-pj1-x1033.google.com with SMTP id n10so14999423pjh.5
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=X6KzDWV2s9CddCeS2n3xLkn5ljOP7g4ucSnb8sgeU+g=;
 b=Junva1dQ9VVrtil0/VpAz8ZRAtOPljAlGJVh05PqgLdrJhGyiHPb7kbuqAuAAxGIE7
 gznLGGFfa94LmzfgcSigDTio2gqW3/nwqKVWoyDOaLD9k5uuwxT4+F0toncGxj1+ccfJ
 3Me7uu2SBTRg2wvnFbtpnAUWBlpWG6VOt3SGMYz9uiRs/NFLGSww8HPDSX1KAtvqKPlx
 Q+TWhEIh53KZp75I4AI0GD0i47vRV82w6zcC1yk1hie6QObR5Azm9pvoLfsQTVSB/OpS
 tYWuCJYLFbhCC8Gth4ilRFHlY5bXVVT5ZxroqDiYWubXmqwATuCgwu/N4/AHm2ICgJY2
 5VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=X6KzDWV2s9CddCeS2n3xLkn5ljOP7g4ucSnb8sgeU+g=;
 b=zDm8lt2F/Tp7U9/DQ9YQUx4WuTiXlTVWk7of5OJwgHfWFRhc34zMBcZDqmJUN3+HHR
 0XbebmAXCBwHk3Lvaa1DT4+ha2r7iupoIw/lgM8ZiNKT/D6XemPA/poSWcU8eO2LGPhT
 iqD8UDJFgG/edu8Krgh5UUc3umo/1S9rx4TFWl6R2ny2Ltja6+mxnQyWHWjpTnGwzcs2
 zsCvyl2ElNZ/7bS1GPTPKrsrBelAoHaqwmYI2Eyu788oU7ZfJYhtAnaOVZYTJuUjJsR2
 0MfzS0B0E436miLzvVs2whBFE2oGBDKGDqT3pBW5QMpfzfPtVDgzxYhDUKozfoQWNfrz
 Gtmg==
X-Gm-Message-State: AOAM530eQPWgaN4x0o4jo1VFSWoRay+zZgADv3qIhBL/v9sPiisI+8+F
 PV3dZfHA5nzr+9MypCWCDCSpSQ==
X-Google-Smtp-Source: ABdhPJwE2FyhUuyJfb2fxL0s3tzgZw/zFzPrpAe0yTUW02/5PzAcT2O1SW5Msdq10Wsdt/kQI9SVVQ==
X-Received: by 2002:a17:902:e94e:b0:158:91e6:501 with SMTP id
 b14-20020a170902e94e00b0015891e60501mr24261902pll.29.1653337180154; 
 Mon, 23 May 2022 13:19:40 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 ck18-20020a17090afe1200b001cb6527ca39sm129991pjb.0.2022.05.23.13.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 May 2022 13:19:39 -0700 (PDT)
Message-ID: <caa5e85c-2bfe-b9e3-1e32-c11f78e6ad29@kernel.dk>
Date: Mon, 23 May 2022 14:19:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [GIT PULL] io_uring passthrough support
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <6f712c75-c849-ae89-d763-b2a18da52844@kernel.dk>
 <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whfi3FE3O7KrziqPbyGvAmNFas3xxLz2O+ttzBkCOQmfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_131942_514539_E2F9DF75 
X-CRM114-Status: GOOD (  22.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/23/22 2:15 PM, Linus Torvalds wrote:
> On Sun, May 22, 2022 at 2:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This will cause a merge conflict as well, with the provided buffer
>> change from the core branch, and adding CQE32 support for NOP in this
>> branch.
> 
> Ugh, that really hits home how ugly this CQE32 support was.
> 
> Dammit, it shouldn't have been done this way. That io_nop() code is
> disgusting, and how it wants that separate "with extra info" case is
> just nasty.
> 
> I've pulled this, but with some swearing. That whole "extra1" and
> "extra2" is ugly as hell, and just the naming shows that it has no
> sane semantics, much less documentation.
> 
> And the way it's randomly hidden in 'struct io_nop' *and* then a union
> with that hash_node is just disgusting beyond words. Why do you need
> both fields when you just copy one to the other at cmd start and then
> back at cmd end?
> 
> I must be missing something, but that it is incredibly ugly is clear.

I think you are! The NOP case is just a sample way of exercising the
CQE32 support, with extra1+2 being what is passed back in the bigger
CQE. The NOP command exists purely to test things, and the CQE32 support
there is a bit forced because NOP just always completes with '0' in the
normal res field.

We can obviously dump this as it isn't integral to anything, and
honestly now that the NVMe is wired up, there's no great need to have a
separate test for it. But it doesn't really hurt and there are already
regression tests for it.

-- 
Jens Axboe


