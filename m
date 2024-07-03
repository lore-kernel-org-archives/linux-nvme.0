Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23ECC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxWFvXqw4DGVeH6jtrfZC3M3z1wfB4tjuHR00dkObpI=; b=VNbP52uwfk0WRAd1H5i4ncE8Py
	FpqkDMukLfGCT59RTB+aYJ85fs+cUuNUevEgEiliEFzL4ovGPeMJSR31tjDXYBL3hyzW9wYwvI7Mi
	9qa9jWR8vMdblF5uylgd3txBdtbhjPsTcX/PYpnoRxzxTk50iLvt2GNmdOqGbbmmdTz4QllBQ2uZ7
	hYcF5RPb8PR5vmXWjvKq8jmYzrvNx3A9WKe0Bn6F8yRVOqphVXN1cO8OHKRIJMkeXm/g4dQtmNEDI
	5QORnbH0oE84zRSk0t3/qqUwGoIbs4a8wsFrAd5vP/GTuiB7z+s/pK2+ENof54VLbBuomy0b0fe35
	D+qMCCEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0i1-0000000AQW0-2Adb;
	Wed, 03 Jul 2024 14:11:45 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0hy-0000000AQUl-0w6g
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:11:43 +0000
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5869606a790so418787a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 07:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015900; x=1720620700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxWFvXqw4DGVeH6jtrfZC3M3z1wfB4tjuHR00dkObpI=;
        b=crwYiV03Ss5r+Q+FBNq7eCN1n2jEmuZj9GIfJZbFrNGnKZhbNx+lIxgv7ukGwUN9AZ
         8UuLEmm5ewzYVB+kBx1sCL5ej8W8mOllsVo6JkbL87tKoRpMcyR7lo15TSR2E5ygY9e7
         6g6jKno1ULGnyYA6tbjiJXL7OytIDKk3FToNTQD3c9w89P7R7yb19aKp808cKWIs2qhT
         aPku+zcNpvXuIyRTHwTAIGhQ3uuhyIbQl4Gv0DFvo8oFqSEO5areDvYT4Vvg/s4bzA1L
         B+/pcXC0TzhX5NVIAUeJj5rCREm4FXIc4LoVHafF7zgSew0GQQgC/XwYkE4MWFXjn+dP
         tUGA==
X-Forwarded-Encrypted: i=1; AJvYcCXG++NN04gQjyyRogTksmbcCi+Ih0dqnrsfSg8KpA6870eS/oyfVV5kSYwQPXH1jlDtvxvKpdNCBvnnoStjLE+Tnp7VVw5QL1guin8X3Zk=
X-Gm-Message-State: AOJu0YzMPYsvLRNgYEVAGJuQUuXuroKqsaYjFK6MlwyyX83C53sYoOq4
	NTobJw9/XU3EExfxyouf+o0ytiyADOcUnWiAHeQ/4cQ7ku5T8UFOspzPgPeN
X-Google-Smtp-Source: AGHT+IE16e0f/SIGVvl8MzLzsEFDzGAfacN3ta12QDfT2Laop6yT04VVegTVZdzbhx5AoLiG1n3JTQ==
X-Received: by 2002:a17:906:15c3:b0:a74:bed:fc62 with SMTP id a640c23a62f3a-a75145c0621mr599672966b.5.1720015899444;
        Wed, 03 Jul 2024 07:11:39 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b92985desm429705166b.78.2024.07.03.07.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:11:39 -0700 (PDT)
Message-ID: <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
Date: Wed, 3 Jul 2024 17:11:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240703135021.34143-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_071142_294833_1C7ABBB5 
X-CRM114-Status: UNSURE (   6.55  )
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



On 03/07/2024 16:50, Hannes Reinecke wrote:
> Implement per-controller I/O workqueues to reduce workqueue contention
> during I/O.

OK, wonder what is the cost here. Is it in ALL conditions better than a 
single
workqueue?

