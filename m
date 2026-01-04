Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB8EC2A062
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8S+hbhFVjYhXYYrd3pwPzijBCkYyEKTYj/qm1LKXfTg=; b=plSGSPNpvSMblcO3P3w7SleF9S
	V3S9h4JO8MWZ4kF1T0Husx3GCJGE0rauFPJHgoh9BqCovREqDhGkDMB6p3zzSoUh9gk0vjCbyT7Bb
	1Yi6N0bd9JL0AqYspC+o3pRx2InK0gJyfZjuL14Ez/kiMyd903mAQUetoedsnhjDlDBD/oNWNFL0D
	TBTA4oK/xGDLnNV+gXa2ybNIAbQuDi6pLZXUICUBJoWSY0QuAOguVv/4XnGXX0h5+veLRK7N8pWw1
	Z+QVOlHsgdpRb3MlG5xFfAaWldGq7dhb5hxW66Fnm2AGf4Thsmvg+4mpODT7ZOHAD8s3fFcKMI6cS
	OWqYQISg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVVK-0000000AStz-3qNT;
	Sun, 04 Jan 2026 21:19:14 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVVI-0000000AStT-3ZjT
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:19:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a8195e515so80941895e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767561551; x=1768166351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8S+hbhFVjYhXYYrd3pwPzijBCkYyEKTYj/qm1LKXfTg=;
        b=beI2DUROZ8437Pn4/4w/T9veDSlpzdTmtkzba+x43ZNFu74K3fPoJ5D+mHxj5R3cKw
         ckgtjpLmQ9hWghX5/FBmrnpQX/FBV+NasluhdHrQaVnvKjDu9WFCczmFsUIAG6z0i1iB
         qCSbyPAfsa7S7kXR1dEoTmOoU/j6CwJaMCzUsud0bcron3eF7/4LBUn9PWi7p+yZejQJ
         sloC7zwFZnAu1o30GGqXC53qXK2tp295qVnBqIvny2jBx/q5+t63uD+JuCLAxFIN8ZNm
         Qt+7dfK6VjAD3yIR6KbGZxZwd6jcHVSqrKDFJFS0xuy89pJ3sozdc4wJ/ofQZo/UhjTC
         +Bsw==
X-Forwarded-Encrypted: i=1; AJvYcCXKtdsCUBtdak3Qjmfa+R6tDraTSsfd3blGMljKaILdmwAT0Ihm6Ga76kr7WPZFd6mLWnGEQN+gjz8u@lists.infradead.org
X-Gm-Message-State: AOJu0YwuD+Ks55ckBfxWzYnRjGU5zwBiKgOkSRl0iiBD/rYEw2+BGGZ0
	zPTMxU191FudPSISH0fZ0mJ7AwvN1NijMVVCNbMmZ5vP1DunWMYWpua9
X-Gm-Gg: AY/fxX6wD1qT+5EjXxbgQ1TmQl1u9JiILIzGDCBdIsX87tNz2O9DT22QilXypmC1b5p
	+imsfwY3pqXn19fiW9wwZ+hyjj97+gIDdTlvLo3xm+KKEdjrkGzslhTgpPE4Kz601fCmAUpszJf
	mBKH9eNn/4BxaIaw90+jDfue1P/JChIUbhOLtq2Ti7Zly7qNuyezX6j+h/UsI1ll2TXZQJD7dv+
	13gLW4Vl/jnvy196HfDH+WRanntoNgcTER/kOf9NM9VhqfLrctEnrPEKels8Ma+/MXka0oHuuir
	bjQvg4H833iKuRZUB1eOLYbfpTbVc5SiP2cMMP0lgGMeyu2UP6V+QbCySxS815NYmI6piU1hJrV
	Vr3Hp5MLSlWlvF2aygIdZ5zPNUDRoDZTedP05QGBsXabMSAt0Whv0dBDyq++0xQrDGQbQDnc4jp
	OdUZ6AxyNBC+izhzD/6nCoUFLnfaKHLXp5d9FThgR3O8Y=
X-Google-Smtp-Source: AGHT+IGx//L+1uxBIldaz4O0xIb+8nkG9CoGbpmBam23eG14dziukvSqh3xuqTzUuGI5tBY2zC9BHQ==
X-Received: by 2002:a05:600c:6096:b0:479:3a88:de5f with SMTP id 5b1f17b1804b1-47d1959d6eemr514286355e9.36.1767561550919;
        Sun, 04 Jan 2026 13:19:10 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6b9efb7dsm47504645e9.0.2026.01.04.13.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:19:10 -0800 (PST)
Message-ID: <697242db-b748-4b27-9e60-44e81a6644bb@grimberg.me>
Date: Sun, 4 Jan 2026 23:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Randy Jennings <randyj@purestorage.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-11-mkhalfella@purestorage.com>
 <5befc95c-b66a-4dd8-bb72-7cc6839c7c4b@grimberg.me>
 <CAPpK+O1g+Z=CYDfA1u6-iBx8L5tuhFOgipbyVvmj=oqW9UbLkg@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPpK+O1g+Z=CYDfA1u6-iBx8L5tuhFOgipbyVvmj=oqW9UbLkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_131912_919933_B79F69EF 
X-CRM114-Status: GOOD (  16.22  )
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



On 31/12/2025 2:13, Randy Jennings wrote:
> On Sat, Dec 27, 2025 at 2:35 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> ...
>>> +     dev_info(ctrl->device,
>>> +              "CCR failed, switch to time-based recovery, timeout = %ums\n",
>>> +              jiffies_to_msecs(rem));
>>> +     set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
>>> +     queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, rem);
>>> +     return -EAGAIN;
>> I don't think that reusing the same work to handle two completely
>> different things
>> is the right approach here.
>>
>> How about splitting to fence_work and err_work? That should eliminate
>> some of the
>> ctrl state inspections and simplify error recovery.
> If the work was independent and could happen separately (probably
> in parallel), I could understand having separate work structures.  But they
> are not independent, and they have a definite relationship.

The relationship that is defined here is that error recovery does not start
before fencing is completed.

>    Like Mohamed,
> I thought of them as different stages of the same work.  Having an extra
> work item takes up more space (I would be concerned about scalability to
> thousands or 10s of thousands of associations and then go one order of
> magnitude higher for margin), and it also causes a connection object
> (referenced during IO) to take up more cache lines.  Is it worth taking up
> that space, when the separate work items would be different, dependent
> stages in the same process?

Yes, IMO the added space of an additional work_struct is much better than
adding more state around a single work handler that is queued up multiple
times doing effectively different things.

