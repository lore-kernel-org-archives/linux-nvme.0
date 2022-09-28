Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F0C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dKDsTfI+AcMcLNhrOXYb5dpwDFkFH94v54T2dqm9zI4=; b=4AyjhzqF77z2airzOwQwM+N860
	wuS0/pXWItA9ZhL/7EoFbOlo5k1lnJFsbO09HZX0HWLVWHRxBJOh01kVk4AAPsJPgi2zC4Jb9bDp2
	yy6AayWppIaAGV0cAnX1NbGBvwwWaA2ytWKRTy6eqRGQR7RXBGwiLP+FIYVXE0vQmqhc3NgLz7pvD
	NIsJhHysfLWayGvovI+XvXXeREG99UhcG3tmFdmur8OQ2GXlwm4e4CMZ2/m0knrUQLXh+shkWk/P2
	R9DiHEWtKMbogaMQFz5yFEuDFTk8PJRD8fbz1EAItOfHQ0r6JZf0Q5dxCYyO80mVakDiHcd1rL/wO
	WIoPYEqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odSTy-00Eu1Y-9K; Wed, 28 Sep 2022 08:31:54 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odSTv-00Etzl-4V
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 08:31:52 +0000
Received: by mail-wm1-f47.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso596290wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dKDsTfI+AcMcLNhrOXYb5dpwDFkFH94v54T2dqm9zI4=;
        b=c/6oEWR5M9dOJsiVkkY2orv4lDqQQV1JlBxJjmAjMgHXXW0mXzoGTHzBGYIy89e5VV
         Y3+KWzmYkawhsjOwy7VZHirtTup1wIMjwaNYx1JyaNMk5Chp6tb7vr3Ti9H19SI9e6ly
         Jbaam//S00x37YOTmLxCUMXi9/0mOvl1vx0TbOsQk4rbC71AwU66EOqgA4KB1JiStbGZ
         V+BRIdlACBPvTrGtTiny59B0EAAoFwpsZPTSGzd+wYgTY4kBb6aQ0hbTlnCoDiY90HT+
         h9kOr+vbG4hyIKUBgn0eKRq5tQt7pxAS+4WNtTn0ieN6lKsuTR/gDQjNA9OgzLleRNIA
         cv1Q==
X-Gm-Message-State: ACrzQf0Xwf9eB7l3OaCXonP1y3WCCJvNR+APQzaCdv+/y62iVW1lgpmw
	4oqzfJPwY+nn/8V3nw0wkPHpI1s5LKY=
X-Google-Smtp-Source: AMsMyM5Oo1Y+ELKBpUJLuG5N3quUjHvnitkKtjDGi68q1OQiI/pE0WwllgIj15RI2RfksrVyxVWDpQ==
X-Received: by 2002:a05:600c:c7:b0:3b4:88ec:f980 with SMTP id u7-20020a05600c00c700b003b488ecf980mr5940018wmm.92.1664353908634;
        Wed, 28 Sep 2022 01:31:48 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u8-20020adff888000000b0022cc6b8df5esm468184wrp.7.2022.09.28.01.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:31:48 -0700 (PDT)
Message-ID: <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
Date: Wed, 28 Sep 2022 11:31:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_013151_209541_020EB305 
X-CRM114-Status: GOOD (  24.13  )
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


>>> In order to be able to test queue number changes we need to make sure
>>> that the host reconnects.
>>>
>>> The initial idea was to disable and re-enable the ports and have the
>>> host to wait until the KATO timer expires and enter error
>>> recovery. But in this scenario the host could see DNR for a connection
>>> attempt which results in the host dropping the connection completely.
>>>
>>> We can force to reconnect the host by deleting all controllers
>>> connected to subsystem, which results the host observing a failing
>>> command and tries to reconnect.
>>
>> This looks like a change that attempts to fix a host issue from the
>> target side... Why do we want to do that?
> 
> It's not a host issue at all. The scenario I'd like to test a when
> target changes this property while the host is connected (e.g. software
> updated -> new configuration). I haven't found a way to signal the host
> to reset/reconnect from the target. Hannes suggested to delete all
> controllers from the given subsystem which will trigger the recovery
> process on the host on the next request. This makes this test work.

But that is exactly like doing:
- remove subsystem from port
- apply q count change
- link subsystem to port

Your problem is that the target returns an error code that makes the
host to never reconnect. That is a host behavior, and that behavior is
different from each transport used.

This is why I'm not clear on weather this is the right place to
address this issue.

I personally do not understand why a DNR completion makes the host
choose to not reconnect. DNR means "do not retry" for the command
itself (which the host adheres to), and it does not have any meaning to
a reset/reconnect logic.

In my mind, a possible use-case is that a subsystem can be un-exported
from a port for maintenance reasons, and rely on the host to
periodically attempt to reconnect, and this is exactly what your test is
doing.

> Though if you have a better idea how to signal the host to reconfigure
> itself, I am glad to work on it.

I think we should first agree on what the host should/shoudn't do and
make the logic consistent between all transports. Then we can talk about
how to write a test for your test case.

