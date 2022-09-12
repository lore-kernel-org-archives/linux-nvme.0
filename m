Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80085ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/mrwAhkttjMUseC4C+DSpr7WQNE1b3yUDpvKTLpUaTk=; b=0bqnFglTJUSho5MfatJ1Z1fSWx
	QS3hw/R4/3LEYpjYj+zpH0/S1xr0iThf2OkgSKRxa1bwmSOulKzTVqWYb7Tsa/9H7Z9veFuUo/ZWM
	lft/p2EVtmePPZd/8K4hmOkeTO5bAv1+ufsdMv78n/oTrgjseZFBWptxIzCsdXm64GNnxVEuUf3Tt
	VCSV1tXxBHfWZ8x9OSru0ubphVU9ebBwWkz6M5LQBZv291T/xeWeTjh5ZWwlKHEDPrW5obG1FDV0f
	1J0Pceu6Dp5Z/k80ozYBcTun9P+dQmJnRBlicleMpWrdBWRZcvW+5wPXUKzM1A4+PoRSFEfjwoS49
	X8hP+WsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiUt-009iwO-7s; Mon, 12 Sep 2022 12:25:07 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiUp-009iu8-Rw
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:25:05 +0000
Received: by mail-wm1-f53.google.com with SMTP id l8so1643119wmi.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/mrwAhkttjMUseC4C+DSpr7WQNE1b3yUDpvKTLpUaTk=;
        b=vjTXNu7+9tIiXZG8CcESyW+rGCiXzIPs66FRyy0p+4cddFYWJHy6oH6YyADpD58MHd
         hZsSMKNE/KEkxJnkXPCU8YRY4/QNEHAnc24wD+5m5I3WAWtClqNzapGMVfONEQxQx9jN
         CHwzb1pE5AghHY5cvH/CpEiKi0XZOhrZaLj9NYcUOhYOkGUYyAIO0jzThl4SSTmBDjPw
         Ze6N+4Nap886qBxA4Zuzmy+lip6syDueRyb4jRUQToR3s6uja0Cg1M7nJvpoW+IPhh5l
         z5SRIKddULZg6EjhSE8o6sCI2gzj7w6f7D/cfBsHOHUgG3kB3gRm8VxRFCjYkH275O/K
         K4XQ==
X-Gm-Message-State: ACgBeo2fqr61CSrvgH4e0BCT/RfnbSRuyIfgha5Lya7n+ajzuCdDwOxM
	fL9Nivc2SHm/boePH9jSX7QxQPUIKL0=
X-Google-Smtp-Source: AA6agR7daqPHAHJd3aD49E8kfU4Q5FhUmBEsagWSO96uJA1Px5kTXisZPoPfYeQyse2tpVOHet1CkQ==
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id ay24-20020a05600c1e1800b003b3b9f82186mr11069239wmb.151.1662985501318;
        Mon, 12 Sep 2022 05:25:01 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z19-20020a1cf413000000b003a5537bb2besm9488740wma.25.2022.09.12.05.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:25:00 -0700 (PDT)
Message-ID: <34c52d5c-ae05-d896-0bbe-26f1a444afcd@grimberg.me>
Date: Mon, 12 Sep 2022 15:24:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE
 state
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Varun Prakash <varun@chelsio.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20220904213518.4532-1-varun@chelsio.com>
 <91de007a-e860-faff-9e86-4166bad7885c@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <91de007a-e860-faff-9e86-4166bad7885c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_052503_974103_C8678944 
X-CRM114-Status: UNSURE (   9.22  )
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



On 9/7/22 19:03, Chaitanya Kulkarni wrote:
> On 9/4/22 14:35, Varun Prakash wrote:
>> If target receives ICReq PDU in queue state NVMET_TCP_Q_LIVE
>> then call nvmet_tcp_fatal_error() and return -EPROTO.
>>
> 
> Can you please state the detailed scenario in the commit log ?

Can't find the original patch... Where was this sent?

