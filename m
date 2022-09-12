Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAFBC6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6Eh5kP61tiLLsvm1MCR4BGA+cVcFydeU7cdfziTsFc=; b=p+mqtqEMTPSggrD1UqF6SNbsTe
	QpYXDkMI2RbGzWgzxIRz8n/k50+9eHPTFXHOI8J3OB2h++2RmbRS09JVfVHcUL/4GiXaoL+TeaofP
	oDyDBN8l0O2dzSP7cj0YKWhQLHjMaL0q9fe/5q+tDicUtuHwZ2uhPc/8ApDWcjwbpH8XKM0z4T6t9
	lKkZ53akCtvwFOmaTkJrmIAWOhwzKLrxbk/ZraSLzob5dOXsaPySWs+1FulsjW4p++lBZ4p15FlxZ
	2n4g51sPXwemfpVWWkU9EJzR2mYf97P5pjdjNxqu61N3mxLwvphVEXULpLC2cFp7t/Gahu4BmnPkt
	3nNk9Hhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXij6-009q5F-Nc; Mon, 12 Sep 2022 12:39:48 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXij3-009q2D-2F
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:39:46 +0000
Received: by mail-wr1-f48.google.com with SMTP id d2so15170063wrn.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=U6Eh5kP61tiLLsvm1MCR4BGA+cVcFydeU7cdfziTsFc=;
        b=fhfSqBjafTktMHvLBfkTdD+1W3fps6i/kApz1YIuihZmpYe0+33Hz8bApbjXUy5S2x
         U9TiJIWb5voDVln7OxJrnK7EQ/BA6Ys41ZWalJ5Ztg3qBbwP16Hq1ith+UFHPMPSiYoc
         YcQ1/01XYdY4bgQPkMrhoek0Sz6+W5NfU7C506hq1Txm2GmGS7hDgbWAYc6zh5UrN0i+
         rlXR1l88tTgux0VP4UR5XNCfiE6GrHdkmfSU5ya3nm3xXHsDHInooEIlqd9lLy/lqkQl
         CI38THAP0WfmYlsc4VD90L6E24Zk5vUigqSw8nTI0GG6Xmh88XiCYbnZtcZEoTUMs2MJ
         ry+Q==
X-Gm-Message-State: ACgBeo2VecqIvykRf25wbId+nWRMUDTPAzoRZdFa0H+IuKgVqVvR1ImG
	BOfeKiB6uBYA1PJ0Ud6Orns=
X-Google-Smtp-Source: AA6agR5q6fdS6fES0OiPPxXI6oXB/JYllIcgQkM6Px7F8+Np6dzQINvrXAj4PG48OZMiIKK8U96tMg==
X-Received: by 2002:a5d:64c4:0:b0:228:e143:ddb8 with SMTP id f4-20020a5d64c4000000b00228e143ddb8mr14474253wri.148.1662986382543;
        Mon, 12 Sep 2022 05:39:42 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b002285f73f11dsm8965122wrq.81.2022.09.12.05.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:39:42 -0700 (PDT)
Message-ID: <403e19c8-fec9-2d5c-157c-cdcb4fc2fbf0@grimberg.me>
Date: Mon, 12 Sep 2022 15:39:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc 0/1] Fix missing AENs when discovery controllers are
 disconnected
Content-Language: en-US
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Belanger <nitram_67@hotmail.com>, Hannes Reinecke <hare@suse.de>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9eb798de-149d-a56d-ac00-dd6b7ae79a81@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_053945_159062_30782E38 
X-CRM114-Status: GOOD (  20.53  )
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

>> When a discovery controller is disconnected, no AENs will
>> arrive to notify the host about discovery log-page changes.
>>
>> This attempts to fix it with a new connection parameter asking
>> the kernel to send a dedicated udev event for this case. Prior
>> attempt tried to use "connected" event already sent by the kernel
>> however this also applied on the first connected, causing undesired
>> side-effects when issuing a simple 'discover' command.
>>
>> The patchset includes the nvme-cli/libnvme counter-parts as well.
> 
> Sagi,
> 
> Do we really need another parameter/option ?  seems awkward to need 
> userspace to figure it out.

It has a rather specific use though..

I was looking for something more fine-grained because I initially
used the generic "connected" uevent which had some negative side
effects, so I decided against adding yet another generic "reconnected"
event that nvme-cli would use, and may/may-not fit other use-cases.

I thought its better to have something that is as specific as possible
like "send me an event only when a persistent discovery-controller
reconnects" and I also used the name to indicate the semantic of
the event, so in the future, a possible consumer of this event will
know exactly what it is used for before opting to use it.

> The transport certainly knows the difference between 1st time connect 
> and nth time re-connect - perhaps this should be a simple flag on the 
> nvme ctrl struct set by the transport ?  Simple thing for rdma/tcp to 
> set flag at end of successful xxx_create_ctrl(), while FC, given it does 
> reconnects w/o a first successful connect needs a little more logic.

I used ctrl->nr_reconnects to decide it, which introduced the constraint
that transports would clear it _after_ calling nvme_start_ctrl(). Open
to better suggestions though...

