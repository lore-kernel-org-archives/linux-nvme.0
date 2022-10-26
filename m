Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3E7C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkziyNulvuCpKttkp9fhQ/YdQN74JvF7A8TDwagZTBg=; b=s7DdgsFesvxBHny/hhuIJGc/Dx
	vd8sPfH0jBqTs/c9uvSLwYvhDv4tQJhyNKqtK2zO1Etyl8NX81Ty6005YQKMiKWxJrxd1hcOVPTIL
	OCsA4OlKuFc/S8POtuZQ6ODnafCAWjKUhUji1LAPRRrWhaf3CEEm0CYK67rIzVD9UUhwNwTi7pBht
	7j6BW0P/YFBp1pURGWdjCgWlvHXqpbjjg2oSDX8gBEOs/ciuKMeDNQR5SDq5mVTi0rS+44SIc8AVd
	h8BJTivFDDVp0OluGo4ezAKU4XDWb5B0RDDMQ9+PEiuo+NZuzp/irtGWZGmcfHJw8Si5sf8MoSk44
	2ESIgeyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfzN-009Khz-48; Wed, 26 Oct 2022 12:58:33 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfzI-009Kep-4L
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:58:29 +0000
Received: by mail-wr1-f46.google.com with SMTP id j15so15667573wrq.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkziyNulvuCpKttkp9fhQ/YdQN74JvF7A8TDwagZTBg=;
        b=O6fcq/kNOrok5N8YA618xp6YNWguXdBe0SC4rkvT2lpk8SVpAhxxCVoqKz4l25LRml
         vTqEfq5heHn1WsMvJpzV3TcentyXnQ6MaOfhfsNpvaYi/UJjKaFw/LTftIFDwKEETZKu
         /MuXyHS47rGhS6RVGLM+AO+Bb3d7V/hOvMmIXwUZRq3n15kjvcl1tCWXCgK48yHKiUu1
         uQYaeenX9NIcFcWAhkrfOpQfR1U+FFDx+zoll+ivfH6kEz2hldBIRfpAD6B0ZPdw9ya3
         wwaYx5dh0C5zEhp9kyFWtKA9+h/Xc7bEzaMdVkv3khf2DGMllsmK+qnk0qhi6UGrbPUb
         fiDA==
X-Gm-Message-State: ACrzQf18JUntFVQmkPg7tYZ/CnYmNE3vz+NFZtv7iagCLQTbG3S0d+IG
	xOmU+5c13XcTmKmmKwfJcgM=
X-Google-Smtp-Source: AMsMyM4RiM1dHUoUivbMPNSZHt0bj3Qv5wBN5O/ZJfLCeamLL9SzyRj2Dnzni9o7VWFNqOL00qqQkg==
X-Received: by 2002:adf:dd0f:0:b0:236:2f7f:4cce with SMTP id a15-20020adfdd0f000000b002362f7f4ccemr21392799wrm.347.1666789104084;
        Wed, 26 Oct 2022 05:58:24 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v14-20020adfedce000000b00228dbf15072sm5346836wro.62.2022.10.26.05.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:58:23 -0700 (PDT)
Message-ID: <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
Date: Wed, 26 Oct 2022 15:58:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-12-hch@lst.de>
 <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055828_202629_4E301B41 
X-CRM114-Status: GOOD (  13.47  )
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


>> nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
>> call nvme_dev_disable and unquiesce the I/O queues.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/pci.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index bef98f6e1396c..3a26c9b2bf454 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct 
>> nvme_dev *dev)
>>       nvme_get_ctrl(&dev->ctrl);
>>       nvme_dev_disable(dev, false);
> Currently set the parameter "shutdown" to false, nvme_dev_disable() do 
> not unquiesce the queues.
> Actually we should set the parameter "shutdown" to true.
>          nvme_dev_disable(dev, true);

But the final put will trigger nvme_remove no?

