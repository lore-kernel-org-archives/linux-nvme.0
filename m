Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35EEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDF226U8s20wd6YP8ikmSWH6z2gzB09wST2WRKhovQI=; b=yZkuX2/WWXqb5xg4xP621fK0VK
	gqqL+uzd1wTtvQfr4XD5xWAHY5gWYrv50mLrGtTqWrd+c1b49WgJA+6gzWImd3WNH4EITyHi93d62
	i3Llcqf4sXvEDeyjcE1DfTQ6a+gxg1rQVlQ2GqaQGWKmOZAtEYWKvSopqe0owg9Nslhn6FYQ6tqr+
	fcdzorACo87WtHeXkiecmWZrSk3GQ9zJnSp0nUBbhJAAP2Zple/Edv8Jpj6NdyI9sfMFx0RLy5QeS
	jord0f0mJR105j8rwFk3xCFVmrfTm5W9/s3di3aabiDGTXs6kveayVWijwoU0JxlmxiG+Px+uolf0
	PDpQAEDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVcsl-000B8C-2v;
	Mon, 14 Aug 2023 19:05:39 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVcsj-000B5i-10
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 19:05:38 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bded9d93dso102284366b.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 12:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039934; x=1692644734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDF226U8s20wd6YP8ikmSWH6z2gzB09wST2WRKhovQI=;
        b=Xoha5FkpOM/Hzi5CKojtJPPJdxhCE6RWFdZRBPbfasdXoTOabge6L1w81KIMbR+ixq
         0yZBi0tkPsXvAoBEdj14cZ86h4Z7jwQ9NBUsczCFvG/OGrh2p2rLqZMS05e9QH/d3aO6
         Oy7sUDBVMS04tAb4ZXnCgmzuEXI2Zb+PS5Ak3o/NfcvkXh7/YNGqC/31ym1YmAg1zQ5Q
         mb9uUlq06gHcdOnBqDm1pIeEVQ7jkSAF4HMpH9BVx1CB4hQLVsjW+zCiEdMswW0LAr9A
         NAiAD+IuDsD5ySM5OqUsuWvI9Ei9Hpfs4LBxtYnZP/Nvq8hZIbSaWonRG/8YUQhM8n7a
         fdew==
X-Gm-Message-State: AOJu0YwEXPDhD5IXOFq0Vzt2nYlW5kvRV8Flav2E96n1KfgjZ5eYymaB
	60n5t/3mveUX/Yg2+4KUpyA=
X-Google-Smtp-Source: AGHT+IFshae9uLDqcs3fwT3y7Y9Y0Q99ktIq4atrQ1uA+SbbrnZrfL2r3M0L0wS54JnFHSmVpifWrA==
X-Received: by 2002:a17:906:1041:b0:99c:5711:da5 with SMTP id j1-20020a170906104100b0099c57110da5mr7729118ejj.5.1692039933918;
        Mon, 14 Aug 2023 12:05:33 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906671100b0099bd8c1f67esm5955053ejp.109.2023.08.14.12.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:05:33 -0700 (PDT)
Message-ID: <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
Date: Mon, 14 Aug 2023 22:05:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
 <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
 <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_120537_347914_8FA6090A 
X-CRM114-Status: GOOD (  14.14  )
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



On 8/14/23 16:18, Hannes Reinecke wrote:
> On 8/14/23 14:11, Sagi Grimberg wrote:
>>
>>> Incoming connection might be either 'normal' NVMe-TCP connections
>>> starting with icreq or TLS handshakes. To ensure that 'normal'
>>> connections can still be handled we need to peek the first packet
>>> and only start TLS handshake if it's not an icreq.
>>
>> That depends if we want to do that.
>> Why should we let so called normal connections if tls1.3 is
>> enabled?
> 
> Because of the TREQ setting.
> TREQ can be 'not specified, 'required', or 'not required'.
> Consequently when TSAS is set to 'tls1.3', and TREQ to 'not required' 
> the initiator can choose whether he wants to do TLS.
> 
> And we don't need this weird 'select TREQ required' when TLS is active;
> never particularly liked that one.

The guideline should be that treq 'not required' should be the explicit
setting in tls and not the other way around. We should be strict by
default and permissive only if the user explicitly chose it, and log
a warning in the log.

