Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7546AC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPLyZ99seCPicBCXDZB9lqIEFSMnRlWV8gcxMk/enRM=; b=dSHa/zUpehCR6ZLSM84kYgVILn
	dvtfkMAmY3B5kskCnApE9ui2vA1TDhEeMvxe8r6HGb3yRH3uFq0ybu/x1FPWwqrt2g/ibSUBkY/Mk
	Efg7+OxBXAT8RJCd5HRpXmuTTqqPt+rMXP4hNXxQiypNQ4KHY303NdMqrVZRJCqBBP5m65YHzQlyZ
	xTLyuAUrQdKfMVv7U7XdV9bEb3zFAt1/zxlbCtpDimytyVzpbYszH3cFcQSDfEmqQXPC9K7xbpXGF
	6PdO+g4JzYOTOz8drZe0xz4oJx9h1e6c519E1rjjEwj+DjuPfcU56+gX0Akh5/Douyh3nGIiT+N7M
	8xI8Nt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEh0-005SW0-24;
	Mon, 04 Dec 2023 19:33:22 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAEgw-005SVW-1v
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 19:33:20 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35d7e22ccfeso316685ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701718395; x=1702323195; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPLyZ99seCPicBCXDZB9lqIEFSMnRlWV8gcxMk/enRM=;
        b=VPxZ/XmU+bnIRaI53kEKXQ4rb14kQS+5BnLru8yb4au5JwvDHCq8772+j3B8OoRpjS
         QZXo5IDASj4k0Xwj8uiPqnFazX6IA39bwtJ9JrngVk61N3LSVEQs1Gw9C1l+UWdmveZ0
         SZc9phtKw9AG12gzyZdWT/L7aIvBBZ6X9qJPOEfvruYypR6juq4/lR0vBTSmT+0sbPSg
         wB6kEVZPHOQUubichQ8/lUdPe1YMsTajN5+NYClFlk1Ikqk0xeW6hOD+lQ7/Yc1S9nCA
         qVsfcH9eqCHMerC8FDB3eVOoIVqWC1hWWzbFcWFYVEXfzoe7K0GrhfApkMVsBAPhD+Qn
         pPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701718395; x=1702323195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPLyZ99seCPicBCXDZB9lqIEFSMnRlWV8gcxMk/enRM=;
        b=CTFh3M9EJVx96tKNmrHlpxA1AyfrawiQOQwTKHeQ4iWxu9pH35VMZsUHENpf+bXR0B
         ZbZh7iFu5HTl/Y6Cce4CPaQogYmHQPgJmSwhYambwvWaJ9iq1GKUJCaVRwKXWvw5GY2j
         lVrczo2DAj7UWC1zQtQkLckLZiz9WZrBmAjmylLepVEM363QhYUpXiMwz0tiaHWCq6w2
         F1uQ/L8YMp/moVmRwAR9V0FNKRJgQJIqRto4UVgYdLt0auCVXoo6t8DWbduJIzfxVbxv
         UfLNpjd2TSqSSTZ6Sixio0DzyT/pyUAaLbZILqBbr3wdGnaPpQF3GhC4mtOC5e71BKrP
         m96w==
X-Gm-Message-State: AOJu0YxM6lppHXkxCm6rtACawOThvcrbln3wL4S/P7lfieW4yxAYIY86
	6wIlc2OQH8if7iHIkDSYa+ghYg==
X-Google-Smtp-Source: AGHT+IGkrKaGiFhAp7oK0f4BIQy2oFELmC3jxP+vwpzj8s/Gl4T3A6gIJhi/I7plWsz2YyH/VgUi4A==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr33072956ioo.2.1701718395387;
        Mon, 04 Dec 2023 11:33:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y14-20020a6be50e000000b007b35a715c92sm2857601ioc.24.2023.12.04.11.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 11:33:14 -0800 (PST)
Message-ID: <aac915ff-6726-4463-985e-9401228404ca@kernel.dk>
Date: Mon, 4 Dec 2023 12:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Content-Language: en-US
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
 asml.silence@gmail.com, Keith Busch <kbusch@kernel.org>,
 linux-security-module@vger.kernel.org
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <9c1ee0ee-ccae-4013-83f4-92a2af7bdf42@kernel.dk>
 <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <x49sf4hsrgx.fsf@segfault.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_113318_698431_3706C521 
X-CRM114-Status: GOOD (  12.07  )
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

On 12/4/23 12:22 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 12/4/23 11:40 AM, Jeff Moyer wrote:
>>> Finally, as Jens mentioned, I would expect dropping priviliges to, you
>>> know, drop privileges.  I don't think a commit message is going to be
>>> enough documentation for a change like this.
>>
>> Only thing I can think of here is to cache the state in
>> task->io_uring->something, and then ensure those are invalidated
>> whenever caps change.
> 
> I looked through the capable() code, and there is no way that I could
> find to be notified of changes.

Right, what I meant is that you'd need to add an io_uring_cap_change()
or something that gets called, and that iterates the rings associated
with that task and clears the flag. Ugly...

-- 
Jens Axboe


