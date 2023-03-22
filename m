Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA1DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 13:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rC0zG0SvapUEBPxtVD1GPdKxIKQjvdqme1KCiz1Z1EM=; b=e0Kt6/8YO/QH1mlT+Py6GXhOsC
	UJ2pfVtX28sn28e+TZUUODpywcb+qZPObsXawAJQu05Dae3YoZHE7kmp5HA9yjHRj+qfElnq7XeKa
	S6s98BuAG7Jkn6G1T52xVkKSBXrN42o62huFr4hQ/SKGTHPpudMqW0mxdgIY+eC1WRDjEmLypjNv3
	0g5CpOrMNasD6hJPGHS5o4dM5f8eKfA82rP39eo/WiroiUzDRLa8rJymph+s0LTD2CL3NXIP9C6wC
	k7IHCnRR386ZZgZaD9aOGiFWIBxEZvzXzUCk62xN/fTOtKHDORUup7LD4FNNKK5kjjqE4bzsYNnRu
	fjyFCshQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peyK8-00G4ns-2z;
	Wed, 22 Mar 2023 13:16:16 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peyK6-00G4nL-1c
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 13:16:15 +0000
Received: by mail-wm1-f45.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso5922754wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 06:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679490973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC0zG0SvapUEBPxtVD1GPdKxIKQjvdqme1KCiz1Z1EM=;
        b=3005X3skyAV+72NaxDUcLZVameX0iZF6cj5wTRIl0WZnNkrzRoHFh3KqSTvyBLzejn
         97Tqgdy3rPZcPw0CzudS179/cNUaZFvxnvqdo5fL1FyDjcsOBnKvCZdlMQcrA7M0izix
         SVnpY8UJYE/rgZBl7qhsGvPZTaVsnlmkjBx71CR2YUIxII5+b0n6sAg5HeTh24iJMT68
         cWnJDbDj+WNeVvABESedEToYKeLnLrBpiNouFDWrXV6aty551dCucXdd+QaT9WoqVy+y
         UUGl7gY6hCfPz0PB5OJgruFSz0x7jcAGKkyPwXFKfhRNEf6VLs1OaxJrb7V5Pz3SA+Y5
         99Rw==
X-Gm-Message-State: AO0yUKUvNwKrjvhYp1DmTnlovPPv13bK+DhXaKyCdK1g1208jjZH/M3o
	ou8W4iiDG46p5J08T+ooStE=
X-Google-Smtp-Source: AK7set+CpPWzKU7kUJo9nlEKZYxHxWSSGqrbg4gwFWfSP6DmVprzSIknku66aprgww/Yt7zEOatIsw==
X-Received: by 2002:a05:600c:4ec7:b0:3ed:d119:df36 with SMTP id g7-20020a05600c4ec700b003edd119df36mr6522869wmq.0.1679490972555;
        Wed, 22 Mar 2023 06:16:12 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003ed2c0a0f37sm16757490wmq.35.2023.03.22.06.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:16:12 -0700 (PDT)
Message-ID: <8a2515d4-c8cc-a70a-2b37-ec5260ea22ac@grimberg.me>
Date: Wed, 22 Mar 2023 15:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-9-hare@suse.de>
 <92bd0f9f-8df1-b1ef-dc8b-99ae3b1e0300@grimberg.me>
 <cc5a73b9-7457-9f72-1b2f-750443b33925@suse.de>
 <6d582f3e-24b9-0e27-40ad-fe2691ef26d0@grimberg.me>
 <3ba504a2-5756-8767-3cf4-6369d136fec9@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3ba504a2-5756-8767-3cf4-6369d136fec9@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_061614_537875_33D9DA0D 
X-CRM114-Status: GOOD (  18.01  )
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


>> I have a more general question.
>> What is the scenario that we will have for a given hostnqn and
>> subsysnqn more than one valid identity? Do we need to support it?
>>
> Well; there are SHA-256 and SHA-384 identities. We need to _support_ 
> both, but seeing that we're dealing with retained PSKs for now I would 
> assume that the admin ensures that both sides are able to support the
> chosen hash.

Yes, lets not over-complicate it.

> So the real choice is just between a 'retained' and a 'generated' PSK.
> And it is assumed that any 'retained' PSK should take priority for any 
> 'generated' PSK.
> So for 'retained' PSKs we can use userland to pass in the PSK
> (or, indeed, having the kernel select one as we really only have on 
> choice...)
> And for 'generated' PSKs they really come into play only if we don't 
> have 'retained' PSKs, and if secure concatenation is enabled.
> But even there you can (out of necessity) only generate a single PSK,
> so again there is no choice.
> 
> So in the light of all this I guess we can revert to only using a single 
> PSK.

This makes perfect sense to me.

