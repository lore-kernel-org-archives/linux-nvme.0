Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C136C05027
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 09:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=snpLNXv2ZkBTEkENBmqwHef9Krq2PGoJ7VZwTLPy97E=; b=2oe3Ourtjoh3CxzM/eCZnRwC3V
	Jp/IJCPgKipHIeBNrlJB3t4t+Bv7OcnWCBbjSiUNvSwkOMX2/8G4qwOAPlk60IwMGYoQh4L9CuEhy
	KkGF5mIq22M6eIwIGS6bBooe8TAucqQLFlcTuw0BYyD/7MYmF5EuUJLDBpFhDyPdA9W5JZfA6kJ3R
	UiXsj+S2kVSWUm/c8JLhhi0U/Cv2m7GZM9C2V4FmQT69rIvxa8EjfVGmSkgTBpzbwehk0DVTJoK6q
	zlEGniGkA7zlRlOOhIQGQNcTDVJZWEUJh5Nv8CpNIHPgxqf0RA8JH1Bc0ncAmioj69FQ1WH6cfisa
	e+ADFwKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrF9-000d9e-W5; Tue, 14 Feb 2023 09:04:56 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRrF4-000d8d-0M
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 09:04:51 +0000
Received: by mail-wm1-f46.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso13127588wmp.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Feb 2023 01:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676365486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snpLNXv2ZkBTEkENBmqwHef9Krq2PGoJ7VZwTLPy97E=;
        b=orijdisTi3AiZ6e8ZyRRw7X3Eb21xSOtv0Gw6HQah/EhMc9ShLzrJpmbevWS2RDfBp
         AD7I+z/sTejkTuowcO6lw3XmfbGkLmyZK8nBkJTLBqAc7jV6lynfH063fwtm2j5K+XdY
         2DV7IATRwUH91GPdAQjhSvFt2cF2NaCOHpIt87d/zAuuwK9sKq46ilZpK+ZfGcsxm5SH
         T/AugpcYNS51e919skIxT1XV/LgITF8xW1bgq7fWBKLSWLhyoUuznvaSEEUZxhbSmWON
         h1zyVfUgLebxnZQrf3tChVXJzDG6L/nYTWrQLdlLIKn2HkKrLIqKX5v20pZFCbFZt6vy
         zk2A==
X-Gm-Message-State: AO0yUKUasBy/sfH4sfJm+s3f2tkWeav1/+oZObSob/bgC7babJv1CTop
	+cxgnLH0zFSCAkEIL8aKRcrJkobD9NQ=
X-Google-Smtp-Source: AK7set+4wGWlDZrmJJAqxkOuNC3KAN99QAfpz+L2V7L+mjfmrXf3C5GPel0u7nD5hl1E2/MNO/Vsgw==
X-Received: by 2002:a05:600c:4f8d:b0:3dc:54da:ba3e with SMTP id n13-20020a05600c4f8d00b003dc54daba3emr1658633wmq.3.1676365486319;
        Tue, 14 Feb 2023 01:04:46 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c544e000000b003db06493ee7sm20623650wmi.47.2023.02.14.01.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:04:45 -0800 (PST)
Message-ID: <6e532415-e440-c8ba-6bc2-afcf1fccf183@grimberg.me>
Date: Tue, 14 Feb 2023 11:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme/pcie hot plug results in /dev name change
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org> <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com> <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y+pmI52Ahfn/hF6m@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_010450_052655_AE8E13C1 
X-CRM114-Status: GOOD (  16.16  )
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


>>> Also not sure if this is going to work out, but it looks like a good start to
>>> me.
>>>
>>> Instead of user pinning the virtual device so that it never goes away though, I
>>> considered a user tunable "device missing delay" parameter to debounce link
>>> events. New IOs would be deferred to the requeue_list while the timer is
>>> active, and then EIO'ed if the timer expires without a successful LIVE
>>> controller attachment. The use cases I'm considering are short bounces from
>>> transient link resets, so I'd expect timers to be from a few seconds to maybe a
>>> minute.
>>
>> Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
> 
> Similiar, but generic to non-multipath devices.
>   
>> We can keep the mpath device around, but if not, what is the desired
>> behavior from the upper layers?
> 
> I don't think we're looking for any behavioral changes in the upper layers.

I'm looking to what Christoph wrote, that in the long term upper layers
will need to look for replugged devices. Let's take the simple example
of a FS mounted disk that is going away, today the FS may get an error
and go into RO or failure, needing a manual remount after the disk came
back.

What exactly is the proposal for change here?

