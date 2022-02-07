Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC13C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3rioTBymiH/CLKfgZ6jGkOtiMVIaZHwxVT6yfVG4KW8=; b=cJU8asmDlb53ibxZPlG4SkC5jj
	erSWoXsz47z2HeqwBULJIscaNIWUpz97WrOVqGYoJi83V2Ydp6PuNdmY4VYDyUPHAhUl0zo53ss75
	+Ped5PZvdV9bU+Yot4z8iMajChssYizVPG84fe9pplo3k2yHecTxcjxnWKyGwSp9mqqwTflnzEdyQ
	H59ryuWdvq5FPIhYMXFWZv0sRJAeEFjiNJsni58OKi7khSlZZkFaZegSu4Oyk0nKK/O6cUJxQ1UYQ
	30xFDL9EOQn+M0tqFW/ZB9UupOuIFzJ6HkQPjTIg0oEIVbVsuqCMt4QBAkQSkDVoiN+fuIezic1Wz
	lMdjwy7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH1rt-009wIp-D1; Mon, 07 Feb 2022 11:07:37 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH1rq-009wHX-Kd
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 11:07:36 +0000
Received: by mail-wr1-f54.google.com with SMTP id u23so249446wru.6
 for <linux-nvme@lists.infradead.org>; Mon, 07 Feb 2022 03:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3rioTBymiH/CLKfgZ6jGkOtiMVIaZHwxVT6yfVG4KW8=;
 b=ZVhTOmulHHUXXHDXBb0v8UGEAreACG2wRBYOFYZ7w41kuN84uTbeWvEZkH/kOfimwI
 BpCnJmHv49oGon+WE8ZR6wg2CDyP28VkYSHAirllzVUKdw0fBpmOEpX5+c/GHbEXWyIP
 DB3wOjFV0X5sKbfpTqBGoPw/8xAx4EUOJX3EFhb+uZ3Y/CfdvXuFTh6NZ4Wlx9SG4WHh
 P6ssP7VFcCZNbWtrlEBC5x+JykvaD0WdWNytGNCYXwi7ELTtdxsDpeWT6RB5pcp37V0M
 rgMiUrJmdCTA/Oi2GpmvSj6sm+l4z45GC5IOFoC1AhgZnmplrhKG9mJNZwVWQ8dSHwDR
 sH5w==
X-Gm-Message-State: AOAM533jF6vMKlqFq4tVre9oIZKapLobuHmKHZnXVEI/GG2fFZLEh7ky
 Vj8kJUxljW0hQxN9U5YIhPxHIluU2pg=
X-Google-Smtp-Source: ABdhPJz4Zl6cBq8WCsv4BPUJHirFdzcz+RRLqqNNvv7o0nNSCwjISaZZQOoV4J9pdRcJLZqweO0T9g==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr3415201wrv.262.1644232051980; 
 Mon, 07 Feb 2022 03:07:31 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h6sm17643950wmq.26.2022.02.07.03.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 03:07:31 -0800 (PST)
Message-ID: <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
Date: Mon, 7 Feb 2022 13:07:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_030734_723629_59C59EDE 
X-CRM114-Status: GOOD (  43.81  )
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



On 2/6/22 15:59, Alex Talker wrote:
> Recently I noticed a peculiar error after connecting from the host
> (CentOS 8 Stream at the time, more on that below)
> via TCP(unlikely matters) to the NVMe target subsystem shared using 
> nvmet module:
> 
>  > ...
>  > nvme nvme1: ANATT timeout, resetting controller.
>  > nvme nvme1: creating 8 I/O queues.
>  > nvme nvme1: mapped 8/0/0 default/read/poll queues.
>  > ...
>  > nvme nvme1: ANATT timeout, resetting controller.
>  > ...(and it continues like that over and over and over again, on some 
> configuration even getting worse with greater iterations of reconnect)
> 
> I discovered that this behavior is caused by code in 
> drivers/nvme/host/multipath.c,
> in particular when function nvme_update_ana_state increments value of 
> variable nr_change_groups whenever any ANA Group is in "change",
> indifference of whether any namespace belongs to the group or not.
> Now, after figuring out that ANATT stands for ANA Transition Time and 
> reading some more of the NVMe 2.0 standards, I understood that the 
> problem caused by how I managed to utilize ANA Groups.
> 
> As far as I remember, permitted number of ANA Groups in nvmet module is 
> 128, while maximum number of namespaces is 1024(8 times more).
> Thus, mapping 1 namespace to 1 ANA Group works only up to a point.
> It is nice to have some logically-related namespaces belong to the same 
> ANA Group,
> and the final scheme of how namespaces belong to ANA groups is often 
> vendor-specific
> (or rather lies in decision domain of the end user of target-related 
> stuff),
> However, rather than changing state of a namespace on specific port, for 
> example for maintenance reasons,
> I find it particularly useful to utilize ANA Groups to change the state 
> of a certain namespace, since it is more likely that block device might 
> enter unusable state or be a part of some transitioning process.

I'm not exactly sure what you are trying to do, but it sounds wrong...
ANA groups are supposed to be a logical unit that expresses controllers
access state to the associated namespaces that belong to the group.

> Thus, the simplest scheme for me on each port is to assign few ANA 
> Groups, one per each possible ANA state, and change ANA Group on a 
> namespace rather than changing state of the group the namespace belongs 
> to at the moment.

That is an abuse of ANA groups IMO. But OK...

> And here's the catch.
> 
> If one creates a subsystem(no namespaces needed) on a port, connects to 
> it and then sets state of ANA Group #1 to "change", the issue introduced 
> in the beginning would be reproduced practically on many major distros 
> and even upstream code without and issue,

This state is not a permanent state, it is transient by definition,
which is why the host is treating it as such.

The host is expecting the controller to send another ANA AEN that
notifies the new state within ANATT (i.e. stateA -> change -> stateB).

> tho sometimes it can be mitigated by disabling the "native 
> multipath"(when /sys/module/nvme_core/parameters/multipath set to N) but 
> sometimes that's not the case which is why this issue quite annoying for 
> my setup.

That is simply removing support for multipathing altogether.

> I just checked it on 5.15.16 from Manjaro(basically Arch Linux) and 
> ELRepo's kernel-ml and kernel-lt(basically vanilla versions of the 
> mainline and LTS kernels respectively for CentOSs).
> 
> The standard tells that:
> 
>  > An ANA Group may contain zero or more namespaces
> 
> which makes perfect sense, since one has to create a group prior to 
> assigning it to a namespace, and then:
> 
>  > While ANA Change state is reported by a controller for the namespace, 
> the host should: ...(part regarding ANATT)
> 
> So on one hand I think my setup might be questionable(I might allocate 
> ANAGRPID for "change" only in times of actual transitions, while that 
> might over-complicate usage of the module),

I'm still don't fully understand what you are trying to do, but creating
a transient ANA group for a change state sounds backwards to me.

> on the other I think it happens to be a misinterpretation of the 
> standard and might need some additional clarification.
> 
> That's why I decided to compose this message first prior to proposing 
> any patches.
> 
> Also, while digging the code, I noticed that ANATT at the moment 
> presented by a random constant(of 10 seconds), and since often 
> transition time differs depending on block devices being in-use 
> underneath namespaces,
> it might be viable to allow end-user to change this value via configfs.

How would you expose it via configfs? ana groups may be shared via
different ports IIRC. You would need to prevent conflicting settings...

> Considering everything I wrote, I'd like to hear opinions on the 
> following issues:
> 1. Whether my utilization of ANA Groups is viable approach?

I don't think so, but I don't know if I understood what you are trying
to do.

> 2. Which ANA Group assignment schemes utilized in production, from your 
> experience?

ANA groups will usually relate, a ANA group will be used for what it is
supposed to. A group of zero or more namespaces where each controller
may have different access state to it (or the namespaces assigned to
it).

> 3. Whether changing ANATT value change should be allowed via configfs(in 
> particular, on per-subsystem level I think)?

Could be... We'll need to see patches.

