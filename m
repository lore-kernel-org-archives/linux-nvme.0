Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D372C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BAA20759
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ngVWJXpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BAA20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iVGuM4XDu4rnktlItAaEHctXF7H/mh/qUVaz3kymBxU=; b=ngVWJXpV5RqI7gROqdfUygKNq
	d1OcpiVy6rpYas7W10ttcNP7feI5imo2860DZr8yC0rd5LiEqB3XwnpG+TTXfZrThW16+w4Y+cOjY
	5OGQn5CWh2apNh1FS7Cccyk2mooKIj7M9u5Ztzhn86L2mhG18xUBBcvvEe7WLteB38XZh+tmnE1ns
	X2uQU2Zs5lU8CA6zUH7lO2ZdcRGrqlO0VGjCenkEALG4zR/BJhun0ktv1THxJu0YyMSj1BAe/vEED
	FURG2Q9UMIBY4KItrVuskeTuI3ek/eTDt+EHW2G8b/DpRcTH5uDfTFcedghk0XxsJuNjNYwZXwktW
	ObAs/ENKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB0P-0002NS-8T; Tue, 29 Sep 2020 08:29:01 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB0K-0002N3-CE
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:28:57 +0000
Received: by mail-pg1-f174.google.com with SMTP id 5so3266318pgf.5
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OkjsO1D/ui7sHfJg2VLTOew/E7j8v4aw+gcMgRYOKqw=;
 b=QW2TqZEd5ldxVr1U3UQHk5rz62cVXLt2ysqgOR2mYNHqueOszwqIXq1Xv0WGRC/O7/
 nA/g5+cxTwpMqQPrw3ZCpytaR1rKu3BR6H1lSePglc+wL4LNBsAZN81KXAqAOHsnYAYw
 5Z8RuDo9/53eg6PhrUzqXegIUNkscNZ1OasunlKLRVBi7j+WjOdUh41jP0fYJsD/KS9v
 7MtiWbxa92KVbwFlgOkqbk/srHA57zBkarKQHBcX3EO8rD5QcOuScio+9V2Ui241rg/O
 ixhpbcekq9ZWI9GLlxKpBwZFjQr0dcbkPxh/w+cDjIYjyDaIe/Ix0gLRe1HJE4rDflUC
 06Hg==
X-Gm-Message-State: AOAM533RfZwy1e5Eiff+b3UH+33j5nWnydui2auhNKEC7BbldxTZmV6K
 o3zZPZvF5IlGLRhkgpjioFuDNVpZwc4=
X-Google-Smtp-Source: ABdhPJzbb71zdMxYNXpXz2/RJpppf6yDMZ4rCruF14s3T7zZIsr2J2V0MC43RtO4sykLk91rEY989g==
X-Received: by 2002:a63:1016:: with SMTP id f22mr2401464pgl.226.1601368133165; 
 Tue, 29 Sep 2020 01:28:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id s8sm4007389pjm.7.2020.09.29.01.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:28:52 -0700 (PDT)
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
 <20200927060709.GA24024@lst.de>
 <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4af645fe-f513-22b5-2d28-3e8890cc8776@grimberg.me>
Date: Tue, 29 Sep 2020 01:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_042856_432043_99CA87C1 
X-CRM114-Status: GOOD (  18.91  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> I'm okay with that in general, but then again we might run into situations
>>> where an 'all paths down' scenario is actually expected (think of a
>>> temporary network outage on nvme-tcp).
>>> So I guess we need to introduce an additional setting (queue_if_no_path?)
>>> to be specified during the initial connection.
>>
>> The original design was pretty much intentional as and all paths down
>> even usually is temporary.  So any change in behavior should be based
>> on an optional instead of a change in default.  And I think the right
>> way to do implement this would be a timer when to take the gendisk
>> down, with the default remaining infinitity.
> 
> Ok, we can let the timer be an option for fabrics so it can be specific
> to the subsystem you're connecting to. The timeout for pcie targets
> probably has to be a module parameter, though.

Something here is not clear to me, we are not really talking about "all
paths down" but rather "all paths lost", which should take the gendisk
down AFAIK.

Keith, shouldn't we modify the gendisk reference manipulation in
nvme_mpath_remove_disk instead of moving it to the call sites?

I'm still unsure why we need a timer for this. If a path is removed
(e.g. disconnected, we shouldn't keep the gendisk up).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
