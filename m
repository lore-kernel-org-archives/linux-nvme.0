Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D889AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hoPWBro4VveouJ4vx2nAAxYFxr+KDw+cTxYyidREMFo=; b=FS8PA6ACyNuJ+jLbjFtdWewRt/
	e3nLyucqWy1bhrzMzhjjE2EFvaNTuFMbuO/x5cQINDHRNG7wHf2NqH1d/32cZa8XFPaOr2VwCdhPs
	fh0YCajqEZKx3Zb0xbUhiDDbVYLZL9p4/nSTiB71p2/qv0rH/F9D+qOgWGbdHCr8h+4H2CdGkoKyU
	jOGyV+6rMX7f8NHZ8Jhny3J3i92nOqjkKBoL9/wDKzZqhoS/jUJpR6xVMK0/NFpk/GayRhrBIla8j
	M9qK6uBSyvHO57xjIvtDm6Kv03i7XY0FgzzlkMpxNm+XoYCjlv4SgUdimBvq3SZS1KStRrsiC+ruD
	ADV3csZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSHhO-00ClJf-0V; Thu, 10 Mar 2022 12:15:18 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSHhL-00ClIs-4V
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:15:16 +0000
Received: by mail-pl1-x635.google.com with SMTP id e13so4706399plh.3
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=hoPWBro4VveouJ4vx2nAAxYFxr+KDw+cTxYyidREMFo=;
 b=3lHvgXyOZWgBu7xmQFS37eeUDuf1cB/DlgDJKt7JktscFsHvnp2Z8HCO7AOl2uhI4v
 IfKhXbGVbCyxw6KBqmCJJj9pXcgNwwx8ywoRtiOyPNStQnrxq6KFtxGsd3biz/AqcHWW
 j/w7UdCS6+jAfG4hgQcTgSKFx6XIqC3Hw8YADTHIrxFAt+0Rmac4VbfJyn/Y1VvMEj6d
 VMO8rDYU5jzoD8Ukc1lKq/tWuwpvqQxOdscRi7bEgiCGO5gHq1sZuu1Qy9OGPoqkq6Bb
 HqFsp7iKPtFoQ8ApxZav7UKCYUNl9udtO7+ktT1RlPCAqGWAg58SD0xHYkrZOrmdn/8K
 1cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hoPWBro4VveouJ4vx2nAAxYFxr+KDw+cTxYyidREMFo=;
 b=tIVkjOrgbxhqHezHlnT0sLf4j2HnFTRxGRRlN0Q+QRGid2/KCQpEGLmBW+kDg1xMWJ
 Plv6Q7T1j2/nJqgxcIxaz0V6afoGkdQupVIN+ahB/QmDVbztQtgGxaLPHHRPM7h6mJQ8
 Rc/tnnZ1Pi+zaV0XwMWDIaZFXIpmkuUGYPd4IycM7LLw5jciQDJgPeVb5B7FnVCpV69e
 OV3MeCnwDjt54dy1QdpCsQZmVzvyyoBQ4stC5R+VZYSMXC21LMUKmnROLHWCDUpOB1NL
 LUsMzH5vWUiqJtEUopRfkjsVPdKJNomg+no/wAI9qbPl1q0NK4XK+LoeJ1OdJgF2sNb0
 /aYA==
X-Gm-Message-State: AOAM530Gx+CdVC97lboyl2FVUNpApEsenAekqsxooclbdtvzjgsL4lQa
 bNDkJC/EqU5wxzGHqsGE6ILexA==
X-Google-Smtp-Source: ABdhPJzSQmxtoIBTxfTuTtDJblYzgJmRRteHsYoyEbd/AE8Ym0coXr6/kU1kFb735T1a56f84F6JHQ==
X-Received: by 2002:a17:90b:3a8f:b0:1bf:ccc:59bc with SMTP id
 om15-20020a17090b3a8f00b001bf0ccc59bcmr4730847pjb.234.1646914513229; 
 Thu, 10 Mar 2022 04:15:13 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 o66-20020a17090a0a4800b001bf388fc96esm5918336pjo.21.2022.03.10.04.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 04:15:12 -0800 (PST)
Message-ID: <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
Date: Thu, 10 Mar 2022 05:15:10 -0700
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_041515_216209_6402064D 
X-CRM114-Status: GOOD (  24.02  )
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

On 3/10/22 4:34 AM, Luca Porzio (lporzio) wrote:
>> -----Original Message-----
>> From: Manjong Lee <mj0123.lee@samsung.com>
>> Sent: Wednesday, March 9, 2022 2:31 PM
>> To: david@fromorbit.com
>> Cc: axboe@kernel.dk; hch@lst.de; kbusch@kernel.org; linux-
>> block@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-
>> nvme@lists.infradead.org; linux-raid@vger.kernel.org; sagi@grimberg.me;
>> song@kernel.org; seunghwan.hyun@samsung.com;
>> sookwan7.kim@samsung.com; nanich.lee@samsung.com;
>> woosung2.lee@samsung.com; yt0928.kim@samsung.com;
>> junho89.kim@samsung.com; jisoo2146.oh@samsung.com
>> Subject: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write hint.
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> you recognize the sender and were expecting this message.
>>
>>
>>> On Sun, ddMar 06, 2022 at 11:06:12AM -0700, Jens Axboe wrote:
>>>> On 3/6/22 11:01 AM, Christoph Hellwig wrote:
>>>>> On Sun, Mar 06, 2022 at 10:11:46AM -0700, Jens Axboe wrote:
>>>>>> Yes, I think we should kill it. If we retain the inode hint, the
>>>>>> f2fs doesn't need a any changes. And it should be safe to make the
>>>>>> per-file fcntl hints return EINVAL, which they would on older kernels
>> anyway.
>>>>>> Untested, but something like the below.
>>>>>
>>>>> I've sent this off to the testing farm this morning, but EINVAL
>>>>> might be even better:
>>>>>
>>>>> https://urldefense.com/v3/__http://git.infradead.org/users/hch/bloc
>>>>> k.git/shortlog/refs/heads/more-hint-
>> removal__;!!KZTdOCjhgt4hgw!qsgy
>>>>>
>> oejchUYPeorpCL0Ov3jPGvXpXgxa7hpSCViD7XQy7uJDMDLo3U8v_bmoUtg$
>>>
>>> Yup, I like that.
>>>
>>>> I do think EINVAL is better, as it just tells the app it's not
>>>> available like we would've done before. With just doing zeroes, that
>>>> might break applications that set-and-verify. Of course there's also
>>>> the risk of that since we retain inode hints (so they work), but fail file
>> hints.
>>>> That's a lesser risk though, and we only know of the inode hints
>>>> being used.
>>>
>>> Agreed, I think EINVAL would be better here - jsut make it behave like
>>> it would on a kernel that never supported this functionality in the
>>> first place. Seems simpler to me for user applications if we do that.
>>>
>>> Cheers,
>>>
>>> Dave.
>>> --
>>> Dave Chinner
>>> david@fromorbit.com
>>>
>>
>> Currently, UFS device also supports hot/cold data separation and uses
>> existing write_hint code.
>>
>> In other words, the function is also being used in storage other than NVMe,
>> and if it is removed, it is thought that there will be an operation problem.
>>
>> If the code is removed, I am worried about how other devices that use the
>> function.
>>
>> Is there a good alternative?
> 
> Hi all,
> 
> I work for Micron UFS team. I confirm and support Manjong message above.
> There are UFS customers using custom write_hint in Android and due to the 
> "upstream first" policy from Google, if you remove write_hints in block device,
> The Android ecosystem will suffer this lack.
> 
> Can we revert back this decision? Or think of an alternative solution which 
> may work?

You do both realize that this is just the file specific hint? Inode
based hints will still work fine for UFS.

-- 
Jens Axboe


