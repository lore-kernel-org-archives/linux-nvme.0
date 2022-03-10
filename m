Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F4C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7PndJI501rkr9gmwF/udE5TGyFYFXZE5Syas0Qrj84=; b=0iFoRscr0oz94v8lAOE0A5C2tZ
	iNjQ5A7flCGmr0p4byoTFbYPTR9OP4OTdSGEBTL6uIU5/9NLDR5aZrp5Adw8uLYRqfJuFyAsSRVrD
	zOEldarPbMmoCr885HjcWfm9gO0Blbg44uqiNDLNzr3kmQ70VQYyGxwmdKZDzndZlqJA5gWw/mZNY
	mn4BU6JpLDphf/vK6gAmc8cm1e1c15viqwxODNUxQH+TuUpC/jqefSa/RyvHVMnRB4XwKBAdl0dPc
	0yQxnFmEMDMxqINGU6JtPUpHmuUkBKNa6uP7ZgR7VaqbUOYQ+vjNarz6KVXNbrlPCOfs45ehE1Xzw
	mZSFzclw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSOYp-00DphH-1Q; Thu, 10 Mar 2022 19:34:55 +0000
Received: from mail-pg1-f175.google.com ([209.85.215.175])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSOYm-00Dpff-Gv
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 19:34:53 +0000
Received: by mail-pg1-f175.google.com with SMTP id 132so5563379pga.5
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 11:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=o7PndJI501rkr9gmwF/udE5TGyFYFXZE5Syas0Qrj84=;
 b=EEfd8E4Yw0ZjgsZwXWashl8+mXjEinNBXIqGUeH+EubxWhXndT5PubRKf/h7t74qDa
 za5iHwiBZo2mq6DuwOvBycUW4F6gmuUqOudQ+LBhQxG4UZT+zZXn7UF4HXo5K0J9csC2
 UZTiDc98KfP41mn2X1ijM7708Q7UFoq3teqSWuJgmjV+r6dlf3ALUrSm9xJqfdNMxgfQ
 KscT4ClKSBeoKCEy0MrX9tFS4VDPVZv+NVOnpSUKNV/mlyOjXv0XQalwNw0CVer6OYUn
 wfCN8ykk4Lv5A+VunpKXqljs+LtRFq1C3rb5/eLkSitzl+sXLJUxEVaHY9+e+RPWcdsb
 vcog==
X-Gm-Message-State: AOAM531kjBHXf6Qy8Bun/iaw40+4TSg6kAi67d9K1S716RB+q8s/GVjd
 JXagGdtC03w+FwRsJVHMEXU=
X-Google-Smtp-Source: ABdhPJxgm6AqE8kHcxQEoxRzzLFn66z5SVUx1Kz9Qkq3sTGTHT/Hr8ElW/IypR19OtkCCKG08u/bxw==
X-Received: by 2002:a63:c011:0:b0:378:74a6:9c31 with SMTP id
 h17-20020a63c011000000b0037874a69c31mr5348347pgg.585.1646940886455; 
 Thu, 10 Mar 2022 11:34:46 -0800 (PST)
Received: from ?IPV6:2620:0:1000:2514:57c0:65bf:1736:4f17?
 ([2620:0:1000:2514:57c0:65bf:1736:4f17])
 by smtp.gmail.com with ESMTPSA id
 f194-20020a6238cb000000b004f6ce898c61sm7669112pfa.77.2022.03.10.11.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 11:34:46 -0800 (PST)
Message-ID: <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
Date: Thu, 10 Mar 2022 11:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, "Luca Porzio (lporzio)"
 <lporzio@micron.com>, Manjong Lee <mj0123.lee@samsung.com>,
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
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_113452_590996_63C8DCCB 
X-CRM114-Status: GOOD (  16.42  )
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

On 3/10/22 11:10, Jens Axboe wrote:
> On 3/10/22 11:50 AM, Luca Porzio (lporzio) wrote:
>> Micron Confidential
>>
>>>
>>> You do both realize that this is just the file specific hint? Inode based hints
>>> will still work fine for UFS.
>>>
>>> --
>>> Jens Axboe
>>
>> Jens,
>>
>> Thanks for this reply.
>>
>> This whole patch series removes support for per-bio write_hint.
>> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold
>> information to SCSI / UFS driver.
>>
>> This is my current understanding. I might be wrong but I don't think we
>> Are concerned with inode hint (as well as file hints).
> 
> But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
> does that work?

Hi Luca,

I'm not aware of any Android branch on which the UFS driver or the SCSI 
core uses bi_write_hint or the struct request write_hint member. Did I 
perhaps overlook something?

Thanks,

Bart.



