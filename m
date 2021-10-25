Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52482C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 20:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE21D60EB9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 20:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE21D60EB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WjbiHP1ZtTDV/TyZXKUsc9hq2F/BsU2e/PUSNBqCcIg=; b=HkCqZUPFTK5FPtfJpetqtEKM3G
	t782i/O0GFzfHFLLQg+voznEj7c5CKZyKaPLJyBbEO3Z1CEmBF0quzFlrjW6ZoBQ4yVdMIKUmhLXI
	rHZW0nVQdbwXNrvYWe6CNi+6yG/PfIh3E6kGCEpW+NmAPxtuPYpFmDw8u/qjOjtKr+PQTgWM+0KLP
	iq1KYJrYyJaI/aISKsPn/fzNbtSsivDJfqRcBdy8kRBTYkq/M2WxGrhy5ncaOMfuVWqlbq0ewD5yQ
	Ly2euouY8Xo9z54WAy9s7SaLTmCNgEmKWvob4pLdIWr+u3PGBlqBbANzZy7WrYlmAtKDf0+YcOrNs
	XVaJUiNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mf6go-00Haka-F9; Mon, 25 Oct 2021 20:35:26 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mf6gi-00HakH-LT
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 20:35:22 +0000
Received: by mail-wr1-f46.google.com with SMTP id s19so14939047wra.2
 for <linux-nvme@lists.infradead.org>; Mon, 25 Oct 2021 13:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WjbiHP1ZtTDV/TyZXKUsc9hq2F/BsU2e/PUSNBqCcIg=;
 b=Ys0br1TaTSHNtJ/eizulksjrUVsn7vp7bDGf+Uc0IOtwcjUqLbWkH08u0xGyqmVQif
 kICw91HDUwjRWiAIP7rxYV216eHyGTcYg5uQ/zDxrmQeSf/5QgUtu7DM1RC+Ob3/VFuU
 ySKG8DoRA++KF8BvyBfXgL5/k9o4/WhGQxkFKv75nWuy+7hNJJ49Iq8Rh4kc1ExKsjkh
 Hl5NL6Ix7+yMVXDjCA+h9F1hzfoStEmWXaqGS7MQi3NrXItXrmai+cSpThYRSVDmd3Rt
 oLtUT+k0xE9Yy5kZNLno1ni3GW55JXrO8JOfFr9M/Z+uOWKjjv3mG+yIagqlc1w0Ucpa
 JqZA==
X-Gm-Message-State: AOAM530/ogP9+wMjBfZM1nnq74ypWeoWccg0dQuLaJnOu9k08C2gBwBM
 Y/5clrb1mGVnoGp7A+9SMyE=
X-Google-Smtp-Source: ABdhPJzClJ+KaXzi/eUxUpoUDJ2/r9jvT/rese0QF0mFp7Xi1nOBUd1TtGbbS8aTp5betYALNhOdrA==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr26595691wrc.105.1635194115737; 
 Mon, 25 Oct 2021 13:35:15 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id r1sm12233064wmr.36.2021.10.25.13.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 13:35:15 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20211024074331.546635-1-sagi@grimberg.me>
 <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <619dc01d-a4a4-c3e2-d228-15e57b8a3f12@grimberg.me>
Date: Mon, 25 Oct 2021 23:35:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025143838.GA2335106@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_133520_741623_1C9B4A9C 
X-CRM114-Status: GOOD (  16.99  )
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


>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 78966b8ddb1e..42b58eb1ba62 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -926,15 +926,17 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>>   static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>>   {
>>   	struct nvme_tcp_queue *queue = req->queue;
>> +	int req_data_len = req->data_len;
>>   
>>   	while (true) {
>>   		struct page *page = nvme_tcp_req_cur_page(req);
>>   		size_t offset = nvme_tcp_req_cur_offset(req);
>>   		size_t len = nvme_tcp_req_cur_length(req);
>> -		bool last = nvme_tcp_pdu_last_send(req, len);
>> +		bool pdu_last = nvme_tcp_pdu_last_send(req, len);
> 
> I'm not sure why you opted to change the name of this variable here,

It's designed to clarify that this flag is for the last send in the pdu
and not in the request (each request may consist of multiple pdus).

> but the patch is testing successfully: no observed r2t errors since apply
> this, so I think we're good to go for that regression.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks.

