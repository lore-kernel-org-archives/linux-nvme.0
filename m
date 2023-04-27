Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A4AC77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTSpPIZe1Obt24YjnKDvoF2YqyJyc7UGd5/XTD7d67A=; b=pm5xzGEVTF11REWGB+6B+95Bw0
	Bw1GLC3g64TScHScJs+YHCsHxdBNdw5e4T9Rw+pzn9vq624SkJO8RY+4V7vYawjm6g2lHQRxvU+VV
	uT3e32dt0B0TOoOcFTFhbvUn/XIUN3BtSHimNdZmWkE3TE3p0JBgDGeG3H27LGffadfduhzMEfJBh
	7Frd2GktLlBkVrt2QjRuWa8XoMLuA4Gl/XGy/zYIiSCxRO9r2xa2+r3jffTarWlPnhKZgBfs9vscO
	LZRnrTpRKEdH28L/6Ln2HyzkVu1IODuoQIjgdRsIWc2jta2pVIYYBolauX1nhHYgqlUWqQWSPYPVu
	6PsQR2hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0cy-006Waf-0v;
	Thu, 27 Apr 2023 12:21:36 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0cw-006WZZ-1j
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 12:21:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f174c4b404so15555145e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 05:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598092; x=1685190092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTSpPIZe1Obt24YjnKDvoF2YqyJyc7UGd5/XTD7d67A=;
        b=Ck9nPl4xhgx/KZQWM9UQLUaLrfQCmLYaD1nAZk9tKT0W+PR+k85qlx6n2C0Wh6Oh+S
         rIUe6G3BYrVPEVVP8WHyNpLTTGpTPnsgkcqrOk7iQ4OsAJM8if44IgiknyGbCF1/YfQL
         ZTBVd97/Ycf5Ln+y6YZ4jplO1YShZ1yhWFy4RBGVzB1t3poApIJQ0RoMeSUH8mGJo5MH
         js3YB0YfAtEHGJCTzG5i7X2l4qUcpHaO8zYzjWqj4HhJzJaG9x06jthpjFOYVT/ZfU98
         q3+GtzE12vgKPEUhIekcWAc2S65RbvWUqMmOKyfooUdKFMTQcfV8ZTTgqkIdfvAof2sM
         D2sg==
X-Gm-Message-State: AC+VfDwOY6O8Ol7Z6clCEVmcG3FDzdKr0m5Ma0Qr3PIhmjKdrftSUn3T
	ivFs1gkhr83tqOJY+qhz20wwc9jM09U=
X-Google-Smtp-Source: ACHHUZ4T8PmiD4CF0X5gwaMJ87abzq+NR5j3tA/Ftzc3Qrje8wr1IebNXIaNzviQVPGGDiKi7s71GA==
X-Received: by 2002:a05:600c:1d02:b0:3f0:a845:f215 with SMTP id l2-20020a05600c1d0200b003f0a845f215mr1374344wms.3.1682598091745;
        Thu, 27 Apr 2023 05:21:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c181000b003f046ad52efsm24372335wmp.31.2023.04.27.05.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:21:31 -0700 (PDT)
Message-ID: <a2eff7fd-5670-8c15-a72a-589fe7d99f31@grimberg.me>
Date: Thu, 27 Apr 2023 15:21:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Li Feng <fengli@smartx.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
 <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
 <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_052134_597707_965823D0 
X-CRM114-Status: GOOD (  11.76  )
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


>>> Not saying that this should be a solution though.
>>>
>>> How many queues does your controller support that you happen to use
>>> queue 0 ?
>> Our controller only support one io queue currently.
> 
> Ouch.
> Remember, NVMe gets most of the performance improvements by using 
> several queues, and be able to bind the queues to cpu sets.
> Exposing just one queue will be invalidating any assumptions we do,
> and trying to improve interrupt steering won't work anyway.
> 
> I sincerely doubt we should try to 'optimize' for this rather peculiar 
> setup.

I tend to agree. This is not a common setup that I'm particularly
interested in exporting something dedicated in the driver for fiddling
with it...

