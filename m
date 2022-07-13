Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EDFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2AcRM2dbenguVq8Sn45LnuUE26anJQ/q/pVY/6n1mI=; b=5BT02R6bVt7m72ePmxcHwo6f1z
	saCc2Shl/t886d3/8U+yDJsVmdOXeoIe2bxitCtVpoRBCJtPrEk4uW2wuBgt2IvOuUgIR3Ad7MBGw
	bPbrIKrs6fzWtYMcNV1vSf+WyC+t2Xp3b3wx0J12OzUFXfsLEk3RLVwcIZdxQ05o7mL2Q1batDDyY
	J53C2EUtozvcJ8cdCMNCXv7l39DLb1fp0RASzxd+dTOHtl8IwjpFIDjIG8UQQcJhaF5mBby3nRrHR
	meGLFNOrWsoWk8bcywzdcAawPlIWDeLlUGf+Dy0SivOKAV+2GU+NfnPLH6YuMw9Sbcl1kVZECHRCY
	8ry6W01A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBelk-005Ndw-34; Wed, 13 Jul 2022 15:59:20 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBeli-005Nch-9D
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 15:59:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1458659wmb.5
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y2AcRM2dbenguVq8Sn45LnuUE26anJQ/q/pVY/6n1mI=;
        b=NmElwbyaciOXni1dswtaFTpJm9x4/iRGzznGIAGVQU4urfewU3ezgzqOI4sdXbOCp5
         XxUFU6T2pODxytudiwR2xyKKXGzqTBRe2s3i0OutsDKgqoo+ViYj/FUutAX9BxLK6yi6
         WsBrUS2M/dSaqD5uca00nFB4Uw/PsRHepQLeTCYzXyouEOJ8c3JBRwfSNXDMhXk9ddzR
         JKR7K7FaDE+9iFBD/0j8/3cCv1GmlOSIdJw5Uol7QMURj1LSezGT3dT5YTZ70VSCe3Kd
         grgqFD6iEqu8vXjleSYFEzUdoBERWKXpOZwzGwTUQ0j0xShUjO3OCaZL0IVRKCdW+AnC
         wYOw==
X-Gm-Message-State: AJIora/eRB5MJkIcjYLpz8aWheHCKo2zxW3dFoZgWv24kNXi72AgH17R
	NBASofQUVwbIUXgH7TmzmwI=
X-Google-Smtp-Source: AGRyM1v89jFtIWf5Owe/3xq9jPWOLvLV7mOEFexlE0Il+i3C8RydeEbGQ74p0+J4bujEJipuYpHfag==
X-Received: by 2002:a05:600c:4fc8:b0:3a1:987c:82d4 with SMTP id o8-20020a05600c4fc800b003a1987c82d4mr4449032wmq.26.1657727956465;
        Wed, 13 Jul 2022 08:59:16 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d458d000000b0021d728d687asm14103484wrq.36.2022.07.13.08.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:59:16 -0700 (PDT)
Message-ID: <c000ecc9-e570-0788-88fa-8225a4b9fa04@grimberg.me>
Date: Wed, 13 Jul 2022 18:59:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
 <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
 <20220713101235.GA27815@lst.de>
 <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
 <96f47d9b-fbfc-80da-4c38-f46986f14a43@suse.de>
 <7c7a093c-4103-b67d-c145-9d84aaae835e@grimberg.me>
 <04b475f6-506f-188b-d104-b27e9dffc1b8@suse.de>
 <66322f2d-fbde-7b9f-14f1-0651511d95b8@grimberg.me>
 <1d1d94ea-b67b-405c-c825-faf67f258558@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1d1d94ea-b67b-405c-c825-faf67f258558@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_085918_352651_324DDD22 
X-CRM114-Status: GOOD (  24.72  )
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


>>>>> Amongst all the other issue we've found the prime problem with 
>>>>> SG_IO is that it needs to be directed to the 'active' path.
>>>>> For the device-mapper has a distinct callout (dm_prepare_ioctl), 
>>>>> which essentially returns the current active path device. And then 
>>>>> the device-mapper core issues the command on that active path.
>>>>>
>>>>> All nice and good, _unless_ that command triggers an error.
>>>>> Normally it'd be intercepted by the dm-multipath end_io handler, 
>>>>> and would set the path to offline.
>>>>> But as ioctls do not use the normal I/O path the end_io handler is 
>>>>> never called, and further SG_IO calls are happily routed down the 
>>>>> failed path.
>>>>>
>>>>> And the customer had to use SG_IO (or, in qemu-speak, LUN 
>>>>> passthrough) as his application/filesystem makes heavy use of 
>>>>> persistent reservations.
>>>>
>>>> How did this conclude Hannes?
>>>
>>> It didn't. The proposed interface got rejected, and now we need to 
>>> come up with an alternative solution.
>>> Which we haven't found yet.
>>
>> Lets assume for the sake of discussion, had dm-mpath set a path to be
>> offline on ioctl errors, what would qemu do upon this error? blindly
>> retry? Until When? Or would qemu need to learn about the path tables in
>> order to know when there is at least one online path in order to retry?
>>
> IIRC that was one of the points why it got rejected.
> Ideally we would return an errno indicating that the path had failed, 
> but further paths are available, so a retry is in order.
> Once no paths are available qemu would be getting a different error 
> indicating that all paths are failed.

There is no such no-paths-available error.

> 
> But we would be overloading a new meaning to existing error numbers, or 
> even inventing our own error numbers. Which makes it rather awkward to use.

I agree that this sounds awkward.

> Ideally we would be able to return this as the SG_IO status, as that is 
> well capable of expressing these situations. But then we would need to 
> parse and/or return the error ourselves, essentially moving sg_io 
> funtionality into dm-mpath. Also not what one wants.

uring actually should send back the cqe for passthru, but there is no
concept like "Path error, but no paths are available".

> 
>> What is the model that a passthru consumer needs to follow when
>> operating against a mpath device?
> 
> The model really is that passthru consumer needs to deal with these errors:
> - No error (obviously)
> - I/O error (error status will not change with a retry)
> - Temporary/path related error (error status might change with a retry)
> 
> Then the consumer can decide whether to invoke a retry (for the last 
> class), or whether it should pass up that error, as maybe there are 
> applications with need a quick response time and can handle temporary 
> failures (or, in fact, want to be informed about temporary failures).
> 
> IE the 'DNR' bit should serve nicely here, keeping in mind that we might 
> need to 'fake' an NVMe error status if the connection is severed.

uring passthru sends the cqe status to userspace IIRC. But nothing in
there indicates about path availability. That would be something that
userspace would need to reconcile on its own from traversing sysfs or
alike...

