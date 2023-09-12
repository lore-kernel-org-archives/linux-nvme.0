Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B0CA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/acZ8pxww6frnk62//oM2wZhERtHvFqNyYp7N6EkbXc=; b=vUJZQkDeEDMlS+MFOsSUXWM9Rs
	7+VtMrdqvnG+PE55tyO2hUlG8GO+iHtFP846Xoap4B0lhGjd0CyHLOKt2+TGugjz0D/6418i3XnYK
	6DrSN+/ONfKZL3wmbtW+1Xh73MLdWHIo6AsbUYwkBGEdsUy8P3P7l9lISqOlY0X5qu1i6dSLsJRZ9
	hylxQil/weUEnccAoN4+BSKVsrL4UkvQIdHAaxG4zDTLXLJy6BmOYJ9Z3FzO8QpfZhcI9ZO0D0KvX
	GtkLwckWE+5IFw0Z2wDs5VmnCMy6Rse7UtxCpwzF65S0jT5EchzSwC43UYcuHdy2zZ5Pg11a5bBvU
	jA9lD+DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Gj-003Isn-3C;
	Tue, 12 Sep 2023 12:13:26 +0000
Received: from mail-lj1-f179.google.com ([209.85.208.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2Gh-003Irq-0k
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:13:24 +0000
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2be4d132654so20107031fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694520800; x=1695125600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/acZ8pxww6frnk62//oM2wZhERtHvFqNyYp7N6EkbXc=;
        b=jWz8CEQ8BaMBX6uIUVsizPu+zXrkpWEMNulWdTN3I1h7nlaXpjxlnFqiGmcUBvyBhK
         o6HGIh82+qXVWwdn6HISSkIxb22HOz63GOCpOg54vHfkLrI3awwNERXsc2ATaqc3Hapl
         3HqtlBjM4dI+DE0wystMxLm0YkkM8Aq+IXY1NeBVm+cnQFK8/8VzAc/NSC2Rg9VoHjSn
         jqxjfifzJ878pSop3z1qCNAM3LH7asNElzt+DqV7887nfNtnRjaJNe4xJVL2LXZR/i/C
         EqtWN6UF87syXHtLR2flcoYd4Hg7RMlIcouGqoVvSRgsKbnQIrYKKN4NA/+mRs7efaur
         AxEw==
X-Gm-Message-State: AOJu0YyBp5oOPiaYifo6Rr+HgTHion8hCUDwWghUtSVFZNPWNoqIQNHC
	i+BAh/MjFHfx9EKVtQSAnpw=
X-Google-Smtp-Source: AGHT+IE6pGvM2Xfn9lZZdAn7N0YSNpNE/IomDPQVBm2CleUVRrJu2mbR0J6r67tWNgMRdW3rSxT3bg==
X-Received: by 2002:a05:651c:124a:b0:2bf:7908:ae73 with SMTP id h10-20020a05651c124a00b002bf7908ae73mr6670278ljh.2.1694520799866;
        Tue, 12 Sep 2023 05:13:19 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id mc14-20020a170906eb4e00b009888aa1da11sm6714655ejb.188.2023.09.12.05.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:12:58 -0700 (PDT)
Message-ID: <16908ba7-73d1-0cb4-6724-caaad7468d37@grimberg.me>
Date: Tue, 12 Sep 2023 15:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/3] nvme-tcp: start error recovery after KATO
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <1cea7a75-8397-126c-8a2e-8e08948237b1@grimberg.me>
 <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <691e717b-daf0-458c-bbd7-be6c8ffa8f7e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_051323_265900_6BDE1674 
X-CRM114-Status: GOOD (  21.10  )
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


>>> Hi all,
>>>
>>> there have been some very insistent reports of data corruption
>>> with certain target implementations due to command retries.
>>
>> None of which were reported on this list...
>>
> Correct. I can ask them to post their finding here if that would make a 
> difference.
> 
>>> Problem here is that for TCP we're starting error recovery
>>> immediately after either a command timeout or a (local) link loss.
>>
>> It does so only in one occasion, when the user triggered a
>> reset_controller. a command timeout is greater than the default
>> kato (6 times in fact), was this the case where the issue was
>> observed? If so, the timeout handler should probably just wait
>> the kato remaining time.
>>
> Nothing to do with reset_controller.
> The problem really is in nvme_tcp_state_change(), which will blindly 
> start error recovery (and a subsequent command retry) whenever the local 
> link drops.

That is incorrect. A link drop does not trigger a socket state change.
a state change is triggered for specific socket states
(see net/ipv4/tcp.c for description of socket states).

These are a set of states that describes local and remote sides
shutting down (or a TIME_WAIT). The cases where the host
triggers error recovery without the controller acknowledging it
(in case the link is down) are FIN_WAIT1/2, and these happen
when the user triggers a controller reset/disconnect.

In the other circumstances, we'll see a TCP_CLOSE/CLOSE_WAIT/CLOSING
which should indicate the controller acknowledged the shutdown.

> And that error recover does _not_ wait for KATO, but rather
> causes an immediate retry.

We can't blindly wait for KATO. If the controller saw the socket
closure, there is no point waiting kato.

If the user sets KATO to be 3 hours, and does a controller reset,
what happens now?

Only when the host triggers the shutdown, and that is not acknowledged
by the controller, then yes, the host needs to wait the remaining of
kato.

