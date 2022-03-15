Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B766C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dD/BjmkuNx6yrh/kaWsIOKSDZahcbVrvnkj9RQWRSog=; b=McpQixSyw3DGXywmiPHUV66wAo
	MLa7uQ+fLIn18b6qXFcbJXJxUZgohGQMXrTA6dHFKO/jG6MHR3YN1tQY2+TOpWIeiZ+UWulucdzo2
	bOR5IIA36pQaPc8g6idzhV9YepYWiglF7pDTAu694tMI00EkCg/x0ZLEoItpUXN/jRZx+NKFJ4rv8
	M1QTYpnNj2FgCoPF6VFB46pFT51rE8qfTEn2IvEYjOPSGYx1oC81NfqOWk+Gc639+HFRGkd34MkL5
	p/WraOQ7LCh83ZdqAcaBaoRgUuq2cgQ3vHYHElqaVxpKcshLhBcugr+Mo8HI7Hp3DC6ZHB3Yk9QWP
	tlDuyF8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2jL-008JOg-0B; Tue, 15 Mar 2022 08:40:35 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2jI-008JO0-8P
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:40:33 +0000
Received: by mail-wr1-f45.google.com with SMTP id x15so27710990wru.13
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 01:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=dD/BjmkuNx6yrh/kaWsIOKSDZahcbVrvnkj9RQWRSog=;
 b=Aosd+1W8T3Iv1vkpzYx6ac8VC5ZnbE6v74iTNKJI/jBwVg2GKjDHoxFwrz8dkk6pL2
 VDCJRkPbyp7WJXIa7dOn6/f2NaQEbupNc81tfgjud4x5OkNqWNpi0acy14HsM1fup1vC
 3MMUlPFMwWtNuNr1muVbarU2KKgtgvOM2iW4LY/pKye8TwNT2K2UJ7RtEWpmxBp7WDZK
 nIl1Lh/+mF4t9Pqe97NHPfhjE6qFQo8eNYMsjnbyLNDQdkycLt0xK8FEZlY5+H4ot60J
 B7cnKQgCk4rKjbTXuxN36rAhdlMdglhHJxt3vtGganjbgZdVDHVEUh/NnZqx1LUy84bP
 YDNg==
X-Gm-Message-State: AOAM532iTfO7pu1QvwLEGyVqhap/O11SANJP3ytkYO8WqxgGnky20/ax
 q3d6sCbCQ22S3VaYtvJ7A0XfB2eWcbw=
X-Google-Smtp-Source: ABdhPJx7gpT3LKgdEh9YzflQ5g7A2+oKWUi5mEevCBSO+55vshV7gcUSUURTps4uINsmAQVc534EdQ==
X-Received: by 2002:a5d:6d52:0:b0:1f0:73eb:23b9 with SMTP id
 k18-20020a5d6d52000000b001f073eb23b9mr19147320wri.649.1647333630368; 
 Tue, 15 Mar 2022 01:40:30 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 h13-20020adff18d000000b001f1de9f930esm24895177wro.81.2022.03.15.01.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 01:40:30 -0700 (PDT)
Message-ID: <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
Date: Tue, 15 Mar 2022 10:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315080602.GA3082@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_014032_338388_FE9C27F8 
X-CRM114-Status: GOOD (  10.36  )
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


>> Expose the discovery subsystem in sysfs instead of having it as
>> an internal structure. This requires the admin to manually
>> enable the discovery subsystem by linking it to a port, but
>> this can be seen as a feature as it will allows us to expose
>> subsystems without discovery subsystems and discovery subsystems
>> with no I/O subsystems.
> 
> ... and completely breaks any existing setup.

Yes, this needs to be backward compatible...

