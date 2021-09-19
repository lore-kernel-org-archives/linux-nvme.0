Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F791C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 07:12:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD54760F50
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 07:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD54760F50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJWrmUr5Ewq5xTWulm1xUHHt8EMx5z9qNi7ouIKdcDs=; b=0PVaiPRP2vHdlOuNHkTy64/av/
	c0zyPxX8fvNbKtowWcFmy6XHUfR55vbGzlIPA8irbJeHqR/6F98C8xftBj1m32jAXe3s9lLHKL4EJ
	MAsIDvKUtILoL5gGwuFFkXhXADaLZDqscpqLVX35LeXNmCm8ckl8sneGRVF0u5bdMsXN6q/lo9LnM
	1Zu2eYguXF9MOjhiSzgBBCR9lvQdcqXaa252sQXH8YtvMtQlNpiuj7hMzymx//yJeqtaYhyQ3NdVD
	pYDECkSsux2XSGVPQoaZyhvygq3lM06QmEIYeeGxrbOWzMKLTYECMsllsGMzL1ZZRp4kPrcCGuQyC
	syeMtf/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRr0F-00GuGd-QP; Sun, 19 Sep 2021 07:12:43 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRqzu-00GuG0-Ei
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 07:12:24 +0000
Received: by mail-wr1-f51.google.com with SMTP id x6so22645517wrv.13
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 00:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dL7ydF7VPkrUvMyHHr+7UQxIe4pE3JJE7YEQylKAIR0=;
 b=mOh8EzRo4kxx/fsFq8sm9NnXC1yKAn+e7yMPJDgpdfVz0pLNmGRPguUlh/znlo3qcK
 46mPZJZmVQcqWgcxwR+hA0E2O6sc1Wz803jHzB9eijCgW4udQp3ALpux41jB7yH4k/F6
 3ak5f2IEJx+Q6ZmoN7I4/FIknF9flYLUp69YNJ/D/Txh6glFGYRb2hNdLE3tuCCw9thp
 Hh/em/rzVkyrGIuVGZfhr54GRcz4tMHm+/zbDyJmY+9eoyAd4yap6+31bWO4QedpHp9a
 JB7dqsbUdAgwzISzcP0TV0KU264uVguDliPiiwneLZQNrcEp4lVTWSFo8O1hOq0gwTRN
 xtGQ==
X-Gm-Message-State: AOAM532Z7VX7sNgYjL/vXpvAKnMp+WcdC61Oy3WPhvPEn+NH9HCNPw2A
 qXATcEl3RKP/4kpJovAD9gE=
X-Google-Smtp-Source: ABdhPJyKe6Hi6HA58aKIITkyMZZMDLpHx5TYd6wccs7/w/N1tAzBXAQvFM1EGhP7rhGBZifPhfXxZw==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr21372938wru.384.1632035539710; 
 Sun, 19 Sep 2021 00:12:19 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id z19sm19038388wma.0.2021.09.19.00.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 00:12:19 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210916164559.GB3908552@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a006947f-8494-4e8a-1ab6-72372018b4e0@grimberg.me>
Date: Sun, 19 Sep 2021 10:12:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916164559.GB3908552@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_001222_556639_93F9B2D9 
X-CRM114-Status: GOOD (  20.86  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/16/21 7:45 PM, Keith Busch wrote:
> On Tue, Sep 14, 2021 at 06:38:55PM +0300, Sagi Grimberg wrote:
>> When the controller sends us multiple r2t PDUs in a single
>> request we need to account for it correctly as our send/recv
>> context run concurrently (i.e. we get a new r2t with r2t_offset
>> before we updated our iterator and req->data_sent marker). This
>> can cause wrong offsets to be sent to the controller.
>>
>> To fix that, we will first know that this may happen only in
>> the send sequence of the last page, hence we will take
>> the r2t_offset to the h2c PDU data_offset, and in
>> nvme_tcp_try_send_data loop, we make sure to increment
>> the request markers also when we completed a PDU but
>> we are expecting more r2t PDUs as we still did not send
>> the entire data of the request.
>>
>> Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
>> Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
>> Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> - Keith, can you ask the WD team to test this as well?
>>
>>   drivers/nvme/host/tcp.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 645025620154..87b73eb94041 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -607,7 +607,7 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>>   		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
>>   	data->ttag = pdu->ttag;
>>   	data->command_id = nvme_cid(rq);
>> -	data->data_offset = cpu_to_le32(req->data_sent);
>> +	data->data_offset = pdu->r2t_offset;
> 
> Shouldn't this be "le32_to_cpu(pdu->r2t_offset)"?

No, data is a wire payload, so it is le32

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
