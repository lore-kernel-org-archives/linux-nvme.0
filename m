Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDB5C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 11:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jfAtuIy94MmY44kjJY0H9PUQZQa+ozS92J+fDPX+r5U=; b=t3BR8/KFVULUMMfRDFerKnN0PM
	wXed9Yzn2HmCZtpG5OpG11rCugBasToUMMkUMkpiPo47zSgGWOacNw/iFDaCv22HXoLvcDO0ni9wG
	SIo5CxzqBE2P4QOSDU4T8mUzkmBiNqskUbQUk4ZLSmGExS+ZZ97miVHuPpvsOu3kwak1DmVyGq2Bc
	TSgpMqfybwMDvDJA2CiuVARDfriplYVHabWkgfubzGe1y9mlggv4oYWFtsFPSL9gtHplMf0or/iYC
	xeZBg8K/0aTvTVu/pi22vliAEZ2ax2LYxX5P4f2EigzHkvXNmwBXRcigOqXDp6jkZOTZbDn2iqCH4
	7sZ+0Imw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVFO-0000000AN1S-3rRA;
	Sun, 21 Apr 2024 11:20:38 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVFL-0000000AN0l-22NZ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 11:20:37 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34a0cc29757so383199f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 04:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713698431; x=1714303231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfAtuIy94MmY44kjJY0H9PUQZQa+ozS92J+fDPX+r5U=;
        b=PkKmXE4ZE0t+cU5dIpQXyYgPHB7eIZl5va06AOb+3Uk2SzTnYe6ENgUzRqWAdzPo5N
         kIE4kokp5PqD/RfImiAkH6D8qGw542z3Q4IepfqtnWH//dK6jX51bGECeZ1pPx8OQq1K
         EfFl0JUaPIGQGPDP22avFIgGrCry2iQspAe4cfqWfHcxEgj1wsk4DpSIRVi1iszF1hmu
         d5pSQxnQxk4aEHWninbCzI806FGUe4EzuqzKmWfVhDcEM3SxWHDdHelhlokmL6MOMDaG
         lTOeGLaf382U0HmY6el7Ce5oxpLGpO8yxnbPWJQWB+pq4lN3n1TculV5qJ0MeMVpj2Db
         HLyw==
X-Forwarded-Encrypted: i=1; AJvYcCUDP3ukYPxgmVv0S2z0epQPZrHen3D0AlS5UIYa/xqc1/XZ/Lv1vYHyA34FWu3opvN9NvAQ7iaE4iiq6GdcYpVvEjkqAikfk8vxb7/GC7A=
X-Gm-Message-State: AOJu0YyRo06qtCSRh21xP/SgGUnj3yPK+7zf1hwBvV72iwigyLELdP70
	CLrekydrxdi+7wvwlIlmDLx8wADvn8xL+Oizfjy+eizvGvZSFtHpllLfpw==
X-Google-Smtp-Source: AGHT+IEwyI+3yUBzcRessYPGqiqm8vDj/Oi6c45SWod60C1w3GCMlbhhfSTErluRF54ikFgLmUrbng==
X-Received: by 2002:a5d:6392:0:b0:349:eb59:c185 with SMTP id p18-20020a5d6392000000b00349eb59c185mr4373023wru.1.1713698430640;
        Sun, 21 Apr 2024 04:20:30 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d5542000000b0034720354152sm9045201wrw.117.2024.04.21.04.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:20:30 -0700 (PDT)
Message-ID: <cdc98a0e-d196-42d4-9184-864bcf2a084c@grimberg.me>
Date: Sun, 21 Apr 2024 14:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
 <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
 <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
 <ad9eb876-061b-4f85-9c6f-add1719b72c8@grimberg.me>
 <c4e7d9bc-aebe-4efc-bcde-11a481f76a6f@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c4e7d9bc-aebe-4efc-bcde-11a481f76a6f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_042035_568205_738D3DC6 
X-CRM114-Status: GOOD (  24.77  )
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



On 09/04/2024 1:08, Hannes Reinecke wrote:
> On 4/8/24 23:21, Sagi Grimberg wrote:
>>
>>
>> On 08/04/2024 9:21, Hannes Reinecke wrote:
>>> On 4/7/24 23:46, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>>> When secure concatenation is requested the connection needs to be
>>>>> reset to enable TLS encryption on the new cnnection.
>>>>> That implies that the original connection used for the DH-CHAP
>>>>> negotiation really shouldn't be used, and we should reset as soon
>>>>> as the DH-CHAP negotiation has succeeded on the admin queue.
>>>>> The current implementation does not allow to easily skip
>>>>> connection attempts on the I/O queues, so we connect I/O
>>>>> queues, but disable namespace scanning on these queues.
>>>>> With that no I/O can be issued on these queues, so we
>>>>> can tear them down quickly without having to wait for
>>>>> quiescing etc.
>>>>
>>>> We shouldn't have to connect io queues here. The scan prevention
>>>> is just a hack...
>>>>
>>> Oh, believe me, I tried. What _should_ be possible is to create a
>>> controller with just admin queues, and skip the io queue setup part.
>>> But once you do that it's impossible to create io queues after reset
>>> (which is what you'd need here).
>>> I tried to fix this, but that ended up with a massive 
>>> rewrite/reordering
>>> of the init path. Which sure has its merits, but I deemed out of scope
>>> for this patchset.
>>>
>>> So I decided for this 'hack', and shelved the init path reorg for a
>>> later patchset.
>>
>> Interesting that it requires a full rewrite. Can you share some info
>> what particularly breaks when you change the nr_io_queues between
>> resets? nr_io_queues can be changed across resets from the controller 
>> side
>> as well.
>>
> Just look at the 'new' parameter to nvme_tcp_configure_io_queues(),
> and try to modify the code to _not_ required the parameter.

What happens if you set ctrl->queue_count to 0 and then restore it?

> Key observation here is that the _size_ of the I/O tagset is actually
> defined by the parameters for the connect command; we cannot grow
> beyond that. Which means that we should be allocate the I/O tagset
> right at the start, and only modify the number of queue which we _use_
> based on the information we get back from the controller.

What does the tagset has to do with connecting the queues?

> Currently the io tagset allocation is tied to the number of queues
> for the controller, and trying to modify that is an even worse hack
> than suppressing the namespace scan.

I don't think it is... All I'm saying is that if we are connecting 64 io 
queues
to just right after reconnect them with tls, we are doing something wrong.

>
> Anyway,it's quite a different patchset which is basically unrelated
> to the secure concatenation work.

Well, they are required by the secure concatenation, but agree that
they are preparatory.

>
> I do have a preliminary patchset for this if there's interest.

Again, the fact that we connect io queues, disconnect them and then
connect them again is backwards I think.

