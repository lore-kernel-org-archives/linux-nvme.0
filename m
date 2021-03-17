Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31056C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 16:49:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2A764F4F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 16:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2A764F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zz6GXwci9Fiv8hmm2E2dbNHCYcpOpNnXU9+lMRlQsUY=; b=Ipcv3EmtOegeYhZFq7nWHM9S2
	5uqohbHwpcKLw2CcL6V1065iFK7+nI1XK1Gp8Qcq9qNMReJ3MRq14Ht8L3IC2T5h6bClB/moYdN3G
	17KwCjGLFX92dSXPZ4zStRJKbsnCHXxGQhZpefVlrOCywHq3eXCQ+UG21Ohadvg3pxE814OKZOG33
	JDJRdPzHRqEpSJwG7kzMShO5o+/XE7m/0pzmjD4zc6ODtQhM3EZypuNwhxAJAOrlgpBz4p7HmvfFW
	gY3fhMIQlWBcM6v+gtjB3dUDYPAb9E9+HMwTjxGoUTqxX8yY0FHw6FEfOIRGoyydxESNq9dxeLWD2
	9wuKGxkpA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMZMW-003aLp-7Z; Wed, 17 Mar 2021 16:49:36 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMZMS-003aLK-Av
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 16:49:34 +0000
Received: by mail-io1-xd2a.google.com with SMTP id a7so41655774iok.12
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1wH2LyRR1+bkK8ozSKChGqdKiq+o6C+KbC3pYm1I//k=;
 b=vx74i421oIidL1AV7IVP9x/MKke8KwPgl0Y/NHP+XkaFldqzFwsFqlHqiB++OfBskX
 sny0d/GsB7SOBY8Tav4jUUjJzHngV91SMwRsadcbUbS2jSz+pxe7cb5JoIaadWd9sLYn
 1uJzR5njwT0U+JfnBjRyc9IOC6WgrJALssO+afnYk+qh6kDNUX7mIh5HEaYe/OhSCJTv
 cwwrSWxOF6GPfsm5Ur44XKUeNbR4N++fQblLIL04axWlKBkLMQiTotp8DA7IwZQh8hXq
 J9E137FEu/TUl/HrdEeQuoYB+veJwHVmGsXPTzf+C2fI21YKGyATEMpc9f7rCrSzTNyI
 rjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1wH2LyRR1+bkK8ozSKChGqdKiq+o6C+KbC3pYm1I//k=;
 b=AwxaQIguqN7SG1FzND9pybg13x3MMwPevkEfMLR+63sNRSFDiz6pTJabQVG9JLVXXd
 Lq217CVAUetQt0dUbd9cSviSyvUykEbqsmCNf+5oJLM83eUJskjgSgUt62Hth3W+ZiAY
 XFj0x9H4KtXUdA7o2y14WN1gCjIQAhRYygU1TJ8Xfreqni4Qd9r4jIS9cBA1ithg2fdx
 LrXAhuPj1GdOsDggU5Kuoj3XXNKwJaOn1oeVN6roL5+llN4wi4KRZKhVb5EPujcSZciL
 7OcuntlOfEyzgIAFn4/ZJ2+Bm+4Sy9GZ06o91f2X3pcELiA5Q2BPU9v3necSU4ixY1Xl
 vKgA==
X-Gm-Message-State: AOAM531tqib9HSvAG7dAWIxZHJgAwZVoC8PVcuUlt7Ugp4xAm6a8ZJ9O
 7dtD2NoHbD2w8bHNxjGxYy0r2A==
X-Google-Smtp-Source: ABdhPJwuYqaRv3GWQJYe3nx1X6av0DUufct9XitEkVCCQ93kIMY9i5w81Fpt7geD2f0zEp9BWeddYw==
X-Received: by 2002:a02:3304:: with SMTP id c4mr3597808jae.68.1615999770323;
 Wed, 17 Mar 2021 09:49:30 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id s18sm11490637ilt.9.2021.03.17.09.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 09:49:29 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/3] nvme: wire up support for async passthrough
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, chaitanya.kulkarni@wdc.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
 javier.gonz@samsung.com, nj.shetty@samsung.com, selvakuma.s1@samsung.com
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140240epcas5p3e71bfe2afecd728c5af60056f21cc9b7@epcas5p3.samsung.com>
 <20210316140126.24900-4-joshi.k@samsung.com> <20210317085258.GA19580@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <149d2bc7-ec80-2e51-7db1-15765f35a27f@kernel.dk>
Date: Wed, 17 Mar 2021 10:49:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317085258.GA19580@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_164932_464601_2294D10A 
X-CRM114-Status: GOOD (  16.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/17/21 2:52 AM, Christoph Hellwig wrote:
>> +/*
>> + * This is carved within the block_uring_cmd, to avoid dynamic allocation.
>> + * Care should be taken not to grow this beyond what is available.
>> + */
>> +struct uring_cmd_data {
>> +	union {
>> +		struct bio *bio;
>> +		u64 result; /* nvme cmd result */
>> +	};
>> +	void *meta; /* kernel-resident buffer */
>> +	int status; /* nvme cmd status */
>> +};
>> +
>> +inline u64 *ucmd_data_addr(struct io_uring_cmd *ioucmd)
>> +{
>> +	return &(((struct block_uring_cmd *)&ioucmd->pdu)->unused[0]);
>> +}
> 
> The whole typing is a mess, but this mostly goes back to the series
> you're basing this on.  Jens, can you send out the series so that
> we can do a proper review?

I will post it soon, only reason I haven't reposted is that I'm not that
happy with how the sqe split is done (and that it's done in the first
place). But I'll probably just post the current version for comments,
and hopefully we can get it to where it needs to be soon.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
