Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31179C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enjxRNkKuZiWZ2RiN4WqGso5DfY7oIJ6tL/Jqqxp350=; b=umrPEKThGm0W5fsQrsGIJfUrii
	YUVjz17+gj82VUP4RZHYdx7VCsA6Yfu/RoIs55wvA0MM8epAlVOkHpUwH/PSPqCK9RXph6/rYoxVS
	XHiob6U2oypDqHAiDKlLTGEkWiYMfYFS3zq6SGZiCKo8yfa4/T6dtG8nf5FZdhbDV4TJOVxS0U1UA
	C2zFopZZRk8LUE2mZKW/y3YWuVOd4l23jpUPv/eFUix0aeoiA/XASLEUYmDBjP8uTGaQDz5jTOHcU
	STkRc8CpTaReH/w3w33dwiZcRcV+cSESQkHBPCqivoIIQ+TmMMu+aekNmHc5ZkBXQ8oXo+0GL2fgU
	OFVO0GJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zhO-0000000H8cT-2EgN;
	Sun, 28 Apr 2024 08:15:50 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0zhL-0000000H8bI-18TJ
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 08:15:48 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2db8021275eso8669991fa.3
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 01:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292142; x=1714896942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enjxRNkKuZiWZ2RiN4WqGso5DfY7oIJ6tL/Jqqxp350=;
        b=PWDlEqWkx+lydEf5OlZm6l0LqOQjHWZ3Q/+dPCLjJYFZiwhngju+EY7M0Jy/uOyYCn
         D6S6WW6FspDg/VlgW3+EmBaCy7HhyOjct0WERXJCMtaWm9iR4iff2PUEiot3tBo48xe3
         aVQvcjaezK7B8Z2VFtt7s9Qr22/vwUqoHweWsjNSkc6+y052Rne7qxOYRqgbaPtfjPCn
         2Vbsv4o9VBuA8q14fnuR0v9aRayNECDwF2DTnchkxF+WTLaaZNqfh//y8cK90v2P3jE4
         CkZG1c/DejqhsCo10HRQpK+H6ycBKgHfH3Ivy4GxeJUUpfuWuSIPnM7iGSWJ7NDiy3oQ
         xvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9I1fLDsoqSVzMle83x7WIqOREjyJHTGy+1iPp/zhfhIAjb9YJD30piv9rJyBwjmL/wpRmAovxnTXNFLzEoVKlL0sJnukZD2IOcLACprY=
X-Gm-Message-State: AOJu0Yz8EC1ttL0bDE48srGvXrw5TahHZQe68ahySyvhFD5+NQN9KQHz
	3ci8JJaEcLBXZR0yylaz3SumekxpghLjZZkQ6tjdqUqkpygg3OOC
X-Google-Smtp-Source: AGHT+IGgjtFA6/cgUSNKNIFtaCVcvt+A4VZ8wiDKLn1OldQJe21264nSpXFsT4bzNQX2wDoiLY87SQ==
X-Received: by 2002:a2e:97d4:0:b0:2df:1e3e:27e8 with SMTP id m20-20020a2e97d4000000b002df1e3e27e8mr4050673ljj.0.1714292141883;
        Sun, 28 Apr 2024 01:15:41 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b0041bf21a62bcsm3462222wmb.1.2024.04.28.01.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 01:15:41 -0700 (PDT)
Message-ID: <9a38f4db-bff5-4f0f-ac54-6ac23f748441@grimberg.me>
Date: Sun, 28 Apr 2024 11:15:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
 <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
 <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253o79wr3lh.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_011547_354914_73CC0391 
X-CRM114-Status: GOOD (  13.29  )
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



On 26/04/2024 10:21, Aurelien Aptel wrote:
> Hi Sagi,
>
> Sagi Grimberg <sagi@grimberg.me> writes:
>>> +     config->io_cpu = sk->sk_incoming_cpu;
>>> +     ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);
>> Still don't understand why you need the io_cpu config if you are passing
>> the sk to the driver...
> With our HW we cannot move the offload queues to a different CPU without
> destroying and recreating the offload resources on the new CPU.

This is not simply a steering rule that can be overwritten at any point?

>
> Since the connection is created from a different CPU then the io queue
> thread, we cannot predict which CPU we should create our offload context
> on.
>
> Ideally, io_cpu should be set to nvme_queue->io_cpu or it should be removed
> and the socket should be offloaded from the io thread. What do you
> prefer?

I was simply referring to the fact that you set config->io_cpu from 
sk->sk_incoming_cpu
and then you pass sk (and config) to .sk_add, so why does this 
assignment need to
exist here and not below the interface down at the driver?

