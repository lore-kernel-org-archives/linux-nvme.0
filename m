Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:13:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19E923136
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19E923136
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OjfGejf75lz7yvk3hICNXtMTTyDCDJU2N6GqhqStKA4=; b=IjTKRT7IztcS0297U4aJn8rDF
	MEINkB4vLMweDrBZl5TagDI1JSICfYvg5kKudOjdU+wbNvSHDJTSlJ5Yi8apXzLuoTdaNgn/joy5L
	ZJhsWfoAJCC2byb78UIt06740mFKCayBif3PRl4BCzmiWIfnG8CoVMYYs3zwXpc+tY1HpS5JspJ+V
	XRqAqj2IbEqo/esuPhxdlOIT3J/O6Jj9nhgD4tWVVP6UQBfijr7mtP+ka/+Bz11FuUEY4TF/+yWvk
	YGKrT1+ivICchNoHGibCHIBq9OBZ/5qUHRfJxpDSayVnQdvn0AZ+yJPF7oFvGPRk3F1/ktwuv6tot
	cb4xv3IMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoO4-0008HB-1r; Wed, 13 Jan 2021 22:13:08 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoO0-0008Fp-HG
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:13:06 +0000
Received: by mail-wr1-f41.google.com with SMTP id m4so3732384wrx.9
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VK/iM6R27LRQ/Qm/8qm5HUt4QdKjqmK+S3xgybZNYKk=;
 b=WWehY8og9KqS6xLD9aLxSMPFIYlmb/+1qT/oORP/KfVuTttIqakackGAGiBGyu8v0V
 Cf46uMYyefxhwNVJWhgpDksYmD46gZiieQ1P13Pnox1B/LwXW0kd1LyMcatbv28sCZVl
 KrLNOl9/v6gHXvkWhRqU42p1GNKRtByZCNH1I58u0U3d6AnTYWlTTlin/JNyFEmyi7wH
 IvYo9Cm9CjtKmr6WXZjNAEGbXjPfQCLnIj2f3RXiACG/ADDzy1xk7iadEkCs09xG1Ite
 c6EUg7agl+lZArQ4+B8UOhwXSQT6vWychcLtzvcmNEX1tlR4JBYnFKjk9A2gr6S5WGVO
 b9zw==
X-Gm-Message-State: AOAM533l0soHzuACsXfkk10RvaNZNQdUPlgAOUW8v1Z5A9jZnCd+zPeg
 qhy1xNB7rD1MND2G5cYVaGA=
X-Google-Smtp-Source: ABdhPJwEyYL3weXHM+uwbX5BM3Ogp/SoLHVZ6sVZ0fmQP+g4Ys36zOKb4ergNxlvtvMYnE10wvC8Gg==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr4617979wrg.285.1610575983501; 
 Wed, 13 Jan 2021 14:13:03 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id s25sm5764685wrs.49.2021.01.13.14.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:13:03 -0800 (PST)
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Li Feng <fengli@smartx.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
Date: Wed, 13 Jan 2021 14:12:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_171304_663188_32D3BDBF 
X-CRM114-Status: GOOD (  18.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "lifeng1519@gmail.com" <lifeng1519@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> The nvme spec(1.4a, figure 248) says:
>> "A value smaller than 9 (i.e., 512 bytes) is not supported."
>>
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>>   drivers/nvme/host/core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f320273fc672..1f02e6e49a05 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>   
>>   	blk_mq_freeze_queue(ns->disk->queue);
>>   	ns->lba_shift = id->lbaf[lbaf].ds;
>> +	if (ns->lba_shift < 9) {
>> +		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift);
>> +		ret = -1;

Meaningful errno would be useful. Also better to use dev_warn

>> +		goto out_unfreeze;
>> +	}
>> +
>>   	nvme_set_queue_limits(ns->ctrl, ns->queue);
>>   
>>   	if (ns->head->ids.csi == NVME_CSI_ZNS) {
>>
> 
> 
> But this only catches a physical block size < 512 for NVMe, not any other block device.
> 
> Please fix it for the general case in blk_queue_physical_block_size().

We actually call that later and would probably be better to check here..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
