Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF56C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qrkhLGFiOhJUvJx8Zd/ZRGYvnBujxufO0mRfURt1kw=; b=RN+S9BBsi1KpxthZiI5T83UgeR
	R8q4VyTmB7fjP8KVCG6sNJDLp0c4hL6Z5PudqZv4hezVF6yq1SOa1ZVxrwUUYfU6DsHtFIlaN/YEf
	kFcf7DK8VI1iRc7SUZNJXmdytcv5BriI+uLGGR0mBMjQRqeiGEaWgNmBGgZ6hnHYpBhNSR5lZ00+p
	fRPpG7itIrluHGQ15M1dJRD9AK63gv7bl7upnvTbvWuKkd3OqCRD40m7M/mF9DtI7i2kZHlR+2++4
	dfB0a1JqkTWm34Jq/3mI3En37Ng1JPJuq54HPsnnNkzAC4MxgW3VDlv65X3WCiImtysD0u0egVTfO
	Sj7yTU8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s13np-0000000HXsz-0ze3;
	Sun, 28 Apr 2024 12:38:45 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s13nl-0000000HXsM-2HLs
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 12:38:42 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346407b8c9aso952907f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 05:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714307917; x=1714912717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qrkhLGFiOhJUvJx8Zd/ZRGYvnBujxufO0mRfURt1kw=;
        b=wvC8hXAHnYEwXxf8of4rAWqjZfOYy15f634JmitzfV5scZb97VgrdTibUgQj9iyAhg
         o+bqTL2vfG4Qr0Glg1CCtxD0yMZMhbfc9g0JX03ueIuipEigJyeRug4ThI72Y/UC1msJ
         EmJ4eiSODO9MRCJNBa1OvKq+cHQaoLOkB1jJzMFBBxPlaHNYNUzXSh5Okzb8nSEqWDc/
         770ziUaRhNvWw2p5O9sskiSi6KvLCxYGdv7WsKiuqT2/mCannrTjb3I5g6TKxIGTQFEW
         UTd9F1ids84mDkPtKQZsAqDjxmJw6ApJ4hVNDU5ieRJalHR51/0RZyaG58p+xnA3aCHw
         41Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVqZfbcq8NI22EyaYpNtf5fwOpFALGcwRrrdS+7uxXeakrjnRVXtggNtDpNrDGgeP99GSi3Wk9AaBubEiQiUS8MMO7UN29b59psT6OAOIY=
X-Gm-Message-State: AOJu0Yzm570ACdX34ZrkRnpeAftlFI1I7DdpRyt9+//sMXGzHhBb0QrB
	4065BWIS+5JaySGecFCdDBOQJxInb0iZmwa3jWW7NSpB1H0e5oW0
X-Google-Smtp-Source: AGHT+IFBe0UM3OUjH2RryrS/FQjB51e2yJzBYqU6NhjEKAauDK5BgRjfVpwg/rezbQeRw2Zny/aCbg==
X-Received: by 2002:a5d:5f52:0:b0:34a:a754:eb51 with SMTP id cm18-20020a5d5f52000000b0034aa754eb51mr6222293wrb.3.1714307916652;
        Sun, 28 Apr 2024 05:38:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm26983632wrs.53.2024.04.28.05.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 05:38:36 -0700 (PDT)
Message-ID: <fd92f659-f96c-4e48-b4be-3156a9616dab@grimberg.me>
Date: Sun, 28 Apr 2024 15:38:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
To: kwb <wangbing.kuang@shopee.com>
Cc: axboe@fb.com, chunguang.xu@shopee.com, hch@lst.de,
 james.smart@broadcom.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
 <20240428102527.37462-1-wangbing.kuang@shopee.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240428102527.37462-1-wangbing.kuang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_053841_624666_B7F9B594 
X-CRM114-Status: GOOD (  18.85  )
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



On 28/04/2024 13:25, kwb wrote:
>> On 28/04/2024 12:16, Wangbing Kuang wrote:
>>> "The error_recovery work should unquiesce the admin_q, which should fail
>>> fast all pending admin commands,
>>> so it is unclear to me how the connect process gets stuck."
>>> I think the reason is: the command can be unquiesce but the tag cannot be
>>> return until command success.
>> The error recovery also cancels all pending requests. See
>> nvme_cancel_admin_tagset
> nvme_cancel_admin_tagset can cancel requests before stop admin queue, but
> cannot cancel requests before next reconnect time.

the error recovery does quiesce + cancel_admin_taget + unquiesce, all 
following
admin I/O should fail immediately upon submission as the ctrl/queue is 
not live.

> The time line is:
> recover failed(we can reproduce by hang io for more time)
> -> reconnect delay
> -> multi nvme list issue(used up tagset)
> -> reconnect start(wait for tag when call nvme_enabel_ctrl and nvme_wait_ready)

failing all admin I/O should not be associated with the next reconnect, 
it happens
way before that, in the error recovery work. Hence it is still not clear 
to me how
you are seeing what you are seeing.

It is possible that 5.15 is missing something.

>
>
>>> "What is step (2) - make nvme io timeout to recover the connection?"
>>> I use spdk-nvmf-target for backend.  It is easy to set read/write
>>> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
>>> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
>>> timeout will trigger connection recover.
>>> by the way, I use multipath=0
>> Interesting, does this happen with multipath=Y ?
>> I didn't expect people to be using multipath=0 for fabrics in the past few
>> years.
> No certain, I did not test on multipath=Y.We choose multipath=0 cos less code and we need only one path
>
>>> "Is this reproducing with upstream nvme? or is this some distro kernel
>>> where this happens?"
>>> it is reproduced in a kernel based from v5.15, but I think this is common
>>> error.
>> It would be beneficial to verify this.
> ok, test need more time, but we can first verify it only in v5.15.

We should not be spending time debugging an issue that might have
been addressed in upstream. The first thing we should do is to understand
if this reproduces in upstream, if so fix it, if not identify the 
missing patch(es)
in 5.15

