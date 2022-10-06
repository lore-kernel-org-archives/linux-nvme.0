Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80764C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYvXTSvjb1rTcLtEIHCyxPLmlrBmjIb3Yd15rWeIH9w=; b=ozFsWuHDxnIru0BRqdV3rS0AfV
	adVfmYYVCD/R+QNFGQheNbxMYbTLYq8vRqZeL9PofyrTQ0rpawtfzNUVTd7ZYBXRI00Ms1Dmc7lg9
	fIAvRgb4Sy1/FRmskgD9H20fpWFmszAJwlY7TGlFgBLmZiexiqsfaB/kE293BgQl9kLSho32FNwEM
	mRcOdZlp5urMPN7MQdHPYsCWJeyKP1eJmPiWcEZdw8Co3qHzFok8NRgOtEnQgZ6PLBiKxxbkWbDW+
	ooJThYv4pahjXbZQEYzT/CZdmp8D5YgyRZEGpNNp/a7oeZIc6FQ62o41rGi4RXNXLYW24yqAqZQ98
	MBqFphgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogPDD-001wkS-HL; Thu, 06 Oct 2022 11:38:47 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogPC6-001w3O-00
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 11:37:39 +0000
Received: by mail-wm1-f41.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2986327wmr.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Oct 2022 04:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYvXTSvjb1rTcLtEIHCyxPLmlrBmjIb3Yd15rWeIH9w=;
        b=jLsMIE7deUITSMJDjsIFMUJTnmWARA4BFHnbWsV0UG1Jb1VkZ0pdqZ4M0KTnhK5pKz
         Ry7Z8l2DMw3QSykCP7AXIigepRxPuY4LVKNr/dTckNY/CriEWieY4tWr5GFHTf3Bmh7K
         tWWDAqtDthfI/jpxleBh7j/yMtIjV57zXmcWuedYfhDQOFqgKpXe/U349EPiWeYdPIum
         Y7P/SCk4s7RID+8BMr0GemuTyj1AddpdHQXIOe78zdjlTCDEQRDAg8W3fL/4WDHfRBPu
         +isHHSpkmp9PzuQrEgH05YGKuadaTC7yXVxTGjYo2Fd8PVUxAzvrKZ4vzYTpErj+l3zE
         qaQQ==
X-Gm-Message-State: ACrzQf01ASV1xHLtfMDnxLKYKYP23kCxqMtB9/vAuYalHoHlU8m7OWlY
	CaKbp+vt9GE/tq07heFuZIFtJZ1rXfU=
X-Google-Smtp-Source: AMsMyM4CGd/eqXlGNw9+Ec5j2tdLkUdKQepQHEBub/HsItW73EB6nlW8H9Ps0Xojkgsr5+M6AQUTpQ==
X-Received: by 2002:a05:600c:20b:b0:3b4:86ff:ce with SMTP id 11-20020a05600c020b00b003b486ff00cemr2747650wmi.179.1665056254743;
        Thu, 06 Oct 2022 04:37:34 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d5342000000b00228692033dcsm17520634wrv.91.2022.10.06.04.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 04:37:34 -0700 (PDT)
Message-ID: <74eb192e-13aa-5043-3016-5ce0d7ca2688@grimberg.me>
Date: Thu, 6 Oct 2022 14:37:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: "Knight, Frederick" <Frederick.Knight@netapp.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "hare@suse.de" <hare@suse.de>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
 <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
 <20221005181510.zu7vcwjtltcal2zi@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221005181510.zu7vcwjtltcal2zi@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_043738_076955_4287D450 
X-CRM114-Status: GOOD (  22.20  )
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


>>> As far I can tell, what's is missing from a testing point of view is the
>>> ability to fail requests without the DNR bit set or the ability to tell
>>> the host to reconnect. Obviously, an AEN would be nice for this but I
>>> don't know if this is reason enough to extend the spec.
>>
>> Looking into the code, its the connect that fails on invalid parameter
>> with a DNR, because the host is attempting to connect to a subsystems
>> that does not exist on the port (because it was taken offline for
>> maintenance reasons).
>>
>> So I guess it is valid to allow queue change without removing it from
>> the port, but that does not change the fundamental question on DNR.
>> If the host sees a DNR error on connect, my interpretation is that the
>> host should not retry the connect command itself, but it shouldn't imply
>> anything on tearing down the controller and giving up on it completely,
>> forever.
> 
> Okay, let me try to avoid the DNR discussion for now and propose
> something else? What about adding a 'enable' attribute to the subsys?
> 
> The snipped below does the trick. Though There is no explicit
> synchronization between host and target, so it's possible the host
> doesn't notice that the subsystem toggled enabled and updated the number
> queues. But not sure if it's worth to address this, it feels a bit
> over-engineered.

I think that for the matter of this patch, you can keep force reconnect.

But I still think we need to be consistent with the different transports
on how we interperet controller returning DNR...

