Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63923EB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7shZw4av8v5IHZpujoNAJoSx10yveOKO/iFninPOH7U=; b=AykIUHVSrbh2rZevXVAHPqEkiT
	GVXM+6/H8P9r26ZapZ7hemCa5r1UQ49VowW+GmpXqH2Uxtn2MgYSEx67y/eyp442voheXElfhqEFs
	er2lRgEvwxPUEh5taHuGgx/dRJC5Ru9LJb277eJbwBvxbt4BLJWI7KA8J8JFyG4HVoOM9vrDPxNjB
	TLp4O0JkUIRJyH78q0iEdqCKBy9TXkd75b3/4ALr/+dLswFpO82oZpoGBV9RDFiZlR6yGaaXlXNEy
	z43oGWzEsDpy4BP8Ss7+w5pnjjw8UFud134I/orhQ71q4KfU+rYrSMRkY+ykvl9V/UVZRMWHJesz7
	g+3TXrBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAdB-00F7TO-1f;
	Sun, 13 Aug 2023 12:55:41 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVAd8-00F7SQ-2K
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 12:55:39 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5230963f636so1032670a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 05:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691931336; x=1692536136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7shZw4av8v5IHZpujoNAJoSx10yveOKO/iFninPOH7U=;
        b=NBQGzVN+SeFPAQc7CX8Rh4RV9W2ST1cMGIPnMr259vjVEmY/OfExvk4udyZPuXQqYs
         TsVnpWCWRamvU5cHMmA20xqbpg6d/kgiRu+kJiBAMS+vFUEsYxqiLAuAmVLKei9hGpK7
         xa2rOzvDJiKEf4OOCPl2rqDKjluimWYe/0NT6cH53L1ineaD/CT0rw+OnenVDYZotB7M
         q1VYcx2QPEDwaCN/0N8hX0cBSa0gYS1aNBA/sA5C8xMlbFy6YU6XSAL7Sqp4S6GlHSr9
         gDVoCqN8ZUUAufBoEJIGre/UKZV12R8c+KoRYGNIJYee/ChuhKVYsldc2YzitroOjS5I
         1mnw==
X-Gm-Message-State: AOJu0YwE1XUV78vFUDjc2mIYH6gL1Wtiw90tQWZNofniL7dd+2M6XSnp
	WFXZpKw/Bzg8LTTmoAYccQlyvFqG4Jo=
X-Google-Smtp-Source: AGHT+IHbBKXmzm30+LJORTpCDrqNKlBYaIuaj59wR7D6mpfIqjH5pqoBwjFo236BvUY0/t+zHhb/bg==
X-Received: by 2002:a17:906:1d2:b0:99c:d995:22e6 with SMTP id 18-20020a17090601d200b0099cd99522e6mr5311544ejj.3.1691931336143;
        Sun, 13 Aug 2023 05:55:36 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id lj5-20020a170906f9c500b0098d2d219649sm4621748ejb.174.2023.08.13.05.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 05:55:35 -0700 (PDT)
Message-ID: <ffdf48e2-6722-81d7-d253-e27da5ae9620@grimberg.me>
Date: Sun, 13 Aug 2023 15:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 2/6] nvme-tcp: use nvmf_resolve_address helper
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-3-sagi@grimberg.me>
 <a2580de7-f1c1-4a42-a1dc-1fca4c5dfd2d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a2580de7-f1c1-4a42-a1dc-1fca4c5dfd2d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_055538_757789_415F486A 
X-CRM114-Status: GOOD (  12.27  )
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


>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/tcp.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 3e7dd6f91832..a47b597ace3e 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2537,8 +2537,7 @@ static struct nvme_ctrl 
>> *nvme_tcp_create_ctrl(struct device *dev,
>>           opts->mask |= NVMF_OPT_TRSVCID;
>>       }
>> -    ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
>> -            opts->traddr, opts->trsvcid, &ctrl->addr);
>> +    ret = nvmf_resolve_ip_address(opts, &ctrl->addr);
>>       if (ret) {
>>           pr_err("malformed address passed: %s:%s\n",
>>               opts->traddr, opts->trsvcid);
> 
> Merge with the first patch?
> Otherwise okay.

I try not to spray changes in both core/fabrics and in
the drivers... We can do either way...

