Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB92AC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9r8TSxia5VOpRvq2ZH+KZFO+iNGYVhgl/TCGYdPnBV4=; b=3ujCAy4zZ2XwUNyjPjdQ6pdpeY
	mHzB+tQiNs0QDRdNlPXQv7W0J6eLc+GPopTISpBBugNmUKQ+PMiINGJIWj7M5mXMpBTt9hmNrrE46
	VrZKTYr0NeXnnGMUor4tK5p7HVM95X8qkWz58uureAxd2BF/bPHywY/qi+Pb04fTXmju/qSjU+xka
	6GZO8lpxkaFAiA4fU53hkfr2MFw/MZKmbYje58zefoM+VZpd3kFwo1JqZOHGzQrF8dZKdSMDW5G9B
	gcc5V+WRyRbfJw3C4th7Nghx/3IOE5bYx8ibM6RhWrtRvYfgwliviDfQIvGTUzsMMjVP3IiGnIR74
	+hDFQANQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGg2k-00000005QJO-18oE;
	Mon, 10 Jun 2024 14:30:42 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGg2g-00000005QIL-1DJC
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 14:30:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217ee64ac1so1475615e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 07:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029836; x=1718634636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9r8TSxia5VOpRvq2ZH+KZFO+iNGYVhgl/TCGYdPnBV4=;
        b=lspdlGTDkH9mPFYw4YHCGGSJ5/JCUJw51Z5d+PGHcf6WtWJWjaN0RztetvmPjzr8rZ
         6Rxwujb+DQVLb1liwadGXUSo/HHZqz3Itb/mLLH2HASttukrTIu7l8ak7eXfaFt95mas
         tTOtd8VwRJFECLZGyFSUQV/Y9/tX7q55/aeoaYhsfFsAVlP/QhiZBY4QbuGitTzeWPmp
         uRI9/jh8mP5RheuJtrZlVU9meZyYHnvqGkbaSqpR+QnsC826tJgoed5MCCukY6nDbg/N
         D6aagK08/yvdXUrMGmVA0H95M79HL5RYNvl7Iw7WbdbgoPFLLL/4WjzzPoLjeB8g8KQs
         RWiA==
X-Forwarded-Encrypted: i=1; AJvYcCWWzJovR0UXhLpcrHrJuEbPOwfZHe8MChWDbLT/auUtjgjOh8Td13u83lSIBATyEwl9U+nOi73EiDe7PrEvi6Kxudwu+cNmv/bbinCVN6g=
X-Gm-Message-State: AOJu0Yxbpyh7ufO8Iu46lqe3fHeMxbbAuxWhUjzBDxALrBs8AgNjztN5
	VHjZ5UdrktcC+oNq49WLnEqX6F8m/7EtV/bfTO8xXEXiItQSnfxY
X-Google-Smtp-Source: AGHT+IGNYwmKnUFOdEUBOUxTES955Io2GxJGmqmRpCkKr9SjdDxpdv9dXwhK1LcpQbQUyokSvA1QQA==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr7179815f8f.5.1718029836111;
        Mon, 10 Jun 2024 07:30:36 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f048dddddsm8554380f8f.111.2024.06.10.07.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:30:35 -0700 (PDT)
Message-ID: <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
Date: Mon, 10 Jun 2024 17:30:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
 <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
 <20240610122939.GA21899@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240610122939.GA21899@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_073038_362293_368509DA 
X-CRM114-Status: GOOD (  27.69  )
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



On 10/06/2024 15:29, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 10:09:26AM +0300, Sagi Grimberg wrote:
>>> IETF has standardized a generic data placement protocol, which is
>>> part of iWarp.  Even if folks don't like RDMA it exists to solve
>>> exactly these kinds of problems of data placement.
>> iWARP changes the wire protocol.
> Compared to plain NVMe over TCP that's a bit of an understatement :)

Yes :) the comment was that people want to use NVMe/TCP, and adding
DDP awareness inspired by iWARP would change the existing NVMe/TCP wire 
protocol.

This offload, does not.

>
>> Is your comment to just go make people
>> use iWARP instead of TCP? or extending NVMe/TCP to natively support DDP?
> I don't know to be honest.  In many ways just using RDMA instead of
> NVMe/TCP would solve all the problems this is trying to solve, but
> there are enough big customers that have religious concerns about
> the use of RDMA.
>
> So if people want to use something that looks non-RDMA but have the
> same benefits we have to reinvent it quite similarly under a different
> name.  Looking at DDP and what we can learn from it without bringing
> the Verbs API along might be one way to do that.
>
> Another would be to figure out what amount of similarity and what
> amount of state we need in an on the wire protocol to have an
> efficient header splitting in the NIC, either hard coded or even
> better downloadable using something like eBPF.

 From what I understand, this is what this offload is trying to do. It uses
the nvme command_id similar to how the read_stag is used in iwarp,
it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
the command_id to an internal MR for dma purposes.

What I think you don't like about this is the interface that the offload 
exposes
to the TCP ulp driver (nvme-tcp in our case)?

>
>> That would be great, but what does a "vendor independent without hooks"
>> look like from
>> your perspective? I'd love having this translate to standard (and some new)
>> socket operations,
>> but I could not find a way that this can be done given the current
>> architecture.
> Any amount of calls into NIC/offload drivers from NVMe is a nogo.
>

Not following you here...
*something* needs to program a buffer for DDP, *something* needs to
invalidate this buffer, *something* needs to declare a TCP stream as DDP 
capable.

Unless I interpret what you're saying is that the interface needs to be 
generalized to
extend the standard socket operations (i.e. 
[s|g]etsockopt/recvmsg/cmsghdr etc) ?

