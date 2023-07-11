Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D3EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/v941ucvo72PkhxWJDqp+4mJnXPIS0RPAlyaHweRTGs=; b=QZv6khZn1AocWf/ROXN8gR3Usz
	AI3RjtmRvCntY5oJsq7ABaaX7gvDR3XmmOVc3VXqrF99RbC8ckHvLV2YBCMQz8ux/Qs5lMp9S7Q3D
	3lKG+uLs7YHlAIgjH7ZwycXy2qLAcbb+pHYepqHhWszcr6/tDsSpusK7jRJu80yvOq5qsBNDhaioU
	X9m+dMFcmhp0XvuZZZIOVEiXv7ugTW3UHh39sZ6JgIqyD7QRinFLJLF0U64Tcu+URpOUI90Zdgv6N
	0Vit9JUwmunxJ/NSctW3WNUG7jixNL720chlh6ucj9L/kLVjuUblr6lOYzCIZFeLdRXA2lJJz9/+y
	EaAEuaRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9Q3-00EFPC-13;
	Tue, 11 Jul 2023 09:12:27 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9Q0-00EFOA-17
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 09:12:25 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-313f5f5c6c3so1441619f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 02:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066742; x=1691658742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/v941ucvo72PkhxWJDqp+4mJnXPIS0RPAlyaHweRTGs=;
        b=Rbg11zSiWn747JCgnYZJT1RGalbJe8NEIIw2dr1UYSuOuohdixeHZysnG73cpFwriJ
         5zwtFJgfN6AECSh/U89GP/1RkvQ8z5T06Wt3Ucs2UoeK+O0WeZXrkPdgwCY1uLyMsLUS
         xZGIIgpUkZwBTTyqlxxuBUdNQJKT1Nl9GoUvZ5MrLVQDNZENDDYvkUCKa+vASl9GPej1
         mx54ZBnbjsSShHSbHeRxah9BsLaEsblEQS8bzMpjkcFz5j23ouP5ymAtL9q+Q/AYHMGW
         0M+fmVgejy3EJH/uPsjxuOivxdSneoRS+fNdptwjOJSe+4/X3NfLJkodhb2lb0bsvg6m
         xFUg==
X-Gm-Message-State: ABy/qLZgzm0cc72Ij6Wn7InAWixdwQ+gE8kC6v+d7W+XV9wXqKdT+/eQ
	p1tqoN4gdjm3/7ew2iOFTCE=
X-Google-Smtp-Source: APBJJlF6G48sfVAYHYwypJxUvgo1ZZPZb7JnKHKTdoRUQmiaqF4gNrKEkoQ5BDVyiW/PojB9s8aLLQ==
X-Received: by 2002:a5d:488f:0:b0:313:e8fb:b00f with SMTP id g15-20020a5d488f000000b00313e8fbb00fmr14129148wrq.6.1689066742267;
        Tue, 11 Jul 2023 02:12:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y17-20020adfee11000000b0031274a184d5sm1685649wrn.109.2023.07.11.02.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:12:21 -0700 (PDT)
Message-ID: <84f74166-b26d-c1de-ee8c-1937a4d3518b@grimberg.me>
Date: Tue, 11 Jul 2023 12:12:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] nvme: unquiesce io queues when removing namespaces
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-2-ming.lei@redhat.com>
 <20230711082719.GA23019@lst.de> <ZK0TRK89VVatUdXE@ovpn-8-22.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZK0TRK89VVatUdXE@ovpn-8-22.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_021224_379196_0EFC02E9 
X-CRM114-Status: GOOD (  11.02  )
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


>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 47d7ba2827ff..98fa8315bc65 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3903,6 +3903,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>>   	 */
>>>   	nvme_mpath_clear_ctrl_paths(ctrl);
>>>   
>>> +	/*
>>> +	 * Unquiesce io queues so any pending IO won't hang, especially
>>> +	 * those submitted from scan work
>>> +	 */
>>> +	nvme_unquiesce_io_queues(ctrl);
>>
>> What quiesce does this pair with?
> 
> The one done during teardown of error recovery, then removal comes and breaks
> the in-progress error recovery.

unquiesce is also safe because of NVME_CTRL_STOPPED flag. All the
drivers depend on it being this way as we unquiesce unconditionally
after reset/(re)connect.

We don't track enough state here to know if the io queues were quiesced
before or not (in the happy delete they weren't and in the unhappy
delete they were).

