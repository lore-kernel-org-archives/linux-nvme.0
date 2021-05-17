Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C764C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:59:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA02C6117A
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA02C6117A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P3upSKCoNPjTIh5dF80I2VFabVXAlAHlUDIcQpxVaHY=; b=GWAZUGkhgmG6p5ut0SrnYiURV
	yzlLQqqQVexkWJ5HS4wr/gzis/+kdQzFIFBf+OjwSMmv+lkuFyKrntjkkdBezpTV+34YwJ7KEAwoM
	xgVc2Cg6qphPoLcnILAWX5c7IKOxREgoz+5GQ/PWXImIbRr2uHXfhl6mWP+G9UVZDeb6R8boB25sU
	ocF3+KfMqb5s0AmDQdeYhfahrui/AbjDxFwMdmMAU+7aVgp+5p1R9NWYbvJxRwT3FWzygriKO11Wu
	+d8+6PPvUd+6eaeIQcGno5mhh0MImLQHMmdCzxF5O97BZReZacqo8/ntzJWW1rjbs6BybJt4dPBWF
	Ww/9GExcw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihVu-00Fjix-UH; Mon, 17 May 2021 17:58:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihVs-00Fjii-GR
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 17:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qbBAcmKfJzceLa2JUtS5m1ONNW0fcDzUMERu3V2lMjA=; b=NpinAor/4ipioMKNQRN15ishA8
 e65GRq1wXkkfes1A7Kp/Juu/Nhc02wz2nOZPWFTFw15YbP5TO1aaudzEVfYunAleT+U3oKNhPtLP7
 C+pdFbbRgSD87X+wxbPBNZLFPyPoSlPvvXjqgS+gSdKrg++E4UuYyc6j9C20uGAguwEUVYmmhEYHq
 4ZP47KGkd41h1Wj8Jx3V1mW4qGUdqxo7ki3g1OB2U9HVCxXsa/uc52VSa6E97RQUIP7VJ5BpE+e3W
 ZunL8KQzo4xlqdAmNcTqscAYS56uUJVVikpGPIf+WW5ykU8ogFsjRM9UFBtcyto/7Z4B5ptCtynmN
 1ZPatggA==;
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihVp-00E2J6-59
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 17:58:42 +0000
Received: by mail-pg1-f179.google.com with SMTP id f22so4229283pgb.9
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 10:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbBAcmKfJzceLa2JUtS5m1ONNW0fcDzUMERu3V2lMjA=;
 b=afCMNueF09cB7GvgJ6jRSbvg9A6FHGViyubSuqYCiFTKMI4NiARS6mOGKmKdp55ts4
 BvW03kBiD7NU4Hha24qVz4Z+iN5qbFNAva7/IMhdIJdCb7dzc6L4zQqiexDw3xaeuWgR
 JE+CNdQUwYD4aHUwHLyd23MFC2m8VWLVk/7SJChQN8QCMS/OEFc7V0O4muGdW+cFhdGU
 6P4B9OTnPqw8Brx0k6V22A0PmYlaJZfDZ4ieZnZA1hmLje8ReW8jwuenXqMO2Crze56O
 Hs0hhH/taSUtfkz/et4vwSeGoXwTHj+4FmPsN2CEk3ZbozD6gvx1JsVqBVsJ04BE4DWE
 g3Hw==
X-Gm-Message-State: AOAM533G6icpU6FZrezc52Iu1EIpSHQpYnegW9u9AEN+U2Y8kCPFmpwY
 bVwmnsR5xbc4ZAh7i9WgET2o7jwWMrc=
X-Google-Smtp-Source: ABdhPJyZQreiVOH1jYkD13pE2yVFK0XeUjCB3ZScoE9Jx91GSY6IDTtiZjAbNML+vG2fMNcFmgp/BA==
X-Received: by 2002:a65:68d8:: with SMTP id k24mr732872pgt.242.1621274319871; 
 Mon, 17 May 2021 10:58:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id p65sm6209376pfb.62.2021.05.17.10.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 10:58:39 -0700 (PDT)
Subject: Re: [PATCHv4] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210517081809.104813-1-hare@suse.de>
 <20210517152601.GA2709350@dhcp-10-100-145-180.wdc.com>
 <688618fa-a079-6d84-adf2-01ee36f95d76@suse.de>
 <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4b32451c-2426-c86f-ebc6-9de74e0bbde6@grimberg.me>
Date: Mon, 17 May 2021 10:58:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517154942.GA2709391@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_105841_228413_228F6AE3 
X-CRM114-Status: GOOD (  24.95  )
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


>>> On Mon, May 17, 2021 at 10:18:09AM +0200, Hannes Reinecke wrote:
>>>> We should only remove the ns head from the list of heads per
>>>> subsystem if the reference count drops to zero. Removing it
>>>> at the start of nvme_ns_remove() will prevent us from reattaching
>>>> the namespace to the correct ns head once a path becomes available
>>>> again.
>>>
>>> This looks fine to me
>>>
>>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>>>
>>> There are potential corner cases associated with namespace management
>>> that can cause problems here, but it would certainly be a user error
>>> that needs manual intervention anyway. I suspect those scenarios are
>>> very uncommon too, so I think we can deal with that later if it becomes
>>> a problem.
>>>
>> How so?
>> We're keeping a copy of the NS IDs around, so after reconnect the
>> namespace would have to provide same set of NS IDs.
>>
>> If the namespace is different yet providing the same NS IDs we'll have a
>> problem even with the current code, as we're using the ND ID to identify
>> multipathed namespaces.
>>
>> Or do you have a different scenario in mind?
> 
> Sorry, I didn't mean to imply this creates a new problem. It's already a
> problem. :)
> 
> This just provides a chance for a recycled ID for a newly created
> namespace to attach to an in-use head associated with a previously
> deleted namespace. I am not really concerned about this scenario,
> though, since it wouldn't work today anyway.

That is because we keep the device node around even though it doesn't
have any bottom devices. Which is what I think Hannes tried to fix
in an earlier patch.

Also, if an NVM subsystem happens to recycle nsids, it will trigger
pretty surely. So I'm not sure this is an obscure case...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
