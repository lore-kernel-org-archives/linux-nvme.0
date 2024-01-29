Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42883C47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9C/gc83G5Aiq556z8qvcu7cmket71gitgUD2VeeHQo=; b=cc5YKjoMAgtq7Hdb2OZ5EBIDZ3
	X3412nXa/i9Yt6gTlro9rFnTC/hy8Y+R8kp/tDwMauq5JGYRl7H/JUlwanE5fpKwyblbjGqnxEUQH
	F+CQOjKFJzWuKNIcW3gRuaQivEkj8NJWiyvXjvlaK1ABT2oT8dYkPUO8E7DHWOR4yCCqt8HJcOdzp
	XHF9M3dZJdi12xOjRxk/759Xx6Uk+uki2D4mw0CQIWZXomRS76bU8vkCXmkGL6VG2Exua+M08lv1N
	FVs32TBsfwap+Ggj62fo3AJ2BRb9xNR0o7HE6veem9i9AToinX3unG+ZqlKytJtFzuKtZjr9x4SbO
	2xJHnHkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXrR-0000000EC8E-2shH;
	Mon, 29 Jan 2024 20:04:05 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXrO-0000000EC7f-3XCq
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:04:04 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339541178beso171226f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558641; x=1707163441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9C/gc83G5Aiq556z8qvcu7cmket71gitgUD2VeeHQo=;
        b=h+uhD2uPjVPZykov5U6U+FJxda6lMy4kppzEYwglLo1F/sk+AJH3Pfbf2qtU7X1io5
         YE1+ybH8Yh54tMBliRqjDvl7+ymq2T5kwojT+WZdz276JF/s0yNPbg6blwmjh12Ce/yQ
         2i6pnQB/LwzN6Eze5xaiA6zf08n60Jsnfh0db1RQRouwwqH1r8xvpBSzm2GzS6vFTScM
         eI4e6Wji4NaK5Mg6sg0NRtJalmiJYwU7GUlMpFiV9yZXOlqrITU6iVccMlhL5Q8O8wD6
         43OFeJz2ElFtWk5UxTwNGfpwsX1i4lZnlr/NZLPClDKUeiRqA/TnBLwT88tqqCtJa6xw
         y8Wg==
X-Gm-Message-State: AOJu0YyvuSzbFRHgSlERp/D8D+pKolpuE6xZbvBoE1kDhSSFOAtPDYs6
	MeeisOQc4gDflIKriTE7QMixV9CQbqgXuHB0KQIklAeXdLLZmqBA
X-Google-Smtp-Source: AGHT+IEwVO4Pe8PADS/+TT2g3KYewUf5GzRL+8sgTil8bObQXsKl0STjaFPNU+wltt8uHHZCQbKF1Q==
X-Received: by 2002:adf:ae52:0:b0:337:c50c:27df with SMTP id u18-20020adfae52000000b00337c50c27dfmr5618929wrd.4.1706558640892;
        Mon, 29 Jan 2024 12:04:00 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id bu25-20020a056000079900b0033ae4f2edb0sm6481894wrb.37.2024.01.29.12.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:04:00 -0800 (PST)
Message-ID: <74eeb2e2-31f3-4d6b-9c71-cfe591cfdbd1@grimberg.me>
Date: Mon, 29 Jan 2024 22:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp
 target
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: "Nitin U. Yewale" <nyewale@redhat.com>, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 loberman@redhat.com
References: <20240129110639.45542-1-nyewale@redhat.com>
 <501724df-de9a-4b74-bdee-eea7c3507f51@grimberg.me>
 <Zbe__KROwAeKO6oO@kbusch-mbp>
 <b579db5a-bc4d-49e3-a467-a3a32fa5d2a0@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b579db5a-bc4d-49e3-a467-a3a32fa5d2a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120402_913039_5263DA02 
X-CRM114-Status: GOOD (  11.65  )
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



On 1/29/24 17:31, John Meneghini wrote:
>
> On 1/29/24 10:10, Keith Busch wrote:
>> On Mon, Jan 29, 2024 at 04:18:14PM +0200, Sagi Grimberg wrote:
>>>
>>>> Log hostnqn when connecting to nvme target.
>>>> As hostnqn could be changed, logging this information
>>>> in syslog at appropriate time may help in troubleshooting.
>>>
>>> hostnqn is available via sysfs, why do we need to log it?
>>
>> I personally haven't encountered an issue where these patches would have
>> helped, but sometimes a dmesg is all you get with a bug report.
>
> Yes, exactly. dmesg is the first place people look and often times 
> it's the only thing available.

Its going to create overly long log lines... but if you find it useful I'm
fine with it.

>
> Reviewed-by: John Meneghini <jmeneghi@redhat.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


