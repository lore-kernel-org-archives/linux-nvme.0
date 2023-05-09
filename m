Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED0C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5iazqQN9HoraG3YLEHhwlEl6ClzFiLIpRdCNg4pVmE=; b=EgYsYm58rZplGtCyfk1RA/NHpo
	eVu/ondMRzjJVgduhqBGXx5EDl82tc8/CT3gvybqGT14Ns78DWGF6p6iTPJI/AhXFW61+/SZrUXEC
	RFOYOiFFes0kVyfUc37GJ8mYHDP7LhXfWKh1IU4Fh1jj4J6QgcvVKPdpk51zAfIEkrAjb6imZAIRZ
	MDLEZbRTFeM7PW+CmDpXX+kOk3N7h7wF2HWmdap7YSHgo9NtT+gvuNAdbE9sc+H0TTdPks3k3Ks/t
	/x3UXMlezzzffQ7I8GIj8euzS9DCREklMqG6PmPzXas41hn39wLcJ5SeCMrwXiPor1z7mf/csOQ9M
	7rCTmFoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWj5-004VWg-0J;
	Tue, 09 May 2023 23:26:35 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWj2-004VVs-1V
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:26:33 +0000
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-51f64817809so867003a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 16:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683674790; x=1686266790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5iazqQN9HoraG3YLEHhwlEl6ClzFiLIpRdCNg4pVmE=;
        b=gcsk+87h0h1I6tND5QbAGSKvGDRrM2gkr1p1MKUGCBzeWXvziRRuSzN/C04VZQSsfz
         5X+8KgAox91mi2fvyE6Q6vx9jlStB5Z0XKOyF+togJjuKAonWxKiOyGIaQblvape2CrM
         mfR7tVruCXJ7/bdCYcApbIwEyS2B+twbHchZRsm9xeCykbUO6JVvmurQB/0uUMFjwA+J
         +frIm0zICq3nBGWPyW3i+gpgTpZHRfsSRSjTtV2vrKnRKHGpE9DuaaOmyHTQ0PhNuGJ8
         CZ72348K5+oXRugJzM7DbPmes/ZxfCnoJbw21uJ3nnMUkwbPVVAKA0xRH/MngcA6zhCb
         1cRA==
X-Gm-Message-State: AC+VfDyeBZbjl9qaqsItnqjfJnqeMOofJN532XPMfpRKjHidb6NIChrx
	JE0LITUz8dviXQTqN6eR1u0=
X-Google-Smtp-Source: ACHHUZ7tH0bP+Sv0xTjJGKv5j5SjyOZVR6bK/nYA3IIyUS0sE4E457INUkr+trQZolg8mIFHJTjGhg==
X-Received: by 2002:a17:902:e843:b0:1a9:6467:aa8d with SMTP id t3-20020a170902e84300b001a96467aa8dmr19949892plg.1.1683674790446;
        Tue, 09 May 2023 16:26:30 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:c6ee:a400:39c6:2a73? ([2001:4958:15a0:30:c6ee:a400:39c6:2a73])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b001ab1d5726dcsm2173189pll.243.2023.05.09.16.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 16:26:30 -0700 (PDT)
Message-ID: <3beaef07-66e9-e27a-9499-5592b41e7a1b@grimberg.me>
Date: Tue, 9 May 2023 16:26:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Max Gurtovoy <maxg@mellanox.com>, Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
 <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_162632_500563_97183940 
X-CRM114-Status: GOOD (  12.61  )
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


>> Can we fix the lockdep not to get confused
> 
> Lockdep uses static keys by default. Associating a single static key 
> with multiple synchronization object instances can cause false 
> positives. This is why I introduced support for dynamic keys in lockdep 
> about four years ago. I don't think that it is possible to make dynamic 
> keys the default without changing all synchronization primitives.
> 
>> or ignore it if its not a real issue ?
> 
> Most lockdep reports indicate a real problem so every lockdep report 
> should be reviewed. Having to review false positive complaints every 
> time blocktests is run is tedious. I think it is much better to suppress 
> false positive complaints (in a safe way) rather than asking everyone 
> who runs blktests to review all false positive lockdep complaints every 
> time blktests is run.

Agree, shutting up just this complaint would be great. This looks
perfectly fine to me.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

