Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78521C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:25:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABAB61004
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABAB61004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6iErU+fSpkUwLqaRJoCIQwRrcu+bIeHvSiCJL6nYhu0=; b=ldbrQiBTpmIwo+IT2SJrgTqPJ
	4xr+bTwXn9yCNoeKKD782Hayik7t086gTfQRHqbExKMZvRngGgFAj15S7YQsaiRqPTJrMsiwB0xUR
	9J/eMCWKlW5yc/aoJyB2BzjHzGf1YSqwDdvg6O6xEO3yCtFCpShGyzWYaKTFNx9+VmqEMZ1/oAp56
	GRFU5LfCTDf6/zRkSThLOm+0dF2ux4nsrjFsbzAOaOu8YQDKXlsFna4Uw3SgLKRTqnXTRwFHL1h3E
	7S+QXKsm8QWIp5vDcc7yvyNJnPi0ZZubzt3xwzabBdWk7LDUKPLrt7ugtkD3K2Xh9lsejuCxhzaJc
	yVhXABfGg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihvU-00Fndm-8R; Mon, 17 May 2021 18:25:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihvR-00Fncs-5M
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZJLVKyz91Gj3RHsSrgijXeGWJQh0M3Jb/4YKsN3Oy+I=; b=2wY3k7iYYNIzBnScLN+PizFwzm
 O6YvOXreYJjEKJk4FNGyegAJdl9xTSZTqhPN4wgEpl2UG7fSwBcutREX++Z+dcUKJAJb2+SfIzkLb
 CUDmE7TCIJUcdRvm/zIOGN7Z0lpGi5GJJBt8uQQW2YpyVOaxIeGkx4f4XKmhGcBYrJGgq7MQf+Co2
 piIeGGvCqETawaKf1lG2DxmW5WxjH6rxIS0t7fV7tqmLMWB6hZLBb+TfdCVGiOyUxetrSNhZFwX/y
 Xj/ar6g3hH1n4dn/jMmmTxOvfBtRIDJRX0PPoYaAR/h++CV2WUyB7VHXD71xjL/Y3Vz1LtrYWdT0h
 A3CwwtUw==;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihvO-00E3bo-21
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:25:07 +0000
Received: by mail-pf1-f180.google.com with SMTP id d78so4685320pfd.10
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 11:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZJLVKyz91Gj3RHsSrgijXeGWJQh0M3Jb/4YKsN3Oy+I=;
 b=fPmfNRSK02ImJhuuHLmoL4YnclZvImIzomT3nw2mNUt+8zk9SxWfJ4Etsu38zeF4A8
 6wnApw2xGOyCEucCTkSmC7LD+xpCdWtLfM3riPjoMWjPklHcHbtrsT8W6YvR8D+TAAgy
 WYJ/ZlIwWMpIzbkkOR+Mu64T21s76DfyoTWphJBsUQA3oyknPqN5Gl9Pa5jSmZIB0mJQ
 DAnoYUgU0Gg0tahTESz0SxHTz5Dua4jmcE9/4LDGeKsOCugj1JCn8dDoXCCnI43OBuMY
 MAgWuoE33eKASeJ1uhnuSwqX6thEijNtLOssga6IWWzr0L+tIzSF67gb5u7l09pbZ5Ck
 BwXg==
X-Gm-Message-State: AOAM530io87XV3J/0xHk+i9zmbfO6PNJMaDkC2CPRaDhEMgNgq54vhL6
 4GCRIDQJ16SQ4ZgZNmetMEo=
X-Google-Smtp-Source: ABdhPJwvANeOoxC/wt2ZO5Jkr6HdrLeF7Znu4JpW70VKoMgYD+GTyyucpU+cdtVHx2WuaSH4QnFWlQ==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr835320pgi.73.1621275905165;
 Mon, 17 May 2021 11:25:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id w127sm10376697pfw.4.2021.05.17.11.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 11:25:04 -0700 (PDT)
Subject: Re: [PATCHv6 1/1] nvme-tcp: Add option to set the physical interface
 to be used when connecting over TCP sockets.
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB4291A122DD3E31016AADB82A9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eba75cd2-5021-05c3-f1ca-bfb05432af2b@grimberg.me>
Date: Mon, 17 May 2021 11:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BL0PR13MB4291A122DD3E31016AADB82A9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_112506_143545_2AF3C318 
X-CRM114-Status: GOOD (  34.53  )
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



On 5/17/21 11:16 AM, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Addressed Sagi's review from PATCHv5.

This commentary belongs after the '---' separator.

> 
> In our application, we need a way to force TCP connections to go out a
> specific IP interface instead of letting Linux select the interface
> based on the routing tables. This patch adds the option 'host-iface'
> to allow specifying the interface to use. Note that corresponding
> changes to the nvme-cli utility will follow.
> 
> When the option host-iface is specified, the driver uses the specified
> interface to set the option SO_BINDTODEVICE on the TCP socket before
> connecting.
> 
> This new option is needed in addtion to the existing host-traddr for
> the following reasons:
> 
> Specifying an IP interface by its associated IP address is less
> intuitive than specifying the actual interface name and, in some cases,
> simply doesn't work. That's because the association between interfaces
> and IP addresses is not predictable. IP addresses can be changed or can
> change by themselves over time (e.g. DHCP). Interface names are
> predictable [1] and will persist over time. Consider the following
> configuration.
> 
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state ...
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>      inet 100.0.0.100/24 scope global lo
>         valid_lft forever preferred_lft forever
> 2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:21:65:ec brd ff:ff:ff:ff:ff:ff
>      inet 100.0.0.100/24 scope global enp0s3
>         valid_lft forever preferred_lft forever
> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>      inet 100.0.0.100/24 scope global enp0s8
>         valid_lft forever preferred_lft forever
> 
> The above is a VM that I configured with the same IP address
> (100.0.0.100) on all interfaces. Doing a reverse lookup to identify the
> unique interface associated with 100.0.0.100 does not work here. And
> this is why the option host_iface is required. I understand that the
> above config does not represent a standard host system, but I'm using
> this to prove a point: "We can never know how users will configure
> their systems". By te way, The above configuration is perfectly fine
> by Linux.
> 
> The current TCP implementation for host_traddr performs a
> bind()-before-connect(). This is a common construct to set the source
> IP address on a TCP socket before connecting. This has no effect on how
> Linux selects the interface for the connection. That's because Linux
> uses the Weak End System model as described in RFC1122 [2]. On the other
> hand, setting the Source IP Address has benefits and should be supported
> by linux-nvme. In fact, setting the Source IP Address is a mandatory
> FedGov requirement (e.g. connection to a RADIUS/TACACS+ server).
> Consider the following configuration.
> 
> $ ip addr list dev enp0s8
> 3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc ...
>      link/ether 08:00:27:4f:95:5c brd ff:ff:ff:ff:ff:ff
>      inet 192.168.56.101/24 brd 192.168.56.255 scope global enp0s8
>         valid_lft 426sec preferred_lft 426sec
>      inet 192.168.56.102/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
>      inet 192.168.56.103/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
>      inet 192.168.56.104/24 scope global secondary enp0s8
>         valid_lft forever preferred_lft forever
> 
> Here we can see that several addresses are associated with interface
> enp0s8. By default, Linux always selects the default IP address,
> 192.168.56.101, as the source address when connecting over interface
> enp0s8. Some users, however, want the ability to specify a different
> source address (e.g., 192.168.56.102, 192.168.56.103, ...). The option
> host_traddr can be used as-is to perform this function.
> 
> In conclusion, I believe that we need 2 options for TCP connections.
> One that can be used to specify an interface (host-iface). And one that
> can be used to set the source address (host-traddr). Users should be
> allowed to use one or the other, or both, or none. Of course, the
> documentation for host_traddr will need some clarification. It should
> state that when used for TCP connection, this option only sets the
> source address. And the documentation for host_iface should say that
> this option is only available for TCP connections.
> 
> References:
> [1] https://www.freedesktop.org/wiki/Software/systemd/\
> PredictableNetworkInterfaceNames/
> [2] https://tools.ietf.org/html/rfc1122
> 
> Tested both IPv4 and IPv6 connections.

Also this.

Can you send the nvme-cli bits as well?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
