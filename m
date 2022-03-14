Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB8EC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 19:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoDbpPad98yBr/P4hDC6OztGJxe6FslUMUsgktjpSRY=; b=gahT1BzKWcGe3cFL8Ac1uqFjEK
	EDihhbHmpMot911PJRKfFSlMJ+3XIj0fAzkVfMF0vExOaa2uy+plrpyZ/xBHZZvHFpcdDtrevWCYi
	Hqyea+Cp1mhv/8NAFE2MMniQ0vd7W+RaV4blXaTQEokwLJ73oRbTglL6UZFNodAYWdeXdhKX/PVBd
	cU0CzAcq2nbiDIbhgR9c/1Bi7jgGFZO77h86CzuHi6hyZaCmcn2A+FIdRWfb6UZdiOb3AsF8+RlIS
	bc0iISWPgZal+XEs3InZB1nVVESy33+slV9y5k2djpBA031Cviih97D+Yb2j1TAMNwRk124v+6CWX
	pc2klBDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTqpt-006g00-1o; Mon, 14 Mar 2022 19:58:33 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTqpp-006fya-5M
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 19:58:31 +0000
Received: by mail-il1-x12d.google.com with SMTP id b14so11845367ilf.6
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FoDbpPad98yBr/P4hDC6OztGJxe6FslUMUsgktjpSRY=;
 b=zcpz3auL0eUDeysh83YHCGAkEjQZy7D9iVBctpG8u/FzLqgyOwweObH4vp5ZaQjUMW
 /qQW5WHzJj2+UOjV0gs3rG3zsk8mROLXe7vH13Cdf2XRSuELdjUoSBvm471d0VXZK6TE
 /pzfZTqeQHLuIOyUnyBeNGsiXy4o2oE+QBsKnzyQHIvbcrX3kDu3cxkHvCYXtsWQFPih
 kqhjcULvDmaadjyL/ooTABD6ZafAhMatgovxozx1U139QWvL55UaRDTYjzcefXpU0t5q
 wnJNl/0bMPSod8ZBPXnG5iQSm6WdRRlQsG6KfI66KlY86aHo320lXCjEfEldEHT/hCUk
 jS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FoDbpPad98yBr/P4hDC6OztGJxe6FslUMUsgktjpSRY=;
 b=wiQtqyMmg1TKasBxE2YzFN6YgB9+9t1Mdh/17iKJ/5q/I7MaiqNWmwUu99JBjuvsOj
 g88cgFEWGN/rKCHpJU/d0PkIP4jBI/XTqjvxqWsEzR0TMR1CKnJu9xFXVhcUqtM+T7BO
 GLPXRgZYyESnU+x6qQXmnhC5WqNeibU6ybe7wKVH3992FpTMohOBABe53/8MQqMrjSj6
 bD1MY7gASM3rk1A4ESZQALgpz3a3JTKExPQHLbY/um9fJw0zuxjQl9Hcdjgvgt2d/t20
 PNr/fxTZKX7pUkB5s0g0q/o4h4+Ubqlp7tIXUSz0LZDZYo6RcWEfhaJXh7DQ+h8AtKkg
 bBHw==
X-Gm-Message-State: AOAM530Vt+SpAISRZnbELyE+GmFAk8VYlypmt+obGgIFvgiG6N6Lyjfb
 iUaxkn/pnqhruoW2kmIm2X3hxw==
X-Google-Smtp-Source: ABdhPJxgchNSFavsqZ8EK1LwbgCOqE0/yyzu+VyrAE0z8wJ1JCkVNMruqyrYC8XnodmPzLeC58gvPw==
X-Received: by 2002:a92:cb04:0:b0:2c6:101d:6f9f with SMTP id
 s4-20020a92cb04000000b002c6101d6f9fmr19087412ilo.117.1647287907077; 
 Mon, 14 Mar 2022 12:58:27 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a056e021a4f00b002c665afb993sm9993826ilv.11.2022.03.14.12.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 12:58:26 -0700 (PDT)
Message-ID: <0c40073d-3920-8835-fc50-b17d4da099f0@kernel.dk>
Date: Mon, 14 Mar 2022 13:58:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: Avi Shchislowski <Avi.Shchislowski@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, "Bean Huo (beanhuo)"
 <beanhuo@micron.com>, "Luca Porzio (lporzio)" <lporzio@micron.com>,
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
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
 <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_125829_284129_814ED7B7 
X-CRM114-Status: GOOD (  20.22  )
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

On 3/14/22 1:40 AM, Avi Shchislowski wrote:
>>>
>>> Hi Jens,
>>>
>>> The "upstream first" policy applies to the Android kernel (see also
>>> https://arstechnica.com/gadgets/2021/09/android-to-take-an-upstream-
>> first-development-model-for-the-linux-kernel/).
>>> If anyone requests inclusion in the Android kernel tree of a patch
>>> that is not upstream, that request is rejected unless a very strong
>>> reason can be provided why it should be included in the Android kernel
>>> only instead of being sent upstream. It is not clear to me why the
>>> patch Bean mentioned is not upstream nor in the upstream Android
>>> kernel tree.
>>>
>>> From a UFS vendor I received the feedback that the F2FS write hint
>>> information helps to reduce write amplification significantly. If the
>>> write hint information is retained in the upstream kernel I can help
>>> with making sure that the UFS patch mentioned above is integrated in
>>> the upstream Linux kernel.
>>
>> I'm really not that interested at this point, and I don't want to gate removal or
>> inclusion of code on some potential future event that may never happen.
>>
>> That doesn't mean that the work and process can't continue on the Android
>> front, the only difference is what the baseline kernel looks like for the
>> submitted patchset.
>>
>> Hence I do think we should go ahead as planned, and then we'll just revisit
>> the topic if/when some actual code comes up.
>>
> We also supports Samsung & Micron approach and sorry to see that this
> functionality has been removed.

This isn't some setup to solicit votes on who supports what. If the code
isn't upstream, it by definition doesn't exist to the kernel. No amount
of "we're also interested in this" changes that.

What I wrote earlier still applies - whoever is interested in supporting
lifetime hints should submit that code upstream. The existing patchset
to clean this up doesn't change that process AT ALL. As mentioned, the
only difference is what the baseline looks like in terms of what the
patchset is based on.

-- 
Jens Axboe


