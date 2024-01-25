Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D6C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W1HjUo397VBT5ZzyyIxM2rewLrO4V8KtKr8yUnsVp50=; b=1coxFOGQh2dUFAfQngqQfrvjJB
	z8+WPBdvB+T+1l2YxNNlClCRsHHRyU+i7BSxVhSFC5/kSugi0JGEfMoErs9NsCe4ZgSsWfLj1K0U6
	qA201fwlca3TrDsLjtfzfsD61gCsdyaC1wNrWCufNJQRTFgk1zhtPa2HLCVivxEMTx7okttk1Djpl
	pbUQOH+BvHEisyHf+FG+u4IID+WZE0YE0XpLfmfKrvWuSvvjEbLwW9DmA+NRhpwPoyiSIXCCiogek
	U+k+YddI505lmmrJLyVKBgXAbl8iw63pRRfAIVo62xno0g8gW0PLEGW99VPeP/LdG0uBVA5sUiGT7
	nYPLBomQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2vo-00000000x4h-49pg;
	Thu, 25 Jan 2024 16:50:24 +0000
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT2vi-00000000x0K-0qso
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 16:50:22 +0000
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7bed82030faso91409739f.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jan 2024 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706201416; x=1706806216; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1HjUo397VBT5ZzyyIxM2rewLrO4V8KtKr8yUnsVp50=;
        b=Uh4xdE35Ecdjw7VSagBdS/iridwCSCTFFVaNV/x7Aq8gp+AcxXxN5puBUkVzYSifQ8
         69feA7Hd+8IspOgt7bRMmfJdfyUCGjO1a8YybAqvVttw7Dls1agxP+T1YFEKikamhYDN
         yKj+hISKHGBYnaHZX8Lh2gZ2L0MI+KIQZ9NAZO89k82PbFxdt2nL5i7VQ110V6wFOY3u
         P8cwmQDEHLRiyEhty6o3e3feS6smgkvbbLu2SITcCGUmZAiaSJeiBJt6PlRmItphxCN2
         0/B5ZwbCRL7epHKKk2Pdbvu9ZPhyM2AG1yKJy+z2BRQrjDfCzx59k9vGMUyAPJ2tMduJ
         DGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201416; x=1706806216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1HjUo397VBT5ZzyyIxM2rewLrO4V8KtKr8yUnsVp50=;
        b=CYJ9pY/WWuRMfsGirwKg1lItVg0GW6RBdtYPa/Hzq9Gs/GzsMFvbq6RHIjDgH+CGrG
         NbQlmbQaYhjYKc/jh1VfvjPsCxh3vcXh+QRuKs97X8cuTgMwGqfBaSmBtECLWgmwLaGj
         cYhbQwsKQ1kOFblT14DrRriS7Jp0nodfwNnSYRS+yiESdKEgr2Xtmwz73+iHJRblWfbv
         1GUo2Qr291fkERSMVWPORk0zBRV+iSyYreLq+m92cSaxmND0doCxywXHsyfyKCFkPnqW
         YenVzabEbNMoRRDCHQbnHSgQTpqBggwt9BEQhmBYRQta85TL0+1kR9B3SxBIDEO2NCfh
         PoWw==
X-Gm-Message-State: AOJu0Yx7q0NyU8XfwJi2bfN3hI1t9Xq+SZOLbInDGK9MVIHd3ss12fjB
	yOlCDztT83bUZAPuanaY2om3Uc+RZbWaxOMdCTCSkhhDCCfUpPvTP9BeGMtMAJw=
X-Google-Smtp-Source: AGHT+IHV7yDgt5sCuzpSSeDz5A7joXpYcObJ3dMSHA8rVqpqNZfJAbq7eP0Y61GmstUKE9OPiynU1A==
X-Received: by 2002:a05:6602:71a:b0:7bf:4758:2a12 with SMTP id f26-20020a056602071a00b007bf47582a12mr119213iox.0.1706201416211;
        Thu, 25 Jan 2024 08:50:16 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v22-20020a05663812d600b0046ed5f51becsm605331jas.39.2024.01.25.08.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:50:15 -0800 (PST)
Message-ID: <aa4a3561-2ecc-4e64-895f-356405dc14c3@kernel.dk>
Date: Thu, 25 Jan 2024 09:50:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Martin George <marting@netapp.com>
References: <20240125130906.94874-1-hare@kernel.org>
 <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
 <20240125154814.GA23800@lst.de>
 <b3e68e05-f698-4fbc-87a7-99f7461d88be@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b3e68e05-f698-4fbc-87a7-99f7461d88be@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_085018_736915_CC663B9E 
X-CRM114-Status: GOOD (  15.14  )
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

On 1/25/24 9:20 AM, Hannes Reinecke wrote:
> On 1/25/24 16:48, Christoph Hellwig wrote:
>> On Thu, Jan 25, 2024 at 08:42:10AM -0700, Jens Axboe wrote:
>>> On 1/25/24 6:09 AM, hare@kernel.org wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> Authentication commands are normal NVMe commands, and as such
>>>> can return a status where NVME_SC_DNR is not set, indicating
>>>> that the command should be retried.
>>>> Rather than checking NVME_SC_DNR manually for each command completion
>>>> this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
>>>> the REQ_FAILFAST_DRIVER option to be cleared and the command to
>>>> be retried via the normal mechanism.
>>>
>>> Can we please do this without adding Yet Another parameter to that
>>> function?
>>
>> Heh, I wrote about the same reply a few minutes ago.  I'll try to think
>> what we can do instead.
> 
> We could do something like this:

That won't really do much, and yeah wouldn't be the way even if
complete. How about just not setting the flag in the first place?
nvme_init_request() defaults to doing it, so either pass in the init
flags to that, or just clear it in there and have the callers decide if
they want to set it.

-- 
Jens Axboe


