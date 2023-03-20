Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AA4C761A6
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kmv0TT9FlsgW40fFGaVuNVUpSEwFzqiWbeCmhxiIXGQ=; b=MaEWDhTlhOwAU5tyNFZ9GTO4wt
	fkMR1Wjtuc8eoXrHltEpvVDi3kBpd+1+szFPOvbvNQS6mwnlcLeDE+FO92kkk5P6ZY+fRBYsL5Zqh
	XVXKG0BF0O4T1fwMRT6zlW4osbIf3WPh0w9xflt6OqYobghIiW236oYj16K/9jIW7sG0RkkJomCK7
	LbkDnqvXlAvbRV1z8+joxi9C8NwP9bwVRWfzsMxVJjkkwVyObYvy1t6FOJAbhF8nI0KbZ8f0hYxFL
	YCemnqgHk0AybrBKNS+RTO5CV9x2ZoPMitFdjO62SA7k0oaKR9EKKaZtXi/YyQDhroYZ87qaoIcLd
	g4e9x5KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peLgY-00AMCy-0s;
	Mon, 20 Mar 2023 20:00:50 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peLgV-00AMBr-1X
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 20:00:48 +0000
Received: by mail-ed1-f43.google.com with SMTP id cn12so5814398edb.4
        for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 13:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679342444; x=1681934444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmv0TT9FlsgW40fFGaVuNVUpSEwFzqiWbeCmhxiIXGQ=;
        b=W1Di6L7xvCWTa4N8xbxAc9s3PZNB2lsvaYiBf2526zCGE+0BPcOjoESs5vNjNUDRlQ
         vXDDN49EP9mSCKGZMH+OVdmfsapkmFMLSzfb7ZAkqia0ig9hHTML4wreX3Z2iznD1ujW
         jtTBIRmBmXCclRH9u/FC2NmHbv199cxyTknlyIjLcM/H4l3W2T2eCwZq/GQzp72De+jq
         e/8QcR+Yx3N/M7LYjyRe49naKFMH6qTZutpYLIcPSErncHPPdKwtW6OHtg4jFDFpOo2y
         7Wiy5kHdlAzcAZuGvvTj9Okn5TlvLe0g6VFyZTpdbQwVpjMsYrPvAhUQe6Oe4OhoE5g+
         Hcrw==
X-Gm-Message-State: AO0yUKVGOPB74gsXEzTI4sWgwnq3uII2tC9ntDqzozw5cFBoxPmSi5jj
	R2pY0QE6feWrwtlbqBsFFRU=
X-Google-Smtp-Source: AK7set8ATzhO8z7Or1jCSYY9dEG/pnPJhMcFd+ySGnB9nW+AffwzsHR5B0us8jpbUETFCFTRFKNMxg==
X-Received: by 2002:a17:906:4c:b0:933:23c4:820b with SMTP id 12-20020a170906004c00b0093323c4820bmr258991ejg.4.1679342444521;
        Mon, 20 Mar 2023 13:00:44 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id v4-20020a509544000000b004fb402a2a37sm5402202eda.33.2023.03.20.13.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:00:44 -0700 (PDT)
Message-ID: <5f38f8fe-5180-04bc-6b77-a5b1e4960dda@grimberg.me>
Date: Mon, 20 Mar 2023 22:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp poll queue crash
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
 <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
 <20230320145113.md6dcyv22yqhppmz@carbon.lan> <ZBh2bCPAnShTMxoF@kbusch-mbp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBh2bCPAnShTMxoF@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_130047_516161_64850C3E 
X-CRM114-Status: GOOD (  12.64  )
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


>>> This was reported and is discussed in thread:
>>> nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034
>>
>> Thanks, I couldn't remember this discussion.
> 
> It just happened late last week, so no worries.
> 
> I believe we can get rid of bio and bdev dependency, and I am working on
> detangling how to get the cookie through without these.

Keith,

I think we shouldn't have an issue *today* because the only non fs
I/O that can be polled is the fabrics connect, which has a payload
and hence has a bio. The minimal change to fix the regression afaict
is protecting against a polled request submission of a user command
that doesn't have a payload (just fail it), which again, shouldn't
happen afaict.

