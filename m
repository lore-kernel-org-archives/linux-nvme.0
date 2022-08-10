Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC773C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1+638QINDav1vq21sB8cgT54nj2PCYpFOxt0R4Yq/o=; b=Bs6f+bezzBerYd5XSbWBBPRyIN
	hk611+5bSKvdcYMhkx+X3ArDMH1v7x2aWzwLezIPthfFRMJQOcSkE0Fk11uoMaL8dc0oS3di7JKp8
	Lr5UOfkbeqJHq4UJbYYoPJP42zJ/ePrebz7WbrLLbruKy6Vi5QVelF5AU+4gXqSHCTdf0qwHqAKJ5
	c9E1Sp7KMMnMMfGxzHkF0jLD1tnQ6ivqj8wxWqGanmrxAbbIe25HZVONxmZ3DKRN7cysqusZi5LN/
	keEFk7M5DHLvMTGrdDOr90hisgjhhJowWeUSQ+4bxNQKQ1RVzQ9A10o9EyNSOx5dngJsgOB43LvUE
	29451jKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlOh-00BuNI-5H; Wed, 10 Aug 2022 13:05:19 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlOc-00BuMA-0h
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 13:05:18 +0000
Received: by mail-wr1-f50.google.com with SMTP id n4so15916681wrp.10
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 06:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=T1+638QINDav1vq21sB8cgT54nj2PCYpFOxt0R4Yq/o=;
        b=ywm6j5Qdqs8IR99I+c6nzXdfZvq/NAlhAvlPLnqVaq1bpSJ5rNmgn/N2MnQT1qFCB5
         PSCdiS5yDIqTEVfktHYFEYUqvYCCjWEV6eQQ8JFHF/NBmHEoBXWhPugeSdg3BaARQL+/
         xQHoPWRbooG/pk9PXJ7jsF4wuXBmLf1efrzye+73zCvawd8vrGezs478V92nI6gxHQso
         fBxrFehtAewTG71fZ6Ni8wEYGtaksLS8l8EyuPSSbdUJvXM/CH6D09TtMlAvGMLNkmjH
         /S2SKwGPpGd8BBEzIU8b9HwCNdSnVAronr7qM5qEal+ILvRMkWl7xPR9OS8Kj/nHgi+t
         gZCA==
X-Gm-Message-State: ACgBeo0IadqSiMloz6FiC04Z0FZOKNIxeLK9vSolob8eixnIo9Uno17f
	38ECNfMuBG48pAmIkWxOYewdVDL31NA=
X-Google-Smtp-Source: AA6agR67RbHQ7lIkHGiKhAQeP2bDfOpC9e6HkwxCNPQ/AXP1JZ638pZzBzI89DKT6a/fHxqO9IM7+g==
X-Received: by 2002:a05:6000:12cd:b0:21e:c4e1:6e27 with SMTP id l13-20020a05600012cd00b0021ec4e16e27mr16475205wrx.366.1660136712199;
        Wed, 10 Aug 2022 06:05:12 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c7416000000b003a541358bdbsm2285301wmc.21.2022.08.10.06.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:05:11 -0700 (PDT)
Message-ID: <56fd179d-f684-122d-5e23-7856d54ba2fd@grimberg.me>
Date: Wed, 10 Aug 2022 16:05:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-host tcp: check if the queue is allocated before
 stopping it
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
References: <20220801080900.391575-1-mlombard@redhat.com>
 <9feb87bd-baf2-a9ca-f4ca-8af6b8b00d95@grimberg.me>
In-Reply-To: <9feb87bd-baf2-a9ca-f4ca-8af6b8b00d95@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_060517_140388_04B8C31B 
X-CRM114-Status: GOOD (  10.60  )
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


> 
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index ac74dce3e95b..ab9bb5c98c78 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1619,6 +1619,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl 
>> *nctrl, int qid)
>>       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>>       struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>> +    if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>> +        return;
>> +
>>       mutex_lock(&queue->queue_lock);
>>       if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
>>           __nvme_tcp_stop_queue(queue);
> 
> This looks correct to me,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Just one nit,

The patch title should start with nvme-tcp: and not nvme-host tcp:
This can be easily addressed when applying the patch

