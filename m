Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639AC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 19:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TVJeiLt5j/iH8lwK4LU4olaiGRYiuB6QYTKpmCdHn3w=; b=Ux74ofZrY5snzzmz8BbiqGB38g
	8GX3ls1ExUZtZbfxW/Upv2HDsfxFaN6PBUC7+4qT+2YwIEAynJhHzGj1J9DGpxM3WnZMj2yp3ld6Z
	hNWsmcfT0CiXjCEtvtjnYWSHcaeVFCEU/KfHwPFMMTiMr8AgrCVN3BcquaeXE1WAzHeTsV8w7rX09
	TD1u+GeXe00HMFGzcqF1zoJiuLT5lE6sfOBuqEN0yvC2WKRqnXLgoSNGAz9wsJ75S4uWdC5FlAhIl
	0ufe32KR9+FFoSr3SDScJfaXU777LiPbsPY3I9OL93h/6Gd2JCsHO5iCG3GxgruROPJm2gwxN9LNl
	meYfFxfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5xS-0000000BIt8-34Zk;
	Wed, 03 Jul 2024 19:48:02 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP5xP-0000000BIsl-3wOz
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 19:48:01 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367339ddcdeso363261f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 12:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720036078; x=1720640878;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVJeiLt5j/iH8lwK4LU4olaiGRYiuB6QYTKpmCdHn3w=;
        b=PRVq8UaL1Fkc/iQrsRN23Ov3aSpjNgWUygUXrtZ00hnxzV2H0WJmJLDXpLZ0sA0ftt
         WMc0TirKVR8BNuuW00UK+JInQTYtp+/lWdmcHsIrdCI0oxUQTx6LzHVjguAiMzhA0rO+
         BYwRujuWrzwMjtlVB9OVpK3tZr5Upubx9WcKIEgjaFGg6rPogwhFFjS3vjWt7pveQZwn
         mmTb/NJNvZiIPs9mGiksH93QIZuAFzL8YE68pzli3ybmyGeKqpX/lSMJcAxH+dNA3L+q
         ioOlwAPnuLa++Yh10V7D8b3iIX1U2nix+wIUvi7cT071/rbB4T+gUUOYEbzkEYivXdqn
         W5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZK7oLOla+klcD2lvL8H5t/cAsvf+GBJsM/jN8ceMT1wb6rYzooFdNkLgPnJHZCtCBKk2yOj7Q1t3ubF5RiejHBR1mlnopc7/7Es3vTI=
X-Gm-Message-State: AOJu0YwuCQPnxxUz5ddm4WVjCp+zIZ7MQFwwrOyj2F/kAIUZ2gd6kbQf
	xO5sToGJwhaMyPOEanXEO3R2uTIatJxJbEUc26lq51KJ8xKsF0jc
X-Google-Smtp-Source: AGHT+IFJL60Eh/CsKzFFcjiRO08UZz4ZkNw0zJkhU5WWYa1xoP38a8bB6v9AKIBOTHIARvEBlGDmWA==
X-Received: by 2002:a05:6000:1acd:b0:365:da7f:6c13 with SMTP id ffacd0b85a97d-367756a07d0mr8982336f8f.2.1720036078260;
        Wed, 03 Jul 2024 12:47:58 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55cccsm249601935e9.16.2024.07.03.12.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:47:57 -0700 (PDT)
Message-ID: <9a8b33d0-b908-4f09-9823-410ba12f2d0d@grimberg.me>
Date: Wed, 3 Jul 2024 22:47:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
 <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
 <9bc9d94f-a129-4c6e-ac9e-d0eb8db341b0@grimberg.me>
 <dc849cb6-8bf3-4363-9bd1-9b13138c0fb7@suse.de>
 <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
Content-Language: en-US
In-Reply-To: <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_124800_015353_4E6D20C9 
X-CRM114-Status: GOOD (  18.24  )
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


>>
>>>>
>>>> And it makes the 'CPU hogged' messages go away, which is a bonus in 
>>>> itself...
>>>
>>> Which messages? aren't these messages saying that the work spent too 
>>> much time? why are you describing the case where the work does not get
>>> cpu quota to run?
>>
>> I means these messages:
>>
>> workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 32771 
>> times, consider switching to WQ_UNBOUND
>
> That means that we are spending too much time in io_work, This is a 
> separate bug. If you look at nvme_tcp_io_work it has
> a stop condition after 1 millisecond. However, when we call 
> nvme_tcp_try_recv() it just keeps receiving from the socket until
> the socket receive buffer has no more payload. So in theory nothing 
> prevents from the io_work from looping there forever.
>
> This is indeed a bug that we need to address. Probably by setting 
> rd_desc.count to some limit, decrement it for every
> skb that we consume, and if we reach that limit and there are more 
> skbs pending, we break and self-requeue.
>
> If we indeed spend much time processing a single queue in io_work, it 
> is possible that we have a starvation problem
> that is escalating to the timeouts you are seeing.

btw, if this is indeed the root cause to this issue, we can probably 
combine the softirq approach with this.
in data_ready, consume a limited number of skbs directly in softirq (say 
32k), if we have more, schedule io_work
to consume the rest, and pace from there in limits of say 512k bytes or 
so...

We may actually end up eating the cake and having it too. But lets see 
if this is indeed the root-cause first.

