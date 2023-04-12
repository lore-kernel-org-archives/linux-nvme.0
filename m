Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24238C76196
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYX6HfKlkq6rTsyGxlSqNq+zLejasLWXrvN1REPXNGo=; b=a82dthEzXmsTO3+7FMgraHM2Bg
	/lsceIhT+h7Xz7lbz35Rpt8yLbIcy25Zs8IXWyrCvLeLbCAKFONCR0ZUeM+PPllC20thdVHmetTQj
	XpMPgnUInd2bT9hPXtNt8Bm4kl09S3pimFjBGXuD/IMssFKgn81ewvqz5/lnlzlayDg1hkuqvUoLI
	Wl6tJd6rJ4HVAwVHS3F3qu9D4wIiNUyeD+X0+KE3v2/rWlWyNfywlFTe37y0fZmkQFJ/vQe+K15zw
	nKbMAkBUkMYA3pmht574OkVdj7jlL6FpYiVfrB8UAutZOEJyTQq3yuNGzuvsN5ciN+TrKjQocDJPc
	K8pRW5Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmPyd-001b4O-1b;
	Wed, 12 Apr 2023 02:12:51 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmPyZ-001b3J-3A
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 02:12:49 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63238be13deso215784b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Apr 2023 19:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681265566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYX6HfKlkq6rTsyGxlSqNq+zLejasLWXrvN1REPXNGo=;
        b=U//oTeibhAaddhu++0BM+2wLSmCiHL45cPfqipQllUImVfG9vuCwlvnuTeOuscyLPl
         Dom/17LHAuLqbWzJcVKd65CgsxOJDOUvnGS8P7tVE1TA1WwxEIceJd1XefBi6uWJAchk
         uJ+Zg7b1RuqiasYLCMDuTB0Q1LPJdWPrPszbUZqA1qDAcp0x7WjjamuMDPXR86SwhHk4
         UYs2T/sTlvAMO8/3Q733fAjqD7MeHk/AY4Zp5JLmXu4GvhREuznhoXcrdhcG3Xn0JA+G
         HXn9GKM55UPGZigKY84Vdt72XJwJPZUKdafMFtJfvQN3+YPGAsTRpsG+i3kSK3eMGuVp
         LGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681265566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYX6HfKlkq6rTsyGxlSqNq+zLejasLWXrvN1REPXNGo=;
        b=eEa+F3WKc2utZjWTMXyGYxA4yrNu59JuqFZyTYH3hpnJ9pR3TVHs9xZ5g4pUBeqURH
         2vi+Y5rH84RYhoTNs/bJaYm75CjVymHiWAWbJtxRfXCaesNcOQAvzfLWKyoT+LZASINd
         38dEglPrmA3Leulam+iGGcsgJ2XKCPJmgd2TahYT+np/yHnMFrO52kyXaeRFTJcN7tkp
         GEzwBAYDTBGwuXuCyTnB9dbzCKufX4okTZiYbbvazhiWNHCVpRPQHfap9WgKP+72d6nI
         /lqnA9sTkyf2jNlx9MzwW7ubOCrRrRe0fTTxWeH6LwZ9d3Ju1xu+k8PPlqzEBJ68TDvB
         Jc7g==
X-Gm-Message-State: AAQBX9cTTPN1NKxxPSpcASN3RPx/dGPds+m/RFIE2AI93CfECf3uwGOW
	R1W52D3qQITyXNKDEU1KbJfNLg==
X-Google-Smtp-Source: AKy350YJ9VIENBzJsdeE/IPWzCoz88UyX7fVAW4U/XTQqShqTWQ5AVZaFJmyTqMNfPvJknuvCsMnuQ==
X-Received: by 2002:a17:903:2443:b0:1a3:e67a:4bd6 with SMTP id l3-20020a170903244300b001a3e67a4bd6mr642458pls.5.1681265566274;
        Tue, 11 Apr 2023 19:12:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709028f8800b0019f9fd5c24asm7301899plo.207.2023.04.11.19.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 19:12:45 -0700 (PDT)
Message-ID: <b0c0d8f7-5e2b-feac-bf77-46b6d6edd2d1@kernel.dk>
Date: Tue, 11 Apr 2023 20:12:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com>
 <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
 <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
 <09a546bd-ec30-f2db-f63f-b7708e6d63a1@kernel.dk>
 <CA+1E3rKrXOOBEaRb4pfE29wmhRP-fcUcSwQ4gobKGRxMGyS8jg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rKrXOOBEaRb4pfE29wmhRP-fcUcSwQ4gobKGRxMGyS8jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_191248_025380_89434031 
X-CRM114-Status: GOOD (  23.34  )
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

On 4/11/23 5:28?PM, Kanchan Joshi wrote:
> On Wed, Apr 12, 2023 at 4:23?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 4/11/23 4:48?PM, Kanchan Joshi wrote:
>>>>> 4. Direct NVMe queues - will there be interest in having io_uring
>>>>> managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
>>>>> io_uring SQE to NVMe SQE without having to go through intermediate
>>>>> constructs (i.e., bio/request). Hopefully,that can further amp up the
>>>>> efficiency of IO.
>>>>
>>>> This is interesting, and I've pondered something like that before too. I
>>>> think it's worth investigating and hacking up a prototype. I recently
>>>> had one user of IOPOLL assume that setting up a ring with IOPOLL would
>>>> automatically create a polled queue on the driver side and that is what
>>>> would be used for IO. And while that's not how it currently works, it
>>>> definitely does make sense and we could make some things faster like
>>>> that. It would also potentially easier enable cancelation referenced in
>>>> #1 above, if it's restricted to the queue(s) that the ring "owns".
>>>
>>> So I am looking at prototyping it, exclusively for the polled-io case.
>>> And for that, is there already a way to ensure that there are no
>>> concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
>>> flag)?
>>> That will be the case generally (and submissions happen under
>>> uring_lock mutex), but submission may still get punted to io-wq
>>> worker(s) which do not take that mutex.
>>> So the original task and worker may get into doing concurrent submissions.
>>
>> io-wq may indeed get in your way. But I think for something like this,
>> you'd never want to punt to io-wq to begin with. If userspace is managing
>> the queue, then by definition you cannot run out of tags.
> 
> Unfortunately we have lifetime differences between io_uring and NVMe.
> NVMe tag remains valid/occupied until completion (we do not have a
> nice sq->head to look at and decide).
> For io_uring, it can be reused much earlier i.e. just after submission.
> So tag shortage is possible.

The sqe cannot be the tag, the tag has to be generated separately. It
doesn't make sense to tie the sqe and tag together, as one is consumed
in order and the other one is not.

>> If there are
>> other conditions for this kind of request that may run into out-of-memory
>> conditions, then the error just needs to be returned.
> 
> I see, and IOSQE_ASYNC can also be flagged as an error/not-supported.

Yep!

-- 
Jens Axboe


