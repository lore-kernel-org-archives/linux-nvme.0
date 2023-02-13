Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8D3C636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5xvqA62qcU+q+x+rft9Cudh5ZUICfBxZR5SHZsTSms=; b=C1+BTID/qztVTKgfV4wazfZnZV
	dls2hiDTlZ2skfhRmfIVFmOuNGo+JPkuNcQkCAeblzNig1ezqasDTzzrhzKbUHr4ziw2jC1kO2+2g
	dNVvY96/wrdeI/cpubmE7r4kt9NrM+bRG1XkLcQ052m3WEokm8LGpNIEVxvH9r8Dk5yg+zxHoTLDi
	HJiae4s+ifERqXNv0//2+exr9ukIIFLu5k9l/3wnAxHz3dpKkrI8/7j5dDZlqUAtacE2xaO4f99/q
	D1h8J+oiQXsnHkeA0OaBzangFLoaTcKmQ/VyxLMdum8sAqKY68S8Zv0UAM6BERiXiwMmJBIJjZMma
	3C7aU3MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRWUN-00EFAm-8H; Mon, 13 Feb 2023 10:55:15 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRWQ9-00EDGX-N9
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:50:56 +0000
Received: by mail-wm1-f46.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso3297353wmo.3
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 02:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5xvqA62qcU+q+x+rft9Cudh5ZUICfBxZR5SHZsTSms=;
        b=1xkzpBJRGJloWDvgWs+6VV9uytPGrS7ahM5baDVfT4cesuriZnJvwcVjjZqY6ym3Zt
         mizs4ABXn8q/Zy38i5aZ42cEdN8Nzgm49hqaKyuF1ED5FIa32tvtZox0NY57rHaWjBP0
         KpHxfHISblrJYiWseW9n8UAEJ9Yqs1oSLvb0Vbl0bf23/PktAvRzPgY6cZNVqxOVAp4X
         /yRwhYG4om00R1D5S3ssZ6xFWqdPSOIZuWYNwKDduCFYClBkXBLNPThE3nrk8WuvHUUQ
         1G1FjcO72A+0t26H5Gb5VfaSZQn3ZcWxUIgmhp+SfljrXM7Dkpw0nlp98sGVTX6kZldj
         RTlQ==
X-Gm-Message-State: AO0yUKWNPZN7M+85jkfGL8JBbrbtR5Njg3VaaWhj7Bt4ZLa/7kIXB9sU
	BRK0YhdlGiMFGTU+gaoapiqu6bgM0N0=
X-Google-Smtp-Source: AK7set8DEKMTQCe3SWSEn5KDfqgPSWKdxfGIH6/mXoWsKrM6Jvjqw1K2+6iT5fi9uMiAX9cQ9YJ1Vw==
X-Received: by 2002:a05:600c:5127:b0:3dc:5b88:e706 with SMTP id o39-20020a05600c512700b003dc5b88e706mr22825993wms.1.1676285451565;
        Mon, 13 Feb 2023 02:50:51 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003e118684d56sm14439110wmb.45.2023.02.13.02.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:50:51 -0800 (PST)
Message-ID: <97d66e3e-1100-1b72-5521-8a2a54b9b067@grimberg.me>
Date: Mon, 13 Feb 2023 12:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-tcp: check for allocated queue in
 nvme_tcp_get_address()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230207145548.113618-1-hare@suse.de>
 <20230208062737.GA14870@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230208062737.GA14870@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_025053_903019_24F29AA6 
X-CRM114-Status: GOOD (  17.29  )
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


>> We need to check if the queue is allocated, otherwise we get
>> a kernel crash as 'queue->sock' is not allocated.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/tcp.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 4ddf3e7b252a..487ea3e8b6c4 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -2859,6 +2859,9 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>>   	struct sockaddr_storage src_addr;
>>   	int ret, len;
>>   
>> +	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>> +		return -EINVAL;
> 
> I'm not sure this is enough.  The queue could be freed right after
> this check.  I think we have to cache the address information
> somewhere instead and ensure that it is always valid.

The destination address is cached in ctrl->opts (passed to the host).

What is referenced afterwards is the socket src_addr of the admin queue
(was added for debug information afaict). So it has the same lifetime
of the queue.

The patch should return call nvmf_get_address and if the queue is
LIVE, append the src_addr info under the queue_lock.

