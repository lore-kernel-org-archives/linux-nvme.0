Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13754C38145
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=diZUoBX4+zVt/dTLToMYaMD50LiKHy4q3x4ShLLBosk=; b=4DebqWZAk9Nb9r2NYfMkhxV+wf
	2c3L9a2tjryIwVbA1ZvejmQKKFFcjs9fykUKE1aXm4AOelz3kiNoVoeqN1q5Z1aZtnpx/c1Z8OkyZ
	fKcIwa0LkXKNnFp3793Zbe7vwd0JLNefZFLjvg6NsDuApIx6yUcdTGCz1z3KbhpXcGD3txBtxM2Dm
	ner+e8JU9kqYL1Q5boz07G1B47Bf+OsFhBYOU7mYv7ojhQYqQJCBHF67hKcqlh3Z5b8B9kJFKp3R4
	ZEtllkkDmN1Q2wLpPUVRzmZ2vBgGLd0nQbqciePTNnYAx2H4X3AMH8m6+lTUSedfdt76Xz+O8qaax
	IJb21fYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVq5I-0042I5-RS; Wed, 07 Sep 2022 08:06:57 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVpuI-003vf7-4w
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 07:55:35 +0000
Received: by mail-wr1-f53.google.com with SMTP id t7so14001154wrm.10
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 00:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=diZUoBX4+zVt/dTLToMYaMD50LiKHy4q3x4ShLLBosk=;
        b=M3ocFGDHkUrEm5vd+gYbKLs/3HdnMNoz6vyV94AOUG5cJ0W4M6Ozo5QuYiidLBy0BN
         lHzBRO96N/wseSk/2RU5E9TbaV9XN+Plr02vyOXFXZwxy/6ZQfiz+95XsOFw/JCsjcMU
         6dIKf6vW6MXfkBwTUK7Sg/0qwAPOlbBkRvnzhJMNxpG182ohlmoUU3RCgk7hQV4D7THz
         43y1D7jH4O40EhAQyozw3RjOS84A+WTYnRW+1LYpN/HyKwdcoy72ohAz2TJad9NQ1/bf
         yfpa8WOC4UTpr4SlcBFqqA+Z8LtwUuWAzxMtBX89BRj3NAkYb6cflWWNZeMddb8qdPKU
         wBkA==
X-Gm-Message-State: ACgBeo0vEgaGfc1cKgIHCizFIc6UdHXfVFrEBU/cWvfixgK2dg9Rg5d0
	PFv6qHVNqRu0FTOQLE5AVpV1+VPvmtQ=
X-Google-Smtp-Source: AA6agR7Xk7RRQFmYdDEgf8NPSq66BSII34etxruec+Vph5pxWO3dEygXTaMnyjnsScCgWUVyO0AJTQ==
X-Received: by 2002:adf:d4c9:0:b0:228:de3a:220f with SMTP id w9-20020adfd4c9000000b00228de3a220fmr1268326wrk.597.1662537330896;
        Wed, 07 Sep 2022 00:55:30 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe9c9000000b00228d94931dcsm6391714wrn.116.2022.09.07.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 00:55:30 -0700 (PDT)
Message-ID: <f8afa4c1-4b10-caa5-0a6b-ce84c5280bac@grimberg.me>
Date: Wed, 7 Sep 2022 10:55:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme-tcp: i/o errors and stalled host from failure to send
 command pdus
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: linux-nvme@lists.infradead.org
References: <CAHex0cqr8Sn1ydFjRbwkG8LOMqBXEHL2YpYu_vO8658xLzouww@mail.gmail.com>
 <CAHex0coXdbR28S1PPSGuqJRH2JFZ4VpTg8NzfWFpHyBehK2urw@mail.gmail.com>
 <CAHex0cqVOuSXf759Wdr3NS5gGCve+J-TUSNsvvbEpS7ONvFhMw@mail.gmail.com>
 <715a183c-f888-74f2-9217-b9b430f16d1e@grimberg.me>
 <CAHex0crz1FGrQKnWCrWTCWJ_GsMn5iMmNMtq-BN+nDDUajshdg@mail.gmail.com>
 <CAHex0co9JNwFkDpNvPitESYX6-2F8_n8phxzVsZFq2kieYLGJQ@mail.gmail.com>
 <CAHex0cr80EyJXN1gOgEXF9r=_Y8Z5N6=jxw=je_8Px3vab+qtg@mail.gmail.com>
 <376e2073-439b-7113-48f4-862d3404c328@grimberg.me>
 <CAHex0cq-YzgKVH6RazgPRFi0mJ7n+CsS+Cr-NqLEszZGen8dKg@mail.gmail.com>
 <CAHex0co8NidmjzMoeQp8GXy8t6B9cJCA-DoSwO-H5Prae=ZSMg@mail.gmail.com>
 <CAHex0cpGJoq7Lf-VgtT3hnUZhLLoenGqK3OTqTKkPg8UpjaDuw@mail.gmail.com>
 <7881a1cf-483c-3e70-18db-d02a5f8606fa@grimberg.me>
 <CAHex0cpMw1HEkSxdXsXTRtqw13PBVOmxGRtzyRBJai8nKAv+iA@mail.gmail.com>
 <7444389a-f52c-f7ed-3290-b209fb5f2acf@grimberg.me>
 <CAHex0cre4FLEKspyHvpRshLepbsK5ouXnnK6Lb1Oq7pS+Jfyeg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cre4FLEKspyHvpRshLepbsK5ouXnnK6Lb1Oq7pS+Jfyeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_005534_265349_08D97E56 
X-CRM114-Status: GOOD (  10.21  )
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


> Not a problem. Is it possible to get this fix committed back into the last few
> longterm kernels? It seems like anyone running nvme/tcp could benefit from
> this fix.

The patch has a Fixes tag, and the title clarifies that it fixes a
regression, so it should be picked up for stable kernels...

