Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F751C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=H0zOIO4pX1bLqcby5ZromtfwbU
	5u20lCo/ygTvz5BuJ2HSt3AXTCJBeFvEdQrbJ6PuTWVNBv3yy+g/LgSehSMkMbhi/fsIdHOIHFb+r
	JJcSiw8Ws/2xJlaobbdwQk6Qp54QaKEmWPMWWtTeQz3MfkTDwTGgjM0/jJ9BR1TywOueetpV4Otdw
	fDUIeCsgEOk8w9mrkvu6XIXQFrhBlJfdurRRWceT3hntw+LlgRCsqz4BsteBrkTQW3dn19YHVefuh
	KYWLrZrP+XulRKu1n1mphRYgfIKbYYS0RCSg7hBpRYYmLEVvy9GMxcy4RlGgAz3Jqfz595CQLVBbw
	UQMQxK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVSr-00DyZ3-Q4; Mon, 13 Feb 2023 09:49:37 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVSm-00DyXQ-OX
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 09:49:36 +0000
Received: by mail-wr1-f43.google.com with SMTP id bk16so11455077wrb.11
        for <linux-nvme@lists.infradead.org>; Mon, 13 Feb 2023 01:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cd4RBiJIEtJtKTRiDHiZuVt2AindivNbjrizEbQxoYseV56PDhekgVCrgyMCtth4Op
         JlyEEF7sXw7KiHUmdkRmPCvFWJ1AAgQ/odxM2LrsrdOYen5A4SuMih2nNitX3XkPEqFx
         CHlG7YOfVWD2IO7VuTcoDCIDQQZVzbFX9rSDKCtKGAZIICEEG9s2eKgPsvNOo9ZMBEdS
         9wMm9s7Sj7S3wmMGz2sxBVCR0v2pQj6IX1BAibHeAtwMEAMaz/12T+uQX3/NIz1DEc6W
         dEmg9dHvL6vKojHaMxG2BZ6+55yb7BCPfHDhLuo2ezSyCr97UpoxA+YdzBlkkQ8bD3ia
         Rovw==
X-Gm-Message-State: AO0yUKXSwNxzc+HHvGDHLYzWF52iiTMGa8CirZl5Nge9qh4sKzc2RHTJ
	v9IYz9ystdZD7uZ7m97QTkE=
X-Google-Smtp-Source: AK7set9F+5yl2puIjKzL2TsG7D4nY0GwlSyOHTGRb9sR+2ir9QSi6yvjG4jfHYXLp2dZ2al5uzYgBg==
X-Received: by 2002:adf:fa92:0:b0:2c5:534b:ffc9 with SMTP id h18-20020adffa92000000b002c5534bffc9mr2855930wrr.4.1676281770043;
        Mon, 13 Feb 2023 01:49:30 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm8054772wrq.25.2023.02.13.01.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:49:29 -0800 (PST)
Message-ID: <38625d46-e595-27b7-3dea-bb2faf76dff9@grimberg.me>
Date: Mon, 13 Feb 2023 11:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/5] block: make blk_rq_map_kern() to accept a NULL buffer
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230209143820.118097-1-hare@suse.de>
 <20230209143820.118097-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230209143820.118097-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_014932_822753_04A705F7 
X-CRM114-Status: UNSURE (   6.77  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

