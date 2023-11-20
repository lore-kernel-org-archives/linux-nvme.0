Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF008C2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5KPw33DUnloSXmLKhxzWQDAiWR982hvErweR1UOOOM=; b=NQYUSIYKBjRoxRh5f2mNQuJAi4
	GWLW53AId+ZY52kWO8fmOqkmAm5XTDwpH7reQ3cQbOsURYTotN0lHDyCY5tZ4rHDgaPQhZ4PAahwN
	1DnMFtvZXHESE12gn+Vy0f7IZkGCEq5dNYABtv491utGqGiPq98bViaQxYtSbRYoddlKum+3xT+mY
	See6XTz90/qPcomdpu0hi2wUnXC7vlJ8Qu3w3Hz1ymx/jFTXSVpYAESVwYjpCHfVjl2ux3y0QgQ9E
	rAqlhkAYoemTboP7JdzQMM11u1a7vl8b5AJAiy2OlLXZq+dnfgpPJnXfyvgL7wSa8+CVZcfbVXLFD
	RrMAovvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54dX-00CBH0-03;
	Mon, 20 Nov 2023 13:48:27 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54dC-00CBFZ-1e
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:48:23 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3316db2c5c0so654317f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488083; x=1701092883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5KPw33DUnloSXmLKhxzWQDAiWR982hvErweR1UOOOM=;
        b=foZiyQyoPuskHO2Ifc6YopCihAp3LWYHve/ZJ4kYR2yEDlfSnK2jTHNQ3kw1+sqbi3
         +wR4iQGmpUzffRsv+Q9vjwSMBgMMtZiMKOUwX1yZ1u8pnpByRn5F+mbWLuQQZIelutuw
         AA9SZtj6McGRtg2XR9KtchxtzTMIbzLClluJ5aMiSUcz98T2y7hAnNrKKnxEAsFgh5D4
         Wso3tUMRquQi91J4duSV+MyEK+Q7bUFhQ62Bq7daleO8Gn22Ni8A7cXeuexJqjBFXylk
         N9OHU4FyKwEWhP1UQgn0PfAY4t6ptpmMihgONyKyp6ojVgQRsl4dl4ttF2xzPsY3jrw6
         JFgA==
X-Gm-Message-State: AOJu0YwuxqJAe1sHcPbSWN7klmgMYEoeIV+cqzWMpNGUNxWp+KGf9//E
	pOy5LKEau0SpZ1l/56TjXL8=
X-Google-Smtp-Source: AGHT+IEPOdeVC2NwJX1XEly6rHI7gFb5wPuMX5pgZPUv9HQDv7V0bRjfkCqHcFWFY/qDnH3SzL+03g==
X-Received: by 2002:adf:e242:0:b0:32f:8a45:93a7 with SMTP id bl2-20020adfe242000000b0032f8a4593a7mr5625942wrb.0.1700488082662;
        Mon, 20 Nov 2023 05:48:02 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b0032db430fb9bsm11265176wri.68.2023.11.20.05.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:48:02 -0800 (PST)
Message-ID: <d5ef550d-91da-4135-959d-e10f153514a0@grimberg.me>
Date: Mon, 20 Nov 2023 15:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
 <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
 <20231103091952.GA18200@lst.de>
 <e09869f2-193b-4f03-a12f-2a7f6c24d537@suse.de> <20231103140514.GA2395@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231103140514.GA2395@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_054806_655902_C976F404 
X-CRM114-Status: GOOD (  11.19  )
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


>> According to 777dc82395de ("nvmet-rdma: occasionally flush ongoing
>> controller teardown") this is just for reducing the memory footprint.
>> Wonder if we need to bother, and whether it won't be better to remove
>> the whole thing entirely.
> 
> Well, Sagi added it, so I'll let him chime in on the usefulness.

While I don't like having nvmet arbitrarily replying busy and instead
have lockdep simply just accept that its not a deadlock here, but we can
simply just sidetrack it as proposed I guess.

But Hannes, this is on the other extreme.. Now every connect that nvmet
gets, if there is even a single queue that is disconnecting (global
scope), then the host is denied. Lets give it a sane backlog.
We use rdma_listen backlog of 128, so maybe stick with this magic
number... This way we are busy only if more than 128 queues are tearing
down to prevent the memory footprint from exploding, and hopefully it is
rare enough that the normal host does not see an arbitrary busy
rejection.

Same comment for nvmet-tcp.

