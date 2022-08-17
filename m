Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761CCC25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6XoCRWTpHFxKAXiFtoAE096KFo+xlJ75DyKMVWp9KjE=; b=ySSqV2qTXyUUt3EB0KD+dvpdGX
	4rIPDV9q1Jw9Qsz3iNwqyJc/br2Xr6VfqvvmWTrPl+LeUlF762DrUIKrriduzh11xWvRwpxaR3gs/
	D826aeBJ+vJx5Q3fC92RBNgeBKzphSdzX0MPnREQNPHG9mYGtkGc9qi61UTbsN+uhSwJsfacgZFGR
	09KenUYAgqVS4K1zpt+ctMcm4cMViz3cU0AdXIjVqH8dZdotS9WIQAWxvy6WvfJVTfBdLYUFdwt2J
	S9eL9wM53bnjZJwyz3Xad1xwwOFkQzpPE4KTe6rSwW92WIEErQNmiIzgzRpCBivc1zV8I5dirParC
	HfBgyo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oONjV-004xVl-Gu; Wed, 17 Aug 2022 18:25:38 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oONik-004wk1-JK
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 18:24:51 +0000
Received: by mail-wm1-f47.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso1434108wma.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6XoCRWTpHFxKAXiFtoAE096KFo+xlJ75DyKMVWp9KjE=;
        b=O+wpVMNVeuYaWMjBPMvswo6HIqHyjpu0ivkxPsK3WCi2FRx2YNnDgbMfnv8D26PH1m
         bvB1GeFN2yJs1v1Zratx+foARNRI83y9kiq0D+b/EEXxsB+KAy4RJZWYP9z9a9Z0CIoT
         3ICSoMfAl7P30rxUBOIeZFS8UedAs0Lq+XCLCqz6wMsJ7j7itttqzqhhL1wNSyBHVWzd
         hBdP8uYuLrMv0grFIB6tDQAsorPyYDl2bS2OD4wKEbuIKfMHp+azxtBLtpoMJWwcBBuu
         QxmBNVSx3KrxKDRzoHYZ/gq0ReHK0L08n7HkI3Jth7LQsCefoXsPUGNsMK8LA6STByUB
         wi6A==
X-Gm-Message-State: ACgBeo2pefpdvOnKR4IzXej4PXg8lPHuWIFxrE5eW3wsNCMxw1R6xtKe
	LF9eUemQ4cB6lcliazh92j0=
X-Google-Smtp-Source: AA6agR6LAY7RcTFsAxJ/3LYoG+1PdOZtBozR/j5W5+DEosWciHEvkrT+THm9dB3Vn7RsIHRg4rtWNw==
X-Received: by 2002:a05:600c:1906:b0:3a5:f9e0:fcb6 with SMTP id j6-20020a05600c190600b003a5f9e0fcb6mr3044330wmq.157.1660760686884;
        Wed, 17 Aug 2022 11:24:46 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id j17-20020adfe511000000b00225239d9265sm2840786wrm.74.2022.08.17.11.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 11:24:46 -0700 (PDT)
Message-ID: <581ecec9-8f2b-32a2-6ce1-63551496e332@grimberg.me>
Date: Wed, 17 Aug 2022 21:24:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Ira Weiny <ira.weiny@intel.com>
References: <20220817170427.15682-1-fmdefrancesco@gmail.com>
 <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_112450_693589_769825EB 
X-CRM114-Status: GOOD (  14.07  )
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


>> @@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   	u32 length, offset, sg_offset;
>>   
>>   	length = cmd->pdu_len;
>> -	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
>>   	offset = cmd->rbytes_done;
>>   	cmd->sg_idx = offset / PAGE_SIZE;
>>   	sg_offset = offset % PAGE_SIZE;
>> @@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   	while (length) {
>>   		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>>   
>> -		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
>> +		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
>>   		iov->iov_len = iov_len;
>>   
>>   		length -= iov_len;
>> @@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   		sg_offset = 0;
>>   	}
>>   
>> -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
>> -		cmd->nr_mapped, cmd->pdu_len);
>> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
>>   }
> 
> I earlier meant just use a local variable for 'nr_mapped' rather than replace
> it with '0'. I don't think that 0 segments would result in usable kvec.

yes, that is wrong. Need a local int nr_mapped variable.

> 
> I'm not even sure the existing code is correct, though. The sg->length can be
> higher order than a PAGE_SIZE, so it may be over-reporting nr_segs. It's just
> supposed to be the number of initialized iov's.

The sg is allocated with sgl_alloc so it is for sure 0-order.

