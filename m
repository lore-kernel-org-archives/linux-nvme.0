Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873DDC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 11:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OmuX7s/e/VbG+QRsTX+4gHwPMk9vRHc/KVnlZ8Ipnm8=; b=LkwICqDtOgXspa2K4I6gNYhOAN
	9CsuHEdL0owNRXruth2z6/p6xE80U9o19Cea/QnPR8IDcuXyTELdXStonYBEfDgwp9MWk7CgY5lTM
	Fpu1QhGf8JdTE4wFTMQGnE0xQDcMEUgr5qIc9Qh5FirUs4E+KMC6S4j1iV77wlLnwyzpqQO8xAyqp
	eJX6z19Rr8NW+QEPLtRfHPZeEVNzAw4A9tGtwoqgPxMljmNvR74wqwCcfM1TdVeHQRqwTdi52EXLv
	/3VRc1iPfbiA5XM6diY/07yOc3y0pxXfgViswJeOU84z24nVRs0I1pq9s+GNr33RUssqLwQ7ZW6QZ
	94lmfdMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU59c-008rns-Ci; Tue, 15 Mar 2022 11:15:52 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU59Y-008rnD-PB
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 11:15:50 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 v2-20020a7bcb42000000b0037b9d960079so1223010wmj.0
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 04:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OmuX7s/e/VbG+QRsTX+4gHwPMk9vRHc/KVnlZ8Ipnm8=;
 b=WIrv6i+V/H62MgNCW95HtktrH+B9XOIvdVdhC70D35OyXaaJsxYj28j1CwGDoKsfp8
 SUS3vA8SVQOODD2Htzw4Dv9R2W4UYM7zLt34fAMaInSWXdQHQ7lUoFjkguDDFUCCqOro
 lcXGBPMLp6u40unlIFyROOVwKko8ApqMxtfbva4/LRKID48LdQW1MQr7tMNZAdZqYzyv
 s/0L834d0M7cxzcCo2+v0OrzC95UmPZQu0l+4aPeKj6Zf24wQcYIwnBjZZfy8ABg7Wmw
 G6sW48Wa0QsjnoxyIzPRq+XTwN52Jcd8yWxIhzk7yWY0PgehgNgbLyzIo26h2HAIZ5qd
 f0kw==
X-Gm-Message-State: AOAM531uhNUebPUQ98N7xC4gve30Ti8R5ltrv+sL7h290iTrVzN2LHBA
 AGWn+oQT5qg0N9dQbk+Xx/U=
X-Google-Smtp-Source: ABdhPJwBlFjfX0YKAMpGBIaeUdCMl7SIFVgk4TmrNLcw/9kCvaXi9LOnomtz9MpNby3vquc2MVwhkw==
X-Received: by 2002:a7b:c1cb:0:b0:384:177d:871c with SMTP id
 a11-20020a7bc1cb000000b00384177d871cmr2888377wmj.84.1647342946823; 
 Tue, 15 Mar 2022 04:15:46 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 a8-20020a05600c068800b00389bdc8c8c2sm1865079wmn.12.2022.03.15.04.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 04:15:46 -0700 (PDT)
Message-ID: <b0334223-367b-690b-3a41-55ccae21b47a@grimberg.me>
Date: Tue, 15 Mar 2022 13:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
 <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
 <79067416-401e-7ee1-2de8-f67187aaecdb@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <79067416-401e-7ee1-2de8-f67187aaecdb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_041548_855658_324A9BC4 
X-CRM114-Status: GOOD (  21.98  )
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


>>> The current problem we're having (on linux) is that we cannot 
>>> identify discovery controllers. Each discovery controller has the 
>>> same subsystem NQN, and hence that's not sufficient to identify the 
>>> subsystem
>>> Which resulted in linux to always create a new 'nvme_subsystem' 
>>> instance when creating a new nvme discover controller.
>>
>> That is the case regardless of naming... there is no multipathing with
>> discovery subsystems so there will be a subsystem for every discovery
>> controller...
>>
> Well, technically, no, but in practice there is, as one can easily 
> specify more than one discovery port (to the same discovery subsystem).
> And quite some target implementations do.
> Discussion is probably moot anyway as multipathing would only affect 
> I/O, which won't be done anyway.

It is a moot discussion.

>>> Problem now starts when you try to use persistent discovery 
>>> controllers; it's quite easy to _create_ a persistent discovery 
>>> controller, but less easy to _use_ an existing one; how would you 
>>> know which one to pick?
>>
>> You are not supposed to "use" an existing one, the whole point of the
>> persistent discovery controllers is that you don't need to worry about
>> it. We already perfectly handle that with udev using the kernel of
>> the uevent.
>>
> 
> And my point is that you _do_. Yes, udev does work, but only in so far 
> AENs are involved.

Why do you need persistent discovery controllers if you don't want the
AEN?

> When you want to retrieve the discovery log manually 
> _and_ have existing persistent discovery controllers you'll need to know 
> which device to pick.

Please describe the use-case because I still don't understand.
nvme-cli offers 'discover' that gives you the log page and 'connect-all'
that connects to the subsystems it found in the log page.

Do you have foreign udev rules in addition to the ones supplied in
nvme-cli? I am missing the problem statement that you are alluding to.

> Which is getting especially interesting if you have several different 
> subsystems to contend with.

I still don't understand what you are describing.

