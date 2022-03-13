Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1BBC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5hpgio9pD8hulFoquYbcjRBj0pBDXvlxYZEsR0wPc6k=; b=5FeLvDI3bGbnqwnoEqIe34PmPW
	OhYS6xdY4Fhk3cs87mXcDEPP64hhvKpew1UHW2nLhikOLWm6yHo2uB8G/b6x9phw+Le6NFmPx+Ykr
	gX4NXOjksQCfRmuouInwo74hSQf9UPk1ZYgaCJQiPhFMpL2F8dvIeQD+Hrsp7xMSMrV2f09Qi+Szy
	KeWO9Wewza79lWh3DPwRbZnxSR105Coex/kcM0MHtRyYd7YAmdeJt0VLiFqI7GM1Nn/knsHkxQcrL
	RRkJlHhU8D2S9bvyFwjeLuohTShJDbxNPDREZ/+Dy8fb8H1fseYQcwxRWGelIf0GHalmY2wc0rokx
	unWyd7BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTMar-002hqw-7k; Sun, 13 Mar 2022 11:41:01 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTMan-002hqa-Rg
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 11:40:59 +0000
Received: by mail-wr1-f44.google.com with SMTP id r10so19716968wrp.3
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 04:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5hpgio9pD8hulFoquYbcjRBj0pBDXvlxYZEsR0wPc6k=;
 b=Sp747K3w9VJL2ZwFnI+1vFapVpy4+HaB6QhvNPxejOXqES1khLIRB97o8fpW5FTc4u
 YxGvpsHeS2UL4r5/s3eEztibu8FXq2mT0n5W39IT6TEWDcG9o0qFIgtw2FFFPqXsvSxh
 q1yorFScZl4WUtSfKvE2LZ6eJmeWmtRC/yuI6jEB9SpAZuzkKzP4jaz1xyB6Py385htA
 rLUE9ZygYr+LYfDigyVhoeXESCBnMKZO8cLZqq6R/ke+mAdUooIF6zlOwAAOCxkYH8Tg
 vI+IF9BNMEdivW7sWo0PvYoqnl2vrJIxw9YIhDayIdfJg8jsirb1p7PMmfwvJbiv3auF
 lT5g==
X-Gm-Message-State: AOAM533xLSxnQSE3oNX/BGM+Jum3TUkh/Adzd0Q8betoFCtW2157ohLE
 rqxxdMXex8V5LKd1hvd9AIc=
X-Google-Smtp-Source: ABdhPJy1IlZerQti3MqLer/rw/mvsghVdBsTdaWqbe8Oz2N2hoosfT3mSJ7cYydWJ0YhpGxxMbxpDw==
X-Received: by 2002:a05:6000:18ab:b0:203:731d:1ac1 with SMTP id
 b11-20020a05600018ab00b00203731d1ac1mr13288082wri.411.1647171654840; 
 Sun, 13 Mar 2022 04:40:54 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 l126-20020a1c2584000000b00387d4f35651sm15209301wml.10.2022.03.13.04.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 04:40:54 -0700 (PDT)
Message-ID: <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
Date: Sun, 13 Mar 2022 13:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Content-Language: en-US
To: Mingbao Sun <sunmingbao@tom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220311103414.8255-2-sunmingbao@tom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_044057_935956_7D32C31E 
X-CRM114-Status: GOOD (  23.97  )
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


> From: Mingbao Sun <tyler.sun@dell.com>

Hey Mingbao,

> congestion-control could have a noticeable impaction on the
> performance of TCP-based communications. This is of course true
> to NVMe_over_TCP.
> 
> Different congestion-controls (e.g., cubic, dctcp) are suitable for
> different scenarios. Proper adoption of congestion control would benefit
> the performance. On the contrary, the performance could be destroyed.
> 
> Though we can specify the congestion-control of NVMe_over_TCP via
> writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets that
> have not been explicitly assigned the congestion-control, thus bringing
> potential impaction on their performance.
> 
> So it makes sense to make NVMe_over_TCP support specifying the
> congestion-control. And this commit addresses the host side.

Thanks for this patchset.

Generally, I'm not opposed to allow users to customize what they want
to do, but in order to add something like this we need a few
justifications.

1. Can you please provide your measurements that support your claims?

2. Can you please provide a real, existing use-case where this provides
true, measureable value? And more specifically, please clarify how the
use-case needs a local tuning for nvme-tcp that would not hold for
other tcp streams that are running on the host (and vice-versa).

3. There are quite a few of TCP tuning knobs that will affect how 
nvme-tcp performs, just like any TCP application that running on Linux.
However, Application level TCP tuning is not widespread at all, what
makes nvme-tcp special to allow this, and why the TCP congestion is more
important than other tuning knobs? I am not supportive of exporting
all or some TCP level knobs as a local shadow for sysctl.

Adding tunables, especially ones that are address niche use-cases in
nature, can easily become a slippery slope for a set of rarely touched
code and interface we are left stuck with for a long time...

But while this feels a bit random to me, I'm not objecting to add this 
to the driver. I just want to make sure that this is something that is
a) really required and b) does not backfire on us nor the user.

> Implementation approach:
> a new option called 'tcp_congestion' was created in fabrics opt_tokens
> for 'nvme connect' command to passed in the congestion-control
> specified by the user.
> Then later in nvme_tcp_alloc_queue, the specified congestion-control
> would be applied to the relevant sockets of the host side.

Specifically to the interface, I'm wandering if this is the right
interface... The user is used to sysctl with the semantics that it
provides, wouldn't it be better to expose the exact same interface
just for nvme-tcp sockets?

Something like sysctl nvme.tcp_congestion_control ?

