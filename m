Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE93C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60s1itEh0fi8jYfRHj4Z8XgU75FRK5h7qs+1v8Fmlzg=; b=FMopE/oee72jWDL4G/tZwlkgq8
	7enqs2e7nHjkf/JxqXYA9O5o0AOhG+2ZPa6atdwjSYlvw7e6kctAPazkDxDkKFTD3g8um5ap2MohS
	2jCszRx9+NnGUt49WvNJrcxA8tDIXA+Qenu1JU3AjGrVa2HNBTl/kqP+KHf3UHMOb5/HZ63PeGtno
	jyOtIHW2OnF3I0n2utGwGnbjb0KG9xX5gkRkhM/dubhzUip8RT8kWs8SGTp0vmnvbIzqK5CP6iF/9
	iGbTI9/Fgn+zjFQ/nTpaP0pju8IBBDFm4vqE8Vx7DgCCePGDwDpziSAy3Ou9PuBozJ2HzFsHXNGBT
	M+8oOfig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQ7q-00F1pY-13;
	Wed, 13 Dec 2023 14:22:14 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQ7n-00F1nl-20
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 14:22:13 +0000
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d6f8485eso900340a34.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 06:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477329; x=1703082129;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60s1itEh0fi8jYfRHj4Z8XgU75FRK5h7qs+1v8Fmlzg=;
        b=H5NLbpFm8w+CEsdTmBIDXw9ymryDqcuf42Xta76BPxQCknvYEt3m0q1XBdPLeomBRr
         /HYtqqaalgCSmMWOXYSxi8VIqzSMiWAlQhfqlJrhFpEHXgQMGAUNsBb69ED5k68tbDio
         mgbY2gaXK80AFyyPNHesylnQ11u1n48H6GQdRDIdq6nvn/Hcl19EmLXPYDHV/2UGCBIa
         sNRicFk70BydL7QXdeoOXfezBvSBP6W1IiHSVCrNF+8DcZtw/q3h4KMvqavxXbpsZ+k0
         OM4Yes5o+RoJ4MIcg7yjNFf7mfCrbuESw61P/83CDKAEckKRVfRcnPj+QrFWXB+UUrp0
         obhA==
X-Gm-Message-State: AOJu0YxOltN1fyzjcmHFDdvDY7RLCCcxDLUEu6ossXdZjMTn1oGzjWDd
	yYC4Yy89UMjZT4oGonuFEnsK8VsfP6U=
X-Google-Smtp-Source: AGHT+IF1CwlQaZSm2OZsJ0C9efi1LIBAmReScpKd8fSp5sxjQzXQmORTY5pvkL9TQVC2HDAnPo13+A==
X-Received: by 2002:a05:6871:208c:b0:1fb:19d6:8715 with SMTP id ry12-20020a056871208c00b001fb19d68715mr14490671oab.4.1702477329303;
        Wed, 13 Dec 2023 06:22:09 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id dt48-20020a05620a47b000b0077f401aab62sm4523039qkb.125.2023.12.13.06.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:22:08 -0800 (PST)
Message-ID: <97a36f84-3004-4af3-a04f-841c9fa8a8a4@grimberg.me>
Date: Wed, 13 Dec 2023 16:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme: avoid deadlock warning in sync_io_queues() path
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>
References: <20231213051704.783490-1-shinichiro.kawasaki@wdc.com>
 <e286d88f-5006-4878-a05b-a0c877ef78d0@grimberg.me>
In-Reply-To: <e286d88f-5006-4878-a05b-a0c877ef78d0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_062211_677510_3FFD53D6 
X-CRM114-Status: GOOD (  17.83  )
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


>> The commit c0feea594e05 ("workqueue: don't skip lockdep work dependency
>> in cancel_work_sync()") restored a lockdep check and it triggered
>> deadlock warning in sync_io_queues() path. This function locks
>> namespaces_rwsem for read to traverse the namespace list and calls
>> blk_sync_queue() for each namespace. blk_sync_queue() calls
>> cancel_work_sync() to wait for nvme_timeout() completion which has paths
>> to lock the namespaces_rwsem again for read. These two locks are both
>> for read, but it can cause deadlock when another task has a lock for
>> write. Hence, the deadlock warning was reported.
>>
>> To avoid the deadlock warning, guard the namespace list by SRCU in place
>> of the namespaces_rwsem. This avoids the deadlock by the two read locks
>> since writes by other tasks do not stop the reads.
> 
> Based on the report this is triggered from the pci shutdown code path?
> I think the problem is that there is a dev disable running together
> with a reset (driven from the timeout handler). Perhaps this should
> be addressed.
> 
> I don't think that making the namespaces lock an srcu helps us here.

Just read the correspondence on the report. If this is just lockdep
false positive, then I don't think we need to change the namespaces
rwsem.

Can't there be some annotation that we can do to teach lockdep that
this one is a false positive?

