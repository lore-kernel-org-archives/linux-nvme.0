Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D1C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:21:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DC260EE3
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 14:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39DC260EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/WuXnMwq8zg2ThBDocQx2H+CTOTc3G5LZYhnsR94qA=; b=oosP38joGR/DSHNpYiHp9ldaTS
	K0c906nD689J9h/jOB4tuep9xxzQII/xB4Rav5KaQkp/dDc/97aVCfGkOnp215nc82j0ZeLq7gaij
	2QWlIbGjgQVsSiuBq67etmbuEvHtGQkdCYFg5OXyvvbjTVfuUjQNCiJxt7VwQnh/P1gqiWC+6MVAR
	QzHUjoC64S7UxxT22qj6vGCOtgxeHBm8NFmf5eBL1q+1GqVguPo0s2AC3u8Juq79MMxa8T/RMVBQi
	sgSZeae//0l0qsvWeP+W2OYUXmf44t/13Z0flhVgPpINWM7IU9L4+e5hcgYge6f8XWrCI/8mDwFkA
	YoHQgQ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ9Is-005z4z-9q; Tue, 14 Sep 2021 14:20:54 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ9Iq-005z4e-3B
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 14:20:53 +0000
Received: by mail-ej1-f42.google.com with SMTP id kt8so29290545ejb.13
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 07:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XGnqHlTada8kt7JMhcSG+hhKlGg+XdQqdPMlXWGpXXk=;
 b=gGMndlZLBR4jeJ4lcdjN6kaUZA3H1+OMUGeObpLTYZHo+24EmpA9qpDgeo2YeYXWs0
 w4T5ZwVkvRUlxHFislTG6qoNsOO3Ozj0DQmOt3YPYa8FAXL0KCG7XckArAtl9GrL4hOo
 yjKQXll0m2FYB7oFcjhBFmxPkaR0rUWod3BtyQyrKFQgwanOum3qG4dOreVPiLRcw88M
 F1Lmomxg3DPzzNuVyggUQoGu3HCsXMKC3Aw84gl0lLIcZzHTRuPdqrl+a8Us6NOxr7BF
 nLptdV2tmDPLizHqlwlf98PIw3Hx/vgCdYmHmVStf/LNHHXvD+xdzbXQM35n/YwyKG05
 s5iA==
X-Gm-Message-State: AOAM532D6BXGwxW+8C8xo2ZVY6kH0zabVjCaEOoihZm0qC+vUlxphE7t
 FWxpd4jo/tGyfs+Q28GYg3o=
X-Google-Smtp-Source: ABdhPJxDbmedGBT9r9JVf+HeI3wIhKhIVhW8I7W0RqxIT+ZyOY5isY7jp3mSeNz41l/EqPc/TJjXBg==
X-Received: by 2002:a17:906:12c8:: with SMTP id
 l8mr18656289ejb.515.1631629248403; 
 Tue, 14 Sep 2021 07:20:48 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id h10sm5004262ede.28.2021.09.14.07.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 07:20:47 -0700 (PDT)
Subject: Re: [RFC v1] nvme-tcp: enable linger socket option on shutdown
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20210903121757.140357-1-dwagner@suse.de>
 <YTXKHOfnuf+urV1D@infradead.org> <20210914084613.75qykjxweh66mdpx@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a79bf503-b1d5-8d18-5f02-c63e665e2e07@grimberg.me>
Date: Tue, 14 Sep 2021 17:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914084613.75qykjxweh66mdpx@carbon>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_072052_197371_A6CE6045 
X-CRM114-Status: GOOD (  19.32  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> When the no linger is set, the networking stack sends FIN followed by
>>> RST immediately when shutting down the socket. By enabling linger when
>>> shutting down we have a proper shutdown sequence on the wire.
>>>
>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>> ---
>>> The current shutdown sequence on the wire is a bit harsh and
>>> doesn't let the remote host to react. I suppose we should
>>> introduce a short (how long?) linger pause when shutting down
>>> the connection. Thoughs?
>>
>> Why?  I'm not really a TCP expert, but why is this different from
>> say iSCSI or NBD?
> 
> I am also no TCP expert. Adding netdev to Cc.
> 
> During testing the nvme-tcp subsystem by one of our partners we observed
> this. Maybe this is perfectly fine. Just as I said it looks a bit weird
> that a proper shutdown of the connection a RST is send out right after
> the FIN.

The point here is that when we close the connection we may have inflight
requests that we already failed to upper layers and we don't want them
to get through as we proceed to error handling. This is why we want the
socket to go away asap.

> No idea how iSCSI or NBD handles this. I'll check.

iSCSI does the same thing in essence (with a minor variation because in
iscsi we have a logout message which we don't have in nvme).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
