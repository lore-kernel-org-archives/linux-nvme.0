Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFC1C4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVZ3ZAKK+mjnth070265wHLdfUoZbt3AfFAGE4v8dtc=; b=b58EA7DqBQAK2MvGf5l8YI0eHx
	OPMZKD58cAxmkHQsdEJoUQ08+B12UpjYszUEbjEgXJ/WUqLym8lDVZTOcR2rWH3+kOLhkh+5SDmDt
	uejV2YleQ2MpwnzFooI+HucOVEgW3w6WFUTYeGKqvPEWgT8pu006DOZpkJ5e7KK+o9v4gMHRO4lwk
	zTPMsnJk5pM/mHLosE/sPvXB+HmcRsbbnjoJjz+w0eIEdRRK2UyNGgMe/i28A6qgRJ+tif2dYikgs
	23e2XxXqk7Td1t64ClAT8Z2rcA0N9bF5SHcVymgrMOFm/R1MmFMZsQV6AA5vjdEfr3z4b0rXqhn3p
	syJ/OVVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PAB-00ATUE-DH; Sun, 25 Dec 2022 11:27:31 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OdR-00ADHF-QQ
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:54:33 +0000
Received: by mail-wr1-f41.google.com with SMTP id d4so162115wrw.6
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVZ3ZAKK+mjnth070265wHLdfUoZbt3AfFAGE4v8dtc=;
        b=nZbLMYDgS5m2nN/4dxuHIFFiCMnBYwNtaboS9+Cuuj1oGOX48xDzpoTIlUYnxxJQMP
         L0lh/2nK5Y3UUVum+WOBtVICAyj2emIp907urKAHPRsT6kG5+ccBjW4gCxZTWHYvtnjW
         dR4hUcEjkCHp7FTGdS5c2GVbeNHCLW42KUUAy3jHoAbpUfxu+7hxLYAnD1PtNaUWgm3R
         YWb1V6sOyS+6DNgPrK5vEZUAfBbM4eDVQKkOQsuHNaVZcemhDvd/MjDAwoDDClFkSqxA
         DJp4Ak+AnNrcX69e8V+791ne0glko64BLq/7I1WJ7rH9l8c4pyfn4ffRLVrQ5pe5XaYN
         5JRQ==
X-Gm-Message-State: AFqh2koez5v9g+9g6ZCZEo6TkBb9EO8S3qnPU6JYvrScmCSVy3pjYhqz
	JN1sL3ZVFsWwSNC3dICBzI4=
X-Google-Smtp-Source: AMrXdXtUqJwqn66FF13sVnjGkvlts9daw83r4igxU2f/FZFngKNLf8LFE7cXlBdDh69AbM0AJZ2oMQ==
X-Received: by 2002:a05:6000:16c4:b0:242:86d:9d70 with SMTP id h4-20020a05600016c400b00242086d9d70mr10072931wrf.71.1671965619925;
        Sun, 25 Dec 2022 02:53:39 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d4a43000000b0026fc5694a60sm7494668wrs.26.2022.12.25.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:53:39 -0800 (PST)
Message-ID: <4f1f6a12-bf9d-4118-23e9-6d20a3d8a265@grimberg.me>
Date: Sun, 25 Dec 2022 12:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] nvme: fix setting the queue depth in
 nvme_alloc_io_tag_set
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-2-hch@lst.de>
 <a7a593fa-9a48-6f6b-a428-2fe6db694d22@grimberg.me>
In-Reply-To: <a7a593fa-9a48-6f6b-a428-2fe6db694d22@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_025342_350409_8B006B3E 
X-CRM114-Status: GOOD (  19.60  )
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


>> While the CAP.MQES field in NVMe is a 0s based filed with a natural one
>> off, we also need to account for the queue wrap condition and fix undo
>> the one off again in nvme_alloc_io_tag_set.  This was never properly
>> done by the fabrics drivers, but they don't seem to care because there
>> is no actual physical queue that can wrap around, but it became a
>> problem when converting over the PCIe driver.  Also add back the
>> BLK_MQ_MAX_DEPTH check that was lost in the same commit.
>>
>> Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> 
> This looks fine, but does this actually fix anything?
> How does nvme-pci ever set sqsize anywhere close to BLK_MQ_MAX_DEPTH ?
> NVME_PCI_MAX_QUEUE_SIZE is 4095...

Disregard this comment.

But this means that fabrics drivers automatically get 1 less queue 
entry? with this patch alone?

> 
>> Reported-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e26b085a007aea..cda1361e6d4fbb 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4897,7 +4897,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl 
>> *ctrl, struct blk_mq_tag_set *set,
>>       memset(set, 0, sizeof(*set));
>>       set->ops = ops;
>> -    set->queue_depth = ctrl->sqsize + 1;
>> +    set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH 
>> - 1);
>>       /*
>>        * Some Apple controllers requires tags to be unique across 
>> admin and
>>        * the (only) I/O queue, so reserve the first 32 tags of the I/O 
>> queue.

