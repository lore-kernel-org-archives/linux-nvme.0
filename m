Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F3AC4706C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 08:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMBQFIUc876c34QlGFj5kCBCwaB1hFXiQWq6EzUwpEM=; b=asQ1iccxU4nT1bmnzpy8b/JcJV
	kEzqJEo5wptty5gsW7QsmgaHqErn6MJQ75NSVfV4KeJV0LsEIDhOego0l89gQoTA0A/Mek7hVbTP6
	MmGvJz7kRPf7Eunf3cKxk6LNz3YdcLnpiT4VcOhGdvzLraSFxwpSctBVGzbRDK9l6DpMeJt6Zw/Hr
	qgSG8R6c1LAM4PjEo7m+xQrnDbDHFDeD0k+JEjwB/uMeer4X1ShhjNysthXnv1ADQIbmAnHfovP+2
	ptyImqAxtb9wGaz2+S/vDTMeO/X1O0dabFj7ZZ5IdxX+QorcKlkHvkloL9F1Y276uBmwuvdeyanVh
	tjhtn19g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeWE-00BMqp-1U;
	Tue, 16 Jan 2024 08:09:58 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeWC-00BMq8-1B
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 08:09:57 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e6c0c0c6bso2097186e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 16 Jan 2024 00:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705392591; x=1705997391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMBQFIUc876c34QlGFj5kCBCwaB1hFXiQWq6EzUwpEM=;
        b=CTvnkN0g+FgwOmw8aNhIB2YzZQXzoD0/luKwrgNDdetKme6lUKEPYYSA9uU0S3vuH/
         PGGj3VQFEw+YG4ByrxMTNm+3diO61WfkM79qYt4dNfQrFkn9+ipRW8zeyGGGMrcuKs/0
         i1lg09VVOpIgbQSf991TizRpIR5qWr1/5habLRVg0mXiGqvAC2VNFWv+tX+znjMUgV5/
         ktFvHk9RIo64pkKk+hh2G3qX6raeM262D2dyn+RXP6iV/6B0wnUGwh2dZtPh9sBadCvU
         RvOz378tgmGJzvfAmbY9L+JzJ0Jkh9TRPKKg4s7fbeWWlfh7GhxPgLGw8DyIDVIfWQ/u
         5fJA==
X-Gm-Message-State: AOJu0YznXkqFpQJhuA9ybedQWXWWavcie3vaKlTNI1upUGFDqtp3jwIn
	fco3nmHUzAfgG2cD3FBc7nw=
X-Google-Smtp-Source: AGHT+IHBoDCshdlQxeop4p+9fUdt7tngJv50cHq+3B66DtvHaj2UCXnNuEX/1RU1wwnmrWs97bpL7w==
X-Received: by 2002:a05:6512:3122:b0:50e:76f1:be2e with SMTP id p2-20020a056512312200b0050e76f1be2emr6800229lfd.6.1705392590486;
        Tue, 16 Jan 2024 00:09:50 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0033686e8f02dsm13919384wrt.45.2024.01.16.00.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 00:09:49 -0800 (PST)
Message-ID: <493dfa7c-a0f3-4207-90a8-b22fb17edf20@grimberg.me>
Date: Tue, 16 Jan 2024 10:09:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Content-Language: en-US
To: =?UTF-8?Q?Sa=C3=BAl_Valdelvira?= <saul@saulv.es>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240113213012.30898-1-saul@saulv.es>
 <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
 <lnfpduryv5nwibiejqxnvohr4pcismnkyzkowqvit3gkpdgt3d@ojcvlonaolzu>
 <df8864fe-655a-4890-a19c-7fb69513aeb5@grimberg.me>
 <qy2em323bnjfuy5if2yyxw5qrzurplltlzqgpg6xpbnh4hfy4f@olq7qyaudjcr>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <qy2em323bnjfuy5if2yyxw5qrzurplltlzqgpg6xpbnh4hfy4f@olq7qyaudjcr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_000956_423795_59D7BD76 
X-CRM114-Status: GOOD (  11.92  )
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


>> Strange. Not sure why it wouldn't work unless the vendor/device numbers
>> are off...
>>
> I got the numbers from the this command "lspci -nn | grep -i nvme"
> The output was :
> "04:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue
>      SN500 / PC SN520 [15b7:5003] (rev 01)"
> 
> So vendor id is 15b7 and device id is 5003, am I right?
> 

Seems so, but it doesn't makes sense to me why it doesn't work.

Do you have force_apst enabled?
What is the ctrl npss value?

