Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A03EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDSvkem0DXecnNow3SI/m/2Du6SOUnVgE4z8L5YCYPE=; b=RsWsu/BbBTnFLvh+FUqyEx+TeH
	tFFoLq4gaU/6u/AsWGQhj7qouGcoyMWYJvzmHVnoptfyP+yD2g7bWCMssji7TYEI7WGYHtj1L4Byh
	FpDJFZhq4W1TbL9q9dvk8peBoyjMRmz+TYVn6/QUZOO18U0EWhemSrlFueDg2aYnVyAiSgT63yxqk
	agtr2tj+mUP5DNychgLyOnNBk1Hfmgb6sqEYDoWBHdbgHNwrdj7OBaqNGagyzv04IRhV0YkpWHm46
	t10N3U3AqPC0vIdtShEYwInYNsb06khlg2PbRLYUlP83Dsh09vmHYq+YxJJsNVKYh7Xugk+Qe7SfC
	Pd02jkzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBY95-00AnMV-20;
	Tue, 20 Jun 2023 09:59:31 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBY92-00AnLz-1e
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 09:59:29 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f80cbc37c5so10714395e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 02:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255164; x=1689847164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDSvkem0DXecnNow3SI/m/2Du6SOUnVgE4z8L5YCYPE=;
        b=k4lzPCVT24SMJyyoeLC1kx/GVQ7FdDY6IguV9pHrMhc3Q3k00WOJzOGp4hTI76zN7r
         8C2fu7ZKjWadEhWZZ9c3iu9GgulqieP5VLSNsZ5jUK3i9AnCmVA9noz0z6HuAFL1x9iX
         I8lAKMyMvYxqVW3qJ5wtcJfFjOKppQuuQj1jJqiGvEFiIanaxjWv3KAiIuG9isTZ8ugP
         Bwer19lYqGX+TT7Tp/vuB3evyqSDyxRmIUyl6rd4H8nsLh3xUEfam3W9eEfb/wKy8WLz
         oUv7hHhqpsQNvvGkWy3At88FmmLWiFCALrCEr2b3Uh5mYbFhuctEjT13s9ETUy3reGWM
         ia6A==
X-Gm-Message-State: AC+VfDwWUpeow4C4AIbrI451FLZ5QsSSqL0WurrNonAxijoKsw/VE+hV
	H4eAbSZ8Kmh+BdkNoP7BsgA=
X-Google-Smtp-Source: ACHHUZ5D8HIqMUsA2kAR+5uZAA1RvnNN9UcA28ISi2BSTqV5gIKxon1GL8WlRvhte+dMV1BWU+PM6w==
X-Received: by 2002:a05:600c:3ba8:b0:3f9:b445:9037 with SMTP id n40-20020a05600c3ba800b003f9b4459037mr2753303wms.2.1687255164004;
        Tue, 20 Jun 2023 02:59:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c21d000b003f90b58df65sm7210783wmj.29.2023.06.20.02.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 02:59:23 -0700 (PDT)
Message-ID: <7b68f0ca-b641-c34c-69e9-8afe54c8fda5@grimberg.me>
Date: Tue, 20 Jun 2023 12:59:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme-mpath: fix I/O failure with EAGAIN when failing over
 I/O
Content-Language: en-US
To: Martin Wilck <mwilck@suse.com>, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <daniel.wagner@suse.com>
References: <20230619141036.1051673-1-sagi@grimberg.me>
 <e9869e4b8bf0854dd9b89bddf3ff8e58bc8933f9.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e9869e4b8bf0854dd9b89bddf3ff8e58bc8933f9.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_025928_644330_C2B86DF9 
X-CRM114-Status: GOOD (  22.08  )
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


> Hello Sagi,
> 
> On Mon, 2023-06-19 at 17:10 +0300, Sagi Grimberg wrote:
>> It is possible that the next available path we failover to, happens
>> to
>> be frozen (for example if it is during connection establishment). If
>> the original I/O was set with NOWAIT, this cause the I/O to
>> unnecessarily
>> fail because the request queue cannot be entered, hence the I/O fails
>> with
>> EAGAIN.
>>
>> The NOWAIT restriction that was originally set for the I/O is no
>> longer
>> relevant or needed because this is the nvme requeue context. Hence we
>> clear the REQ_NOWAIT flag when failing over I/O.
> 
> Could you please explain this in more detail? We are on the bio level,
> thus IIUC a new request will need to be allocated when the bio is
> requeued.

The issue is not the tag allocation, its entering the request queue,
which fails immediately if the bio has NOWAIT set on it (and the
queue is frozen).

> This means that if the fail-over queue is frozen e.g. during
> a NVMe controller reset, IO may be blocked for a possibly very long
> time,

That should not be the case, especially with Ming's patch that moves
the freeze/unfreeze after we successfully connect. This should address
any I/O that is held hostage for a long period of a frozen queue.

> which is what the NOWAIT flag was initially supposed to avoid.

NOWAIT was set by the issuer specifically because it's context must not
block on I/O. The failover is a different context, and there is no need
to require this, its no longer the issuer context.

> I am asking because we've seen a similar phenomenon with a 3rd party
> multipath implementation recently.

I have no idea what is this 3'rd party multipath implementation, nor how
it interacts with nvme multipathing.

