Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4DBEB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1OGu2pUm28FpsvyFdHhbo2XJa+AfqIAoqGJyzvHHWk=; b=kSefuEJ8CfUSYbCMmg6ha1XS7X
	f+S2fbMeeL8GgkTogU/U4z2S4yVTB3LhxQr4bbgF86xUXNHMzMat9/Ksp5wXcDAbnIemPyESZQqkq
	1K5Os8SeeZMV2D8jurR4KfWLxQQXtDbp3u+BpBmMR/q7LBKFDTB4WMceW2tXmdhUf0lG6LrRShBsh
	ps3fTbvo1fXa+/U9y8Bslvc96WsdcxkHnkky3eGCg3xW7Jcn5JD3Xq1cGfEWXH9RfCims1UyO/fgg
	ez1+zSi8fJSaRPHHy1KhkigEKcfrgNPti8GhhLnh3+PVazA8BUg40Z2vwdDaveKleo+ZKc+hh+UI9
	PTIFS4ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbbN-00BQVg-24;
	Tue, 20 Jun 2023 13:40:57 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbbK-00BQUb-2u
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:40:56 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso11358575e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 06:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268452; x=1689860452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1OGu2pUm28FpsvyFdHhbo2XJa+AfqIAoqGJyzvHHWk=;
        b=Vbj94odKE8bpjCGeOM9Uahafe7dIEBhKoSEhpX8l4sb0XwcTElO8MOu51xOcFWPP3L
         IVDTg9CMC36Z6CBhXmbI7Kt3e6iA6euNPswxyxHX0DnPGlvKQEX3nCEPjgxoYINd+io9
         XpiieiV8WuG5Zq+LCIm44N0MZYncSkzrHcTsdbqP6zGodARwiDxl/ENYi8DnM5yCtb79
         78eK0X36W+hr/BnencKf0akzluusA9FdFN1Ug+/x1W1btAcM9csW966nbrRhvpSD6Jba
         9AJP7lBFL9fXHLULIgsRKURjEkxhAkymuqyrY5Mpo5UjxakWDYtaaX4HazPlm1MUpjMw
         MoUg==
X-Gm-Message-State: AC+VfDy6C87ysbBkJBuJiaZMRJBQOoQ5nqe8bL+ptUxwMjAjakJn7bjV
	DxG4sj+oZWkiWR8BS6FNOZk=
X-Google-Smtp-Source: ACHHUZ44cJuwkesDtL/NECGnennY0w2wAzhofWrWomZyX6RfBqrcD+4K0hy3nY3ufEffsP7ax+cdDA==
X-Received: by 2002:a1c:ed05:0:b0:3f5:927:2b35 with SMTP id l5-20020a1ced05000000b003f509272b35mr10919124wmh.1.1687268452542;
        Tue, 20 Jun 2023 06:40:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm2399517wmi.15.2023.06.20.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:40:52 -0700 (PDT)
Message-ID: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
Date: Tue, 20 Jun 2023 16:40:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_064054_939739_E1109F74 
X-CRM114-Status: GOOD (  14.04  )
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


>>> Hello,
>>>
>>> The 1st three patch fixes io hang when controller removal interrupts error
>>> recovery, then queue is left as frozen.
>>>
>>> The 4th patch fixes io hang when controller is left as unquiesce.
>>
>> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
>> connect patches?
> 
> I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> extra maintain burden wrt. error handling, but looks Keith worries about the
> delay freezing may cause too many requests queued during error handling, and
> that might cause user report.

For nvme-tcp/rdma your patch also addresses IO not failing over because
they block on queue enter. So I definitely want this for fabrics.

AFAICT nvme-pci would also want to failover asap for dual-ported
multipathed devices, not sure if this is something that we are
interested in optimizing though, as pci either succeeds the reset,
or removes the gendisk. But the time-frame is different for fabrics
for sure.

