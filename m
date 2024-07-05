Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E25AC30658
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gG2Za/v/Iv1Rv6HJH7vMiIOdwnOxpgOdYrTbMUH9jxs=; b=uUfrBRxozf8yyRUHiXCyrr07p1
	SwUzzcMnGIeTu9WuGrypKubdawb/T5TedyWCsvlITc3BtDj9i/b4JK4XF/bGxLhLE3CXTd3a3Upc3
	TwInVGq4qs7RIKgd9n+jw7PVNKyU/0qLre7G/wWqg6GctYKOuJ4gduZ1+xVQHxnpCIT2Qe88jx/oT
	0MdBJcr4VLXyikgLE2VyOKBk85vPqf1Oo99y48aUdc7orlZ3h02uWJwSDxbw75BSUWLZS7DBCeAdw
	OvyOMyNAkZp3sODdonC70P/i8UYCdax3MVTSxlF6v7PE+0tPmku/ruVm6AovypsS6XBEpRczT36UP
	9AfjMfXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe7s-0000000FFjn-1EzN;
	Fri, 05 Jul 2024 08:17:04 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe7o-0000000FFj6-02A5
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 08:17:01 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-52a559e4429so109749e87.0
        for <linux-nvme@lists.infradead.org>; Fri, 05 Jul 2024 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720167417; x=1720772217; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gG2Za/v/Iv1Rv6HJH7vMiIOdwnOxpgOdYrTbMUH9jxs=;
        b=CqqGSHQwKrvp2MlT6XU5jRqnqQzsFKMmmNM2ZibGbDFKksyDsxQqs6p6W4oXt8TVTy
         C+OwS9qGPwn+hLMmJgl7zymgWmIjCrSCOK3ONI5TPGlf05aLRtwiv/3HOAdaBRnpUyRj
         BP8iVTZ0BYb3WR8Mod7458SwZ3oQkjNgeL8zv/sdyLvcNDs74FRMo3wmL+VNjVSa+uWV
         b2Gz94gnvAp+Xqj0xDAtj9ZbZk+ha2DoLk71xf4idqk7BFfJPHCXxQfdoBGnAUauYlRc
         1hThixUjb4zy/nITNEs6BKgOTAWOF0NjMpjrCEqBYTsiQ0djxlHt+og15dZgA5Qso79+
         hsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720167417; x=1720772217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gG2Za/v/Iv1Rv6HJH7vMiIOdwnOxpgOdYrTbMUH9jxs=;
        b=NRp+jX11oXiGiKrlPt1K22CnZA4fAfz1jAeSFpXkWCYgy79oGQNfSL9r0YNdqXMnET
         +/FWjYgx86Q/xpVchCDWHZ8owfLru8hfclgVNsuhIGh3va7UdHQKnKxvqOP+AV6qEljT
         DWoXMy5leIVLYRMbGB1VpXOMiTLUG5Bknk3FOmluwmtAgi26MHxyP9IMGQyAOf1/DzKx
         OBgRxuRk+2rZaXtL/TEY0SIPDUyxcRHJ7Vf9V886nY5SQvy3ycGSoYhLjXGo3+NWvMDE
         qWYDHInd1ynSePLXXaW+ALwMqXlKx6/C7v0ysALTojCOPx+LCy7YvawfDomUUPrsENhA
         fxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeLpwaAjJJczGgzRl6lymulamSIDzAXj44pMwW0933cBs0R6DZfkgVwaEl6ZolhT+rTGbPyggNO/v9fXGJOD2gwG58/wWNHE45vaYD2RE=
X-Gm-Message-State: AOJu0Yyse9wallc6sMUsJx1KsNkMK8ZAd8Zt/muZz3AcRMFimgxwUrNc
	8AdEEBzWX518LWt+ZBhIh6b0CJDLti0cZo636IqXsR8gU3g+F4RGZ+1o4HENxG4OTWwNy4aRm2v
	BkczLolv5
X-Google-Smtp-Source: AGHT+IH0YPbBvOI2b8WdibPXyDSY7v/J4N+ZYfpyGXcvCtsuzwDnB3VTWAXfJNXIbNZqe7vNxUPPig==
X-Received: by 2002:ac2:5937:0:b0:52c:9a5a:e16c with SMTP id 2adb3069b0e04-52ea0724a38mr2380524e87.4.1720167417430;
        Fri, 05 Jul 2024 01:16:57 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea6bf34e0sm109541e87.172.2024.07.05.01.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:16:56 -0700 (PDT)
Message-ID: <46d73c73-b1cb-4124-96ca-378563fbdfb8@kernel.dk>
Date: Fri, 5 Jul 2024 02:16:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
 <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
 <ZoWjxtyjHTC2r285@slm.duckdns.org>
 <9de5d83c-4b05-4f69-8ab4-b4aa65e5ec62@suse.de>
 <20240705071022.GA13302@lst.de>
 <8beb0e36-af31-4633-ae2a-afa6bcec5a14@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8beb0e36-af31-4633-ae2a-afa6bcec5a14@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_011700_271083_0BC91FC1 
X-CRM114-Status: GOOD (  10.97  )
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

On 7/5/24 2:11 AM, Hannes Reinecke wrote:
> On 7/5/24 09:10, Christoph Hellwig wrote:
>> Btw, I don't think brd is what we should optimize for.  brd does
>> synchronous I/O from ->submit_bio which makes it very non-typical.
>> Trying to get this as good as possible for QD=1 might be fine,
>> but once we have deeper queue depth and/or bigger I/O size it will
>> use a lot more time in the submission context (aka the workqueues here)
>> than a real device.

Agree, using brd is the backend is useless if you want to optimize
for the real world, and may be actively misleading.

> Hmm. brd was the simplest choice to get a high-bandwidth target.
> I'll check if a get a similar performance with null-blk.

Just use a normal flash drive? Even basic drives these days do
millions of iops and 7-8GB/sec.

-- 
Jens Axboe



