Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204ADC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:37:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AE764E43
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 22:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AE764E43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hCOtBLR/2HizsVzxIXxop9L2gINievkkLMYghztMkcM=; b=NowVyNwevZVNNbW8Uv0hq+ga+
	i/bOA8QGeeMVtSbDdTlvZuGkWRvtyWie7gDpNYGd4Eo/9yf35DmNOK2JVholK+PVkB8ZqPXyQs+vZ
	NF7ZjL8ya6r5jesp8JGVmMg1cAUiOzzb7663raSv4GD4jVpRiMq57wN1ZKZf7AKhfeZt007QZ4uIF
	iA0Xe0FUdMGqSX6yYdELDkkf2wCMfxsC7fS3CQWQu9IT9md9OhRZDRWfB1i6sodVAjM0NrpXnxbIe
	RH3B8k9MG2gouZtVDlxIgeamf16vk6mDiH0JQrn2Ei3/a5/wcSgzxn/2pYrPNqcAu9RFITkArUMzY
	XfgJnE+8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Qlf-0003xG-DY; Wed, 03 Feb 2021 22:36:59 +0000
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Qld-0003wv-0v
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 22:36:58 +0000
Received: by mail-pl1-f177.google.com with SMTP id a16so655902plh.8
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 14:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tlNYBmiFhXAz826t8rKF6M+pSGc4XKVfq7RuRWRILB0=;
 b=PYEaQ6Wa9SRz2aJX8yxSNPz75mmv814pTDhrlP07m+SaWB6z/1k129Y3cpv2FUm1Vz
 w2E8ZpQDydRYcYBEO80sCcWG9vZSYzmr46FDjRvXvwKNQcO8xpVLRgiMfxwUpd8deIkJ
 56E3oXOgA/z6U9E46flHV48zMpqBQupCBLV4wfB7ovrNHll4CV7IULQX8WRmoWcj6KAf
 i/bzCbTmN7y+JqXRqlWmVz9Er6oQEt08Mh1kuGYGiOOROsqLLSioEeaQ4MSnMR4WBPFQ
 2N1FalXooSOh12UqA/7nz3rtpnl4e0Z6Cjo/4JDxhaJolvlqKaI2zh96xjyINa7tyRFy
 WRGw==
X-Gm-Message-State: AOAM530w5L+Y09oIwjh0oWfWRnE58v6dQC9mzXR11u7FQyCUPzfxjcKU
 cKD+mSR3NmLOjZx96Abu0i3gs+9TzRA=
X-Google-Smtp-Source: ABdhPJx+0hk1pVa8moPuWYc7KcLgvdW/cRUsnLvH6UHkn+a2AUIYbmZCU6iKxGc6qGpNnnq2sBy3tQ==
X-Received: by 2002:a17:902:8695:b029:e1:6152:c76e with SMTP id
 g21-20020a1709028695b02900e16152c76emr4787022plo.13.1612391815554; 
 Wed, 03 Feb 2021 14:36:55 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:cd99:e813:1dae:a15a?
 ([2601:647:4802:9070:cd99:e813:1dae:a15a])
 by smtp.gmail.com with ESMTPSA id fs14sm2933405pjb.46.2021.02.03.14.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 14:36:54 -0800 (PST)
Subject: Re: nvme-tcp bricks my computer
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SJ0PR19MB45443358535A404035588EC5F2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <42f94a06-cc66-87dd-3a92-de793a228d22@grimberg.me>
 <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ccb20293-efdf-ee96-d97f-405ced9b67a5@grimberg.me>
Date: Wed, 3 Feb 2021 14:36:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4544B86790800C6371E7F96AF2B49@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_173657_104525_3BF34F03 
X-CRM114-Status: GOOD (  30.74  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> I'm running "nvme discover" over a TCP connection. The nvme-tcp module freezes completely and bricks my computer.
>> 
>> Steps:
>> $ sudo modprobe nvme-tcp
>> $ sudo nvme discover -t tcp -a [IP address] -s 8009
>> <System Bricked!>
>> Only a reboot (Alt-SysRq-B) can recover the system.
> 
> Do you have a stack trace to share?
> *<MB> No. I'm not able to collect data since my computer freezes 
> completely. I had a window opened that was showing the syslog at the 
> time the freeze occurred. I took a couple of pictures (attached). *

OK, Are you able to scroll up a bit to see the RIP line in the
stack trace? and if this is a NULL dereference or something else?

>> Conditions to reproduce the problem:
>> The Discovery Controller must support sending Discovery Log Change Notifications. That is, bit 31 of the Identity's OAES field returned by the discovery controller must be set to 1. If OAES[31]=0, then everything is OK.
> 
> What is the discovery log page returned by the nvme discovery
> controller? Does it include referrals? There was an issue fixed
> in nvme-cli with respect to referrals (although nothing that is
> related to any oaes changes).
> *<MB> The driver never makes it to asking for the discovery log page. It 
> freezes as soon as it receives the "Identity" message. *

You mean identify controller? That is strange because not sure it should
be any difference..

>> Systems tested:
>> 1) Ubuntu 20.04, Linux 5.8, nvme 1.13.21
>> 2) Fedora 33, Linux 5.10, nvme 1.11.1
> 
> Are these the default kernels that come with the distribution?
> *<MB> Yes.**
> *
> *On Ubuntu 20.04: *
> *$ uname -rsvpi*
> *Linux 5.8.0-41-generic #46~20.04.1-Ubuntu SMP Mon Jan 18 17:52:23 UTC 
> 2021 x86_64 x86_64
> *
> *
> *
> *On Fedora 33:*
> *$ uname -rsvpi*
> *Linux 5.10.11-200.fc33.x86_64 #1 SMP Wed Jan 27 20:21:22 UTC 2021 
> x86_64 x86_64
> *
> 
> Does this happen with the latest upstream?
> *<MB> I did compile the latest upstream kernel modules, but 
> Ubuntu/Fedora won't let me modprobe them. I'm not a kernel expert. There 
> seems to be some security in place that prevents one from loading a 
> kernel module that did not come with the official release. I tried 
> several things suggested on Google to work around this but could never 
> get the latest kernel modules loaded. By the way, Fedora 33 is pretty 
> close to the latest upstream (i.e. Linux 5.10) and I see the same issue 
> there.*

We definitely didn't get such a bug report on this kernel.

Does this happen if you directly connect to a normal nvme controller?

> *<MB> As I said earlier, everything works fine until I change the 
> Discovery Controller to return **OAES[31]=1 in the Identity message. 
>  From what I see in the nvme-tcp code, this tells the driver to enable 
> AER/AEN. I think that's where the issue is. Since I'm not a kernel 
> expert, I cannot diagnose the problem further than that.*

It appears that without discovery log change events we never submit
async event, so it must be something there.

Can you share your kernel config file?

> I'm assuming this is not Linux nvmet target correct?
> *<MB> I don't know what that means: nvmet? *

What is your target implementation? Is this the nvme target that
is built into Linux?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
