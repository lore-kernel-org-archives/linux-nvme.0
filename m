Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4D2C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbOAwhMnSdJGlPlWPiV1Em71QncrNK6+P5igUXX/YWs=; b=mahp9D5DnQGSyvTMYTaBg91nSF
	YBknPg1YRuX3Ez0ZeCKTXzuE0zgfagnML0zLEUEjgvmvn+8/ibS3Xnqz9YBWtdioLfyrKTb3t6QG8
	OcnEAliUEKGGsrY3M79f1LP2ScgwcengshtUFj9sPVIRlXPF/NETAlORkOaw2zvm7SapbKk6d/3Rb
	mXUoonaUzayu4UStQa7lvV4fH72fnH7hlP7gKTaL62qifoXyYb6Vd6S2LpoDngGcDrE1p6/cHR01c
	qae3c3jHQ+vCjh4Zen7NQ2LKGAaGQNebIMihGeZErb2dL3CjPeCgu5UReF57dY+UMnRXlKLejLl9D
	sp5yL/8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCdW-00000004Vra-0bdf;
	Thu, 07 Mar 2024 12:14:10 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCdU-00000004Vqr-0zd5
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:14:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412db7067d6so307205e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 04:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813646; x=1710418446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbOAwhMnSdJGlPlWPiV1Em71QncrNK6+P5igUXX/YWs=;
        b=u0A5b0toU4aOwZbPbZCpRJI2qskxZX+hc20VGyh9dUjkvOyVqSsKw3yXSV3HeKaFQc
         nQRRHBR9DFY+TmXsus4q+tJ4L6lmU3zGr0ISY6rmh3drVUAq9tte9wq1qS2pao2IwBry
         MAvaGumW5K5o9HgM3D9U+auZerwLWAZgS0qpoy7eU4++iL5R93gQELnZHgNYRWGrnQ/s
         vLKglKXvsq1BrIxIsaPGxTbqarHeVjVGIHssvKKMWcjoh92LABLYoH1ewsAWdxQNkERm
         avC9FkVlg0B9lXJZcOGbWYfnQYJJzcJdo2x5D2l4rlHRYrCATWwi61Jd24z4TISFigLi
         cyjA==
X-Forwarded-Encrypted: i=1; AJvYcCWydbTy2DRzLkujcVXW+NE4gGAA+GUop1id5aqVB/S6Jin5tO13ZlF3Z5ImiSlIyvHFqEw0V4JBLoaTCd6jRdOxdeBUhIkR+XmXzCSTlx4=
X-Gm-Message-State: AOJu0Yz5qdRB2dTzjqHUeH/vwc/ehOt5cB9vyHPVawiP43IVmrmO6+5U
	ilwpZmaRjC0x9C/Aupxs3v2b48KmTNIWjiI/eQdTfGmGXegmqGUS
X-Google-Smtp-Source: AGHT+IG/23S4boJLNpBSrEFKOwJ9L/axhUWJLQuZX3EM3km9SAxXajGd7JKkgqOTFNaskOcCCdwV2w==
X-Received: by 2002:a05:600c:444c:b0:412:eee0:a5e4 with SMTP id v12-20020a05600c444c00b00412eee0a5e4mr1337178wmn.1.1709813646229;
        Thu, 07 Mar 2024 04:14:06 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056000071300b0033daaef7afcsm20579395wrb.83.2024.03.07.04.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:14:05 -0800 (PST)
Message-ID: <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
Date: Thu, 7 Mar 2024 14:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
 <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
 <432a39d5-6d08-4d38-a357-7c8d9123189a@grimberg.me>
 <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_041408_299199_82BF3D5F 
X-CRM114-Status: GOOD (  21.15  )
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



On 07/03/2024 13:45, Hannes Reinecke wrote:
> On 3/7/24 12:30, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 12:37, Hannes Reinecke wrote:
>>> On 3/7/24 09:00, Sagi Grimberg wrote:
>>>>
>>>> On 05/03/2024 10:00, Daniel Wagner wrote:
>>>>> I've picked up Hannes' DNR patches. In short the make the 
>>>>> transports behave the same way when the DNR bit set on a 
>>>>> re-connect attempt. We
>>>>> had a discussion this
>>>>> topic in the past and if I got this right we all agreed is that 
>>>>> the host should honor the DNR bit on a connect attempt [1]
>>>> Umm, I don't recall this being conclusive though. The spec ought to 
>>>> be clearer here I think.
>>>
>>> I've asked the NVMexpress fmds group, and the response was pretty 
>>> unanimous that the DNR bit on connect should be evaluated.
>>
>> OK.
>>
>>>
>>>>>
>>>>> The nvme/045 test case (authentication tests) in blktests is a 
>>>>> good test case for this after extending it slightly. TCP and RDMA 
>>>>> try to
>>>>> reconnect with an
>>>>> invalid key over and over again, while loop and FC stop after the 
>>>>> first fail.
>>>>
>>>> Who says that invalid key is a permanent failure though?
>>>>
>>> See the response to the other patchset.
>>> 'Invalid key' in this context means that the _client_ evaluated the 
>>> key as invalid, ie the key is unusable for the client.
>>> As the key is passed in via the commandline there is no way the client
>>> can ever change the value here, and no amount of retry will change 
>>> things here. That's what we try to fix.
>>
>> Where is this retried today, I don't see where connect failure is 
>> retried, outside of a periodic reconnect.
>> Maybe I'm missing where what is the actual failure here.
>
> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> {
>         struct nvme_tcp_ctrl *tcp_ctrl =
>                         container_of(to_delayed_work(work),
>                         struct nvme_tcp_ctrl, connect_work);
>         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>
>         ++ctrl->nr_reconnects;
>
>         if (nvme_tcp_setup_ctrl(ctrl, false))
>                 goto requeue;
>
>         dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>                         ctrl->nr_reconnects);
>
>         ctrl->nr_reconnects = 0;
>
>         return;
>
> requeue:
>         dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>
> and nvme_tcp_setup_ctrl() returns either a negative errno or an NVMe 
> status code (which might include the DNR bit).

I thought this is about the initialization. yes today we ignore the 
status in re-connection assuming that whatever
happened, may (or may not) resolve itself. The basis for this assumption 
is that if we managed to connect the first
time there is no reason to assume that connecting again should fail 
persistently.

If there is a consensus that we should not assume it, its a valid 
argument. I didn't see where this happens with respect
to authentication though.

