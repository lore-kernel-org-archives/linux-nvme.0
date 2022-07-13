Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA081C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 09:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4vlOUSuSK+FhTh9wftzc20mzgHbEI0vkhcBDU8k6o0=; b=BnAZKm2TtCsRQz5cnPfqRGDwDE
	sX22fWqIQg0IHwV8zyUlr49CUsWYRlnYg5auyxMKhd9WvfqhxhFm0hJjID2eZbGRbT39+3DXVtoPD
	ptaT9j7ovlxUoubmQE8hfcmHB2llkogKPHXamA3KFEIF2XqiineqI7oY9THkPwTpixub3Dc96Pl97
	E8UMryQ7Fc8fu9pdnKZL8Pdt3Ft7THz8eVWTO68P5Ev6NTFc9QJ7LPQJY225cRuFWgpbeV1anW7Wu
	K9vTOhpeRGciVdaBq6qcgz7fh9crVQTHPdqiIFMbv7LdpQhRqx54zutS8FWGBpNg2bFQp2mM+sAvf
	aS5BeYXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYHn-001zNB-M6; Wed, 13 Jul 2022 09:03:59 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBYHi-001zHh-1e
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 09:03:55 +0000
Received: by mail-wr1-f51.google.com with SMTP id a5so14534695wrx.12
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 02:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D4vlOUSuSK+FhTh9wftzc20mzgHbEI0vkhcBDU8k6o0=;
        b=DODZ5OCPrv3W6Rp8uIekIQnbkKyrZy0C7/BDFpxAv4QoQnQxihJ9mIfM5Np67Mxucr
         bpS7sKAN8t5lPEv4ZrLwDzZpEJ+JR3TKFzwNYSvUpUm/3p70SAXK/JCfDcVgEGkdnuk3
         lh8BFkod8vElt9SoM2xA3zbpjBsWmjQu0hMoWNvt7HxCN4PaSg1nm5YPK6B75A799KCB
         qG/EHQPHN07KI9Tf1dji/qdCu+SCdQ5F8Vt5fgxXOl8BAIALxV9AeeYg8Pr7qteNOU1W
         cRzoXqLgc1iQdJ2KPnVVptdOwsNr0EjxGY+ie0Lx48X1sUVK+XgQf69UpO9NbOhwQTiC
         nMbw==
X-Gm-Message-State: AJIora99cjUlsfe6sHDQNbyh0Hd7Jl2KNLZDttfT7npgM/tIGzTPpZ9I
	oqIGD638sViIfSnshBmZpys=
X-Google-Smtp-Source: AGRyM1sUOndfxHpFDhmMn2Ko7HTQ1cbOP4ustw2mw9OA5suipI6Gdfvjnx8Gk5ApYqYcu1YToSzZJQ==
X-Received: by 2002:adf:fb83:0:b0:21d:649a:72d9 with SMTP id a3-20020adffb83000000b0021d649a72d9mr1986938wrr.688.1657703031143;
        Wed, 13 Jul 2022 02:03:51 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b0021d68a504cbsm10344745wrx.94.2022.07.13.02.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:03:50 -0700 (PDT)
Message-ID: <f15bc945-8192-c10e-70d8-9946ae2969ce@grimberg.me>
Date: Wed, 13 Jul 2022 12:03:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 asml.silence@gmail.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com>
 <3fc68482-fb24-1f39-5428-faa3a8db9ecb@grimberg.me>
 <20220711183746.GA20562@test-zns>
 <5f30c7de-03b1-768a-d44f-594ed2d1dc75@grimberg.me>
 <20220712042332.GA14780@test-zns>
 <3a2b281b-793b-b8ad-6a27-138c89a46fac@grimberg.me>
 <20220713053757.GA15022@test-zns>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713053757.GA15022@test-zns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_020354_129904_FA97069A 
X-CRM114-Status: GOOD (  12.77  )
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


>> However io_kiocb is less
>> constrained, and could be used as a context to hold such a space.
>>
>> Even if it is undesired to have io_kiocb be passed to uring_cmd(), it
>> can still hold a driver specific space paired with a helper to obtain it
>> (i.e. something like io_uring_cmd_to_driver_ctx(ioucmd) ). Then if the
>> space is pre-allocated it is only a small memory copy for a stable copy
>> that would allow a saner failover design.
> 
> I am thinking along the same lines, but it's not about few bytes of
> space rather we need 80 (72 to be precise). Will think more, but
> these 72 bytes really stand tall in front of my optimism.

You don't have to populate this space on every I/O, you can just
populate it when there is no usable path and when you failover a
request...

