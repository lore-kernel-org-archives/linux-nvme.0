Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B07C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 03:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuF96zzT57twduJlHeKSD6TkuFieUVPnAsmNC4IsGOc=; b=z4jRbBIVQ02fuUpmefoD0IaDLH
	teEhqPvb9ZT9lNmye/sZsX/I4be6hNchuHma9Qiu58fZzWmHwOVTu6/FKhoXWEMyi+wTLsyTS0dmL
	zGLq/wwcSgt9ws3gIWcQ3xo/Z/f/LNx9ELg5PNvb5jLvyyezFzk+pk1NV6aT/QSl+2dokmoOJDrbf
	nUl2CI69SifJYXRzvQxFXAPnrm1WD+PNYKnuDk6+IXw8YDrdtgsSe4G2gcP/5lQCsAqCtNmGPoS7w
	SEE0fSh5bYp72wZnRHhswZNJreGoFAKEu80PjgZbYBYlHfCQWheij9+TOVhmCvo+4QY4OKneU8msL
	T6sq/1vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOtJf-00Enkm-8l; Tue, 01 Mar 2022 03:36:47 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOtJc-00EnkD-6n
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 03:36:45 +0000
Received: by mail-pg1-x531.google.com with SMTP id o23so13290023pgk.13
 for <linux-nvme@lists.infradead.org>; Mon, 28 Feb 2022 19:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=yuF96zzT57twduJlHeKSD6TkuFieUVPnAsmNC4IsGOc=;
 b=gPI++ctiPbeOLDXHs2JCiOGa5xjh9jv/2cq+ReN80iq+oluvWXc6V2SliGXEJdyNlg
 wFKwEl6crL/rzy5g76d53W93Pnm7BY28bUvD7CS0S2yPCAFa8xe0hGEwJbbwQFmuvLfY
 oYz9vKATTF3DnzAWsegi9S8eiKRvI+kFsEZ0RdvsU/yd6hgv03eqIyI4quwquZqm6i4q
 pB8YYc1tcrXDPsKMqnDMuL8QLPBrE7ZWdXH4qnqEUpASo/+Z1qfysyLEUbM2ysqMqjXk
 sYp8/ha3IbCm3/D23uiUzcTPkQO2WKs0GJwlaAlXouwGG9oO/Bxp5Xsj/nzGKSvZYl4f
 JgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yuF96zzT57twduJlHeKSD6TkuFieUVPnAsmNC4IsGOc=;
 b=greApe3oQ+thdCWOLqfXGZriNsGOCzKeOiKV/iSfV/St/6eDQUEEJG6B9KvYtevWqJ
 GtvlGgPFOpP/+wahVyjgLF0j6Zu9fh9sFSeCx/H57QuCBNlIFt9msbcChmA/BT9nL9cy
 jG8WXoTlGGSdY7wTE/eUWBMnMLWCmVMNrOTKG3Sqlur3ln5qlOk2EylAJMkHxz5SC/sV
 IZbGVDEflnW+czPMuqlKoL7lMCmiDgL4EyC5qLu3687aTQ6Y5Mk62yugLFysmLUFhVZI
 4iKqGCcSLc9ZzByIhink+zki9i40gU/KTK5DMbK/gGqSOpqUHB5l4XszlmgUcdB8B04I
 O8hQ==
X-Gm-Message-State: AOAM533nDwMdZg+UOSQjpu/nC7GLEonrRdovlPaMffog4j3Gn+TNswwJ
 /mRTtJJEj9mtc16RRP9OZ67Dtw==
X-Google-Smtp-Source: ABdhPJywg+Sm8GNjdeMS62YMjsjTrpLvsDf+jafMIIarrfWMp6kDAFDQHsKYHROqVQdwlVoPNp5p1A==
X-Received: by 2002:a05:6a00:a8f:b0:4e1:2619:11a2 with SMTP id
 b15-20020a056a000a8f00b004e1261911a2mr25071872pfl.53.1646105802445; 
 Mon, 28 Feb 2022 19:36:42 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 u37-20020a056a0009a500b004e1414d69besm15344351pfg.151.2022.02.28.19.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 19:36:41 -0800 (PST)
Message-ID: <4100a868-c5bd-91dd-0c45-a92fb1344b12@kernel.dk>
Date: Mon, 28 Feb 2022 20:36:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
 <20220301033001.tozk6cakdznww6wi@cyberdelia>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220301033001.tozk6cakdznww6wi@cyberdelia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_193644_349657_9E4470A1 
X-CRM114-Status: GOOD (  19.22  )
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

On 2/28/22 8:30 PM, Enzo Matsumiya wrote:
> On 02/28, Jens Axboe wrote:
>> On 2/28/22 2:22 AM, Christoph Hellwig wrote:
>>> I don't think we should add code to the absolutel fast path for
>>> blinkenlights.
>>
>> Agree. It'd be a lot better to put the cost on the led trigger
>> side, and not need anything in the fast path for block devices.
>> Monitor disk stats, or something like that.
> 
> There's been at least 4 attempts to do so, as far as I'm aware (one of
> them being mine). All got rejected due to the complexity it introduced,
> that's how I ended up with this one-liner.
> 
> Performance-wise, I'm understand the problems, but according to ftrace,
> ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
> LED is assigned or not. Is that really unacceptable?

On fast devices, we can complete a full IO in ~3us. If it's 6-7% of
overhead for that case, then yes, that is definitely unacceptable.

It's as much the principle of it. If it can be done in such a way that a
feature that almost nobody would use doesn't add to the fast path, then
it should be done that way.

What kind of frequency does this need to be toggled at? Surely not
hundreds of thousands or even million times per second? If it's suitably
low, then a registration scheme and a running timer would be a much
better idea. Each time the timer triggers, check devices you are
interested in and toggle the LED based on that. No fast path additions
for that, and it keeps the cost at zero for folks that don't need an LED
trigger for drive activity.

> If so, would introducing a CONFIG_NVME_LED (default =n) and wrap that
> call around it make it better? Then at least there's a chance to inform
> users that desires this feature about performance costs.

Doesn't really help, because then distros turn it on and we're back
where we would be if we didn't have a config option...

-- 
Jens Axboe


