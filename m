Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E887C38145
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+OaBo72pMJNSBQYXNS+YDPCBT48jhi0Jw9AbEWtY6U=; b=E98ZyALt4R0wuauX+PgPC4qxlU
	PglMWR+P3urTxLUUo8reUjyEluN/ZI5ijl2EdtzBTQgGC+nyfhYSw/cSIkAPTqvpOOYx5GEt/5BV2
	+I5mlFNMnlDWUARBq3NXBvnSIdKmaCUoJytcA5uW/QofjycMdN80kqeNZU8G/lu1DjVw0djNkVFG4
	hvgbjZgfB3L3e+vY2l3kMpGRRQi7qinezjetM8lZEm88At3NbkRRDTHx7+WwZpWf/lyUrUj1qM9TU
	2iXfsge8JA2DkAy0ZpKvLkG7KKrdWeV5scTmYM2Q03IH/uDoKdcxgSGISBk7aZD1pQkZn75RCOVbj
	Ad55IT/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWJ2K-0050p4-R4; Thu, 08 Sep 2022 15:01:49 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWIrP-004uao-39
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 14:50:32 +0000
Received: by mail-io1-xd32.google.com with SMTP id 62so14256857iov.5
        for <linux-nvme@lists.infradead.org>; Thu, 08 Sep 2022 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2+OaBo72pMJNSBQYXNS+YDPCBT48jhi0Jw9AbEWtY6U=;
        b=NCo3id8hFYjm5E9oCtap7qyDZV2P202AU1/FlLpoz/B4AHi5MNm7kJaBcxTA1CWznO
         TR/+dNUh2Ov+/m+vV2J4ki+9HG+PWCv9tAdcLVsMZfK6hYgP0jsrbxPbx4i/Cq/1tKYM
         inxfFGmkMeqZmBJ0Qzr9I2raRigf5w5azzV2EgbZLdzDLI/ZD1eyAOag1pZNhmGuFpWN
         lx8n38xFdvnGrgO+vbup/Y1wqQXjlOcDHJ6G98A8EPDRCaxCPmeYoN76taUao6BUVe7W
         F4V75viqKFiZ/TbLkCRCsiePM21vnd5Cbpnhm+ppV0E6j6r7XaZvgj+Hh3mxs2unHFKq
         G3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2+OaBo72pMJNSBQYXNS+YDPCBT48jhi0Jw9AbEWtY6U=;
        b=2XkYeM4NfYiw/lIAGX0i1LuyfZ4MXGg/9p00qxvkTpyhjcDYdnXVWd23Uh1+M2YabC
         s2f9wV1Uvv2+nSnslwntsWgFKTw1c0fOcCNOnQ/Hy/Y/zdeUOMAax8o3Ml8lKvvx83mb
         nb9yJgtuD6Y/n7fHMBsTe9ARKau+boJC6lDbGGEflzLY1z5S4bA9WI1jgCmbLQV0RwmX
         C+P2x9cshqHDS/129RzjjyjiCKDtDgzATqbGJwkgYlkaP0zhO8VyodSkhAgI7JghCcli
         hlY9iL7NPvSG0ZMgnAAwMpiVQgiF4QIXaXNlvCVfNmSCtbS8X+X64e9i3eiHhTovknhG
         Wi6g==
X-Gm-Message-State: ACgBeo0BL+8IC6Mv9u+Ge9d6VcO3l0Ouer+Y387b5QcBdkCLZ8E834eL
	v+N+uIdcK7BBf58EywAYcnx6+A==
X-Google-Smtp-Source: AA6agR6uieADTj+azZfP+uuQSQTzIi8TQ8lt8PcpWmPsm7pAgm3nZVD0XRV7p4pAe/K6Xu+8pflAgA==
X-Received: by 2002:a02:a784:0:b0:354:69ac:48fc with SMTP id e4-20020a02a784000000b0035469ac48fcmr5145680jaj.14.1662648627205;
        Thu, 08 Sep 2022 07:50:27 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u9-20020a022309000000b0033f043929fbsm8454141jau.107.2022.09.08.07.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:50:26 -0700 (PDT)
Message-ID: <def18512-bc31-6847-f099-8efea0beed2a@kernel.dk>
Date: Thu, 8 Sep 2022 08:50:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH for-next v5 4/4] nvme: wire up fixed buffer support for
 nvme passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220906062721.62630-1-joshi.k@samsung.com>
 <CGME20220906063733epcas5p22984174bd6dbb2571152fea18af90924@epcas5p2.samsung.com>
 <20220906062721.62630-5-joshi.k@samsung.com>
 <26490329-5b51-7334-1e2a-44edfe75d8fa@nvidia.com>
 <20220908104734.GA15034@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220908104734.GA15034@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_075031_179905_C7B2D82D 
X-CRM114-Status: GOOD (  18.18  )
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

On 9/8/22 4:47 AM, Kanchan Joshi wrote:
> On Wed, Sep 07, 2022 at 02:51:31PM +0000, Chaitanya Kulkarni wrote:
>>
>>> ????? req = nvme_alloc_user_request(q, cmd, ubuffer, bufflen, meta_buffer,
>>> -??????????? meta_len, meta_seed, &meta, timeout, vec, 0, 0);
>>> +??????????? meta_len, meta_seed, &meta, timeout, vec, 0, 0, NULL, 0);
>>> ????? if (IS_ERR(req))
>>> ????????? return PTR_ERR(req);
>>
>> 14 Arguments to the function!
>>
>> Kanchan, I'm not pointing out to this patch it has happened over
>> the years, I think it is high time we find a way to trim this
>> down.
>>
>> Least we can do is to pass a structure member than 14 different
>> arguments, is everyone okay with it ?
>>
> Maybe it's just me, but there is something (unrelatedness) about these
> fields which makes packing all these into a single container feel bit
> unnatural (or do you already have a good name for such struct?).

I think the bigger question here would be "does it generate better
code?". Because it doesn't make the code any better at all, it just
potentially makes it more fragile. Packing into a struct is just a
work-around for the interface being pretty horrible, and it'd be a much
better idea to separate it out into separate functions instead rather
than have this behemoth of a function that does it all.

In any case, I think that's a separate cleanup that should be done, it
should not gate the change. It's already horrible.

> So how about we split the nvme_alloc_user_request into two.
> That will also serve the purpose. Here is a patch that creates
> - new nvme_alloc_user_request with 5 parameters
> - new nvme_map_user_request with 8 parameters

This is a good start though.

-- 
Jens Axboe

