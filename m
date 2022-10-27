Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE51C67871
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpWS2J3Es7uIIpMV8NfXpdIdeICyL7ab7tVCU0uhI/U=; b=NuYlGWR//9MIC11rgbfJZmWYNO
	u8OhFh5OBgIYUjvTmt8NFme5yRjq/lk3BjoSHrXxydEsKX93X03dTDKKNP94DwkOIxTEg6uYxbcuF
	cigWFCKDbK7u3TTKpuvTeyQzJQAethvjrcAYfHHDWvcB1YvCLKujoc3B6CyOj0oWX7F54XiKnIvHD
	4FnBgiNF6rcO4g3DZNfMmYYXTRWhSF9Gf0EqbSgp4OwiD4V0AClTaoIucPqF629eVdSBTbaXsRqdZ
	xJRhAs4j8c/+9rTAbpZkgLI8urNOYSqM0iyWSRludyWmdvEkNAjq/zMkjKpuXY7ZW/48JoiCMF8wa
	7AzDBzTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onziw-00CjHL-B6; Thu, 27 Oct 2022 10:02:54 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onzis-00CjCX-Q7
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 10:02:52 +0000
Received: by mail-ej1-f42.google.com with SMTP id bj12so2938206ejb.13
        for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 03:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpWS2J3Es7uIIpMV8NfXpdIdeICyL7ab7tVCU0uhI/U=;
        b=XMbO66N44tNnqQBqsfZY58nGLMDh3hYNtRsDXlncCplbcxQntwEz+ZWdRJIF0QEtGN
         Lv+vrM/KVtiGTmKNzJVU5/GqrAfE+jJvmLe89uAXtJ4vjPYwBrtKshKAfLPiHCxcjKAw
         ZFhpgfaj+QvxhrH22MvEmO1c+yeFhovOE0i1wI6PtoJFjKFXb+Phuk4s4HMtv5ndrd9c
         lhw5G7LJVJuqj8h9CruRDx7ldN9HwDzCutQ1npnrKNRBM5DnC0BeS1eKGI7+blaZo0li
         q6+fvHoe/TD1cRZQdXK6J6ou1TRaG0vtX1YC++JXYcH8IEAA3x6BZbxS7NJlEns5uQh/
         LzEQ==
X-Gm-Message-State: ACrzQf3v8XQAJuepG1YXaS3sdUGg7PHCr7v2qQRXBLpCzmjNH3omIhF8
	0NvQYulN001QOGClJJoO4TQ=
X-Google-Smtp-Source: AMsMyM5CY/5nG0MF2o1QHRha6hhsy0fgyBazhGunp8Q8cB1Uf/XbdOvnjOKX5Eq06ScaH9xc4Sfd9A==
X-Received: by 2002:a17:907:7627:b0:78d:b6f5:9f15 with SMTP id jy7-20020a170907762700b0078db6f59f15mr42093169ejc.149.1666864966910;
        Thu, 27 Oct 2022 03:02:46 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id h8-20020aa7cdc8000000b00459012e5145sm691985edw.70.2022.10.27.03.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 03:02:46 -0700 (PDT)
Message-ID: <bf1fa182-2bab-905d-f48e-eae70e64fd96@grimberg.me>
Date: Thu, 27 Oct 2022 13:02:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
 <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
 <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
 <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_030250_870962_1463039D 
X-CRM114-Status: GOOD (  12.85  )
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


>>>> +
>>>> +    if (set->flags & BLK_MQ_F_BLOCKING) {
>>>> +        set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
>>> Memory with contiguous physical addresses is not necessary, maybe it 
>>> is a better choice to use kvmalloc,
>>> because sizeof(*set->srcu) is a little large.
>>> kvmalloc() is more friendly to scenarios where memory is insufficient 
>>> and running for a long time.
>>
>> Huh?
>>
>> (gdb) p sizeof(struct srcu_struct)
>> $1 = 392
> I double recheck it. What I remember in my head is the old version of 
> the size.
> The size of the latest version is the size that you show.
> Change the srcu_node array to a pointer in April 2022.
> The link:
> https://github.com/torvalds/linux/commit/2ec303113d978931ef368886c4c6bc854493e8bf
> 
> Therefore, kvmalloc() is a better choice for older versions.
> For the latest version, static data member or kmalloc() are OK.

We can keep it dynamic allocation IMO.

