Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73821C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNMFKvhvF2teG0YkKuJXcS83TiA9MMUIKDptjHU1FtI=; b=SqCFA6sFEsTR7nremXEr5P5mvI
	mw//XG0wEVdDxeKCHIo4EfGL3sYm66M3ULrnXOye8BzWMsZLk3A7tA+hEfm42VRWCHUMHePYRTZe7
	vqoAQMnLwoPjF5mxZzxx2BSE8H+CZyx5xL+amnMPfyWOOEi37YHd1zI2/cM2gIDAaFRTmE+kkgUr4
	ZjuC3wWVlqpROtKPiFRKQHgLdMIBcpykfDJ0qg1k59v8+z3UBDbRQu69dBqr8mhL+MF5TuYWdrwpt
	JVml948qDxztq4ONbSdMdPARYIxKgqL25+f1MpR0TrImiChJ9fVshTyx9aA4dhCrY3za3ZyxMe6vX
	ZHS/IZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7sE-00EXsV-T2; Mon, 21 Nov 2022 14:34:14 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox7sC-00EXpZ-F7
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 14:34:13 +0000
Received: by mail-wm1-f47.google.com with SMTP id 84-20020a1c0257000000b003cfe48519a6so6656032wmc.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Nov 2022 06:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNMFKvhvF2teG0YkKuJXcS83TiA9MMUIKDptjHU1FtI=;
        b=l6ryaZ31n5aDw/Um3HqsIqhVn2qRl7G9S2ZkcT8O7H4p3rXnYZDuoqMFvYDayImMRo
         ZZ2WlK2IGhWCQ4kQB4SbGCngxigVn2Y7OQuzGITQhkARFD4cW8ExOPuJfrMmFN4xA71C
         mj/CD2hD5Qi7crHlffQueNqlZqmNC19AqAa4wWxzxvrZSuki15YUzE/hIkduRvE2kFHn
         tryvRaL6Nw1maVIpzNo+EgH48jcsZIgv6WQytJgUlTCJ2DgUSn28F89b81fc7faPxNU8
         JoKKhhMfxAYl/mgzSPugFJoWbYcZyTfAmF3zw6E/tCt8oR9zBnahMD6cQXF1Kr00lPP/
         Tw5g==
X-Gm-Message-State: ANoB5pm8zfU45L0EZ2TMJGuXb+lgzA055pnL+z+26Uy+8AKP7FyMli77
	xFBMkbPc6Baxl5Nc4ro6/3A=
X-Google-Smtp-Source: AA0mqf5R1+j6QT95GyW6eaPiGYEu3K1kxea5RcmjVSn/c2qm0KQELE5nhRinGfJz2GO6lQhPwy5rZQ==
X-Received: by 2002:a05:600c:19d1:b0:3cf:cf89:90f with SMTP id u17-20020a05600c19d100b003cfcf89090fmr2506939wmq.186.1669041249023;
        Mon, 21 Nov 2022 06:34:09 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfaae07f68sm20536134wmb.17.2022.11.21.06.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:34:08 -0800 (PST)
Message-ID: <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
Date: Mon, 21 Nov 2022 16:34:07 +0200
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
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_063412_536924_A9441430 
X-CRM114-Status: GOOD (  14.47  )
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


> Hi Sagi.
> 
> The previous msg:
> nvme nvme0: queue 0: timeout request 0x0 type 4
> 
> We found it more useful to have also:
> cmd opc that was timed out

That is fine

> command id that was timed out

That is the lower 12 bits of the tag.
You can introduce a generic helper to extract genctr+cid from a tag.

> The timeout value for this specific io - in case of a timeout - it make sense to know the timeout value itself
> more info about the blk rq - such as:
> 	a. time of a request that was allocated for the IO that was timed out
> 	b. time of the timed out IO that was submitted to the device

I don't understand what added value that is providing you.
An IO timeout is usually (if not universally) >> the delta from tag
allocation to submission.

This is debug information, and in my mind the proper place for this type
of debug is blktrace.

> The log is already exists, why not provide additional info that can help with io timeouts debug?

We can say that about a lot of things.

There is negative value from spam information in the log which is debug
in nature and is separate from the normal error/warn log information.

If this information existed in the form of trace points would that solve
your problem? Keith had a patch for nvme-tcp trace points, which can
provide this type of information.

