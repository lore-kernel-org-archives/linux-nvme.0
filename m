Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB64C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:33:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA4D610D1
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 09:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AA4D610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ldls0wGJ4YPRb7WMWaahkQCFa3RwPSrqt/GfgT+Tk8w=; b=MWe+F+tuar9MZbJuJhUczS+vkb
	pIgsQo8xgZs6Etci03xFDPdf8lb68J+tZOOMC81S2ne+boWeFTkPyWWZWasUdvW6VYpxWAURs/trS
	/CmueXab6WZUZaOCgwvrZ9CQRKWhu8O3T5qxkv5v1vodgF0yRZpVFXtwkh4f/XaRr2HHFUB1GHr+L
	wBRo35dbc4EzFW1W3jI6z/UcbZdyFAIIfq9xEndoLgyvvSKCV9SY/2bFNJS0D2eeGrKYzt6EyIgMk
	MahC/F7g+DTQiIF/9lWQkAszgo6fG+RMv0vL1pmAcFQYW8FjGkrfmAcbfkEfEd9gkk9AoSpLlAptx
	0EHVoT8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQRHd-008hZs-Hx; Wed, 15 Sep 2021 09:32:49 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQRHb-008hZI-9t
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 09:32:48 +0000
Received: by mail-wr1-f52.google.com with SMTP id d21so2765631wra.12
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 02:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tctzdimomEePZFQ1926Y1beUfE1cC6cv5RQBZ0cexqE=;
 b=fBU0BARooXdvdJfUtAhtH4VfMyj0gMTOKqHcFctqu77BYoRSlbXjouQH+mkQrk0OxU
 LYj6s6MOf5K2ezXpd82wjvv+eGt5+N7wzpkqTse/flJU/H7e/t4B9etNX+y1891NZ8SF
 HxzUv8gTSb6/aYUMdc8iOpUnmpM2Cs4Iv+4SgeakW8slLBM32iBwBS2nEcQ3JRK6K6wd
 MfiImkFABoH/Uo4fPV1UHgvYFm2nQPIjA5nwNbPPT22DOj3R9S++CPMoTnxEA8J9dq+J
 7BU4ZTTlUGeidCc0Dz53f0lQi4VvwSA7OSUfc6BQlR5QuYrCdnHODu8j3b04MrojfXTC
 OQxQ==
X-Gm-Message-State: AOAM533UaRJqzlM4yrJ2/Bs+JSbhF5xBXmQtnrZNkikLmaJUoyzWr+9D
 1KJrQ/Dbw7EbpyKhUhtZ37Y=
X-Google-Smtp-Source: ABdhPJxazB2olf6+pdSpi+qmtORNOuLAGPkjQXvntTO+lDkyYIrI0ho1bMeyqPhPUUh9nD3hgrcS8Q==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr3765679wrr.376.1631698365873; 
 Wed, 15 Sep 2021 02:32:45 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id r25sm13112753wra.76.2021.09.15.02.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 02:32:45 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for namespaces
 just added by scan work
To: Anton Eidelman <anton.eidelman@gmail.com>, Christoph Hellwig
 <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
 <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
 <20210914063052.GA27942@lst.de>
 <e65e9c83-33ed-df58-0eed-4ecf9cb4485f@grimberg.me>
 <20210914073236.GA458@lst.de> <20210914164532.GA142795@anton-latitude>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f73a079-0cff-f900-745c-96dd97d5eb9c@grimberg.me>
Date: Wed, 15 Sep 2021 12:32:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914164532.GA142795@anton-latitude>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_023247_397189_322B3E41 
X-CRM114-Status: GOOD (  18.61  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> I agree it should not happen with xarray as inserts preserve sorting,
>>>>> but that patch has the non-trivial removal of the namespaces_rwsem which
>>>>> synchronizes in a lot in a lot of error recovery flows. It's very
>>>>> possible that xarray will introduce regressions.
>>>>
>>>> I've actually started looking over the series earlier today, and staring
>>>> it I'm pretty sure the namespaces_rwsem is completely broken.  There
>>>> is nothing preventing the namespaces from going away in these loops.
>>>
>>> Where? the ns itself? the ns is removed from ctrl->namespaces list under
>>> this rwsem (nvme_ns_remove).
>>
>> Sorry, with the series I meant the xarray conversion that removes the
>> rwsem entirely.
>>
>>>> But I can't see why we don't just always do a sorted insertation into
>>>> the ->namespaces list.  Just trying to figure out the history of the
>>>> delayed sort ATM.
>>>
>>> Don't know the history.
>>
>> git-blame teels me it showed up with the initial ID ns list support
>> from Keith, so not all that much history here.
> 
> The main reason I suggest applying this as a short term fix
> is that it is well isolated and is easy to cherry-pick into the LTS/stable versions.

I think that Christoph's version of keeping the list sorted is pretty
self-contained and can probably apply on stable kernels.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
