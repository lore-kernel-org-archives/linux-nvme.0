Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465C9C761A6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrb82PZhwYG30G9CvM6x/5xpRlj5GG8gb4X+iqQeUvE=; b=EF+a9QdylPm8q5QdcG7j1w3+VJ
	neTEevBG6bgChkbKvnosufVD/n6aGYDngHnA6+pnh5HiFW0lHGB2gZFpUGDPezkFwkqinUPhTMAMh
	Eu+W3SdpTsXtmMB4iDYgm7XBToFfwJ3BS+7u/zqwVdbcuqaszluUjTxuCz7R6IR2Fu/5Jbld0uDZV
	X6eV3TJtODYLPFoJ5vBWw9unuR27Ql83NGr7kAoXVHxeOgnpKrdtD5FL0WpCxH1TOszFi2ydweFlp
	d57S7cjKxF3u8F0HJWRgyBO3UkusRuQYSQSiACGutippaO+romYob09jeSIR39zHM3Z5saOUHXUKS
	wSu1N5Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4nN-00Dbc9-1O;
	Tue, 28 Mar 2023 08:35:09 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph4nL-00Dbaw-0r
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 08:35:08 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3ee4aa9acd5so5608225e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Mar 2023 01:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679992504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrb82PZhwYG30G9CvM6x/5xpRlj5GG8gb4X+iqQeUvE=;
        b=o9W2n0pqd+359hVFUvPDH/BzOtBvJeDDxjFJW4j6i68rZ1n/3Lsl6LylQqGDS9EwNm
         bZaXlcudBUIw0UJ3s3eZB6NN3qAMy8IdFbfkTJDNI7DX1CIRIR2k6gAaAAAdq++VDuT1
         cX9Q37JrO8rbf6lHvP6P8jQHUEMAbG1zzc4VbGuqmKzmDtNGTsCGoI+3AzS2Ypoesyso
         7dQrNT05OSEdEsdkddIT63N5XJeKCgXgFiaX2NdztuxcxvxKFKPC5FP5po+OEQaxJ3qd
         KW+Ef3XVCj68zb6TMu7jqySpRsemmC5jaNEXzcPh5NZrFyPORtIllQsyCV4kJAOdCSox
         OqYQ==
X-Gm-Message-State: AAQBX9cztioi5/8VMugTNzNdXV1O3t/VQBZCEnNmcNWmLVzwKHoh8R5Z
	7ivjFSVAmlGyr7v8dhhfA2I=
X-Google-Smtp-Source: AKy350aPgWujwxXnHUMyKZo6LhoKJejbw5YY4NYR2NvmUCM7+HLiJpTNjHb/chW37R084iceeRJxBA==
X-Received: by 2002:adf:e786:0:b0:2c7:1c72:699f with SMTP id n6-20020adfe786000000b002c71c72699fmr8950485wrm.4.1679992504599;
        Tue, 28 Mar 2023 01:35:04 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4e05000000b002d75909c76esm20163490wrt.73.2023.03.28.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:35:04 -0700 (PDT)
Message-ID: <c90eff27-9d27-386a-ce07-459ebba3cde1@grimberg.me>
Date: Tue, 28 Mar 2023 11:35:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
References: <20230324212803.1837554-1-kbusch@meta.com>
 <20230324212803.1837554-2-kbusch@meta.com>
 <55f9c095-32c2-648d-7ac9-84c1d9224abb@grimberg.me>
 <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZCG2b85hN+pTm/VZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_013507_305801_6EB46BDE 
X-CRM114-Status: GOOD (  11.32  )
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


>>> +	if (blk_rq_is_poll(req))
>>> +		WRITE_ONCE(ioucmd->cookie, req);
>>
>> Why aren't we always setting the cookie to point at the req?
> 
> As in unconditionally set the cookie even for non-polled requests? We need to
> see that the cookie is NULL to prevent polling interrupt queues when an
> io_uring polled command is dispatched to a device without polled hctx's.

Why don't we export that to an explicit flag? It would make it cleaner
I think.

