Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE67C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 23:35:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EB1206DB
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 23:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J2xTT4Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EB1206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HYqMOfi4Y+CAxA/+6+4W7hhQMxqkIkYpgYLQ6l1pZfk=; b=J2xTT4Q2EfQsM0eBcBsC2VNbP
	dDnw+SJbt3Qf+fvKof9lkZylNZARe0w6xtLWr4FIEtBX399Ahzcm011rqMr/lkPDREPzJ5ih11uHW
	guhMqI+85LBihz1X8xVMPk/KUY9HtSsnHsgx5a2Js6rRRgxre5N9qa/dD4uoHOilpo+X8DKM7RBl+
	vO+dabv3kRkPb227QF3aJwPH0tZqs9slbMVul4SAKz0dSh65j29EfPUEC6Lmfnep2BqZpdtpT8BfE
	G8uL8dIxgqFoHXebiajwi6N+h3wG/XkFcmjTswSFflhZz19yxeIWT3nGopTXTPezHh4QHtLhJWaFN
	EnxVsynXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbuDi-0005X4-Gm; Sun, 08 Nov 2020 23:35:38 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbuDb-0005WZ-2K
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 23:35:35 +0000
Received: by mail-pf1-f196.google.com with SMTP id v12so6129074pfm.13
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 15:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gOOVRz7P8QKXxFfadzvXl9GVbt/zqa9BJSJrILMOKc4=;
 b=YwbFd4tvCjl6LqQsItTu1iWHllR2Gx7aik7X7ZZwMGSNldXy3d+Z9RcpnMVwGu4dCo
 KA30HB3aGNvEzNfVFC++GkAVuQ5dl6xGLXCa8T7JVuqfnFndTE2vUE/xhB1+p0oiCwFH
 2WpvZytq2fdZcIo+nI6d8ezI142AD6Mj/SzzRkGmWcYs1pt9bnutKYgYbHetFLz/kAh6
 SxE2OqqAYRyrbiELt5E9uzpx5IMmogT20jvjqqv2KMNMRNx/TsOMeHOKuhvDsui0uwZz
 5HC1cSF0LyEks3JI4D5VlstMjHryMAEiVQfPb08guURcHoHIorlXwcZGJOrONLYd9P/r
 b7jw==
X-Gm-Message-State: AOAM533uaB+/kuuy5v9v/+ihvdOi0CzblDAAmi3963nFmA/VOqHBUlXR
 Pe/3wsmcmCcLibnssGPp8TnA5nZwDKxOvQ==
X-Google-Smtp-Source: ABdhPJzD7lar54KA6mb39GjSsCFDfj/HPbIIYaTQkdcF3maODhRIGT7YZUnpMXpJBjcohgcQstQLSw==
X-Received: by 2002:a62:fc8f:0:b029:18b:823a:13c2 with SMTP id
 e137-20020a62fc8f0000b029018b823a13c2mr11649707pfh.57.1604878529545; 
 Sun, 08 Nov 2020 15:35:29 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id t12sm9316459pfq.79.2020.11.08.15.35.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:35:28 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Keith Busch <kbusch@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
Date: Sun, 8 Nov 2020 15:35:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_183531_136852_32E936B4 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: Mikulas Patocka <mpatocka@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/8/20 2:31 PM, Keith Busch wrote:
> On Sun, Nov 08, 2020 at 09:24:03AM +0100, Greg KH wrote:
>> On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
>>> The following two issues have been introduced by commit 1811977568e0
>>> ("nvme/pci: Use async_schedule for initial reset work"):
>>> - The boot process waits until all NVMe controllers have been probed
>>>   instead of only waiting until the boot controller has been probed.
>>>   This slows down the boot process.
>>> - Some of the controller probing work happens asynchronously without
>>>   the device core being aware of this.
>>>
>>> Hence this patch that makes all probing work happen from nvme_probe()
>>> and that tells the device core to probe multiple NVMe controllers
>>> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
>>>
>>> Cc: Mikulas Patocka <mpatocka@redhat.com>
>>> Cc: Keith Busch <keith.busch@intel.com>
>>> Cc: Greg KH <gregkh@linuxfoundation.org>
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>> ---
>>
>> A fixes: tag?
> 
> Why? Whether this is an improvement or not, the current code isn't
> broken.

Hi Keith,

My understanding is that the device driver core generates a 'bind'
uevent after nvme_probe() returns (see also driver_bound() in
drivers/base/dd.c). Do you agree that emitting KOBJ_BIND while
nvme_reset_work() is in progress triggers a race condition between
nvme_reset_work() and udev rules that depend on the result of code in
nvme_reset_work(), e.g. NVMe queue creation or nvme_init_identify()?

Bart.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
