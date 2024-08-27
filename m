Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66334C5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HhifHRJmZnTl+NzreaHaHU/lnSFcb4Kc6fTZLGbatU=; b=Imnze3D4sBjV34TK9h1cEzbMVc
	keG2NSMIoZhHjJbdsao4avG7lwZ2WbMue2UqZOvKPXtdmXZ60uUCHeIQr9fGEhVoCTsumwRMxpogd
	kOs/G3/2pkDf1K9CjhRlchTkh2SXb4fsxUeBRW3tuQLw36x+L6fpdGzt+ox4/rkLruPnwKkjLvfom
	m4d2OQAsHLSeg8nVK5j3Lmgd6Hq3jbn1GMA73JUeIFwL4WzQz2oIp6I2bYEG5K7TQg9Ry6zjozigV
	Kzici/PS2gPJA27Ob1ckxPQOEPoCvctxPEovLOBmqY2IiRzmdIJhlSFbO66C9uXi6pq9ZAmO9tz8R
	7c09gYLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1six6B-0000000BdKe-31Sd;
	Tue, 27 Aug 2024 14:23:07 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1six69-0000000BdKC-00fK
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 14:23:06 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso2886032f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Aug 2024 07:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768583; x=1725373383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HhifHRJmZnTl+NzreaHaHU/lnSFcb4Kc6fTZLGbatU=;
        b=HmxkmgvEi3Qc++3k9wziA+dUFzwIovajN5nfCOonEjx76E2HLiHiCXZGkQLMiRjAcm
         rB3aa9SchQ0ZFv2KdUXQC2XJNoZQEtkMHScDcJt25vXEqbMyEcB7l42vXpyKIpKc3F5p
         r6yeoE3r2aiu4zazOhEVrwZS0cG2V4u3tiS2oy3GrkW3OO3QupUgziwQ8KDiZPGSVuPO
         EJliWHhTK6D0pzrbmX+DeMxhZNsAt/lQLAlg7XFle3M7EX/HH5LskagrebJ/EMYwcGKi
         Kvuc5/ON46PJGdhNst0/F7lTWi/1Sdh/ndP3KaQYDpq+HJcpM7sxVzQ25sa1ML44b8T1
         DAUg==
X-Forwarded-Encrypted: i=1; AJvYcCWyUNSEJGP068t3tyhMQIy+xKPWOnmy3znMZEA+jsfsZHxbFuL8XTjb4em3TTkJ4EgemN/h6WTl2h25@lists.infradead.org
X-Gm-Message-State: AOJu0YyqhyHbP3tFLD6LRzjKbl8/6UEQ9xgDyltwOnRDyDokcpBK65K7
	dv2kPFZ0p9LYeqfOFd+zKZh3ZBuHqBMw76CqfAf/imHAg17o8BhNbArcdw==
X-Google-Smtp-Source: AGHT+IFhh8UY4ijB22Bb/uZRymJmn8QLLPLHkqEE8KwPwV5ZeMX86FRNVVz3Kz6xvUrgxQ2Nibwftw==
X-Received: by 2002:adf:fa09:0:b0:371:8c61:577c with SMTP id ffacd0b85a97d-3731189da40mr9394524f8f.26.1724768582108;
        Tue, 27 Aug 2024 07:23:02 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813ce6fsm13298500f8f.30.2024.08.27.07.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:23:01 -0700 (PDT)
Message-ID: <5f5e5ebb-c449-4323-8f0b-ab1f6644e75d@grimberg.me>
Date: Tue, 27 Aug 2024 17:23:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Maurizio Lombardi <mlombard@redhat.com>, Hannes Reinecke <hare@suse.de>
References: <20240826120333.529128-1-sagi@grimberg.me>
 <f6091325-3df6-4de5-8c0c-ecc42d9124fc@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f6091325-3df6-4de5-8c0c-ecc42d9124fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_072305_080466_787056A3 
X-CRM114-Status: GOOD (  12.74  )
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




On 27/08/2024 16:27, Nilay Shroff wrote:
>
> On 8/26/24 17:33, Sagi Grimberg wrote:
>> Allocating the queue commands array leads to a high order
>> allocation.
>>
>> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
>> 128 of those (default queue depth) means that we are allocating
>> an array of 90K bytes. There is no reason why this will be
>> a single contiguous allocation. Change the allocation to be
>> kvcalloc instead.
> Though the description suggests using kvcalloc, the implementation
> uses vcalloc. Maybe a typo here or you want to use kvcalloc instead
> of vcalloc? In fact, either of them (kvcalloc or vcalloc) would work
> in this case.

I initially did kvcalloc, but then I thought that it'd be better to 
avoid the
high-order allocation altogether...

Unless someone has a compelling reason why to use kvcalloc, I'd stick
with vcalloc (assuming that the tls code is fine because I did not test it).

