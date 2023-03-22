Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE9BC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SGnSaHHVT5yK/5atifPp96l6eoFHAYSOYino46iiVgU=; b=gd6vNtsmrHIm8mVMuWevbn1Iii
	Fr1krTBtXvyEbT2uWPUr9NiOb81gfeYMI/Qupjbp/pFZnzwEvyFvHXYwTO0tJni+oSXlUm6p5WPEW
	piGamW3z3JX9iHnbb5ogoZDucIjU8K2vK5r7FLnSefY+YXfRUgrnBqOhdgsdKgbgD/X/nB0Dui1OB
	QrW5sTkldrzEg+rFvSJAPRbFw8q+0BnuBN0eJFjkQezNyCTcAHwqKpYlHUQyQfthas/297Ib+dPJq
	pWLVU3LaYxKkiZKlIUJ8BszK1JQRTDJMEqt6QCid8YEPs7A6wGvnrxgKm9Ra5/pkJoxr1URGqrmDc
	d1QziiBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peyAP-00G3ZT-1H;
	Wed, 22 Mar 2023 13:06:13 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peyAK-00G3Yd-2q
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:06:12 +0000
Received: by mail-wm1-f53.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so676553wms.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 06:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490366; x=1682082366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGnSaHHVT5yK/5atifPp96l6eoFHAYSOYino46iiVgU=;
        b=iHMofYeNhuw+TzUqktbwpTk4ebIHkUmwn+8tErZyqSBkwSOiCrn30xJGi7GX1yeD1R
         x14VnSGjJQNhhLv9XMMoxcO4RDS7huu24C4bFdLFFo3NRWGRYl/F+4mDvmOlePMoD9+G
         WDV+QEo2REBcZr9amNB4yZSXi9f5HA38KJfzFi10b9G4ml5drWhqY7RZb+ZRRWEcmpE2
         snwqB8FqQujYCrXv1YWZh/O7Ojce7mZ35crB/RZNAG+/PDvtQ8iQZy3xOVoXMrKWHlt0
         DvshT2kM8Gjzaxf0H8dkDkesPUCq+sQ9Oi0o+nT0fgtyZBWSK9KgWvHajxpWDY44EOWP
         XJjQ==
X-Gm-Message-State: AO0yUKWeLJnAZ47ud4p6pJIWWX11RthD35HpDiBibIaVeW1X3t5Ao73Z
	u8t1ZyzmMmep6tUll5wBN6s=
X-Google-Smtp-Source: AK7set8+QQoSPxmA9UGGRTkBK5Vm56SLZmzrrV580Px+mPg4UeQNLSPB1ctCLrDtO5bKHpffG3cBcQ==
X-Received: by 2002:a05:600c:3103:b0:3ed:d2ae:9adb with SMTP id g3-20020a05600c310300b003edd2ae9adbmr6204038wmo.0.1679490366759;
        Wed, 22 Mar 2023 06:06:06 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b003ee1acdb036sm6568165wma.17.2023.03.22.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:06:05 -0700 (PDT)
Message-ID: <7d59b26a-94ad-bdbe-7f12-9911de13484b@grimberg.me>
Date: Wed, 22 Mar 2023 15:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
References: <20230320133334.57325-1-sagi@grimberg.me>
 <20230322082034.GB22321@lst.de>
 <5f3b28e6-3bfc-d46b-7265-725d2c661c70@grimberg.me>
 <20230322082758.GA23221@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082758.GA23221@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_060609_744774_E79E3B49 
X-CRM114-Status: GOOD (  11.05  )
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


>>> Thanks,
>>>
>>> applied to nvme-6.3.
>>
>> Actually, I would like to waut for Yanjun to explicitly
>> give out his Tested-by.
> 
> I can drop it for now, but that basically guarantees that we're going
> to miss -rc4.

This has been buggy for a while now, we can wait and then have stable
pick it up.

Thanks

