Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE0EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pyIdYTdUZwKmyF7GRjFGTDPirurocFZ70YWrVGnMIrs=; b=Q0rru9fhSZO5+1QU9qrhiW/00+
	1NfjfhjlZYT3seOOsPgppuyhUz+DnfQhoV0jzH1a3IkJ1sxS6B2Eov5miDuhezmJF/yRgfbuTbIIx
	ntW6MRFxczIc5fB/UdQNYnPTXOllQ0CkPZNpkzjNbpit8ogs+jCuY0Ojs7YtK2BdhmchtnplyNdeZ
	SMjJdj2j7YeMkFSRoWsSxmNKm+W7m0Kfj2kxSZ/KGIZ5lSBN6IX0aaY5NpMFz8LH/mrNClr6RMsDC
	zWD9RBtRm2eU8xMQ295RTUp1GekjrwAIN7IvYaDSCeVBwXEcQamdqyq3Wcp6xKrQikoX4qlXe/nQK
	Lh6df1cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoOk-00AjEY-DJ; Wed, 25 May 2022 10:37:50 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntoOg-00AjDU-Vb
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 10:37:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id 206-20020a1c02d7000000b00397345f2c6fso413524wmc.4
        for <linux-nvme@lists.infradead.org>; Wed, 25 May 2022 03:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pyIdYTdUZwKmyF7GRjFGTDPirurocFZ70YWrVGnMIrs=;
        b=qPaMUgcvsCjIJHjDAw6RGzrl4rmGtwl38YPHa5WPx9WXedDL6ih9QcMZuIulJC32Ca
         NU2GUwQ4XFunD4dTmr1FWayMWwDV++gqAxfxqd0OSJXgU63hKCFj3/ftS63Yu5j7LV0l
         7hFeo913TLmRB0ZOpr7qxun/PD43dp32gRydeGg7MT9aEzQEbFtZ4EQDZKuPY/jWfzW6
         Tt+MHwzQYo6a+cR0U3tplhLLjPanR6N0iKWLMr7SmAhyMxMl3muU9qfsWtcqkojFxRHF
         g4TcncALHie4/1Y+pUf0IHLwtlVKUrh2zdnXFFVgz9gsucXR/0fNO7PkFg99yoizGULG
         05Og==
X-Gm-Message-State: AOAM530sJ7vPKv74u6pVnvzin2uTRoHJLFUJs7WmNAAGdO/mYPTfhnKV
	j5/8iiOGaVn303nvmzjrLGo=
X-Google-Smtp-Source: ABdhPJyBT7m/jA8uuy6Utfj+LkQCQBC1BaCndTfi4ilJDfEx94eJyf1CeGHxZqCr96UDZmI3HQeyVA==
X-Received: by 2002:a05:600c:d4:b0:397:5dfa:d16c with SMTP id u20-20020a05600c00d400b003975dfad16cmr6206158wmm.182.1653475062905;
        Wed, 25 May 2022 03:37:42 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003974cb37a94sm1509002wmq.22.2022.05.25.03.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:37:42 -0700 (PDT)
Message-ID: <8dd97d9c-f241-9ce8-2aea-a703cbda25b1@grimberg.me>
Date: Wed, 25 May 2022 13:37:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20220518112234.24264-1-hare@suse.de>
 <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_033747_067715_2B8FCE83 
X-CRM114-Status: GOOD (  18.73  )
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


>> Hi all,
>>
>> recent updates to the NVMe spec have added definitions for in-band
>> authentication, and seeing that it provides some real benefit
>> especially for NVMe-TCP here's an attempt to implement it.
>>
>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>> to provide us with a FFDHE implementation; I've updated the patchset
>> to use the ephemeral key generation provided there.
>>
>> Note that this is just for in-band authentication. Secure
>> concatenation (ie starting TLS with the negotiated parameters)
>> requires a TLS handshake, which the in-kernel TLS implementation
>> does not provide. This is being worked on with a different patchset
>> which is still WIP.
>>
>> The nvme-cli support has already been merged; please use the latest
>> nvme-cli git repository to build the most recent version.
>>
>> A copy of this patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>> branch auth.v12
>>
>> It is being cut against the latest master branch from Linus.
>>
>> As usual, comments and reviews are welcome.
>>
> How do we proceed here?
> This has been lingering for quite some time now, without any real 
> progress. Despite everyone agreeing that we would need to have it.
> Anything which is missing from my side?
> Any other obstacles?

I've been through it a number of times during the iterations, I feel
comfortable with it. I'd be more comfortable to get a second review
at least on this code.

But regardless, for the patches where it is missing:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

