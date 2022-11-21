Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FDC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FngrzzEBz9c46Xvvv0fn1zF9DYTN2rUhf5tbRv9pJHs=; b=jZeeKazabysBDLmzIaM8a+5gMr
	Cj5j88aKRHiLdlpgapH2Sj6aHyHaDLtK57tm7rO/2858fHIKI/WPdmKTs/i+sl3MzQDWKyZdlInVM
	x2C2n9nZfLkUr9542gt5Es72bYTJy69JqGRYxqYqmYSPw7RqRbrthrzJPEVn3P/IkhgyBft/tjDMD
	1NlXrmp9XJ2+OipXCsiR1wcLAiprMybIQegYj6tMFGwlQAPxr6qRiSq2uqshLokVBwyswOn/J9mt3
	CqhCzgbtRmIzv5nAppo/T/8RBnpXrU0ygaRGM5TPfUb1TCWEU0fPCC1aGagBSxjZZvMhH0t+BH+4c
	8dzCtJDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox569-00CydN-Ay; Mon, 21 Nov 2022 11:36:25 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox565-00CybI-P5
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 11:36:22 +0000
Received: by mail-wr1-f44.google.com with SMTP id v1so19373804wrt.11
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 03:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FngrzzEBz9c46Xvvv0fn1zF9DYTN2rUhf5tbRv9pJHs=;
        b=OdeI8ipGx8UEKa3dMMk716GDaEjbXj9Y0gtaTxP8Gaeb2CT/PysxsLB3XBs0Owt5Ad
         CN3ipS1di7L6oyXheT6qV/Lk1UByqXZhWvrsOd4m9J2CD7tWoHTBo0APh1hwYRUfJC+H
         diCj0sY5e71paWsc9T+g13N+5/XrTTmAjECdh20fXaI7+z59f3IlP1g6kqXk2UzJ/d3T
         STzFshU0U5N0WYsdGoxjdTWoqAi15Mzm6HHRfOC29yWKt/hn0gC5IhE5djwlkFCaL53s
         AoriQYnXvD0r73mI+Y1l94e+aijMxdpLKgVkeg6n1V7cExGuSY0taYunRK9RYQQza78v
         xjSg==
X-Gm-Message-State: ANoB5plm/iuAUv6Jc7Fjd1zqwrKPxpS1Hl9QFUIsl73ijxBbDKUeTwSx
	8+eTwU+oLoLlz9OTlAnzV7RyZG2gS0k=
X-Google-Smtp-Source: AA0mqf5tLXBFBqCoaJ+m+h4eLWiKxn4EgYYMyviP9W8/72F8Xwbl5lHHMcXglV3CRN52No8FZnprLw==
X-Received: by 2002:adf:fc48:0:b0:236:e0d:9ad with SMTP id e8-20020adffc48000000b002360e0d09admr168396wrs.692.1669030578557;
        Mon, 21 Nov 2022 03:36:18 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003cff309807esm18988498wmo.23.2022.11.21.03.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:36:18 -0800 (PST)
Message-ID: <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
Date: Mon, 21 Nov 2022 13:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_033621_839343_E12F9355 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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


> Hi Sagi,
> 
> Below is an example print of a read cmd that is timed out
> Should I add this also to the commit msg?
> nvme nvme0: queue 1: cntlid 1 timeout request 0x7 type 4 cid 28679 opcode 0x1 start time 5022008820ns io start time 5022008132ns request timeout 5000ms

This is not an improvement from the existing msg.

