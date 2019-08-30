Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE66C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908B12342E
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvaR6d04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B12342E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XSc8lWXVkJW8Ip34/ZLOn8Cp513tMxsoX28fa8IB/lk=; b=IvaR6d04L4nv3sY/1WyO923cp
	unxbJTAfuAVU9sQnZLL6b89X+9BcK/JQ1Dy2thGr/2BLRPzTvuyu5/aJcSRNxoT7gN1C+o8XIhCsf
	BVlwBBQeDK5SSZNipkyvPnDdO4sI1I1zW5PfJ7LJ4ZMO1/rKc2KrS3xYn0sNhbNTh1RgIzuaHW/aK
	rCNjmm0mC2ocn6VjwDSPJrDZujrTFvmRKpvotP/Ge8AhGZuLcQHSKEy0VK+bMZo64RpnoKn6O9bNY
	I8CLWmh119TgJJnJBXzNP7/vtziI4Z9ssQtNHw0kW9e+CR1Anosv1iv7UpPtO3ZBMmJHrSIgIVnii
	oGlFukJLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lQ6-0003Bf-Pk; Fri, 30 Aug 2019 18:14:46 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lQ4-0003BI-D5
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:14:45 +0000
Received: by mail-ot1-f65.google.com with SMTP id p23so7814673oto.0
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tcZ7CbFDJuL2UIE4e1E/mRyvfTkPs0zewzMOwmkGiT4=;
 b=Ahxgy0ceR6ttgoQ8WyOgGkfv5uew8k3Se3QUnrCeXNiWENEaNmZR4MUFxSg6vU6T0P
 vJt33VYjKJqfeBsoDU5Arz2cPZrylqUuk5XDin0krnxu9G0tW8wK/0gZCuIx+WOQS3bz
 njvdAd2FP+ykIKajXQtZXWRuKpuI5gBsYvao+Ok5Kb/f5tCDPQfVm2ELNSk/6+/tJuPQ
 ri9lwc0lo/VpOYq2NOZLsIQFxGNuZCrKHdbIHZhU4B/NPQ3yezgdbX2Nmbz777sKYz9C
 Q14PCferbaXwxlIsvXgIixaEamMI58DxgyB8KUv05Cpq6CO1HBuCFdCkSziiX/xp6zL3
 5gzw==
X-Gm-Message-State: APjAAAWKBTBtaCB2orxw3Aq2Y8QhJVuOJCkchiva2DryjqYZok8lFqr9
 D6IlHcIK3YGgTKPj8VN03ts=
X-Google-Smtp-Source: APXvYqzJrSypv8jdgqcjkdqz7JMqUKmism7bakP3K5KtbmwuRNzlmboECazuu8tNvKzgIcHkH/dRvw==
X-Received: by 2002:a05:6830:130e:: with SMTP id
 p14mr13486506otq.339.1567188881552; 
 Fri, 30 Aug 2019 11:14:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 34sm1469032ots.47.2019.08.30.11.14.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:14:40 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
Date: Fri, 30 Aug 2019 11:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830062036.GA15257@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_111444_447387_19064CF0 
X-CRM114-Status: GOOD (  16.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>> You are correct that this information can be derived from sysfs, but the
>>>>>> main reason why we add these here, is because in udev rule we can't
>>>>>> just go ahead and start looking these up and parsing these..
>>>>>>
>>>>>> We could send the discovery aen with NVME_CTRL_NAME and have
>>>>>> then have systemd run something like:
>>>>>>
>>>>>> nvme connect-all -d nvme0 --sysfs
>>>>>>
>>>>>> and have nvme-cli retrieve all this stuff from sysfs?
>>>>>
>>>>> Actually that may be a problem.
>>>>>
>>>>> There could be a hypothetical case where after the event was fired
>>>>> and before it was handled, the discovery controller went away and
>>>>> came back again with a different controller instance, and the old
>>>>> instance is now a different discovery controller.
>>>>>
>>>>> This is why we need this information in the event. And we verify this
>>>>> information in sysfs in nvme-cli.
>>>>
>>>> Well, that must be a usual issue with uevents, right?  Don't we usually
>>>> have a increasing serial number for that or something?
>>>
>>> Yes we do, userspace should use it to order events.  Does udev not
>>> handle that properly today?
>>
>> The problem is not ordering of events, its really about the fact that
>> the chardev can be removed and reallocated for a different controller
>> (could be a completely different discovery controller) by the time
>> that userspace handles the event.
> 
> So?  You will have gotten the remove and then new addition uevent in
> order showing you this.  So your userspace code knows that something
> went away and then came back properly so you should be kept in sync.

Still don't understand how this is ok...

I have /dev/nvme0 represents a network endpoint that I would discover
from, it is raising me an event to do a discovery operation (namely to
issue an ioctl to it) so my udev code calls a systemd script.

By the time I actually get to do that, /dev/nvme0 represents now a new
network endpoint (where the event is no longer relevant to). I would
rather the discovery to explicitly fail than to give me something
different, so we pass some arguments that we verify in the operation.

Its a stretch case, but it was raised by people as a potential issue.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
