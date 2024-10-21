Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0BBD15DAD
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43UnT+pFGN/YtllYopifa6ZWEaQaAuDJazNLhRyQg+g=; b=yjzo0i7cGUiG12oMZBBqvLJmqe
	3oxSfXTIOnlJnt0pz8g2qtwV0TJEVTiczLislNBPZpYFeIGbxYYYeanr3DnbNjvN29i52T/Wj/q5e
	aXUVX6YPJ6XlPoCsJaGrxEY7qLe6dc/yMOK2yiK5IaFuWoVJydIdlHsfK3QzITiD1Klqo/Nm7OIwr
	OOnZm8USnvLMOYDfWbP9uY+agRVa5R1TQy6jfxNmri+GLB7MJN3GjevHKpBQlIsIjuvuN6ZZfxccQ
	1nt/lxXEgGijdSqQWF2Cp3yzf2C7nua2eaDWra8g1AmqJM7olXoyzyVV+keInMfjI7BUGn2768Cvo
	XRN6d9Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uU6-00000007ohy-1NDj;
	Mon, 21 Oct 2024 15:38:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uOL-00000007nng-26iG
	for linux-nvme@bombadil.infradead.org;
	Mon, 21 Oct 2024 15:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=43UnT+pFGN/YtllYopifa6ZWEaQaAuDJazNLhRyQg+g=; b=rOl9Hrgn6gj00pK14aiXc7jnf5
	YL8X0sCTVWtn0TFBCYZj1flHWVDkWo2tBRY2osft+1fgi7h1qxM2JtZ1tyeAdB2QKyxLOXADCHzok
	rlnSXIGMpT4EvOzBBm1UuUZXyfOXELKwvywy6C7iCMjF7/cvv4fopLlcbtc7XkQQLZAbFOwkFzqTe
	MI0oHCrGM7CrLP+IMvBE7eeNjMvICccIwghfca4f5MeAlj+8lWgPGmcVkA1jVmLOG7mDhNyFLOyxi
	gjVXAT9tYU6BE/xPTccLX/2IxvFamQL3Bjx5/5qmQKqt7yJ1/0YMJ3xMG7VJpYyeNZRvRAzvRlHHC
	BA0ZGF2A==;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uOI-0000000800m-0ieV
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:32:20 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so44612515e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 08:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729524736; x=1730129536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43UnT+pFGN/YtllYopifa6ZWEaQaAuDJazNLhRyQg+g=;
        b=RSsBXU25ZoffwUF6prDrgTJtkCTZyKDT7BVWkKBcC/ph8jJB2Zvdwo3mq7yq7sLOZZ
         JT4drlop2Y7gLpbxiiLdIM3jMjc6UqxCQjnvuOTZeDb5j7P9315pnMp8CcwUgk0XC/BZ
         j6qMAZboId1oFJT3PcnqnqiJekiH9K9dRzvXdspdT1fA7rSLdc0r/ibNTsyLNefQAoLm
         MdFMrazSRpu2QaKFJXBTiaqijWR9lPEIfsVQuZMccSz+hAY/A+n3X0JG92RItIp03wQJ
         mX205V1GiwAJFjJ5qGCKZu4WCLIo3QzcXat0oAb2X5L6zFaDiqYKO0E6LRItxcxpR8oX
         BzFg==
X-Forwarded-Encrypted: i=1; AJvYcCWra1BqjlYZvw7JFT8CEARAZPO0MlnfMSv0LAbw+0ef/LJMfT+vFV9fFmKisz3SmSdTQGbBB6uDaGQo@lists.infradead.org
X-Gm-Message-State: AOJu0YxmLVbFTu/FEvWlbOz742gezEQZZX6aIOecdFpD8fNu8ESbFM9v
	uvzDQtquL6vcgU/Aqhexv4QtRNQXxB7CXyqYEkMyzhqpnCaaFc5m
X-Google-Smtp-Source: AGHT+IEP5TEn2oZzz0bJqnjDuhV4Vk01puR4VsoCK0og6+x1FdquNP63k9jUmbXcnF40AaeijMWbiA==
X-Received: by 2002:a05:600c:3110:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4316169ac06mr94805705e9.25.1729524735392;
        Mon, 21 Oct 2024 08:32:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bc9csm4541692f8f.108.2024.10.21.08.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:32:15 -0700 (PDT)
Message-ID: <0b07ae7c-0324-4e29-8058-dce4d29fe5cd@grimberg.me>
Date: Mon, 21 Oct 2024 18:32:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] nvme-tcp: request secure channel concatenation
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241018063343.39798-1-hare@kernel.org>
 <20241018063343.39798-7-hare@kernel.org>
 <a188adf5-55be-4524-b8eb-63f7470a4b15@grimberg.me>
 <56fde9ae-8e27-4ade-bdc4-99bf3f53a299@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <56fde9ae-8e27-4ade-bdc4-99bf3f53a299@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_163218_296085_92D433C1 
X-CRM114-Status: GOOD (  22.52  )
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




On 21/10/2024 14:00, Hannes Reinecke wrote:
> On 10/20/24 23:04, Sagi Grimberg wrote:
>>
>>
>>
>> On 18/10/2024 9:33, Hannes Reinecke wrote:
>>> Add a fabrics option 'concat' to request secure channel concatenation.
>>> When secure channel concatenation is enabled a 'generated PSK' is 
>>> inserted
>>> into the keyring such that it's available after reset.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/auth.c    | 108 
>>> +++++++++++++++++++++++++++++++++++-
>>>   drivers/nvme/host/fabrics.c |  34 +++++++++++-
>>>   drivers/nvme/host/fabrics.h |   3 +
>>>   drivers/nvme/host/nvme.h    |   2 +
>>>   drivers/nvme/host/sysfs.c   |   4 +-
>>>   drivers/nvme/host/tcp.c     |  47 ++++++++++++++--
>>>   include/linux/nvme.h        |   7 +++
>>>   7 files changed, 191 insertions(+), 14 deletions(-)
>>>
> [ .. ]
>>> @@ -2314,6 +2345,8 @@ static void 
>>> nvme_tcp_error_recovery_work(struct work_struct *work)
>>>                   struct nvme_tcp_ctrl, err_work);
>>>       struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>> +    if (nvme_tcp_key_revoke_needed(ctrl))
>>> +        nvme_auth_revoke_tls_key(ctrl);
>>
>> Having this sprayed in various places in the code is really confusing.
>>
>> Can you please add a small comment on each call-site? just for our 
>> future selves
>> reading this code?
>>
>> Outside of that, patch looks good.
>>
> Weelll ...
> We need to reset the negotiated PSK exactly in three places:
> - reset
> - error recovery
> - teardown
> Much like we need to do for every other queue-related resource.
>
> And in one of your previous reviews you stated that you do _not_
> want to have 'nvme_auth_revoke_tls_key()' checking if the key
> needs to be revoked, but rather have a check function.

Sounds right.

> Otherwise I could just move the check into nvme_auth_revoke_tls_key()'
> and drop the 'revoke needed' call.

I prefer that we don't

>
> Furthermore we don't need to check if the key needs to be revoked
> during teardown (answer will always be 'yes').

won't it also be revoked in setup?

>
> So I'm quite unsure what to do now ... document that we need
> to release the key when doing a reset or error recovery?
> Move the check back into nvme_auth_tls_revoke_key()?
> Hmm?

Just a little documentation to why we like to revoke the key so many 
times ;)



