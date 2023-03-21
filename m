Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B83C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 09:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPNYcp8qC0ANS+psDMcZmoPIvl1R9YQbevsEoWMVcPU=; b=f6TtbNfvw5+eMsj7YTq08ToPov
	jymvPRKxEGDIinN7xpK8Jpnq91jPmu7OzNGcqhtTLqLhadngppyLjoSmejh8R8YwdTJXs+K5et3xC
	BGEnPScgMl9t3JR5wxOEKqLV4Wr/7d0EUr4sCNN/ZijR3XR2VYlhIoLEy/wMHAYpm6TA9Po6hcZRQ
	AfCPXoJsMUOJzoaR2ZdAWKfCYAWB1S0bhLpY1tUF9C7wzshzoPOY8y7l31y4Z6Kb3ifZB8nHNHthH
	qo4vLoDOxdkD00/yQMTn5/PcgZJ4+krzDQaueujJBg5K7UlXzs2r0nPH1pWzeZTCEfk9Y5TXw+73G
	0/WT2a6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peY63-00BrWm-1k;
	Tue, 21 Mar 2023 09:15:59 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peY60-00BrW5-2y
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 09:15:58 +0000
Received: by mail-ed1-f44.google.com with SMTP id x3so56847066edb.10
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 02:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390155; x=1681982155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPNYcp8qC0ANS+psDMcZmoPIvl1R9YQbevsEoWMVcPU=;
        b=2OolmJJuRx1V+/ev7cZ+sQpt6MW1UwhmPu5D31zDxWwBjHpOFjo5xDwTXucVxTs+4A
         U71ilhWC7zWwjHAMQDYrCt9H/R47DNHmoKQtB83SYy4KULZoMQir2HPpDdFRdRXUiXmv
         ze0tZxI2ffEfA+Ki47vRUuscASe+LKBubrvYbdqWTmWF59dtAnhy3FvAILXV4iMgp0uG
         nrSKj0TtuExAK1Tsi3BGjcuxK2Oj8+e7NjsOwS9RitAfBj6YTl7y+z6c3rDAi5e02NZZ
         gFuuVVD28e44U4Y7bB5nnOMzwe+9KwxtLZ4ltRT34TO6+R+bKEuFNvjh6oxn/YtQvu8k
         C/yg==
X-Gm-Message-State: AO0yUKWxA5WzMpsgX4r6bjQ8G39d3vqTcrUS1tPNPGKu5hrtpMVPTq1n
	qSotqAv21NFUTeOoMaU7C/gNRsh7X6s=
X-Google-Smtp-Source: AK7set9dqLdJ6rG91SLrXFlIgU/7nrSNX0nvKHMsq5hampEGLf7+ej/QcEW7wl3BECCXFZywi/aZhw==
X-Received: by 2002:a17:906:10d0:b0:931:4285:ea16 with SMTP id v16-20020a17090610d000b009314285ea16mr1891509ejv.7.1679390155135;
        Tue, 21 Mar 2023 02:15:55 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00930894eb708sm5532051ejj.223.2023.03.21.02.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:15:54 -0700 (PDT)
Message-ID: <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
Date: Tue, 21 Mar 2023 11:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321090913.gwuvyuw76ha62hgb@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_021556_954722_97665886 
X-CRM114-Status: UNSURE (   9.60  )
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


>>>>> Thoughts?
>>>>
>>>> It still crashes in the same way with both patches from this
>>>> disucssion applied.
>>>
>>> annoted the __nvme_submit_sync_cmd:
>>>
>>>
>>> [  210.019050] nvme nvme0: rq ffff8881122a0000 bio ffff88810d8cdd00
>>> [  210.022653] nvme nvme0: rq ffff8881122a0200 bio 0000000000000000
>>
>> Why is the admin queue created as a polling hctx?
>> It shouldn't be.
> 
> Isn't this because we use NVME_QID_ANY as qid for the register access?

The admin tagset does not have a polled hctxs map to begin with,
so I'm unclear how any fabrics or admin requests end up polled...

