Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osSMTiTK5JcTm65ANnclln3syX/u0g8hVX9jxGl8Z0c=; b=YkgbqE9MbjdkC+2k3LAqdj78gM
	FgkgOLuuq3KU4RxGj/4rMUWhrU9nZpV9V/dT6JYN8PvI+GOJoP8jYPMQxPIXQsKeItLluDTHXKeFh
	3rBbKUI/HBMciAEsVLgEFL9OM9Ygeip0a/liajV3/NTu9BX3uOo38cdQcjx9wNqPqAa49dfSuKzvg
	sVLDWWRoSQoqbUF9QuBfgH4a9tNH09KPbDX20p73+37zHvykyzYRxhh0oZ/Sn0c+4+Twy9oTTNuEG
	d+PVETThgn36WzDSdAvYDR0CZ++VIYtLinoWnyrWnQ6srtPNTV/wKFWOVXcFXfnf/IqImeWpZgvo7
	8xwxoO1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peuRx-00FIt0-25;
	Wed, 22 Mar 2023 09:08:05 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peuRu-00FIs7-2P
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 09:08:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso12541333wmb.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 02:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476081; x=1682068081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osSMTiTK5JcTm65ANnclln3syX/u0g8hVX9jxGl8Z0c=;
        b=20iiKR9pzw+TxmFbjJRKrBy0ea3Db7wFxs9ChLDiKesxbhjegpjbYhllXZluHgTip0
         hv++gz6TN/YPefM42HwZRkGXOqGQz2wJ9Qie6e1OdB/EOvMXpIDoc2SzaTExm+Mw/BCg
         mj71imknqfJqNjtHK+TbEv9EV7I20Rf+ewR15Y+GIviiN/X0d5gVyWa9DXbCVYLggO45
         Ipem9hyzKu7KkxcrmeTsz8uaXlIw2DkKPfZGZEikaJOgJ6ZwDatG6adVh3J1aRHkbDit
         rkUk50DzxVNXiSZaS0W+MZN1/I467Sv7cnbkvrK2mtLsN6jWA5QGnE3S6fkFd9HigFRp
         M6rA==
X-Gm-Message-State: AO0yUKUArUyfjWk73jNlfneX8AcLZMluRhTFI4k196xAGBCAv/jiMxZN
	a2dxVR4a6vDi5NQ2f4jSJWc=
X-Google-Smtp-Source: AK7set/BJVHloXDXBwJxgApyyFD5P7GlJKpMHsZY88SrjAM69OAqx1S+blmDjhgCbmK5gFJK8Mv0BA==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr1993684wms.4.1679476081272;
        Wed, 22 Mar 2023 02:08:01 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003ed2276cd0dsm16148879wmc.38.2023.03.22.02.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:08:01 -0700 (PDT)
Message-ID: <9723a6b3-7673-1f02-938e-12a12e235db1@grimberg.me>
Date: Wed, 22 Mar 2023 11:07:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-2-kbusch@meta.com>
 <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
 <20230322082717.GC22782@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082717.GC22782@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_020802_874086_8946BE6C 
X-CRM114-Status: GOOD (  18.54  )
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


>>>    +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
>>> +{
>>> +	unsigned int nr_io_queues;
>>> +
>>> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>>> +	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
>>> +	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
>>> +
>>> +	return nr_io_queues;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_nr_io_queues);
>>
>> Given that it is shared only with tcp/rdma, maybe rename it
>> to nvmf_ip_nr_io_queues.
> 
> Even if the other transports don't use it, nothing is really IP
> specific here, so I don't think that's too useful.  But I'd use
> the nvmf_ prefix like other functions in this file.

OK.

> 
> Just a personal choice, but I'd write this as:
> 
> 	return min(opts->nr_io_queues, num_online_cpus()) +
> 		min(opts->nr_write_queues, num_online_cpus()) +
> 		min(opts->nr_poll_queues, num_online_cpus());
> 
>>> +EXPORT_SYMBOL_GPL(nvme_set_io_queues);
>>
>> nvmf_ip_set_io_queues. Unless you think that this can be shared with
>> pci/fc as well?
> 
> Again I'd drop the _ip as nothing is IP specific.  FC might or might not
> eventually use it, for PCI we don't have the opts structure anyway
> (never mind this sits in fabrics.c).

OK

> 
>>> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
>>> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])
>>
>> Ugh, the ib_device input that may be null is bad...
>> I think that we can kill blk_mq_rdma_map_queues altogether
>> and unify the two.
> 
> Yes, I don't think anything touching an ib_device should be in
> common code.
> 

