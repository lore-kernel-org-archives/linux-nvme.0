Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271F6C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CPeRKp2equzjPoiyGuI+L6sOY6qqv2wALvdLjuhPQM=; b=fjASeiaeexeA64afJp8c7jMx/T
	oEGgcJeUarT39PPTDh40u6j1Nj/47hrKtyY78nNo1j138QEqYCBdCwzEmhVBvTNfzmk6Px72yk2F3
	064PrwLhKDIF6EOUlCwGBam06F5vMR7aWdy0hVaFZwM4lgj6f51ZTQpV8x2FWniiD/tjRtHmkINh2
	jvHDDM921Ng6p5u7HCt156GaU9JANw3wAV8fD9znX313reHR3T0w06LVEkqgnJ5aEDFE74nNbUigA
	7xYq5P1gjvkuUIsXgd0cAOWA7zP9yrCxqt7P9CjaQk6jbT4AQiAK7QWBBskwDlmSWRn/n0YkDMT8J
	f7OHw5Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRXQ4-00EWdU-La; Mon, 13 Feb 2023 11:54:52 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRXQ1-00EWbJ-LE
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 11:54:51 +0000
Received: by mail-wr1-f53.google.com with SMTP id m10so2986524wrn.4
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 03:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676289285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CPeRKp2equzjPoiyGuI+L6sOY6qqv2wALvdLjuhPQM=;
        b=NBLTj5bUXx/5GOHAsp3vDOZaEEZwahQW1cRGz1Gz2R+hCtT+d4LNXSkcDtNlFPTP95
         G8hXcNt+vGmT7o++K4ZveZ/csXLHJJ/l/wNw5nDAmnfJKqvfE3hpS9BfPiETY7YyyMgR
         tIR47Ory2CdKllYF4ww5GnvqeaTgxtKnsjPeSRchVTh1pSzKyquFMrzwzObFcgzwLhrI
         g378JG62Dqz9BVIWNFI5qsK0aYWCDUEiBMudcoLXi6Qzl+q3n+Rnf3p98mPpQuJ8Ofyz
         gqQxkLEVDabw65acQlZXZUeRd+gl2t2Tr+1zfuDy88nxabpBSHic+mqsmV0wJ9nyg/92
         PseA==
X-Gm-Message-State: AO0yUKXwptSPnscuW3uYbu0U5JtUwqoQOaJBiVoH1V29zHtrIM9I4nd0
	KvLGKEiIGN4wc7PbL00ju9U=
X-Google-Smtp-Source: AK7set+RjIvySbOj6M2sEO16NGkt3ThmcXKJoOTiWW3+yJEoE8M86yMRqBLAjsl4Qf9scHKo75kd8w==
X-Received: by 2002:a5d:5151:0:b0:2c5:5b85:3b43 with SMTP id u17-20020a5d5151000000b002c55b853b43mr1001809wrt.7.1676289284693;
        Mon, 13 Feb 2023 03:54:44 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f5-20020adff445000000b002c53f5b13f9sm10035471wrp.0.2023.02.13.03.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:54:44 -0800 (PST)
Message-ID: <79c1f876-d054-a8ed-8826-e3ad4f9903eb@grimberg.me>
Date: Mon, 13 Feb 2023 13:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_035449_766846_F060A2AF 
X-CRM114-Status: GOOD (  33.43  )
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



On 2/10/23 21:53, Jens Axboe wrote:
> On 2/10/23 11:00?AM, Kanchan Joshi wrote:
>> is getting more common than it used to be.
>> NVMe is no longer tied to block storage. Command sets in NVMe 2.0 spec
>> opened an excellent way to present non-block interfaces to the Host. ZNS
>> and KV came along with it, and some new command sets are emerging.
>>
>> OTOH, Kernel IO advances historically centered around the block IO path.
>> Passthrough IO path existed, but it stayed far from all the advances, be
>> it new features or performance.
>>
>> Current state & discussion points:
>> ---------------------------------
>> Status-quo changed in the recent past with the new passthrough path (ng
>> char interface + io_uring command). Feature parity does not exist, but
>> performance parity does.
>> Adoption draws asks. I propose a session covering a few voices and
>> finding a path-forward for some ideas too.
>>
>> 1. Command cancellation: while NVMe mandatorily supports the abort
>> command, we do not have a way to trigger that from user-space. There
>> are ways to go about it (with or without the uring-cancel interface) but
>> not without certain tradeoffs. It will be good to discuss the choices in
>> person.

This would require some rework of how the driver handles aborts today.
I'm unsure what the cancellation guarantees that io_uring provides, but
need to understand if it fits with the guarantees that nvme provides.

It is also unclear to me how this would work if different namespaces
are handed to different users, and have them all submit aborts on
the admin queue. How do you even differentiate which user sent which
command?

>>
>> 2. Cgroups: works for only block dev at the moment. Are there outright
>> objections to extending this to char-interface IO?
>>
>> 3. DMA cost: is high in presence of IOMMU. Keith posted the work[1],
>> with block IO path, last year. I imagine plumbing to get a bit simpler
>> with passthrough-only support. But what are the other things that must
>> be sorted out to have progress on moving DMA cost out of the fast path?
> 
> Yeah, this one is still pending... Would be nice to make some progress
> there at some point.
> 
>> 4. Direct NVMe queues - will there be interest in having io_uring
>> managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
>> io_uring SQE to NVMe SQE without having to go through intermediate
>> constructs (i.e., bio/request). Hopefully,that can further amp up the
>> efficiency of IO.
> 
> This is interesting, and I've pondered something like that before too. I
> think it's worth investigating and hacking up a prototype. I recently
> had one user of IOPOLL assume that setting up a ring with IOPOLL would
> automatically create a polled queue on the driver side and that is what
> would be used for IO. And while that's not how it currently works, it
> definitely does make sense and we could make some things faster like
> that.

I also think it can makes sense, I'd use it if it was available.
Though io_uring may need to abstract the fact that the device may be
limited on the number of queues it supports, also this would need to be
an interface needed from the driver that would need to understand how to
coordinate controller reset/teardown in the presence of "alien" queues.

  It would also potentially easier enable cancelation referenced in
> #1 above, if it's restricted to the queue(s) that the ring "owns".
> 

That could be a potential enforcement, correlating the command with
the dedicated queue. Still feels dangerous because if admin abort(s)
time out the driver really needs to reset the entire controller...
So it is not really "isolated" when it comes to aborts/cancellations.

