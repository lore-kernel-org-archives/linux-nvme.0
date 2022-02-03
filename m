Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E2C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSE7TQBd8lJNevBlTyHJ2aMW/ZbD+VM3d+lnBnvPh1E=; b=pwRiyAKGVMqthuYQBunJDGUp9D
	WAvDpDbbRF+cH0SBjlx5WkeDutoIEOB1oYvzpOV69N/nyfszT5eVY471blaz8g2rugsmNTVzzqhc6
	1LouEQ+1qv/s2GAkHNZufIjx4H4eEPoadMq5h62/Jm65FsqsB2jcVQYFbqTsy9mqillqLx5V+tz8z
	07v6owiSVo/sgTKPW991XIalYMCJ5p/nJ8KPbjMtKrluZ/RBGvJMbpSc8AoUsKwQvwppaI0DfoskX
	l3vLu4/3/5ORt/mutIl+StA7F5TiyjD7hTbwb4YHrQrvBPJ3/GwHE4jgX62QLjz4sjxDBy1jrtCmq
	wl3Hrd6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFdeN-001kUf-7j; Thu, 03 Feb 2022 15:03:55 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFdeL-001kTg-7H
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 15:03:54 +0000
Received: by mail-wm1-f45.google.com with SMTP id r7so2267970wmq.5
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 07:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QSE7TQBd8lJNevBlTyHJ2aMW/ZbD+VM3d+lnBnvPh1E=;
 b=ZsN/+4ZpDcZZfUHaAhjTLYX+KAdexDINpI6jEyspnHnKpoUNpcMOoU45kq2q+VLdPM
 u5XZ9RTQh1Z1eNdNGSBmj8nNt2kUZLTV2wRUgDkJrzNzg8uQMkhnY+2cvtSFxAb+GvMN
 +8RBAhOBi27z4pXT+6l1w6sM9pgfxJ8ypQlCr7+9AXU3JtnbXRh9zrHH6R6onhGZlZyF
 1Mvr5swu0C7TxJ5E3iFetSqQ0MonzMpe8lkJ0Q/vuLnjImcmh57nbTeaLe5mQBKprnXG
 CiRNc+RF4s+AbJGAihS/QcpPCdvtu8jI6QD2+L6hJklGyB0fR5M1/HMXHCx0o7nzY3Bj
 JU1w==
X-Gm-Message-State: AOAM5308zMpWzOrDdZJqVsQqjONr9b3A7WOq/1BNkNlUrO2X2gTs1str
 uRfugD6M1liHkjb2DN+2FvI=
X-Google-Smtp-Source: ABdhPJxDC0M1d4tyL32gFFITvr+l3I/mNgh2u0U+eiKT+98AE4SFuvbSddsZEasdmeN9V3fpFE2sbA==
X-Received: by 2002:a05:600c:4891:: with SMTP id
 j17mr2419397wmp.88.1643900631627; 
 Thu, 03 Feb 2022 07:03:51 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j4sm24015174wrq.81.2022.02.03.07.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 07:03:51 -0800 (PST)
Message-ID: <8287fe04-b6f6-8bb6-c538-3c401da600c0@grimberg.me>
Date: Thu, 3 Feb 2022 17:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] nvme: fix a possible use-after-free in controller
 reset during load
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
References: <20220201125421.177942-1-sagi@grimberg.me>
 <20220201125421.177942-2-sagi@grimberg.me>
 <b6b0d486-c1e1-bf8f-6720-9245bbf60815@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b6b0d486-c1e1-bf8f-6720-9245bbf60815@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_070353_305873_9200C006 
X-CRM114-Status: GOOD (  11.76  )
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


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index dd18861f77c0..c11cd3a814fd 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct 
>> work_struct *work)
>>           container_of(work, struct nvme_ctrl, async_event_work);
>>       nvme_aen_uevent(ctrl);
>> +    if (ctrl->state != NVME_CTRL_LIVE)
>> +        return;
> 
> any reason you moved the queue_ready check in the transport drivers ?
> 
> Is it redundant ?
> 

Yes, see the discussion with Christoph

