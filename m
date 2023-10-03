Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602F9E75435
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VNWfI8fwAB3JcjQBeTCGGcvRiz4Ua5Bni+0UwiUdJ6w=; b=W9x8CkeezImFffJBEsbtIoJlGt
	lbn2nrk228ADST98RfWT+wgHGYkXHb2YHYn6oXAgpeoVVMWPaWRXIyUDLkfWu1PQqo0T5qfqTD2Cy
	livEfnnNxo5gUoLCpRw8gkVCqyve3ls9MYEXMhfheGv+Gn1m9BAMCruma3T8cnzqk9xJ8j+JOsbPo
	RGMCVJ5yzce1hVYdZFeSoE+lTEUkrBfKVcE6r8lp5uD6x3bPWLA1qcCmhs4Tpx6Maku1MbZCsDGH2
	HYB2VIpGABj4Tc+uGfux0fKGKx9cDjNWNQ96R7Hkw1fxg6mzPBofJLdpysAGnOukBkV3MLG5dgGLV
	PL+5qWpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnalw-00E9AG-2a;
	Tue, 03 Oct 2023 08:28:52 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnalt-00E99v-2n
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 08:28:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40651b22977so1306155e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 03 Oct 2023 01:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321728; x=1696926528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNWfI8fwAB3JcjQBeTCGGcvRiz4Ua5Bni+0UwiUdJ6w=;
        b=merMxuwyG6dDRL5jfAZ60GAfdGvaR4HLQ9PIMWeYWkqoalu+ZI9IzDzfVeRnkqmxl5
         SduUesR5fPVTw9Kg6RWUvXH1ZVQI9lJPqCULHZVK9hvqCWrC9CwsoLn/FjxJOmGj4LYP
         SKNcI4kfI4Sfts4DRq8DQBQ3MnmLWT/hIunjSnmB3Ft13lCTEHc3WZnEsLS/TJyy+4sN
         QY7CYN9NBT9iejKp0vfetac/Y7EdUweh8TbzFR2nRKtgNBnlXXh5t2LX5qNo6pB8QyIt
         ysSbfhZBWuOTXEn7vTFcuONpwn8v72hN2EFLC6NxKotXyqAjCRpeAujESDFi19G7VR6w
         wY9A==
X-Gm-Message-State: AOJu0Yxa85/n0amRIrwUZ0md+Ry2i4qCh9r4nvVLFCXD+PHe9eglmNzO
	xGdDetCfaHvPlxqlRl71gOo=
X-Google-Smtp-Source: AGHT+IGSDs2Q/07BUPlINdmmjR12yFtNzh0ED2tcJciTtjDASEbpEj213cG9+jUDGKgWvLqx8cWF1g==
X-Received: by 2002:a05:600c:3b15:b0:403:334:fb0d with SMTP id m21-20020a05600c3b1500b004030334fb0dmr13050769wms.4.1696321727449;
        Tue, 03 Oct 2023 01:28:47 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm8863788wmb.27.2023.10.03.01.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:28:46 -0700 (PDT)
Message-ID: <c762dc98-2219-2c46-eb5f-f56e90873d75@grimberg.me>
Date: Tue, 3 Oct 2023 11:28:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-tcp: Fix a possible UAF in queue intialization
 setup
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "zahavi.alon@gmail.com" <zahavi.alon@gmail.com>
References: <20231002105428.226515-1-sagi@grimberg.me>
 <eea851f6-5c51-1a97-3553-da903fa6c522@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <eea851f6-5c51-1a97-3553-da903fa6c522@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_012849_906904_7403FB0A 
X-CRM114-Status: GOOD (  16.28  )
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


>>   From Alon:
>> "Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
>> a malicious user can cause a UAF and a double free, which may lead to
>> RCE (may also lead to an LPE in case the attacker already has local
>> privileges)."
>>
>> Hence, when a queue initialization fails after the ahash requests are
>> allocated, it is guaranteed that the queue removal async work will be
>> called, hence leave the deallocation to the queue removal.
>>
>> Also, be extra careful not to continue processing the socket, so set
>> queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.
>>
>> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
> 
> Prior to this patch nvmet_tcp_free_crypto has only two callers [1],
> does it makes sense to in-line nvmet_tcp_free_crypto() in only
> remaining caller nvmet_tcp_release_queue_work() ?

Its also the opposite of nvmet_tcp_alloc_crypto. Possible to fold both
but I think its also fine to keep.

> 
> Irrespective of that looks good to me.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks

