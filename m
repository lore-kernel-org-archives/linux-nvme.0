Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A82C56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:19:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D78206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dH+0sAZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D78206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=otbyI9xnxx89+bnNxWeVB32HnnLqWw/x5UDTce7DatA=; b=dH+0sAZpOgIzvn3MdARrZY+YD
	Kzwh+AGgzEL9rlTnMeBjDcYxokMdo95tKFVW1qdFfUevxSfS09qWCrlymlsGewan/ml07+0GdbKx4
	meUSEW71z37tpYJAm4YBgnmpY+K3in7vcaWWacdn7S/b65nXT94nrT/98oIcf2XKNXk2ho4yuY/fO
	OBl8XeBVY9ZR+2Jou4vUHsC2LirqUnR/G3TmVuKDoHT4VXsxYM3RcmUTHwj/hT1GjzH/J1tYZwkla
	OO4JudMsuT4W2KKWIuMHs+jMYxSa0llIfc5F31N0MUVMnFSe5w6IPC0VC4Fkb019d7dQSfVK10sb6
	wzJVi6hxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki5wm-0007eI-Um; Thu, 26 Nov 2020 01:19:45 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki5wj-0007di-CS
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:19:42 +0000
Received: by mail-wm1-f67.google.com with SMTP id a186so476139wme.1
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tqa2gXw3zfZmSxcPDSwrpfsvRbrnuL+iEBpFDcX66m0=;
 b=H+WAAAzF0/n/dyOQ7nbc3wblhi1mR6c1qVZSuWbKf1Al385RV9ts1Wl6SRmupL7FMf
 wPzITjqwqirRIDdZNZfMYfkHkMQyrsHy3G3WfDJ6sROIEPesdsmtY3CHP3/qxpsvsCaB
 COZhpM99CQ7pgm/3GggqFuIGH1KgiZw1AQUFcTJg+zqDQbiCuOhqqHZxNy3P+LdYu79T
 saC1uQBFL7k/IkrQGhpl0hMXZCZLAZblJTPddsYgfBQOeml/SnAtQzdkm8WWAJx3/M9F
 MY6t6/RvHkn/2jPC3JD+gSsuSBKOSb1QZ3NAgCf/G1YB3xdwddj1EndywbKdPotn+m4A
 jwUw==
X-Gm-Message-State: AOAM532VhEyH5plY8OFpGVIBaRWuVopniDlZCsyLhUhSOjVvjMcWL3wF
 A8hp51b4n4Nnz4nLLB+rfUE=
X-Google-Smtp-Source: ABdhPJxlmWGvK9eubuo2eRpweY1b1UojaJLNlyZfHfElGVLvx3HS16PcEALwp7Ej5SejgvYjLeTJ/Q==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr474322wmg.54.1606353579775;
 Wed, 25 Nov 2020 17:19:39 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id a9sm6590759wrp.21.2020.11.25.17.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:19:39 -0800 (PST)
Subject: Re: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
To: Shai Malin <smalin@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Erik.Smith@dell.com" <Erik.Smith@dell.com>,
 "Douglas.Farley@dell.com" <Douglas.Farley@dell.com>,
 "liuw@vmware.com" <liuw@vmware.com>
References: <PH0PR18MB38457E1674A23D869414FECACCFA0@PH0PR18MB3845.namprd18.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96585ed1-46c8-e988-71c9-f337acaeacb6@grimberg.me>
Date: Wed, 25 Nov 2020 17:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB38457E1674A23D869414FECACCFA0@PH0PR18MB3845.namprd18.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_201941_555562_5C2C208D 
X-CRM114-Status: GOOD (  21.10  )
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
Cc: Ariel Elior <aelior@marvell.com>, Arie Gershberg <agershberg@marvell.com>,
 Michal Kalderon <mkalderon@marvell.com>, Nikolay Assa <nassa@marvell.com>,
 Dean Balandin <dbalandin@marvell.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> This patch series introduces the nvme-tcp-offload ULP host layer, which will
>>> be a new transport type called "tcp-offload" and will serve as an abstraction
>>> layer to work with vendor specific nvme-tcp offload drivers.
>>>
>>> The nvme-tcp-offload transport can co-exist with the existing tcp and other
>>> transports. The tcp offload was designed so that stack changes are kept to a
>>> bare minimum: only registering new transports. All other APIs, ops etc. are
>>> identical to the regular tcp transport.
>>> Representing the TCP offload as a new transport allows clear and
>>> manageable differentiation between the connections which should use the
>>> offload path and those that are not offloaded (even on the same device).
>>
>> why can't we extend the current NVMe-TCP driver and register vendor ops
>> to it, instead of duplicating the entire driver ?
>>
>> AFAIU, only the IO path logic is vendor specific but all the rest is the same.
>>
> 
> The reasons it's separated into a new transport (and a new module):
> 1. The offload we are adding is an offload of the entire tcp layer and most of
>      the nvme-tcp layer above it. When this offload is active, there are no tcp
>      connections in the stack, and no tcp sockets (just like the existing in kernel
>      tcp offload models for iWARP and iSCSI). From the nvme stack perspective it
>      really is a separate transport.
> 2. The offload is not just IO path, but also the entire control plane, including
>      tcp retransmissions, connection establishment and connection error handling.
> 3. Keeping the transports separate would allow each of them to evolve without
>      worrying about breaking each other.
> 4. If significant code duplication exists anywhere, we can solve it with
>      tcp_common functions between the transports.
> 

Hey, sorry it took me a while to get to this...

I'll try to give my PoV. past experience with the suggestion
of layering a TCP storage driver to support both offload
and SW (e.g. iscsi) resulted in a high degree of difficulty
to change things without breaking something (on both ends, both
sw and offload). This goes for both data plane and also the control
plane.

I think that layering would result in indirect interfaces that
can result in a higher degree of duplication. Hence I think that
this proposed approach would be a better way to go (yet to be proven
though).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
