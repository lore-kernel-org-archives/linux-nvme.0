Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF4AD29C2E
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jan 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUFD55+Kt87AlwhomERgXdEYs+eGxfqziPcFxLUpDFA=; b=v5KGeFa7PG2P09ruGNxD1cAhbs
	b7hzgrrQdHAjmTAIgVLlWyBjLFvE1jlihSAeyX043wU2pj+zLTt/Wt6lgqU1IASFt5hkDf1LTj3ED
	vVtDcL7PCDGgdYi+ntaP8dTXw3WjbmF1Rp4yqp+yCwdMXSWNgTn7TMCHclHP3kwUXwlhHYM/IAoFz
	cnQK5qj9eN+4sFbqIDAIr8TYFWVqSid5ZVwq/kDZ+bX1JgjH56xLEn/Or2xI5NuTyJWfa/jitJ5WH
	VHbR+bujf18IOxZ8ElKF1rzWeu/52KTRM+vGHcK2O2ijbhuxBwp8i25lSLBudfnjmRru8Hul5ZCJK
	4+nsP20Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhr58-00000002LBT-1kkK;
	Mon, 19 Jan 2026 15:22:18 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhr51-00000002LAk-2VMd
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jan 2026 15:22:18 +0000
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-7cfdf0c8908so2003633a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jan 2026 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768836130; x=1769440930; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lUFD55+Kt87AlwhomERgXdEYs+eGxfqziPcFxLUpDFA=;
        b=GJopfnKkWCcqQ9rUGgYvZlUtnaopxbHKJcPHhSc6wjG0gQMpd63/69qPjZ6i/s0ti0
         tm/XOXDNKhTjNaz+uV6IevbaW1liAW4dvDrHa/kZYxkDA+Vjbpl+KkDrkwbhQl9vf0KM
         ANStpHfeDF+9EkPWJO5WI7ArFKr0Pyokb/WN2dm9u5eVY7yuLc0n2Mm6hvTPZrJIxl+I
         JzJdsZS5JttEyKXVTmh0lOqVgNUnbnuq43CHXpHsrKpV5asYeCNAw1K3buFmDIMhTCtk
         dNVWrWUbYNKL/jOcWG4pNBrGQEIXAZzMkd9RCvrgNHmgYHpJLbbTOzu+JZ5mhl5dExgl
         9WSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768836130; x=1769440930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUFD55+Kt87AlwhomERgXdEYs+eGxfqziPcFxLUpDFA=;
        b=tq6q7vD4rqWS5zdG8iVxnzqx6gWb4cAuKHWJPxd6Gq3cmfyLAd9OypzfvcSSksfvQe
         lhckN0YIUxGXXoCV/v47cF1SJ4ypuXc6cqQprEiXh0w54eDKF4ELBtCA0V9BbcnV3spZ
         pLhzYNTGeP57GY4ciLZ8cKmYRloLTORtjM/sP98WRGzMX7E0TifkbsqFC+RTyBXiRR1G
         ozMdvJJfuCFtBQ3eps3z33iaoneuWzbgBgUAp3mggOutDmTb9IyH99HjSaV+1lf3MVhB
         FeSuzqGqV+E5qlZ2Z9fMe0qHlIk5z7sh9BpqfDpkHBnzM8MeNzlBqnnrDuxmLY3hytXm
         AYeg==
X-Forwarded-Encrypted: i=1; AJvYcCWmJXJbyEatFGG3xygdJpaQttyOpg3K+2L7GFNzXWKoKEKhm7ysbBb0jQIPq06bigcLHdwaUJPaU5Yv@lists.infradead.org
X-Gm-Message-State: AOJu0YzCG8041Sjh8HMXrCOdwrSVWXOKeeOQ94SsVfSQOBI/MssT+QJz
	AB186FanAAcWcVCIwo4AxlfigZ0MdhcI54d/+LB+p+1hn359OyO6Fm8kr711/1SYXaM=
X-Gm-Gg: AY/fxX5/8aV4TZEArgddyPcnY3ExbeJBNWCDYGRUyE7tE2K8WSFv5mfsGgDRquXuH/O
	n9AItnYVjdBnSyy+d9C2SPodXer6MFNACr/9cha8bZEhKBXkWx5cIZjDBikqhk4hW+LJbuIJFTj
	GeuxodOzzQaWoelRv3GJ+BeCp2FETwc00/JbFJ+QbWJHJCFeD9GcxkTm7mwHsjGjAztwKv2McwH
	tqRqnMte9wRK3AUaZ0IMN8GqoRYpFc8PSmqewnDHi6rJgC0N5BtTqMEhKQ8q2U4mu4YurSpN6Kp
	UzDpeJZarXi0usQr0tUtGG3kU/raO0iPLEi1bMzCwoT05Yx6/RdIOaTUFv3t5L7DrdSfQF45xCC
	bjK+oSdxvOAfgVbsgrmHxbmjx55KB69t1fGGntCEt6FbG/UUH9dn3rIUDJTFtKVKHte6DS6h7l4
	vrRmzam/0YeesJsLXBb188+eN5GKL3uga9t3HlGlZSiocYId2v/3Fp3YbvzPuu+6wmLhy7FQ==
X-Received: by 2002:a05:6830:6d23:b0:7c7:2e9d:aee1 with SMTP id 46e09a7af769-7cfdee13230mr7336893a34.19.1768836130500;
        Mon, 19 Jan 2026 07:22:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf000b80sm6856840a34.0.2026.01.19.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:22:09 -0800 (PST)
Message-ID: <6f703719-ee33-4fd9-bcbf-afb15967a494@kernel.dk>
Date: Mon, 19 Jan 2026 08:22:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260116074641.665422-1-ming.lei@redhat.com>
 <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Content-Language: en-US
In-Reply-To: <9859f637-d8f9-48e0-98ba-42cc6255c73b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_072217_045400_27D285D1 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

On 1/19/26 8:19 AM, Jens Axboe wrote:
> On 1/16/26 12:46 AM, Ming Lei wrote:
>> Hello,
>>
>> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
>>
>> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
>> context, and improves IOPS by ~10%.
>>
>>
>> V2:
>> 	- pass `struct io_comp_batch *` to ->end_io() directly via
>> 	  blk_mq_end_request_batch().
> 
> This is a much better approach indeed. Looks good to me.

Forgot to mention, Keith can you let me know if this looks good to you
too?

-- 
Jens Axboe

