Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE62C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IsakR5nb5HoVwT7CSmfkuz8869/FesKJl00dWLPNOvo=; b=jnxdCHQEBBV8no5TqYsnIdf6HY
	rRTbKZIQgqetFhLxsJfBG4f6wYbZyS2IpWlvPfvvEr3Q2HblcDYsrc3k7/qSopWudcXgWzIBW9NbE
	jt/zTbBNekYYbx6Q7FWwZSgSe2b1syKlMLfBHgTk5XMDUlk7eaLS+brch/KvxJCUuwX2UWMDFUt5z
	W1Ek+aiVTJnr5Fl3LVH08FfBnGBIoClNMaZ4Ao7R3yKApnG29KekjrN7rjsZIQmv/kUVvb60Vv63j
	IPB83tAaGqYzxQfLRTa75PjFmgwxoD0NBo4PX/K68Zv+0ZGsYjAP4i04wqr9i4FHZvEyXgXoO9Zwg
	TQHnqNxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1Mw-00G4sC-RS; Thu, 14 Jul 2022 16:07:14 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1Ms-00G4nE-UO
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 16:07:12 +0000
Received: by mail-wr1-f54.google.com with SMTP id bu1so3164171wrb.9
        for <linux-nvme@lists.infradead.org>; Thu, 14 Jul 2022 09:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IsakR5nb5HoVwT7CSmfkuz8869/FesKJl00dWLPNOvo=;
        b=UAf5oI6nAYKiOIqd+KJ3vfNHqpByJEzRMIzyO3L5VhPuZbwtyDzZywmdZPp7XRhyo8
         7lcGae48p3vyYcB1OekjNnS0wnrSicTMhcffpBsqVnc9WrqW7bv7lBiaAqHjR0ybqlkw
         UKhZQKti2+U5S6xoJZvUG0OVIFlY5GshX94ogR12PMX6FjvAB7R0NtClSLBuKvpEuz+w
         DUDHBJVkRgRop+IWfj5C833Uq7c4qCKIg3O0QBwEUyBQddHT9kR3zLAAWkMro5xRNiZn
         4Pp4WR8sfT186v9UTczDOQkb5m7HNYloVeKGHTe46Fe1HYOBUkAL0zLV32Opu33RZ6v5
         ji+Q==
X-Gm-Message-State: AJIora84d92iSFNKsSGnu7fVlduSjhkFfuSLcR6bsCAazR9QnrcFhRlK
	b5p+zukaKmsU9HIt0BUlMCQ=
X-Google-Smtp-Source: AGRyM1sWsWpOZfiI82ywc5rwxVKa/0g6y1sLT9olyWVn3G2R7u0iSN3uiAkJTLklRNNhVtgUIz46jA==
X-Received: by 2002:a5d:44d1:0:b0:21d:7471:2094 with SMTP id z17-20020a5d44d1000000b0021d74712094mr9012802wrr.374.1657814827305;
        Thu, 14 Jul 2022 09:07:07 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0039c5ab7167dsm5950509wmq.48.2022.07.14.09.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:07:07 -0700 (PDT)
Message-ID: <6dde7d08-c51b-9595-18d9-673f585c3d5a@grimberg.me>
Date: Thu, 14 Jul 2022 19:07:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-tcp: delay error recovery after link drop
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714122703.67621-1-hare@suse.de>
 <49be3b16-9c99-460b-e321-c2727c159d9c@grimberg.me>
 <cdf87a27-0981-f51f-3900-f601f4dc49a7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cdf87a27-0981-f51f-3900-f601f4dc49a7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_090711_028656_0E2F8F96 
X-CRM114-Status: GOOD (  29.05  )
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


>>> When the connection unexpectedly closes we must not start error
>>> recovery right away, as the controller might not have registered
>>> the connection failure and so retrying commands directly will
>>> might lead to data corruption.
>>> So wait for KATO before starting error recovery to be on the safe
>>> side; chances are the commands will time out before that anyway.
>>
>> We can't just blindly adding kato to the error recovery because that
>> by definition creates a intrinsic delay for I/O failover. There is
>> absolutely no reason what-so-ever to do that. kato can be arbitrarily
>> long.
>>
> Yes, true. But the controller might need to register the connection 
> timeout and do some cleanup action afterwards, for which KATO is the 
> only value we have currently.

Yes, but it is orthogonal to the problem you are describing. This is
tying two things that are unrelated. Plus, kato is controlled by the
user and now it affects the failover latency? kato can be 1s, is that
enough? no one knows... its all voodoo.

>> If the controller needs this delay, then it should signal this
>> somehow in its capabilities. This is not something that we can just
>> blindly do. So this needs to go through the TWG.
>>
> ... as you might be aware, this is discussed at the TWG.

I remember discussing this once, and was against doing this
unconditionally. This is by definition a result of a controller
implementation. There are controllers out there that know how
to fence against the issue you are describing and there is no
reason that the host will failover after kato for no reason.

If the controller needs it, the controller needs to reflect
it to the host.

> There even is a TPAR 4129 which deals with precisely this issue.
> But consensus is that an immediate retry on path failure is dangerous, 
> as the controller might not have detected the path failure yet, and will 
> wait for at least KATO before declaring a path dead and start recovery 
> actions, potentially clearing out stale/stuck commands.
> And retry on another path during that time is dangerous.

Dangerous is not enough to universally do this unfortunately. If for
some reason that is unclear to me, there is resistance to have the
controller reflect what it needs, then add a failover_tmo parameter
that is defaulting to 0. The controllers that need a different timeout
then the user can explicitly state it.

> And yes, we do have customers who have seen this in real life.
> 
>> Also, how come this is TCP specific anyway? This talks about a
>> controller that has a dangling inflight command that he cannot fence
>> yet hence cannot serve failover I/O. RDMA should have the same thing.
>>
> The crucial bit here is the 'nvme_tcp_state_change()' callback, which 
> will trigger recovery as soon as it detects a connection failure.
> 
> RDMA doesn't have a direct equivalent here, and I'm not that deep into 
> RDMA details to know if the RDMA_CM_EVENT_DISCONNECTED is synchronized 
> with the remote side. If it is, we're fine. If not, we'll have the same 
> issue.

RDMA_CM_EVENT_DISCONNECTED is unrelated to what you are describing, the
rdma_cm event you are referring to is RDMA_CM_EVENT_TIMEWAIT_EXIT (i.e.
the host send disconnect request and timed out). At least it is the case
afair.

