Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1623DC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:54:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7899C61244
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899C61244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UyHNWLraQOjYXPl6KQhsp8Pd94xhYRTMjw7MwtzoyAw=; b=dia5K4irptROiMh4WI9i98XDOd
	kjmZiiDcoSGr/697ppZ/tacYq0DTq01vPveitg97f24N0Twy//LoJ9nvw4KkvrnnDgwCDVzFG7TaA
	EevoG4ZMkLLd6eU9SQv1mDpX4Bb4D46BWOi4yOnIgOjB0cdCWNdv/aPyD5MMMT77D4bSuprm2Fcyq
	JEUwS39INdlFor80W9UDy/saQEVckh2Yr4ELjNvjdR5LO0sXCrEiCJd2HcYWwGMv8vmGzAnv469U0
	R+C45Rd19kQc3fmgnBX3Wz5393eVSO477eRxMC+md3F1HF1kz7EwC7vb1K2E+Y0GGeZagTjxZoylS
	ttUkygYA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljnoE-002N7D-32; Thu, 20 May 2021 18:54:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljno8-002N6N-Oe
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 18:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=piD6/4rjkHQIojLZk7qptlpveJLxYPIPmbGvM2jTjUo=; b=5Fnn2jRneaWfVvRDvpPT/fquI6
 LE+IamfzltIsosxrI9TdzLWSe+24w8qvudU0EA6esVckmk7BBeFINY0iLjGk1oLSF5R+hTlSEl/6h
 TeVlm383zq9GhCuU/FcsA1CYZfgt9BBe8T1p3NqsHMs14R9GM2wRh2b8oq42OsCiIoU5N7ULu7VJX
 9CBK2c0qFUYXA9XQOXS2HE0OOM4KeBwIaBduI66qXEDs5nRz9fC4dVa5FhAoiI5/C5QiEL5oOxHuJ
 qgIhLOHsdGw90qHHtQhPZy3Yl0V4ZnSEM/6KYpUGbl/M0J1nC5ihiyFEoEJ7MK8EYuszxUtRJz1+E
 hyoDk6MQ==;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljno5-00GaXR-5Q
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 18:54:07 +0000
Received: by mail-pl1-f177.google.com with SMTP id t21so9644954plo.2
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=piD6/4rjkHQIojLZk7qptlpveJLxYPIPmbGvM2jTjUo=;
 b=ojjvItNTnbrTAAz5TM+7Wik92dDMFPR2BIR4tCx9C6CWUxJozmFBTGnbnX6gTNT6SF
 EwO3ftKfgYU2HaQvdehSXfgaCLzzmHvAqYCLv7vS9HYFs8vaS/6zJGFkb4sKgKFTgfuN
 uItHZab/DhjkpRJS51nSQwZF2Gk8s5/RrcJICvg+PaZGjkT1xI7MjSIDNqe2p8W7Plda
 pBbe7GBBlRGVPIBegilXgSUFg/E2gwYDzouqYfnA8nKa9oi/P3jlcyb5qy0vGOKjBJCg
 luVXTuqw7uEZh32KOlsDrN5gNfRBCaEkSae9nh/0Y0A9oC4K4+MHNZqDCN8W2+fvtVuA
 KC4A==
X-Gm-Message-State: AOAM532gNKxw9VJbxOzJ+6rNPmdQm7O697TIetyho7k+UsgUtqXnTxsM
 Oex2sndVSNdMEjHbSpZf1q0=
X-Google-Smtp-Source: ABdhPJwo4A511HhMXsl/0m3Xg+kyDWS7xvbTUCPB570bZMMcc+PQP/Axp8IeNVGSvDfluk9Jz8urdQ==
X-Received: by 2002:a17:902:8211:b029:ef:64c8:5bb2 with SMTP id
 x17-20020a1709028211b02900ef64c85bb2mr7663170pln.64.1621536842985; 
 Thu, 20 May 2021 11:54:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1349:5b78:fe05:c9c1?
 ([2601:647:4802:9070:1349:5b78:fe05:c9c1])
 by smtp.gmail.com with ESMTPSA id r22sm2651226pgr.1.2021.05.20.11.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 May 2021 11:54:02 -0700 (PDT)
Subject: Re: [PATCHv6 1/1] nvme-tcp: Add option to set the physical interface
 to be used when connecting over TCP sockets.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <BL0PR13MB4291A122DD3E31016AADB82A9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <eba75cd2-5021-05c3-f1ca-bfb05432af2b@grimberg.me>
 <BLAPR19MB4531EBB359E0EA4CB80DD418F22A9@BLAPR19MB4531.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5ed4f43e-40c5-f4a0-f1ce-e85358781bcb@grimberg.me>
Date: Thu, 20 May 2021 11:54:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BLAPR19MB4531EBB359E0EA4CB80DD418F22A9@BLAPR19MB4531.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_115405_242684_6F764742 
X-CRM114-Status: GOOD (  26.84  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Addressed Sagi's review from PATCHv5.
>>
>> This commentary belongs after the '---' separator.
>>
>>>
>>> In our application, we need a way to force TCP connections to go out a
>>> specific IP interface instead of letting Linux select the interface
>>> based on the routing tables. This patch adds the option 'host-iface'
>>> to allow specifying the interface to use. Note that corresponding
>>> changes to the nvme-cli utility will follow.
>>>
>>> When the option host-iface is specified, the driver uses the specified
>>> interface to set the option SO_BINDTODEVICE on the TCP socket before
>>> connecting.
>>>
>>> This new option is needed in addtion to the existing host-traddr for
>>> the following reasons:
>>>
>>> Specifying an IP interface by its associated IP address is less
>>> intuitive than specifying the actual interface name and, in some
>>> cases, simply doesn't work. That's because the association between
>>> interfaces and IP addresses is not predictable. IP addresses can be
>>> changed or can change by themselves over time (e.g. DHCP). Interface
>>> names are predictable [1] and will persist over time. Consider the
>>> following configuration.
>>>
>>> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state ...
>>>       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>>>       inet 100.0.0.100/24 scope global lo
>>>          valid_lft forever preferred_lft forever
>>> 2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>>>       link/ether 08:00:27:21:65:ec brd ff:ff:ff:ff:ff:ff
>>>       inet 100.0.0.100/24 scope global enp0s3
>>>          valid_lft forever preferred_lft forever
>>> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>>>       link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>>>       inet 100.0.0.100/24 scope global enp0s8
>>>          valid_lft forever preferred_lft forever
>>>
>>> The above is a VM that I configured with the same IP address
>>> (100.0.0.100) on all interfaces. Doing a reverse lookup to identify
>>> the unique interface associated with 100.0.0.100 does not work here.
>>> And this is why the option host_iface is required. I understand that
>>> the above config does not represent a standard host system, but I'm
>>> using this to prove a point: "We can never know how users will
>>> configure their systems". By te way, The above configuration is
>>> perfectly fine by Linux.
>>>
>>> The current TCP implementation for host_traddr performs a
>>> bind()-before-connect(). This is a common construct to set the source
>>> IP address on a TCP socket before connecting. This has no effect on
>>> how Linux selects the interface for the connection. That's because
>>> Linux uses the Weak End System model as described in RFC1122 [2]. On
>>> the other hand, setting the Source IP Address has benefits and should
>>> be supported by linux-nvme. In fact, setting the Source IP Address is
>>> a mandatory FedGov requirement (e.g. connection to a RADIUS/TACACS+
>> server).
>>> Consider the following configuration.
>>>
>>> $ ip addr list dev enp0s8
>>> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>>>       link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>>>       inet 192.168.56.101/24 brd 192.168.56.255 scope global enp0s8
>>>          valid_lft 426sec preferred_lft 426sec
>>>       inet 192.168.56.102/24 scope global secondary enp0s8
>>>          valid_lft forever preferred_lft forever
>>>       inet 192.168.56.103/24 scope global secondary enp0s8
>>>          valid_lft forever preferred_lft forever
>>>       inet 192.168.56.104/24 scope global secondary enp0s8
>>>          valid_lft forever preferred_lft forever
>>>
>>> Here we can see that several addresses are associated with interface
>>> enp0s8. By default, Linux always selects the default IP address,
>>> 192.168.56.101, as the source address when connecting over interface
>>> enp0s8. Some users, however, want the ability to specify a different
>>> source address (e.g., 192.168.56.102, 192.168.56.103, ...). The option
>>> host_traddr can be used as-is to perform this function.
>>>
>>> In conclusion, I believe that we need 2 options for TCP connections.
>>> One that can be used to specify an interface (host-iface). And one
>>> that can be used to set the source address (host-traddr). Users should
>>> be allowed to use one or the other, or both, or none. Of course, the
>>> documentation for host_traddr will need some clarification. It should
>>> state that when used for TCP connection, this option only sets the
>>> source address. And the documentation for host_iface should say that
>>> this option is only available for TCP connections.
>>>
>>> References:
>>> [1]
>>> https://urldefense.com/v3/__https://www.freedesktop.org/wiki/Software/
>>> systemd/*5C__;JQ!!LpKI!3qE5jJQA-REQkOr1c042U-
>> ghm28oHvTE48YZkHM5ugob8Sm
>>> IPPIHxwEm7iwkC9kZyA$ [freedesktop[.]org]
>>> PredictableNetworkInterfaceNames/ [2]
>>> https://urldefense.com/v3/__https://tools.ietf.org/html/rfc1122__;!!Lp
>>> KI!3qE5jJQA-REQkOr1c042U-
>> ghm28oHvTE48YZkHM5ugob8SmIPPIHxwEm7ixiy1Q97A$
>>> [tools[.]ietf[.]org]
>>>
>>> Tested both IPv4 and IPv6 connections.
>>
>> Also this.
>>
>> Can you send the nvme-cli bits as well?
> 
> Hi Sagi,
> 
> Just checking if there anything else I can do to help with this patch?

I think just the change log fixes,

Also you can add my:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
