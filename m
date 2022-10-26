Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C908C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RtrfWAcgGb0M/SBvYB4J30r7X8J7A6DigDTfmctW7LU=; b=eLTER8Ni4QNjHkDlLd4oP7bLf9
	93PNIpQCVQIM2Dz2w36u3NjjTYL24OXW+N3vz+IEeElWahnTj9162tEy9/+AC7LaBLof/JIsdp87z
	Ic+n9/0P2mXx54247tEf3NF/8zJTrCokdA3GC6V4WxtRzGTz7+T8a6zHNxsGdYQ7BsyQ2nhlcYJs3
	PCFVaMZPTcgaXgBkvFbRFVvQR0hbnf875HaoxP8iXNHGRWir+VkJpRdtIlvRpKDC+LeWMMXEhkXQy
	QZlMRXiIVzO5cca7fK8M3CqWPAW567Hb0QYd+/RtP5z9LRUcXS/c3u3n+8qNoiZJanerlkZDCQzt2
	CpLMrOxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ong3f-009MN9-95; Wed, 26 Oct 2022 13:02:59 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ong3c-009MLh-OQ
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 13:02:58 +0000
Received: by mail-wr1-f45.google.com with SMTP id w14so1930606wru.8
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 06:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtrfWAcgGb0M/SBvYB4J30r7X8J7A6DigDTfmctW7LU=;
        b=YvB5ioRO7LvQC9HJYMY+KVugc6myuF7lWD9fx3O0bpdP5uFYw+M8TzFPYfHeoQu/uR
         PyqYyECjJR7oNOPkuuzlFQcbSORQz+PA2FvpVchB6Zkr2/mtvUckmPZBTvE82yNXN5Gw
         ajM1SCcekehImYbs6uYYIM6+4pFSnx2OQaye+m0RzX+h0gtx+vVuUSZylY1esjzfYE4D
         4jLVDnRfOG7zgxmwMj2JTwnJ8SawEojiPWmEu95mhgzUE74wzycPEBi54JA0zwgwwinR
         YsDfU/qH70+SuYYjNRdpzpRj6Q/m+uCoEq6BGvGJ2lf6PMWmP703DTPSMeck7ouy/Z8j
         Umaw==
X-Gm-Message-State: ACrzQf0/p0pjk1cZxmnpi3VLYAlwwNye2V4z0lyOJ0QkzJeErQjEJN4t
	m47jVE9wch7xffPwO5xFunw=
X-Google-Smtp-Source: AMsMyM4gUCtZTDq9YICmQjTiN7WWJY9Q2lnJCPmzBs0h6XilL3FEW4eISqYfrPlE2de9D6/ZZqemTQ==
X-Received: by 2002:adf:f989:0:b0:236:5730:62f1 with SMTP id f9-20020adff989000000b00236573062f1mr17835966wrr.98.1666789374715;
        Wed, 26 Oct 2022 06:02:54 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b003c452678025sm2046253wmo.4.2022.10.26.06.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:02:53 -0700 (PDT)
Message-ID: <ec2b88b5-9335-4ed2-3a25-ff7850df720f@grimberg.me>
Date: Wed, 26 Oct 2022 16:02:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 16/17] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-17-hch@lst.de>
 <05e7fdd0-a2fc-2944-679a-dac3d4755f14@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <05e7fdd0-a2fc-2944-679a-dac3d4755f14@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_060256_814175_9059058D 
X-CRM114-Status: GOOD (  10.88  )
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


>> @@ -315,6 +315,31 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    mutex_lock(&set->tag_list_lock);
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list) {
>> +        if (!blk_queue_skip_tagset_quiesce(q))
>> +            blk_mq_quiesce_queue_nowait(q);
>> +    }
>> +    blk_mq_wait_quiesce_done(set);
>> +    mutex_unlock(&set->tag_list_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
>> +
>> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
>> +{
>> +    struct request_queue *q;
>> +
>> +    mutex_lock(&set->tag_list_lock);
>> +    list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +        blk_mq_unquiesce_queue(q);
> We should add the check of blk_queue_skip_tagset_quiesce() to keep 
> consistent
> with blk_mq_quiesce_tagset(), it doesn't make much sense, but maybe look 
> a little better.
>          if (!blk_queue_skip_tagset_quiesce(q))
>              blk_mq_unquiesce_queue(q);

I agree.

