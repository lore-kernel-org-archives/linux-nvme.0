Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D54C0015E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUBV8qGSlyepybri9dttbcr3MFmDnblCsk/NzGVv1cM=; b=ZvgIBKkusYFWfLcjLovRvH6ucC
	UUjz/tuNCBaszksfYHFaZUPNtS3cuuCG8IGBr/TE5AITcPMSmOLQSUlr1AOdKlhCUm/G3uLbPWyJm
	DVeZ+7VLVSsny6/0dizNNepT3zaK2Zx96HJmxRn9o6BjemtRRbV0X9AkRSkwuont07LCPs2futxKA
	z/NwrWryG5763fZ98mt13eUBja/MnLz8z9rT2OL11wsXhwGJjJLtnShjyiDsWI4Qai3fiSCV4e83C
	5kIIMWmT9azj0+xeTgoe0SzvP8ey6zXRBYK7tWtZdRkOkEx35fyOfaPw51Xbb1P78OgMWA5MUd3n7
	FY0sOWFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQp6Y-002QBx-1P;
	Tue, 01 Aug 2023 13:08:02 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQp6V-002QBQ-1z
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 13:08:00 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fa86b08efcso10531795e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 01 Aug 2023 06:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895275; x=1691500075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUBV8qGSlyepybri9dttbcr3MFmDnblCsk/NzGVv1cM=;
        b=GpEHiGf/Lfw3u6E6/1EEs8b+bAapap1fR09BF5LVcwpPfR/TDoKhOBIPlYxTA+M5gw
         0ZaJQH3UAujO7I5GLKMw/PeKX1iH9VVrdv+KvDOP7trAi+tvDctL3rXBS0kkeNJpvaFV
         afk5fGeKXyEuJ1L7dn5F/t3peSuCwSUCzcUXCR4GKfO+RNqcc6myHOUEhSaIvfbZT4su
         FZRvqjKrqw0915wwGVsnnZ6vQmMYQ0lSx5qlZum0Z9YBeH+uXqoG9BoCmH86UxB2U2CD
         HyQkWETCRqoUHubIy+rShsxi9Ywy+bFXun7bK/84WSnNbdDeOWGz7ymEQjr4j7D8XYHc
         EkEA==
X-Gm-Message-State: ABy/qLZJQ5Dx7hHpTo9Be6DF36I/qsuxzaHhrBpBui3+rtoYDZTaplDt
	xITTKA5sUQk0stu5XFv9sbwHOoSW0wY=
X-Google-Smtp-Source: APBJJlENlHumMgu2sO44+WZmg8C2uiFXO+bVGX9tN+cf7r0uNNxoAhFB2Kcx1uQWDMgN8A/WmwRVDw==
X-Received: by 2002:a5d:67c3:0:b0:314:a77:b6c0 with SMTP id n3-20020a5d67c3000000b003140a77b6c0mr7313778wrw.1.1690895275229;
        Tue, 01 Aug 2023 06:07:55 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g17-20020adfe411000000b0031437299fafsm16242990wrm.34.2023.08.01.06.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 06:07:53 -0700 (PDT)
Message-ID: <1218c6c4-b18f-3d35-e4f7-8f645d6307fe@grimberg.me>
Date: Tue, 1 Aug 2023 16:07:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Rakshana S <rakshanas@chelsio.com>
References: <20230727150731.5905-1-varun@chelsio.com>
 <3e08284a-9163-a83f-b7eb-e5b697e45947@grimberg.me>
 <BN9PR12MB53249ED623D6024129237F03BC0AA@BN9PR12MB5324.namprd12.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BN9PR12MB53249ED623D6024129237F03BC0AA@BN9PR12MB5324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_060759_678947_865827CA 
X-CRM114-Status: GOOD (  14.43  )
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



On 8/1/23 11:26, Varun Prakash wrote:
> 
>> Maybe instead of (re)coding crypto_ahash_digest, maybe we can do a
>> little hack to pass the request sg from cmd->sg_idx which is already
>> set when we build the pdu?
>>
>> Something like:
>> --
>> +static void nvmet_tcp_calc_recv_ddgst(struct ahash_request *hash,
>> +               struct nvmet_tcp_cmd *cmd)
>> +{
>> +       struct scatterlist *sg;
>> +       u32 sg_offset;
>> +
>> +       sg = &cmd->req.sg[cmd->sg_idx];
>> +
>> +       /*
>> +        * adjust the offset for the first sg element if the received bytes
>> +        * is not aligned to page size (and adjust back after the ddgst
>> +        * calculation). A bit hacky but we don't need to do the hash digest
>> +        * update per sg entry this way.
>> +        */
>> +       sg_offset = cmd->rbytes_done % PAGE_SIZE;
>> +       sg->offset -= sg_offset;
>> +       __nvmet_tcp_calc_ddgst(hash, sg, (void *)&cmd->exp_ddgst,
>> cmd->pdu_len);
>> +       sg->offset += sg_offset;
>> }
>> --
> 
> In case of offset instead of updating sg->offset can we calculate digest
> for first sg separately by using local sg variable?

Possible, want to give it a go?

