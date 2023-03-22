Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEA9C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qCUJxGjV7L1rJvHzwsGUV3/+MN9H6ACuEOI0mbTY1Sg=; b=ipDa0pesO7mQLuIVHQ0RVGndBd
	EDLkG5XAC1itg2f/foFhwk8i56lI0WoUf5mCBC5pomwJ3R8mbGZC9+loxCq4AdPLiE7/6Puu3KCIA
	ouyK+RCrpVcsNzL1dYgT7Znudc/RKqM5/mSNZrmNymnrx1CcXNAEGVlGhTWFbvDZlkMQSy2Dnli83
	PncgDsCpbt0KadN/QqCGtNn0/hjG+fj99qSvD6L9bPJIpuIH9YKkncihwA4avm8eMMVaJ2AG4Mwiz
	yVRZc367eTUQx6CW3sViSBKimqvXQ/556N4rKop3qlr6yhul08DaGonTCj0iUi/TiDDGf2CvsVZ+r
	DXRdqIsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peta0-00F7q3-1X;
	Wed, 22 Mar 2023 08:12:20 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petZx-00F7pA-0J
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:12:18 +0000
Received: by mail-wm1-f49.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so5986704wmq.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 01:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472735; x=1682064735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCUJxGjV7L1rJvHzwsGUV3/+MN9H6ACuEOI0mbTY1Sg=;
        b=Q+moas4APty8mzYL3bY3ZdsSyOEtM3e9MYuy/ugGzXbv1iETJ0XkGAB1d+UTxtfQmo
         iOlWK9fOBOcjhXY5lbtoTWTZOzmtPnkZNG+YXCDVeputh7Q47YHokWHP1Sp/y2mBFNPG
         ai6f/YVSD9nu/nxKof9t9T/CXWSvAgGuKRGOaA9ICJUK4wiZForsRIr7oZD7cH9i4oDl
         Yrb9zyaHKm4c0e4s7h50arPMqesIBRm6S1/q6haODNTxbFaQpdAJiSm15Nfu9b0lErw+
         tENreLqTAOBhwEgCNcFREWzA0YbYui8mI9gQwzdt1e4lxsw45FEHrwhRbxsYUbE7GRKy
         Jz8A==
X-Gm-Message-State: AO0yUKV1DWTuJsj1z7wnFFjghnoY6EyxEM/vOVMJjxghvhixg/GOBjAB
	C7tDSAawAgAinlpn9zTYLdCqpWxTIwk=
X-Google-Smtp-Source: AK7set+56Fe+VnCC1zoexfEfKHQN1RoOMZBvv3e7HYxbiXSklW6Ef2RbOdlbOEIPkxKjeXyqkMVbpg==
X-Received: by 2002:a05:600c:4743:b0:3ed:c956:4854 with SMTP id w3-20020a05600c474300b003edc9564854mr5090652wmo.3.1679472735572;
        Wed, 22 Mar 2023 01:12:15 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b003e7f1086660sm22391000wmb.15.2023.03.22.01.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:12:15 -0700 (PDT)
Message-ID: <e55cf3ce-6446-7663-aaac-45d497714db7@grimberg.me>
Date: Wed, 22 Mar 2023 10:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] nvme-tcp: call 'queue->data_ready()' in
 nvme_tcp_data_ready()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Chris Leech <cleech@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <cel@kernel.org>,
 kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-7-hare@suse.de>
 <d868b752-1d8b-1236-3543-c9ef82e42f23@grimberg.me>
 <3bd2c6b4-b276-b882-6f28-998118f96650@suse.de> <ZBpJQENvFoyGortp@localhost>
 <2dbd26ec-c384-866c-8d76-38364fa3330e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2dbd26ec-c384-866c-8d76-38364fa3330e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011217_127723_1D551744 
X-CRM114-Status: GOOD (  26.66  )
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



On 3/22/23 08:59, Hannes Reinecke wrote:
> On 3/22/23 01:18, Chris Leech wrote:
>> On Tue, Mar 21, 2023 at 03:09:06PM +0100, Hannes Reinecke wrote:
>>> On 3/21/23 14:44, Sagi Grimberg wrote:
>>>>
>>>>> Call the original data_ready() callback in nvme_tcp_data_ready()
>>>>> to avoid a receive stall.
>>>>
>>>> Can you please improve the description to include what is the stall?
>>>> For example, does the stall exist today? If it is, I would like to
>>>> separate such patches from this set and include them asap.
>>>>
>>> That is actually particular to the TLS implementation, as it uses the
>>> 'data_ready' callback to produce the data which can be read by eg 
>>> recvmsg().
>>>
>>> Without this call there's no data to peruse for recvmsg().
>>>
>>> But I'm not _that_ deep into networking details to know whether this 
>>> is TLS
>>> specific or an issue with any data_ready callback.
>>> I assume the latter, but then again, who knows.
>>>
>>> Hence the slightly vague description.
>>
>> This looks like the socket callbacks end up hooked in the wrong order.
>> Ideally it would be tcp -> tls -> nvme_tcp, while this currently looks
>> like tcp -> nvme_tcp and then this call back to tls for decryption.
>>
> Well, problem is that I need not one but two sets the callbacks.
> One callback is for waking up userspace (took me weeks to figure that 
> out), and needs to added before calling the userspace helper.
> The other is the 'normal' nvme-tcp callback:
> 
> tcp->nvme-upcall->tls->nvme-tcp
> 
> So really the problem is not so much an inversion, but rather the fact
> that the nvme-upcall callback is really only needed for the duration
> of the handshake. And hence I thought that we should remove the callback
> once we're done with the upcall.

What do you mean remove the callback? data_ready? I'm not sure I'm
following.

> Turns out that we can't, and the best we can do is to disable the 
> functionality, leaving the callback itself in place.
> 
>> I'm not quite sure how to untangle this; nvme_tcp can't just set it's
>> own callbacks before initializing kTLS, becuse that's being done by
>> tlshd which is going to need the userspace socket API callbacks working.
>>
> Correct.
> So for now I'll leave the callbacks in place, even though they are 
> pointless after the upcall.

Does it make any difference now that callbacks setting moved to
nvme_tcp_start_queue?

Again, I'm not sure I understand what callback is pointless?

