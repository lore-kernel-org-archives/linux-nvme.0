Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD18C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8AZCSFLMZiR9DDyMMlhDuHkFFeCUZklr2J8QdJLeyj4=; b=2pmh1F4sLqK/q9Zj0A50QY1+rR
	NfP0Tx+/y6LTbtOYhkRWQshAt6Kd0KmlgsyLp0WR6VMPIG/9pPLVDy4qb+GtSYlcOpgIIDPo2P+35
	QfGgSdCwgjngVv8+7CHV8v7MzuKmhDsjPMUANr6ycl+9kJD++fHszrccdge3SRPxAM/fo3UGprXBY
	0K6hvw/fSJEYmOdWM5qb/qcqp14yb+zSmyQpglm6icM/HTUEZm9tGde8FVB5Vw2Un/L5eseh56/hE
	qv8Fo1cbKY7Dw4uy/Tb4D+3Cuf4rWmX+u0MT3dTvl6SQ25BPo8fLfUce8/mxXQIOVuFL0S7bvftsv
	uaIQFhxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IPJ-00EVW9-1U; Wed, 30 Nov 2022 08:25:29 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IPG-00EVRy-Ah
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:25:27 +0000
Received: by mail-wr1-f48.google.com with SMTP id y16so6093754wrm.2
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AZCSFLMZiR9DDyMMlhDuHkFFeCUZklr2J8QdJLeyj4=;
        b=QMw3ld8hQodzSu8iWkT4mGOnSlwNzLaunW0RRb45Kelzu+ARoVw07Lnfk7uBgpUDd2
         QyPOKPK8OUtMGBAQ69eLywb7YuW+s1EbrxHTYx/m6xY+vnPQxWG4GtTtDwA5wWhXQE4F
         LhgYxruRLGwXDCCkx2XHspzj5rfsAsni/4zTZKKCzWHZcXR+MLRSGxAY/6BfMc06Jkjl
         PXyauUZXdN5g1T2+MtOojyBN8qLjWEO5C2FK049d8TbaFPS4XzoA76Pz+/HZ7mDxC+Mc
         xV1DkEK4F5s8FYEX5l2dCsVgjMMHv+rgAqZs2G4SgFJbq60K1Q5xznmuFPxvHXzosKB3
         Csng==
X-Gm-Message-State: ANoB5pkGWGvfaHxVIsTrMf4nOcHNm7asMkzz5pHcD2xVUMQegvt/vy4t
	1THDGM2BkVIIV/0+jinntnpCiJQxMjw=
X-Google-Smtp-Source: AA0mqf6eydOajzqg5uBvidE8VoCvc5EfoAcsFIS6fbiivC5iog5cJ58iwZ7lUseNxQzIjl0dhFdfAQ==
X-Received: by 2002:a05:6000:1046:b0:241:fa2d:debc with SMTP id c6-20020a056000104600b00241fa2ddebcmr19842884wrx.12.1669796722638;
        Wed, 30 Nov 2022 00:25:22 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm5471804wmq.43.2022.11.30.00.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:25:22 -0800 (PST)
Message-ID: <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me>
Date: Wed, 30 Nov 2022 10:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
To: Christoph Hellwig <hch@lst.de>, Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, Uday Shankar <ushankar@purestorage.com>
References: <20221118232756.1457075-1-csander@purestorage.com>
 <20221124002432.3715594-1-csander@purestorage.com>
 <20221129083905.GA25314@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129083905.GA25314@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_002526_403616_C84671E6 
X-CRM114-Status: GOOD (  11.99  )
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


>> +++ b/drivers/nvme/host/multipath.c
>> @@ -175,10 +175,12 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>>   	sector_t capacity = get_capacity(head->disk);
>>   	int node;
>>   
>> +	rcu_read_lock();
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (capacity != get_capacity(ns->disk))
>>   			clear_bit(NVME_NS_READY, &ns->flags);
>>   	}
>> +	rcu_read_unlock();
> 
> I can't see how protection iteraction of the same list once with
> SRCU and once with RCU can work in practice.

I understand what you mean in general, but in this particular case
I don't understand what is not working.

But, if this is too confusing we can make everything srcu protected
and be done with it.

