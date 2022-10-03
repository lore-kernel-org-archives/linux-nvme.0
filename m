Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FB3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DszboK9P2kLc+x/fwfSaNitxkx4T0tjN4W158nD7RQ=; b=XBxcc91ga9wsCqqtcPpOfxi1oJ
	wa2oVGl7fRV8Zm62oD14UZcIeMuBqLiq/MS54e00d9a9gY6xHeBc1FaZry9vlU7uA89eaYCHuuhJt
	J7sl7K54aCkSj8lH2YF2VzJgGUOhm6t2mxlEVIkUlDk3+KGfKRUdPF5CFoQzXn1rcdz+pRpRV9MX2
	vNnKjHuTqCYpWl4tpcT3spFfcxyCWlEarrsAjbRFXC/b6KUv4kUTlVthEiEK3OUnVzfg58u3CLHEc
	xAw0FQcqf3e86lDC3sKZfFO0btLL/cY73w3IxQrprWgkzTqmZTbK1DFS3t1VEfyVCE/Zhl8Ruqi3d
	qOFJ2cUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGvh-004i7J-Tn; Mon, 03 Oct 2022 08:36:01 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofGvd-004i6E-3A
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 08:36:01 +0000
Received: by mail-wr1-f48.google.com with SMTP id r6so15593345wru.8
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 01:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8DszboK9P2kLc+x/fwfSaNitxkx4T0tjN4W158nD7RQ=;
        b=QxJANy8ct2OCNmllOIC3YArWGd/iGEec8969j3nPb+J9PHpR+/I96qOO4qJxMKXQ2L
         jNJZY3LqvMta2pydcvKSg6FNiszjeiiptfnqbupFIXPe0aGQ6ND7drEru7Mn9Y0cmnv0
         WeSd+n57i33DddWZNKUVYw9d4/lE+Blwe31Vl4nMz/Wtz5KQV0L0+GesnnNvPYvTg9E4
         1mms8zUqGQ/KJ7w/X6cw56fHQ2FGOAVZELR9UMUvbSicZqkVjoUeBlNAbINY2vcZYL6H
         Cx3bJJf0I5oPijtbeJTHohBVLjZ6/0YHyBluFPq7vAjamDDOcH/FoZdX7IWPrwlbtJrF
         +UdA==
X-Gm-Message-State: ACrzQf0aIlLzMmUpYhG669knolXGy/12l/oJAXBjom69bumgnnuU3G5M
	t1jeagF1poLF8SWQHCzfUYg=
X-Google-Smtp-Source: AMsMyM5Gdpr6jmN+kyU1bDODzWukh5kcVfipr95CpDmAmdt4r58YxyMU7t3c5bzfSTdXVMkBt5OUdQ==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr12048882wrr.2.1664786154968;
        Mon, 03 Oct 2022 01:35:54 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm16720637wmc.14.2022.10.03.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:35:54 -0700 (PDT)
Message-ID: <20de260f-2cf4-4308-ba9b-5e75abde0342@grimberg.me>
Date: Mon, 3 Oct 2022 11:35:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
 <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
 <c2cab5be-658d-3c50-b1a0-1d7d86e12e0b@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c2cab5be-658d-3c50-b1a0-1d7d86e12e0b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_013557_184823_9A4AE1D9 
X-CRM114-Status: GOOD (  28.90  )
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



On 9/30/22 03:08, Jens Axboe wrote:
> On 9/29/22 10:25 AM, Sagi Grimberg wrote:
>>
>>>>> 3. Do you have some performance numbers (we're touching the fast path here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> Is it? Enabling IO stats for normal devices has a very noticeable impact
>>> on performance at the higher end of the scale.
>>
>> Interesting, I didn't think this would be that noticeable. How much
>> would you quantify the impact in terms of %?
> 
> If we take it to the extreme - my usual peak benchmark, which is drive
> limited at 122M IOPS, run at 113M IOPS if I have iostats enabled. If I
> lower the queue depth (128 -> 16), then peak goes from 46M to 44M. Not
> as dramatic, but still quite noticeable. This is just using a single
> thread on a single CPU core per drive, so not throwing tons of CPU at
> it.
> 
> Now, I have no idea how well nvme multipath currently scales or works.

Should be pretty scalable and efficient. There is no bio cloning and
the only shared state is an srcu wrapping the submission path and path
lookup.

> Would be interesting to test that separately. But if you were to double
> (or more, I guess 3x if you're doing the exposed device and then adding
> stats to at least two below?) the overhead, that'd certainly not be
> free.

It is not 3x, in the patch nvme-multipath is accounting separately from
the bottom devices, so each request is accounted once for the bottom
device and once for the upper device.

But again, my working assumption is that IO stats must be exposed for
a nvme-multipath device (unless the user disabled them). So it is a
matter of weather we take a simple approach, where nvme-multipath does
"double" accounting or, we come up with a scheme that allows the driver
to collect stats on behalf of the block layer, and then add non-trivial
logic to combine stats like iops/bw/latency accurately from the bottom
devices.

My vote would be to go with the former.

>> I don't have any insight on this for blk-mq, probably because I've never
>> seen any user turn IO stats off (or at least don't remember).
> 
> Most people don't care, but some certainly do. As per the above, it's
> noticeable enough that it makes a difference if you're chasing latencies
> or peak performance.
> 
>> My (very limited) testing did not show any noticeable differences for
>> nvme-loop. All I'm saying that we need to have IO stats for the mpath
>> device node. If there is a clever way to collect this from the hidden
>> devices just for nvme, great, but we need to expose these stats.
> 
>   From a previous message, sounds like that's just some qemu setup? Hard
> to measure anything there with precision in my experience, and it's not
> really peak performance territory either.

It's not qemu, it is null_blk exported over nvme-loop (nvmet loop
device). so it is faster, but definitely not something that can provide
insight in the realm of real HW.

