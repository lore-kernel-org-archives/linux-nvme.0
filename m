Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099A1C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJSV4JYZWcx1zjR32pKwL3AktNsdnj/1grT4sVoCQw4=; b=tk9/D7WOtFnpuwRDXpqIxFavHh
	++n7tQp5r7/JZyH1RvNiQDDhDGqEURI306kractTCg/Fzx9DajZGt9geQ/+uY7iqxJl6bVbL8Gq1E
	4QTr2IZ6CTHXGjrZXytOpsv4Zp6Uxzzxxe+lHTPXHgpbRIbYEzEHh7ImBCfKS7eW2VT6vLI8JOlBc
	7xZnQUj9HUh18yAiER904KA3Oe/r007hfytumO2jE+sbTq+HHc/zJTJkOti+gGpJTIVFmtp8S2hxS
	SAtamIX3RZv2X1lpmmkAaouMm9Ozb3s187kW6O1UVy2G/fm9NTHTJLOxg82yWcNBsAbX403E+ufdA
	MZKXez7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmfC2-00H1oW-QT; Thu, 05 May 2022 17:23:10 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmfBz-00H1mg-9n
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 17:23:09 +0000
Received: by mail-pg1-x529.google.com with SMTP id g184so1623330pgc.1
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=BJSV4JYZWcx1zjR32pKwL3AktNsdnj/1grT4sVoCQw4=;
 b=Kpdumbv5o2DcWbrMGSu/gMNglwsaAB+N/m/+05km5jMjuEycrqiEUqg8kwko1oTJ/6
 puR9hrnfaLsbA2/yV4bFxxfIhHCECm/Ga5YSIwWREzTb8IE6cYgYv8lWFLrgN9UQpQmf
 +DUkpbeq3uIl5i9LyxQ6g2o1dLz6vH5jhw0eUaJcXleUnGg6pAD1+xLRjhI1pYAuFEMV
 FnUCwrbhMMFOR0Ukpo17proNbW2av/3rVbS5O/kEPzg40ZTrRhtBoxtL4IMRZjoJbIci
 M1Y8WPP4AE2QBZ++5IktvLIsnRZsmBZhAvUHJLektsh8c1H3cbtvG+u+IS2u39m88I1H
 hkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=BJSV4JYZWcx1zjR32pKwL3AktNsdnj/1grT4sVoCQw4=;
 b=pOE1QDv+fTEuWM58U21PfCXdOwnbJIiE0ARM6orNnrWLcENl4csS78ThuktPz2VCal
 MoZ0x74MPNzZ/8jilHoTz8N/0HPWN1XGqY4rnrGS6yXRrtfs8vQxFdK76Xvz2MxB0jjn
 luqDWgmdt4E2Kzep7mgIEQkISfgPeAhKxmNRRg1ZxnvU9JYTWwDmL2t7cYAQTF5cb88n
 AO/3DGHYdSllnm3Y8wH0Wjj2IZND3om4oZzp3PBJVNg7DowDRZeYsr4wfAcS1A9sVq6E
 K8+alWUrRpMwz7nwMZtRee7qNEFoNBjTBols48/SBaxx7jivuZ6JZnVM8ATDn10q3cKt
 8zqw==
X-Gm-Message-State: AOAM533rUvTRwIpriY+hfG5UVAsHYKCdLgDayv5S48By0qU9zcK3+R75
 FDWbUK3RljTNh7SDrvlQZj9vWA==
X-Google-Smtp-Source: ABdhPJxZGwbtsLOT1wzl9VWVtGPuZwRxSdKWSWtWmeZKgHmiNIannxbuqaujSZHeyjBp/+r7RAT+Sg==
X-Received: by 2002:a63:5464:0:b0:3c1:4930:fbd5 with SMTP id
 e36-20020a635464000000b003c14930fbd5mr22393253pgm.94.1651771383984; 
 Thu, 05 May 2022 10:23:03 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a17090a931200b001d98af21128sm5566499pjo.19.2022.05.05.10.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 10:23:03 -0700 (PDT)
Message-ID: <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
Date: Thu, 5 May 2022 11:23:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru on
 char-device.
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com, ming.lei@redhat.com,
 mcgrof@kernel.org, shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com,
 gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
In-Reply-To: <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_102307_606513_50E0BF25 
X-CRM114-Status: GOOD (  19.13  )
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

On 5/5/22 7:50 AM, Jens Axboe wrote:
> On 5/5/22 7:42 AM, Christoph Hellwig wrote:
>> On Thu, May 05, 2022 at 07:38:31AM -0600, Jens Axboe wrote:
>>>> +	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(cmd->addr),
>>>> +			cmd->data_len, nvme_to_user_ptr(cmd->metadata),
>>>> +			cmd->metadata_len, 0, cmd->timeout_ms ?
>>>> +			msecs_to_jiffies(cmd->timeout_ms) : 0, 0, rq_flags,
>>>> +			blk_flags);
>>>
>>> You need to be careful with reading/re-reading the shared memory. For
>>> example, you do:
>>
>> Uh, yes.  With ioucmd->cmd pointing to the user space mapped SQ
>> we need to be very careful here.  To the point where I'd almost prfer
>> to memcpy it out first, altough there might be performance implications.
> 
> Most of it is just copied individually to the on-stack command, so that
> part is fine just with READ_ONCE(). Things like timeout don't matter too
> much I think, but addr/metadata/metadata_len definitely should be
> ensured stable and read/verified just once.
> 
> IOW, I don't think we need the full on-stack copy, as it's just a few
> items that are currently an issue. But let's see what the new iteration
> looks like of that patch. Maybe we can just shove nvme_uring_cmd
> metadata_len and data_len at the end of that struct and make it
> identical to nvme_command_command and just make that the memcpy, then
> use the copy going forward?

The top three patches here have a proposed solution for the 3 issues
that I highlighted:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough

Totally untested... Kanchan, can you take a look and see what you think?
They all need folding obviously, I just tried to do them separately.
Should also get tested :-)

-- 
Jens Axboe


