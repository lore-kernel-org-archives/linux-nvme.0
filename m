Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F80C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2XnAIZo4F9dSg2/HrPYqXkXeLAaoG9uThWsD0uBJlA=; b=KqE6XQBaDZ4qSZ5ZqHbPnSIk3d
	pTNAkx+GLJLYlCLsQngMY+PaXai1dLV1cuGwaoZXBAt0OOFJcGskPa3b6owIrApF2jcwBM4ri6rnE
	1xOFO6I98M4cyslDMeqkXrJqMe746FzqoqdUJndaqXdFOFO0+yR2UPKy4KVedGAFi7jgXOWgHTZhb
	vN/vv5ubr+nY3mxtTqNhGw1CNAJP6xM9R5lysErkoltLwVXYrQKWONft7W9iZb6ITkIKz+AcFqvjb
	rO/3scRPWrjU7eMstZyXlSzCpI5k8MwPuaepCu8wHHr12/wM1VKEgnGrrzn8XOYCTCXX5KkoaMjk4
	KWbsnrZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSOBG-00DmeZ-2t; Thu, 10 Mar 2022 19:10:34 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSOBC-00Dme8-SA
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 19:10:32 +0000
Received: by mail-il1-x129.google.com with SMTP id b5so4429070ilj.9
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 11:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Z2XnAIZo4F9dSg2/HrPYqXkXeLAaoG9uThWsD0uBJlA=;
 b=Zs/K8Ho3umHLToueBxMUNe97QzEdc/fHEZhQ7JtJWKvwOgjZ11JXrAWoy0GAhtd0zI
 Ds6PmqoMAoryy9OdN7rCKqG2max0dWACJrmkby+3VU+kNc3YdiHD6MKmOmJIMwD261Ze
 dL/7enTzi3bbl5vjuQxDFNp5GXWQswLJnMNLb7qYpVP8pKmByGMd5Am5wz28FHIOq+XV
 o5C2rZRsaiK45ER8KOtnr0QXOt8DHrHvG92aZN2cjSrzOljHkSygMGXA7+ZxntMUjzG+
 slLqs+vTgysxjiGW9RnhGNWaCke+QjEcm3wPYCf04fHEuZhflaQSWQmA8WClSMy+EGRI
 b67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Z2XnAIZo4F9dSg2/HrPYqXkXeLAaoG9uThWsD0uBJlA=;
 b=VVlP0DLWPtrxvsO3bDqcYQdwLNh+NubSQzlYGqRDHJ7/Fgbx2cvWMSXIpX53FTibc1
 I4AKLskNolQfdtnkEDpph0XBlSHINSZ1SVDOVhduBBgpz8xdcGT3k21YozHKy02kJdMx
 3FZvdRIO705PiupG3nRUsx2U5D/bFVRLSdKzFeevynfusjKGNa+e9bDT9E010NaQUcnQ
 GhdiV2lOmU+GLDNp39zWM2AvJqgMe0RpmxT4G22zG3If01L220LWbucmZeCEIy/G8lVT
 XES0yg3Fqn05SztDCjV7V7qeov6TsH7CZ29WWD+91QWxc/mS0Hlo0HRQvNwl49YOzkkR
 EM2g==
X-Gm-Message-State: AOAM532djJWNpoVdGKlzDpcaZZc/AK68JvHocmkRE8SCQ4pgiUg1MjEA
 cVU/Zv93coiBeyt4vJGtv0IYvA==
X-Google-Smtp-Source: ABdhPJwx7bekaEdUtL1Ejn1IAjB6lGjVlrk24NZLRa7bis8QL16ikKs73/7JzgQhljRrnvGpFxNraA==
X-Received: by 2002:a05:6e02:1a8e:b0:2c7:6e36:e154 with SMTP id
 k14-20020a056e021a8e00b002c76e36e154mr1897043ilv.180.1646939429515; 
 Thu, 10 Mar 2022 11:10:29 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a056e021a8100b002c64cf94399sm3435510ilv.44.2022.03.10.11.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 11:10:29 -0800 (PST)
Message-ID: <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
Date: Thu, 10 Mar 2022 12:10:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: "Luca Porzio (lporzio)" <lporzio@micron.com>,
 Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_111031_020046_A6ECE807 
X-CRM114-Status: GOOD (  16.03  )
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

On 3/10/22 11:50 AM, Luca Porzio (lporzio) wrote:
> Micron Confidential
> 
>>
>> You do both realize that this is just the file specific hint? Inode based hints
>> will still work fine for UFS.
>>
>> --
>> Jens Axboe
> 
> Jens,
> 
> Thanks for this reply.
> 
> This whole patch series removes support for per-bio write_hint. 
> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold 
> information to SCSI / UFS driver.
> 
> This is my current understanding. I might be wrong but I don't think we 
> Are concerned with inode hint (as well as file hints).

But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
does that work?

-- 
Jens Axboe


