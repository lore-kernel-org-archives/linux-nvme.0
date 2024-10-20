Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE56D3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IA3Ve8X3TGe0MF5mCdrvfury8DinanNQ4ls6pWACbOo=; b=eCOPGRljZ2zsvI2YCHOusLRJN+
	ppm/oVZAnXO5NrVzC6QWEipycreqbX3XAfZXY/PTPs73EHeA2l1jjjWnbCyMiJ1U5qo5IhNPfDOn1
	zjZKSB450Tl0ROZ467kfrZkOtNTYlOdPlCuPjQb89mtRKcqWj+MgN0/eR2hrUWGiDnKXU+6ueAEv5
	9/T/UV8Gr8GBHRxYW7QeWajkmHH8dOFR++7V5+LwoXrkGB3DVdtDgh8DFxGrEZMBbREgBK/Hpgq0D
	KL6ei25ciDTGtC4B3qix98aS/6TKhJrn17eCgi03UGj+rJsYvdtiDXOd0XTtM0iAZ+f8gTxFZlNpF
	GPx7qYJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fVK-00000005dMB-3NpM;
	Sun, 20 Oct 2024 23:38:34 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fVH-00000005dLf-3vn2
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:38:33 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315abed18aso34831925e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729467510; x=1730072310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IA3Ve8X3TGe0MF5mCdrvfury8DinanNQ4ls6pWACbOo=;
        b=kSdfcSX3PA6F3+IK9pbZWqbKowivdqJxBYSobv8YGZkUlw83ndnc/49LqJ5tb11x8Z
         HLsDcTulNG/BF/nx+KVh3lgiAGblD1kq9s/IRZ8bcloF+HepqDpVTciPZ3wds+WYnCnW
         QkPaovC7nL8rp1MSYUYUAr8qlGqTbVYRoJjjp/LKl/jQMtlb7uyO0w5yKteeiFr7sdwz
         uMTeHMpoQg3pmoKcCyrGl6feOhpXoxSz72nca4s9jSvyGKzwWFsm9r4arfzBlfb37jRG
         Xgrb3xSmgsVJGr9uCizMPCCF0WXlRQg0wpSVbbXHy+fnfCUdzCTyhNO+f87Zk+gPW5s/
         GwYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO7UqwybzZHpQpe/UsK+oQn1zGc7Y4KxxERp+BjU+/OawQiSlPdPrkxnHEz4oMYV3UVcWTFklXoC5h@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7JHQYyexJ/Hqb08vBsqecB+fGkOuguyoQopTfHxP1rJY0R/vv
	JPT2khdUJix40rFI4dzARQctfap7Zw+Msim8xah6aYbDf+ANKz/C
X-Google-Smtp-Source: AGHT+IHHRaV7pmCfWC3hgmAAMMzqS7DdRw0NjpReb7es7IsrNzp6MhZeTx0GEQyyGzD2bK8XnQRL0A==
X-Received: by 2002:a05:600c:4f42:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-431616a3fd3mr70351665e9.34.1729467510229;
        Sun, 20 Oct 2024 16:38:30 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57bc1dsm37930475e9.11.2024.10.20.16.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:38:29 -0700 (PDT)
Message-ID: <54f09817-5fac-4edf-bd8f-1803b10ba359@grimberg.me>
Date: Mon, 21 Oct 2024 02:38:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: skip failed paths during partition
 scan
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-4-hare@kernel.org> <20241008064020.GB22424@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241008064020.GB22424@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_163832_008168_8B7B2E21 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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


>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index f03ef983a75f..4113d38606a4 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -102,6 +102,13 @@ void nvme_failover_req(struct request *req)
>>   		queue_work(nvme_wq, &ns->ctrl->ana_work);
>>   	}
>>   
>> +	/*
>> +	 * Do not use this path during scanning
>> +	 * to avoid deadlocks in device_add_disk()
>> +	 */
>> +	if (mutex_is_locked(&ns->ctrl->scan_lock))
>> +		set_bit(NVME_NS_SCAN_FAILED, &ns->flags);
> Err, no.  mutex_is_locked is never a valid way to detect the calling
> context - obviously someone else could also be holding it.
>

Strongly agree here.

