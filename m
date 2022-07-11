Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83975C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jul 2022 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txFXdouWdbSMaKn/caC2kD6TFZVlGEJSQ/STyjeuePM=; b=26TNkSbr/9UdO6vd1yKxj27ygL
	wGFX9U/ASA/4p2xNg/8fB51DLtqSe9Ajjz5A7k6NcfuX9CTak4XaE3Sywfsr5e/ECvwNu6LSShtAp
	Vlx8Jf4PU1EAF+3Ypv3LPwwrYXLA+0ln0OUpHABbFR8diTYxEXTCF1Ikpfgwu1gb8p6H165e5XMU1
	M92dXcy3psV132CDoQwbvyYXLSmIx1C39/Jhq9TMGIoKtsFIV4Hab9b23yoEnyZr2o/MbmWnojeGV
	ChPc/9ru1KoO5tngHGeGFhiT6UCvMUI+XjqB3PCapS5KM7xEKtgZZOm7a6pM9QGmUflqqYQKnC4Go
	XsCRJMSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAxdT-003fKo-TD; Mon, 11 Jul 2022 17:55:55 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAxdQ-003fI9-Vd
	for linux-nvme@lists.infradead.org; Mon, 11 Jul 2022 17:55:54 +0000
Received: by mail-wr1-f51.google.com with SMTP id v16so7980914wrd.13
        for <linux-nvme@lists.infradead.org>; Mon, 11 Jul 2022 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=txFXdouWdbSMaKn/caC2kD6TFZVlGEJSQ/STyjeuePM=;
        b=uOPheysNOY4Zu9xPn1OicjXXPM1+2VAP1Iz11aT7IUjKo7xuHUPE1PsircEfVGk8KZ
         nZZs0Z+e8n+mWDFiwnbwNGeO1tdfdoD/Uply7wThkQPxKvCqgvhs46ylUVbu3+uhVE1y
         X4c+MELQ6dRZgaEzfA/srmMxmFMvt13aFyNYC35hYg/c3tE+emu9mJSlMORx2vnzr9vm
         1aEug8r9ig260zIFtPBU08fqX8fNwhkWpjNR0IZrqhKp+f1nAFk+cbd6m0Sw0V+QeHUk
         w95ZaqR7asq6mMPmBRYujxpNkBaP22L1LqNXkfDSMlx67rILI3pBOt/jgZBQCQhYPpnx
         a39A==
X-Gm-Message-State: AJIora9K0CqqtC0jfPE6KuTeWYU0IalL0O6hl7QNfW3vNS/QBxTxHGBM
	M1tVMHvZnEjbOmJNo/arP00=
X-Google-Smtp-Source: AGRyM1sKxx1B26hTHr9NFnILGrSO5IkEVbBifXCrW4nydchvlUTDPmtgCkdme4W/ypt+B+OyHU0BLw==
X-Received: by 2002:adf:f946:0:b0:21d:6433:a7bb with SMTP id q6-20020adff946000000b0021d6433a7bbmr18582857wrr.518.1657562148165;
        Mon, 11 Jul 2022 10:55:48 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id w2-20020adfde82000000b00213ba3384aesm6353066wrl.35.2022.07.11.10.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 10:55:47 -0700 (PDT)
Message-ID: <43955a42-7185-2afc-9a55-80cc2de53bf9@grimberg.me>
Date: Mon, 11 Jul 2022 20:55:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 3/4] io_uring: grow a field in struct
 io_uring_cmd
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110824epcas5p22c8e945cb8c3c3ac46c8c2b5ab55db9b@epcas5p2.samsung.com>
 <20220711110155.649153-4-joshi.k@samsung.com>
 <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2b644543-9a54-c6c4-fd94-f2a64d0701fa@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_105553_048913_2B217473 
X-CRM114-Status: GOOD (  10.31  )
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


>> Use the leftover space to carve 'next' field that enables linking of
>> io_uring_cmd structs. Also introduce a list head and few helpers.
>>
>> This is in preparation to support nvme-mulitpath, allowing multiple
>> uring passthrough commands to be queued.
> 
> It's not clear to me why we need linking at that level?

I think the attempt is to allow something like blk_steal_bios that
nvme leverages for io_uring_cmd(s).

nvme failover steals all the bios from requests that fail (and should
failover) and puts them on a requeue list, and then schedules
a work that takes these bios one-by-one and submits them on a different
bottom namespace (see nvme_failover_req/nvme_requeue_work).

