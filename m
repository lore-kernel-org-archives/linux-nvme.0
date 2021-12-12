Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22233C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Yhs3PgEfbHY9LK402CHAvGm87QQih+LFYBrNBKb7hQ=; b=Gue1ojdWVXy9YwTG497/rzQD6l
	V2NTCmQonWO7zI4c8J3ewDtQTdkttUpkvdA70WmoHEd8nMAQse1S/bexMjSnDu/7oUNKsjjcNIFJb
	kDwgmvhy/x7/mYKBuiNU0gAJqLFIOYJGyrP7WcLTDAhpp6H8ORG2v20rD7X0ltEXyBep+Nwswb/L4
	i+9ltLshVm0/tw+Hja7yxWg9u5s/CIy7TTNevOixzW53LQMs+TjO9Kjls5n9WcEz5rmjNqXpDRxwf
	TiblB+xZTU82IBjwCWjRCXV5WS4xCA9unBKnrEkSkbjPswqckhB3e60GqFpxOKh5XR+GunHgpfN6D
	GM/V0Y/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwLWz-006GgT-PW; Sun, 12 Dec 2021 09:52:33 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwLWw-006GfZ-1P
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:52:31 +0000
Received: by mail-wm1-f49.google.com with SMTP id p18so9901237wmq.5
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Yhs3PgEfbHY9LK402CHAvGm87QQih+LFYBrNBKb7hQ=;
 b=V4KBQ8epGMbSpTNUYTy/rDoRoGbSwsLJ6XfZgxrMHNP8VymBRa/OTvFH14/MEN+Bwd
 hfrMevw9OWpRxh0EA0kz0wmtI3JCION1I7i30y4QG5Bqt/5DuMjwS8SanucpdxwbRrTt
 ij5/bl99frzAtrvcp0y9zv2Q5hozsMdUhhpFwUmOX79syX6Z4cAjikp9qO69uANacfYp
 7N0i4npb2whR9ej1aQ3fvBsDg7wHcec5YKyoVKmVRZNd8Y7PGakd8i+ArCfyCM3pUQr/
 zYL8z8lq437aEZMd/etBTn2zhxNKTRasL+cFTmCfAVP+j46qMyA7FPppCsPEpqS+VwC8
 8mNQ==
X-Gm-Message-State: AOAM533KI0Jj1ff5llkJEJ6pFmugecRSFLUZ6YhM6+io+jo4wAs2biIB
 AUsXPsQ12vjfVq5569Zf/vI8/IC+Eq4=
X-Google-Smtp-Source: ABdhPJxqMbdkjZPWCp4vW9hNMlO2Ec7DoLLYzeVfZOv4miAIAD65BuqyWVgrj6WsAUD49ZxWmzhfWQ==
X-Received: by 2002:a1c:a9cc:: with SMTP id s195mr6267109wme.147.1639302748261; 
 Sun, 12 Dec 2021 01:52:28 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s8sm8108019wra.9.2021.12.12.01.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:52:27 -0800 (PST)
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
To: Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Alan Adamson <alan.adamson@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
 <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d23d067-9115-a295-1bcb-ad28679dc4a3@grimberg.me>
Date: Sun, 12 Dec 2021 11:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_015230_121106_38E3B8C5 
X-CRM114-Status: GOOD (  32.79  )
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



On 12/10/21 6:56 PM, Keith Busch wrote:
> On Fri, Dec 10, 2021 at 10:54:45AM -0500, Martin K. Petersen wrote:
>>
>> Hi Chaitanya!
>>
>>> Although I always prefer descriptive error messages, I've not seen even
>>> half of these errors in the field. This will :-
>>>
>>> 1. Increase the size of the driver code.
>>> 2. Require constant patching of the driver code when spec is updated,
>>>     I'm afraid this will turn into churn.
>>
>> Updating the corresponding list in SCSI hasn't been a big problem.
>>
>>> Also, we can easily track down the error in the NVMe spec from the
>>> error code that driver is printing currently, is that not sufficient ?
>>
>> Only the block layer status is captured.
>>
>> In addition, customers are not really armed with the NVMe error decoder
>> ring and are left with no explanation as to why an I/O failed. We have
>> had good results in the field with the verbose SCSI error logging and
>> that's why this patch was modeled to work the same way.
> 
> If they are not familiar with the decoder, does seeing something like
> "Conflicting Attributes" really provide the user a better sense than
> "0x280"? Either way, it sounds like they'd just open a bug with someone
> who is familiar with the spec, in which case numeric codes should be
> sufficient.
> 
> Are the existing nvme trace events not providing enough information? The
> existing ones appear to have even greater detail than what this patch
> provides. Or is there some other reason why the kernel log is preferred
> over the event tracer for capturing these types of errors?

Maybe the string info be added to the trace events? If so, we may
need a verbosity level for the trace to record "only errors".

Although the one advantage for the log would be the first time error
status (or for generally rare errors).

> On the patch itself:
> 
> I'm not sure having it be a new Kconfig option is a good idea since it
> requires a recompile to enable/disable. Could this be toggled with a
> static_key instead so we may disable/enable verbose logging at runtime?
> 
> The new "struct nvme_string_table" is a bit inefficient. Unknown errors
> will scan the entire table, which will slow down our hot completion path
> on any error. The codes are small and mostly sequential, so I think you
> could create a sparse "static const char * const[]", then the "code"
> becomes the index that can be looked up in constant time. The total
> space of the array shouldn't be much different than the proposal.

100% agree.

> A significant amount of the new strings are specific to admin commands,
> yet errors for admin commands skip the logging. Why define unreachable
> strings? Or perhaps a better question: why skip logging admin errors?
> 
> IO errors can happen in large batches, so perhaps pr_err() should be
> ratelimted.

Agree.

