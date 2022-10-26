Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72071C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ZGKHZT7eHDVXHyhk81/G/GgKEUUUIkoFm8tFpTO+q4=; b=hRowpxAL4KRssJG16NNBARIWeO
	SUTV2wi5usQ/n80jfHWOuFjHoQH6V5lXK31Ei6Jle3lzd8TrnvygtIooyeidS/cVFdmJFHKurkMeK
	RgPt2z9RDqh1NRRribIPJCaG8S55yV+zVuyMueLrunsEhEp58JmOldHiLdGR0OrJzrK6uO/is56/Z
	TDFDoOmPj3NGK2gxWt9STNCpl7aL+YdTGmHLy8jrf4yOdlVMyLG3XVqMj51WBxSfnOxEDEfOCNZg3
	owWkbjcPlfl8OwDHRxbDMU0PJl+47RxKq5YHkKG+Hj6bTjL9iaTbYx1fhiuEuzKyMthkNaqhI3ozm
	w9SOzYuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfyL-009KLQ-Nm; Wed, 26 Oct 2022 12:57:29 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfyI-009KIP-1b
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:57:27 +0000
Received: by mail-wr1-f51.google.com with SMTP id h9so15085118wrt.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZGKHZT7eHDVXHyhk81/G/GgKEUUUIkoFm8tFpTO+q4=;
        b=CKj/V6YfeOngP/XTzQAHrQugH+4Kyr0s0ZWBpQVdHgKdwgb4TTD1A2FjvEn9Wj2l0T
         h4+FZEW+bHyuX+S2Wb5lyBpSk6SmiyLH3xmJ6fW0uz4WhMQvGwq79LXHP37DuKmMei+j
         jg5uF4kMgZf92Vh0Lganc08b4rdIyiMHifxLm1dxv5Gs9BfkJ0N58pjFshO91MAUrVg7
         lrdodo1G6l3eiqPJRYRphzJmGLL5jEay6Pt9b2SF9g3ksf2jD0vycXJ+o+nrn3I7mHVQ
         tbfGkeN1Ya5YXC/jRSqegmsvN5h8oNQURbFoYJIf2cIxq/S9+ZneqTUG3PhMZUUBZeQR
         R6XQ==
X-Gm-Message-State: ACrzQf2AsAcOpd0drNqLDGqr7JDh6yVZy9M/ra7UaGfMY100kCiBSZm5
	zE5XHA42dy5wooouns6EmL8=
X-Google-Smtp-Source: AMsMyM7k459DzhGpKR6gZ+BNCuarlj+8Ojb4Dz1RA4xpxPQpDc2g52AicH/P5Am/t2I1HkmiMYXHZg==
X-Received: by 2002:a5d:6d85:0:b0:232:770:aaaf with SMTP id l5-20020a5d6d85000000b002320770aaafmr29544055wrs.595.1666789042111;
        Wed, 26 Oct 2022 05:57:22 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003b4cba4ef71sm1833278wmo.41.2022.10.26.05.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:57:21 -0700 (PDT)
Message-ID: <be199534-260c-f587-923e-3972f56f97ce@grimberg.me>
Date: Wed, 26 Oct 2022 15:57:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
 <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
In-Reply-To: <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055726_110653_59468A0D 
X-CRM114-Status: GOOD (  15.73  )
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


>> When we have a non-present controller there is no reason to wait in
>> marking the namespaces dead, so do it ASAP.  Also remove the superflous
>> call to nvme_start_queues as nvme_dev_disable already did that for us.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/pci.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 8ab54857cfd50..bef98f6e1396c 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>>       nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>>       pci_set_drvdata(pdev, NULL);
>> +    /*
>> +     * Mark the namespaces dead as we can't flush the data, and 
>> disable the
>> +     * controller ASAP as we can't shut it down properly if it was 
>> surprise
>> +     * removed.
>> +     */
>>       if (!pci_device_is_present(pdev)) {
>>           nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>> +        nvme_mark_namespaces_dead(&dev->ctrl);
> 
> Don't you need to start the queues as well here?

nevermind, you call disable with shutdown=true

> 
>>           nvme_dev_disable(dev, true);

