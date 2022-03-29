Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01ABC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Mar 2022 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rpBdm54k3hpAJiNzkv6c+hlup42nSLv/yZ6rcxWnLSY=; b=LifPSDJ1USgFTY4SAEoi8/amj2
	XFO9jBqarYlVcAl9SAYEURh04+X8s5xHo1weoBuc3AwPyksef1JpE6r+P50v1coaqXPsAyubmEuSy
	oXHFxPj9XNte88cFng4MK/u5D6x1hZfm4Mtd9ZLQTySPQxRNTgyjuaJ0FBN/VlSiyE022WQoJLJaE
	tJ8kT3qJSRYCvzuSprfKftUxQbdlSaFYdwnCDSp/xKkcBAJHDNbLxLfQ7ouYQGTfhmi/nhpwN/ukk
	jxlNgfT4qGI0U9Nvz+Aw1aQO/wZrkaIatz19P+vIGU267V7BxqitfSJZsOsQJteHWg3EjWzJtAwzj
	2qbRVo7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZ6YV-00BNcT-RV; Tue, 29 Mar 2022 07:46:19 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZ6YT-00BNc1-QH
 for linux-nvme@lists.infradead.org; Tue, 29 Mar 2022 07:46:19 +0000
Received: by mail-wr1-f51.google.com with SMTP id h23so23500293wrb.8
 for <linux-nvme@lists.infradead.org>; Tue, 29 Mar 2022 00:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rpBdm54k3hpAJiNzkv6c+hlup42nSLv/yZ6rcxWnLSY=;
 b=d40gmXpzlfZzNRsSnUBBpAYTNQlkxENGYMWx6XQIFyGGwsGOEgCR3yDHVEsVr6+nVC
 0rK8HEv/R0ARiYmX/CI33vUEakgZLzvjF2kMhrwYQcjEvsJ0gc+ews8XFkBUm9KcGPZb
 VXMBbiwM4l6tyWVX3KykJCbJ+uHVfDlCgFTfQUffomiRAEmuc5EnRqBGfs15izF5yz9N
 mW/e/ZpHXC7m33598hwkIFUNS1yClyDDYAvCdLTAFzOMMMNpQeJkKtk4/m8Ay6HAT/Vo
 GudwsLQQWlwOnyrGXtbSut7LZzZWKJ2G3yq1eAk/AfUn0a5GZSs6m7O3YQWQkz1BoVwv
 Gc0g==
X-Gm-Message-State: AOAM532uZR/tfld/ELAwwUD/CKavpnXESo2M4/LQgxhLCzwQ0U/qoZ/L
 NiwGXErPnBx1jOdd+XxYMPA=
X-Google-Smtp-Source: ABdhPJyfRXcJMYQfm/T0Xmp6DW40AVrN8t6gvbYC575ZZz3IPPUDF/qI9Epa4K9hd3rOOQQW3cNbmw==
X-Received: by 2002:a05:6000:12c3:b0:203:e0e0:7d18 with SMTP id
 l3-20020a05600012c300b00203e0e07d18mr28850582wrx.46.1648539972774; 
 Tue, 29 Mar 2022 00:46:12 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 p30-20020a05600c1d9e00b0038cc9d6ff0bsm1527133wms.33.2022.03.29.00.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Mar 2022 00:46:12 -0700 (PDT)
Message-ID: <15f24dcd-9a62-8bab-271c-baa9cc693d8d@grimberg.me>
Date: Tue, 29 Mar 2022 10:46:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the congestion-control
Content-Language: en-US
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
References: <20220311103414.8255-1-sunmingbao@tom.com>
 <20220311103414.8255-2-sunmingbao@tom.com>
 <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
 <20220325201123.00002f28@tom.com>
 <b7b5106a-9c0d-db49-00ab-234756955de8@grimberg.me>
 <20220329104806.00000126@tom.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220329104806.00000126@tom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220329_004617_881152_7EFF1A89 
X-CRM114-Status: GOOD (  26.54  )
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


>> As I said, TCP can be tuned in various ways, congestion being just one
>> of them. I'm sure you can find a workload where rmem/wmem will make
>> a difference.
> 
> agree.
> but the difference for the knob of rmem/wmem is:
> we could enlarge rmem/wmem for NVMe/TCP via sysctl,
> and it would not bring downside to any other sockets whose
> rmem/wmem are not explicitly specified.

It can most certainly affect them, positively or negatively, depends
on the use-case.

>> In addition, based on my knowledge, application specific TCP level
>> tuning (like congestion) is not really a common thing to do. So why in
>> nvme-tcp?
>>
>> So to me at least, it is not clear why we should add it to the driver.
> 
> As mentioned in the commit message, though we can specify the
> congestion-control of NVMe_over_TCP via sysctl or writing
> '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets on
> the same host that have not been explicitly assigned the
> congestion-control, thus bringing potential impaction on their
> performance.
> 
> For example:
> 
> A server in a data-center with the following 2 NICs:
> 
>      - NIC_fron-end, for interacting with clients through WAN
>        (high latency, ms-level)
> 
>      - NIC_back-end, for interacting with NVMe/TCP target through LAN
>        (low latency, ECN-enabled, ideal for dctcp)
> 
> This server interacts with clients (handling requests) via the fron-end
> network and accesses the NVMe/TCP storage via the back-end network.
> This is a normal use case, right?
> 
> For the client devices, we can’t determine their congestion-control.
> But normally it’s cubic by default (per the CONFIG_DEFAULT_TCP_CONG).
> So if we change the default congestion control on the server to dctcp
> on behalf of the NVMe/TCP traffic of the LAN side, it could at the
> same time change the congestion-control of the front-end sockets
> to dctcp while the congestion-control of the client-side is cubic.
> So this is an unexpected scenario.
> 
> In addition, distributed storage products like the following also have
> the above problem:
> 
>      - The product consists of a cluster of servers.
> 
>      - Each server serves clients via its front-end NIC
>       (WAN, high latency).
> 
>      - All servers interact with each other via NVMe/TCP via back-end NIC
>       (LAN, low latency, ECN-enabled, ideal for dctcp).

Separate networks are still not application (nvme-tcp) specific and as
mentioned, we have a way to control that. IMO, this still does not
qualify as solid justification to add this to nvme-tcp.

What do others think?

