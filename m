Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F9DCFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cjrM7aAawVVVIU9hDdkUNIJq9Dx05qeU3NVzTNZ7oFI=; b=km1MaxZy4k4UZFA/jfoIm1VR/h
	zIyofGOC6mTmXCov1sUOmqG1Cl1y406fgXNJJq92hAg5WY/cYvYn25eFSFw+2S5cFFctyHz2e1NwJ
	CY+h89ucRavwJHZnI7aseuHewIQ5hLgyjhUy0vyt3slcSTcvws/SXfEQWy89OlqRbPZMfWiKsRc+8
	0ZIIbAuHeJnL7YfGSngr5jtfmY/qPVQ/MXvCvblN1hQ3VT0kPR/a2d2jXIBxo1+XJL/B05REoHVx8
	QcgzCQeu70gmBzKOXTU0dTEBUct7+jjd1kNJUytfFHVX6a5ZYOx2u/IluqRbwSRWAQGKiyYYLsIii
	kbPqVSuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPp56-00000002aJk-28vu;
	Sun, 30 Nov 2025 21:35:44 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPp4z-00000002aJN-3ySd
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 21:35:39 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47755de027eso22924665e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 13:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764538535; x=1765143335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjrM7aAawVVVIU9hDdkUNIJq9Dx05qeU3NVzTNZ7oFI=;
        b=JwIdlUh8NhEMmRni2x27px7h4UYcd793yPh5SkA3R1HlXT7gqsd9xmDZo6dTgxmwpS
         R8tRv8nSqQ9xrrFDl3/RTKIpHO8JazCuTvxp7oJcDJmyWYZng/gwCsX49W9eM6493rKi
         C2mqpD4vGILkyTIfKvevwpSPjqfCBy/Q4Jb8ejBfhO25NsJW5pnburcSnsZzNFeMkCHr
         e/D2+uYK5n+V7sNCXoUPF9pwWL+KvXZKKwbZ4lrgwOHlvVNFmRskKFLopb5SH6JFdatc
         KxuV35IK5MWaVIl+RLvqV8NXq75YVJCROhWYhxqEYhj+O1W7mkpJU0Vc0vj1R82q1SQh
         9uoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVt79Hlg8x+s1gK45FpC4JfccpHpusLzDGUylgdMdBKSMbMbkLyzoRSmnHE4Osc7nEXXLm3oUVsRd+@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5j088tQCd/Dtl70fXEvQUlZ3/kiT7jIKD7ufkzlvhdMivThPb
	LUEGkTDh27becBfc+MfB+TAO9MyYCeoILqYi3/UVha6tpS4RXMsovQBTIDd2Ag==
X-Gm-Gg: ASbGnctjZFJ/vW7sVst5jF6ujjR+aaVnNk6+MwmyE3UEYH/Ygq7yKBagaOmuQ9BqTwB
	fViMaN9vFGY9vAQfdg3dbhh/eLRWUp5GbRtso219HRVfmNMifJ/nScZDOCmrRWib0jOnZ2C+a3g
	Nw8hSbIWhlEm+tPlienKJYem0t7znupI8mZuAglSrN+ursUeIfdsKAOEF6PrCyZOK2MYH6844K2
	nzUoS4loVsCiV95LsUFLEay4YR6nASY1rffS2BQzH90MGh9LoJXxYn+/0ZDX1EwE2PKiu5lKZww
	mU55qCGgo6LXL88tyHt85UolGbEBQs1k2iGxyYRELT+KLxbX99KvndwVmGUYzB+S8fYHbrXhp2Y
	zdBQ9rMeBtwI+PqaYpUZ8iVdHyDc/igutNExe/ypDkRyiqbke/9MaQ0tpMq1zr7u04QADXXnntE
	58drv3gTaqaMcwVfas/cmLKgP1FVHnWyExW+lNeYJZhtdZ0Kgy7qg=
X-Google-Smtp-Source: AGHT+IG62vWXN8eD3t3pZpWaywEVJ3i73L/VIKw1D6j2OP3K1oQ3OEB6PenKzE6GddoaoDRMZSiU1Q==
X-Received: by 2002:a05:600c:1c27:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47904b2bfd9mr244785255e9.30.1764538534661;
        Sun, 30 Nov 2025 13:35:34 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47903e5fae6sm148282575e9.0.2025.11.30.13.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 13:35:34 -0800 (PST)
Message-ID: <aebb3431-2216-4ccf-88e8-ba499417892c@grimberg.me>
Date: Sun, 30 Nov 2025 23:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_133538_019029_7E619CE7 
X-CRM114-Status: GOOD (  21.74  )
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



On 27/11/2025 9:52, Hannes Reinecke wrote:
> On 11/26/25 08:32, Sagi Grimberg wrote:
>>
>>
>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>> The nvme-tcp code is using the ->read_sock() interface to
>>> read data from the wire. While this interface gives us access
>>> to the skbs themselves (and so might be able to reduce latency)
>>> it does not interpret the skbs.
>>> Additionally for TLS these skbs have to be re-constructed from
>>> the TLS stream data, rendering any advantage questionable.
>>> But the main drawback for TLS is that we do not get access to
>>> the TLS control messages, so if we receive any of those message
>>> the only choice we have is to tear down the connection and restart.
>>> This patch switches the receive side over to use recvmsg(), which
>>> provides us full access to the TLS control messages and is also
>>> more efficient when working with TLS as skbs do not need to be
>>> artificially constructed.
>>
>> Hannes,
>>
>> I generally agree with this approach. I'd like to point out though
>> that this is going to give up running RX from directly from softirq 
>> context.
>
> Yes.
>
>> I've gone back and forth on weather nvme-tcp should do that, but never
>> got to do a thorough comparison between the two. This probably shuts
>> the door on that option.
>>
> The thing with running from softirq context is that it would only
> make sense if we could _ensure_ that the softirq context is running
> on the cpu where the blk-mq hardware context is expecting it to.

What is this statement based on? softirq runs where the NIC interrupt
happens, which eliminates the context switch to the workqueue io_cpu
which is not guaranteed to affinitize where userspace is, in fact it often
isn't in nvme-tcp...

> Not only would that require fiddling with RFS contexts, but we also
> found that NVMe-over-fabrics should _not_ try to align with hardware
> interrupts but rather rely on the driver to abstract things away.

I did not expect anyone to fiddle with RFS for softirq context. The main
benefit of softirq context RX (outside of latency reduction) is that it
makes io_work handle ONLY TX, which is probably somewhat more efficient.

