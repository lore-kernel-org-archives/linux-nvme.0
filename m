Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8876C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsP1WXazU8yF9ogCr3BU1JiACfVvmKTu/fnyCfbOqUk=; b=Ab86s1JNeMRGmLunZ9ZriVPZ1U
	EZgEGrAf3LaJ1ajz7d/F0mlj7X8cOvS80q06HwzD+jcQLNe45umIWp6QN5bcSq6yjAnSAuP5Js+ZP
	uE0O5CwFwoZzEJBWA7o9UYQ3A1QyUyXCrlAWnmimngE60a/SUSgmP0ubzOCzMcWhquXpkFT9n8jo2
	mqfcwsPTU+Hdqm4BQNuT6gRggMTnCMljNLdAVyJrd7p7vL67/wepv49a50jdeUlIhpvpWf5sFw3GN
	cvEDAl46S6laxugpltsO8wf0uyhbF8YXtJTCIShrq3d99c96K30hplkPbABCV24bfcj3SsWWztYyH
	bHMRwljw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSQzc-00EA09-0A; Thu, 10 Mar 2022 22:10:44 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSQzY-00E9yk-EM
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 22:10:42 +0000
Received: by mail-pg1-x531.google.com with SMTP id 27so5844940pgk.10
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xsP1WXazU8yF9ogCr3BU1JiACfVvmKTu/fnyCfbOqUk=;
 b=cWzs+wFg2VnGcpieyJaxcWJ19NFXtMUM5FJwD1QRmRVPQpOn+hrfhmieyKgY5aYyKs
 8646n/XopKrT2QSjSnJ4O3ES6AxZEwG9cNQ1HtivZA+NXFfsY0talA6ne5uswoGVjLwa
 4rbQTyibXfPzNi/8zXBv7Cho7AGRZWRnOFy98TTkL07qnEKc7NMLFULAvvzP55gDVcjs
 tpamyOMx/Dwvv2Lf1Wd9aFWv4vWxsyCxiHJcQa0ksrX1UCPeSzxA/V0QLpOdTENIl++z
 Sg+r6scTtoxN8ZP0tmofRRCDkzHSPZ1UGinWToGgROeeNgUsfNHFccXVV/+BYWLiGNyP
 AOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xsP1WXazU8yF9ogCr3BU1JiACfVvmKTu/fnyCfbOqUk=;
 b=7r+WfieGBsMXjZXVMsD0F7cCb+3XruHkMyodegn9Q/u8vTI1ENdhF7PhnwmL3/OdPK
 g7rH3BTiNWVpXdmwU0Upj0Z46439tRK2hgl8ehx3Zh7StA4g43CyD3t4aXQBJxVzApqa
 Djuw5gI6mcPaZVEF2M75xAttodhe9AwOBneCYGejss5gKitHezZB98O4GCFSlEg1G3sL
 stWY6xnBx3gKfoVovfcws6eNviKtNVDOPtF2+LQ0SYttVffmTXLtrcGcmy8H4dM2GElB
 lLZCKTiRTHP9J14PiK1ICK5o7kCU34+sgQtu4wME9isFokPWID98UrCnUjpvpHqdKU7m
 8YKA==
X-Gm-Message-State: AOAM530m10jIMeTEAxuazOZpmQ99orCGlvLPfp6AR9oksdTNCcTsLOj+
 D0kLwuHhJ47fAiREEXZ81QtuDQ==
X-Google-Smtp-Source: ABdhPJxbTLA0OsiplGUL6ou0rPxtgBzbqnjcq2fP5xl4uPaTzTuWqUWDxDpJoesTUoRFLCQFyTMfIA==
X-Received: by 2002:a05:6a00:16ce:b0:4ce:118f:8e4f with SMTP id
 l14-20020a056a0016ce00b004ce118f8e4fmr7263609pfc.56.1646950239505; 
 Thu, 10 Mar 2022 14:10:39 -0800 (PST)
Received: from ?IPV6:2600:380:7676:ce7b:11ac:aee8:fe09:2807?
 ([2600:380:7676:ce7b:11ac:aee8:fe09:2807])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a17090ab00e00b001bf2d30ee9dsm10581380pjq.3.2022.03.10.14.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 14:10:39 -0800 (PST)
Message-ID: <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
Date: Thu, 10 Mar 2022 15:10:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
 Bart Van Assche <bvanassche@acm.org>,
 "Luca Porzio (lporzio)" <lporzio@micron.com>,
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_141040_569580_0B041A58 
X-CRM114-Status: GOOD (  27.53  )
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

On 3/10/22 2:52 PM, Bean Huo (beanhuo) wrote:
> Micron Confidential
> 
>>>>
>>>>>
>>>>> You do both realize that this is just the file specific hint? Inode
>>>>> based hints will still work fine for UFS.
>>>>>
>>>>> --
>>>>> Jens Axboe
>>>>
>>>> Jens,
>>>>
>>>> Thanks for this reply.
>>>>
>>>> This whole patch series removes support for per-bio write_hint.
>>>> Without bio write_hint, F2FS won't be able to cascade Hot/Warm/Cold
>>>> information to SCSI / UFS driver.
>>>>
>>>> This is my current understanding. I might be wrong but I don't think
>>>> we Are concerned with inode hint (as well as file hints).
>>>
>>> But ufs/scsi doesn't use it in mainline, as far as I can tell. So how
>>> does that work?
>>
>> Hi Luca,
>>
>> I'm not aware of any Android branch on which the UFS driver or the SCSI core
>> uses bi_write_hint or the struct request write_hint member. Did I perhaps
>> overlook something?
>>
>> Thanks,
>>
> 
> 
> Bart,
> 
> Yes, in upstream linux and upstream android, there is no such code.
> But as we know, mobile customers have used bio->bi_write_hint in their
> products for years. And the group ID is set according to
> bio->bi_write_hint before passing the CDB to UFS.
> 
> 
> 	lrbp = &hba->lrb[tag];
>  
>               WARN_ON(lrbp->cmd);
>              + if(cmd->cmnd[0] == WRITE_10)
>               +{
>                 +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
>               +}             
>               lrbp->cmd = cmd;
>               lrbp->sense_bufflen = UFS_SENSE_SIZE;
>               lrbp->sense_buffer = cmd->sense_buffer;
> 
> I don't know why they don't push these changes to the community, maybe
> it's because changes across the file system and block layers are
> unacceptable to the block layer and FS. but for sure we should now
> warn them to push to the community as soon as possible. 

If the code isn't upstream, it's a bit late to start thinking about
that now. This feature has existed for 5 years at this point, and the
only consumer was NVMe. The upstream kernel cares only about what is
in-tree, as that is the only part we can modify and fix. We
change/modify internal kernel APIs all the time, which is how tech debt
is removed and the long term sanity of the project is maintained. This
in turn means that out-of-tree code will break, that's just a natural
side effect and something we can't do anything about.

If at some point there's a desire to actually try and upstream this
support, then we'll be happy to review that patchset. Or you can
continue to stay out-of-tree and just patch in what you need. If you're
already modifying core code, then that shouldn't be a problem.

-- 
Jens Axboe


