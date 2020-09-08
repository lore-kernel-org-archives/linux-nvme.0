Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A7C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C93206E6
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X8pOMVS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C93206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aDDZbaOtBU2Un6NXmXVZSBgPq1cuDssMOVO/prPuY9s=; b=X8pOMVS8ufUWdiWP9hG3+1/wr
	IcE1d54noBLZQw6/KQ99JTvap2K5pCH1qZXFi+2dtqKwcEe9mXk2IXHGaW2u7dAccBbzpnTDPHz0U
	9XiIFNwGN2kAL3CC8ctjv0KCd6s2MTp/FM0Siwbs5eHWRiBtlwYLk/MfQ3xphLns8/mCozD83EDPU
	jhEnfdRmpZrpNy7nI8VAaEw/1o3c9JS8+9zu8TBRQfPyQEpQbNsPel/GpyO0H+CRILsSaH3GzW2Nt
	ETKZwgVy2rgc2soaFf1gxCxucKznRQ0ncfhZmUzUt91jPKte8C2vqLedX2iWYpUwqS71p+YSvfKdn
	tpW/BcSzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFgmN-0007hZ-Ji; Tue, 08 Sep 2020 16:47:35 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgmK-0007h9-RV
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 16:47:33 +0000
Received: by mail-wr1-f65.google.com with SMTP id c18so19828598wrm.9
 for <linux-nvme@lists.infradead.org>; Tue, 08 Sep 2020 09:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/RbVWPsmsH0YwpLT8Cn6UyNIWOjnElzLgZSdskV9RM4=;
 b=Uriwrr/kxjk5HoHAU+Z+pSUn/8DDftCNt9Mj8EkyV83b+RHgPAzFyd0ok8WFfbLiNw
 zOXLV0nUkM/Lb/bdL5MjLy5q9AKFu5GYqGXgco1KdmGmPjwfZZ9dwHoxFDWxwc2c2whn
 1dTt+1JjLSznafVDuDS29OFzJwJ0Ntz4J7tAqEERdcUHxIC1SjPI/8LN0Fq1VBGZaDDi
 NYxVgv1/vV3RYvMKrZgwEMHdmRzlAj56qTv+GgFmebkqhwQBcRIhaAc0Ae1IGY9dH9ih
 5hGqEUAg5ja3DybE3DiyX0ThoDqrTgH0xRH6Nx7aHzSzD5JLJ5GRBgCDWoZwTwRmBBmD
 AnQA==
X-Gm-Message-State: AOAM532NlfowZ0GELxTofEoCoqCiwX4YwAuw8/cVDn87XZsf0LB1s+aV
 kskim61eZnzdWYRZHk9EsNaHy4/NG94=
X-Google-Smtp-Source: ABdhPJw6qNzs1HLqjRPViK9WWbFEuDq5Ok48/BU4sH7tLL1w574M43UjJCRRU2S2h5WiLQzpQZZwTw==
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr590265wrt.276.1599583649685;
 Tue, 08 Sep 2020 09:47:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d04f:59f0:a712:2917?
 ([2601:647:4802:9070:d04f:59f0:a712:2917])
 by smtp.gmail.com with ESMTPSA id y207sm40095wmc.17.2020.09.08.09.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 09:47:28 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
 <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
 <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
 <c24eeef2-e235-f095-0a34-8b62fe917e5a@grimberg.me>
 <20200908090518.GA18666@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8567289-1c33-9e82-570c-c77ba52e7a5d@grimberg.me>
Date: Tue, 8 Sep 2020 09:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908090518.GA18666@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_124732_901767_4F1E268B 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Guys, we need to resolve this one, this is needed to prevent freeze
>> during reset from hanging.
>>
>> As I said, any I/O that will use the ns->queue shouldn't be denied here
>> because it takes the q_usage_counter and will prevent a freeze (this is
>> true for both fs or user I/O commands).
>>
>> I still think we should allow the admin ones as well and deny them
>> somewhere else if we want to, but I'm fine with keeping this exception
>> now because no one is expected to freeze the admin queue.
>>
>> Let me know what you think. I want it to go into an rc soon.
> 
> Let's do the minimum change variant for now then.

The patch in its current form is that minimum. I suggest we take that
and work our way from there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
