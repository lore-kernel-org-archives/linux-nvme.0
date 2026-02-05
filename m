Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF1ECD994
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOIgzh7F0/asMA4wYQkOAKt2bxR52YWhKTa5Hn1hbLY=; b=N5EcaC0JothjT0C/b/z9kJbSYy
	I0EPTGYyEg7B66zFCG7KXfTuPh7yfU7JO+BVawPtbCKu5dszNNdcmIejBds9iTCvk3FWDh2+sz48O
	AfbzGolRoVvI9w7okz0fq0U2nCnlQHl4wqL2gPVUZYBrl4/3tlwhY2J2em7fcoiPGON371vN+V0nq
	oHQdBHBmE24/X0/09Ez1QWFmHWWzz5a8aGCQ5gUJh5nq/BkQnrDNI1EkQnFZi6tR0OOOMRtyxPh+z
	+atNwgAvRbu7ZesY7mSWCdrC1UGUJ/sjeyCnnVTIR9JwlvfhbvNj90wrP7whfIpWc+6YhfT8t6hxb
	sGYo/u2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo3rI-0000000ALVe-3QP3;
	Thu, 05 Feb 2026 18:13:40 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo3rG-0000000ALVF-3r5M
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 18:13:40 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso13182165e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770315215; x=1770920015; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOIgzh7F0/asMA4wYQkOAKt2bxR52YWhKTa5Hn1hbLY=;
        b=PEavkfptk2fE0qAyk7XeBAqQ7WZRCdOyKuMdLVuN/5WgIbHd8jcG1V55RuGLOZLZjr
         mEKQUozfecfOEp2IJur9548HA/6+8CE03nOEmmIKwLIlTuhWBl9dhouUeiZft+zw12Sf
         qxtcRnpsMuw7KMS1PsGMbY1muP6rtjAXVsHG6X9l4GUbX5Mc+zDC5lXmsq1xU3sypxUz
         jaCa97FLUdi27AUHGsATWftQZcZrk9P0WNVtwzRQZEg5CqxcsVBWkG68rOyLVp7SYi5E
         AZ3eouw7ENfNSUJ811Tr1T5Jz8sL8QLUCUwYX02JpeGCFCuPSxs0XQ7gzBldPzn47DF2
         d5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770315215; x=1770920015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOIgzh7F0/asMA4wYQkOAKt2bxR52YWhKTa5Hn1hbLY=;
        b=Kl/W3yMp0ows4BBvUjGEagpJ8t2xFryPBbXiy8o3iY2o0Fv9IwTLXVmxF5aJn+6UTi
         fyOzwE62TPkfQEtjV89FEhAn6322YmBzW21fO0t3UcmVQQoTWkagfBtrESO3WzQxhwnQ
         3tajHW0MIIt67a31blKa+BrYqeGGgjRsFhNB/EfK0HAAnoP55iRV/rx4uzh9HqPhfPZt
         Ujh+yvjJsSVsCsuXlul0/8G6jxIW4yk1wCOxVTENYUMC5UI+xlIhk/CWk/serf4bDnEQ
         gVcIAVv/sCwX/ZnzqnU721M78AenJOkP1Y/NLL7p5Pd+thgRadkCfKT98JGt8IWFmCv2
         DFtw==
X-Forwarded-Encrypted: i=1; AJvYcCVCCx/w/hEEp/t1R79r5zF9nDGVO1CDrKNig30x2HjEhuBv1biz6HCbchZwqbpJxdbImUrcJmvP4OHq@lists.infradead.org
X-Gm-Message-State: AOJu0YyVf3heo6CLdxPjeTflesKHul7VYst9cX1Ck9eEK7rN8BhdZEhc
	M1g7WQAqYzUlGwoDPxdaJqK+uRiGEVxiY6+5C7W6mv1n0/EfajtR7J4f
X-Gm-Gg: AZuq6aL0SCRmg7bQ3cD3mug0nmCZkzcYWZvZRZ4I6T6cQktovypSfHMea3Ef8lmK8JZ
	uqyuEdmcGTGB+rK5RWgXSmBWo8v5Urt08E1yOW7cI7xKK6QdKff9PqBmQhuEvksMnDH6JRhSPYJ
	LibxHVJUQ//h4jIim3HvejD3KPTEzTzGlH0dmUBxaSi9rNE6ybETpClwpJNorSTmQ1457VErOCw
	6MrjPG5oo2Q5TOMAT9VQVXiCRJ4ArQYZjvNdeQ4m68sOt9blrWNcOIKDD0FqNleRIBzY4VEawnZ
	2eTBjd4lD3j1zoT2bqWV4H1EuXaVNCEe/d6vWg4rV5vZVEOBoh5BWtQJ4y2NlZ7DaipHgvQoLaI
	UMAjU+CxEUju9UpMG+Y4xhtTVI1zotohYoRI7PllnHyjGC4SABJcXMHevkuHNcVW1Xs1juXehmD
	8NOLHVTffHvGfGBiarn03/Nneh6Rq7QMFU5hul1BDPm6Gnm7Y+WWCYJe/8Ez5DSitrYjjx1QzV1
	a9jfe065NtTZV0BdZNTmrJkZhNw5J27clZVwpU37xYVd4UPkGELp9RNZZKtbZwRog==
X-Received: by 2002:a05:600c:2eca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-483178ebb2emr36092105e9.6.1770315214446;
        Thu, 05 Feb 2026 10:13:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2085asm76942305e9.1.2026.02.05.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 10:13:34 -0800 (PST)
Message-ID: <2403ae2a-0e9e-4b7f-a507-232dc951155d@gmail.com>
Date: Thu, 5 Feb 2026 18:13:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <aYQKhcnTJLimnbEn@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aYQKhcnTJLimnbEn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_101338_981714_77B8523E 
X-CRM114-Status: GOOD (  17.73  )
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

On 2/5/26 03:12, Ming Lei wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>> Good day everyone,
>>
>> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>> and there is growing interest in extending it to the read/write path to
>> enable device-to-device transfers without bouncing data through system
>> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>> useful to mull over details and what capabilities and features people
>> may need.
>>
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping. The actual mapping
>> creation is delegated to the target subsystem (e.g. NVMe). This
>> abstraction centralises request accounting, mapping management, dynamic
>> recreation, etc. The resulting mapping object is passed through the I/O
>> stack via a new iov_iter type.
>>
>> As for the user API, a dma-buf is installed as an io_uring registered
>> buffer for a specific file. Once registered, the buffer can be used by
>> read / write io_uring requests as normal. io_uring will enforce that the
>> buffer is only used with "compatible files", which is for now restricted
>> to the target registration file, but will be expanded in the future.
>> Notably, io_uring is a consumer of the framework rather than a
>> dependency, and the infrastructure can be reused.
> 
> I am interested in this topic.
> 
> Given dma-buf is inherently designed for sharing, I hope the io-uring
> interface can be generic for covering:
> 
> - read/write with same dma-buf can be submitted to multiple devices
> 
> - read/write with dma-buf can cross stackable devices(device mapper, raid,
>    ...)

Yes, those should be possible to do, IIRC Christoph mentioned it
as well while asking to change the design of v1. The
implementation will need to forward registration down and create
a dma-buf attachment for each device.

-- 
Pavel Begunkov


