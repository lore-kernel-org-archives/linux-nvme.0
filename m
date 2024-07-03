Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C54C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dPwWNxfv5GS0DATC5T0CAaTp4/HBjWg/npBUD6DXsaY=; b=nMH8dkI2DgmMrOCusf8B8xd1Mu
	hB8RyB5ZcT2uN3s9d1itq7sXZ01bhrWdrRhyWwKmNcXnxQVDjxLIiaoS8Pd5lAhdZl83azCm1ywth
	S7gXf7bxMMCiUV8HWx7GoH9YNJmknJqMHVEzrBriNLLxHus5pVyUUUUQkr7QRhK3qgumHE6Jw0fDN
	r8o5YpfeMcAZFskGx5AC4/YFTzj2txkQi569sBtdiGAM/8YZQeCQ10NjMTd1Vdd/asRThuj1QQygm
	oah07pBoUtH9nyX0gRKv8bPAfD6tXnSwmDfR44gNdrXykyxDTZpmZ1vcgPW9RAgQ3po/Pw94i3Gzx
	mdX7epng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5Qr-0000000BFg6-08ov;
	Wed, 03 Jul 2024 19:14:21 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5Qo-0000000BFem-0xwu
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:14:19 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3679483091aso76287f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720034056; x=1720638856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPwWNxfv5GS0DATC5T0CAaTp4/HBjWg/npBUD6DXsaY=;
        b=O/p0E7hBrHmj6ePhmxXWl5bCr+KL1ce/ieYbSZ3MBMxiu/faYxDuy5fGvsMcwzIYZ1
         /TaiQnfmDoBBR5nLiHHkKjxzTSaY17Qrp1mHDblnhhEc4nVaNuVbTBbushfdA/wo6tFH
         SBoomo9X3C+7s5CMDV1SjiK4gNekttl6a6bwsV7G/jtl69jdji8ZishmIRu17GzreH2C
         gL64RR9ezepPdrLGvv82Yk4XgZX6i9jQ2dxTczdAi45aRpRWtH8at53AGFDhIY5hUWUu
         01ImMqdU0lk97UNes3OQRA3dQBgfKFQ65Ir8/275weV7QOQV/khyCYOueW+zw0EkYN+l
         k/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUYZubUWcYRvwCa0nRIBH3V59DxN7NMH6j3R6AcJ6xyOB7HDqs7Sy2s4Qaics2Yxi79/uUSy2Mi6JMA2oaF21I7XI0fQoRRg7IVnCRZUy0=
X-Gm-Message-State: AOJu0Yzq2/+Twg650fGH+1S17AaYCk2DlMjsPUGcEQr355Q+Lrl07ehM
	es+JrP5wwtZpH6+4Mb8enQ9eIPUNc4KDY9TjvU0VNjwrvExn23a+
X-Google-Smtp-Source: AGHT+IHIBdb1TutkJWGCfepRJNHf7aZvOop6lVA0vnUKUxAONZ43AHaDiTtVWkMUR6mK6023alI52A==
X-Received: by 2002:a5d:4575:0:b0:367:811f:814c with SMTP id ffacd0b85a97d-367811f845dmr3014671f8f.4.1720034055988;
        Wed, 03 Jul 2024 12:14:15 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103e5esm16556924f8f.108.2024.07.03.12.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:14:15 -0700 (PDT)
Message-ID: <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
Date: Wed, 3 Jul 2024 22:14:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
To: Tejun Heo <tj@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZoWFOnvgWEiKipW6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_121418_303763_7690553B 
X-CRM114-Status: GOOD (  16.66  )
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

>> I'm just not used to seeing drivers create non-global workqueues. I've seen
>> some filesystems have workqueues per-super, but
>> it's not a common pattern around the kernel.
>>
>> Tejun,
>> Is this a pattern that we should pursue? Do multiple symmetric workqueues
>> really work better (faster, with less overhead) than
>> a single global workqueues?
> Yeah, there's nothing wrong with creating multiple if for the right reasons.
> Here are some reasons I can think of:
>
> - Not wanting to share concurrency limit so that one one device can't
>    interfere with another. Not sharing rescuer may also have *some* benefits
>    although I doubt it'd be all that noticeable.
>
> - To get separate flush domains. e.g. If you want to be able to do
>    flush_workqueue() on the work items that service one device without
>    getting affected by work items from other devices.
>
> - To get different per-device workqueue attribtes - e.g. maybe you wanna
>    confine workers serving a specific device to a subset of CPUs or give them
>    higher priority.

None of these reasons are the claimed reason to use separate workqueues in
this patch. The claim is that it is more efficient, i.e. has less overhead.

The commit msg is the following:
"Implement per-controller I/O workqueues to reduce workqueue contention 
during I/O."
> Note that separating workqueues does not necessarily change how things are
> executed. e.g. You don't get your own kworkers.

Yes, that is well understood.

