Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6155DC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 04:26:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA4F7207BB
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 04:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jUJe7VzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4F7207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nK+e8YeTIHFJdyk5ARXwv2YXuRtoCxtEsjjxUyPsUBs=; b=jUJe7VzMXZseKlW77ZxWPtSW8
	GrYXaoYwy2NPUC817bYDyrtKW4/Eq0pJzyhOL2cu8a0rKEwmbByXm8LwZbZhV53EkScE65OxezAnS
	9Y/6+I9CI+T0sHjkrDtG2NkzN7W9yrHSDq0+takExgoONAJ54fVbwxyyFf5TKOBthT/3Ydm6TgidX
	YXeg6eB67uV+px6gOaMs7cePs3c5QdZFZ/FSVdvsxESMkKQqJtKjFXO36IcWQagGSCHX9JNEdXOJF
	BjDwg29cuAG70mA40P0kp9VHRF/mkE+Ct00j7EnAob23WA405n/tjnzLM/oDg0gI2gXMLZAytbHT/
	jaSfZHrTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd4Bh-0001d2-CD; Thu, 12 Nov 2020 04:26:21 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd4Be-0001cc-Ht
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 04:26:19 +0000
Received: by mail-pf1-f193.google.com with SMTP id v12so3289151pfm.13
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 20:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1lv1loymFAKnBUaw9BJ9iP+5QAVBhp2ybXrdyXXJ1KE=;
 b=Ln76qo1PgSHuLBgArA4GY4I/u3L8SM8bz6ZMQ5a5k0DdfaPKH/eva6GRp5S6zylagx
 KMbBJbJKuASddhczO52Cezxp46kbtQiNblwb+KeplnjDHMdpPrN9BzKLBFikw76K0RXq
 X0DH7XTwzE68COMNldO/1qFWroziZ9OIMVSubHN47xpl43YXPD6NY1lwdFQ98TJYimpH
 WOJeP9qjle3CF3iOgaXnRSQeyFOi0Y72+cc5VZEYaiH6kIECcRLEfkQzpcCscFekNRbI
 oZSSKXfIkDKvx86Vo4HrXqVEZyhodk531P8dA20BnHNtUexb1R77dPSdxOnimJ+KiCQ+
 MlHA==
X-Gm-Message-State: AOAM5331TOejlj8CqaZ6+E0TrAPW4opLP4YR58q7Gpe1XvHyjlhIHwsp
 1E47nFHkdrUxf7UT1t/kfOtMomjOMKY=
X-Google-Smtp-Source: ABdhPJxZtZltOz7dldk9hpRFHihdyo+QmRJphS++R1CAfU5s95IjUUKJbvbE1/y5c93Cxum+U6+oyg==
X-Received: by 2002:a63:5159:: with SMTP id r25mr8727770pgl.43.1605155174995; 
 Wed, 11 Nov 2020 20:26:14 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id k4sm4651387pfg.130.2020.11.11.20.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2020 20:26:13 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Keith Busch <kbusch@kernel.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <a2e50a52-49bf-9a69-5897-d471db5054b0@acm.org>
Date: Wed, 11 Nov 2020 20:26:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201111_232618_722175_0339C661 
X-CRM114-Status: GOOD (  19.64  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/11/20 11:19 AM, Keith Busch wrote:
> On Sat, Nov 07, 2020 at 08:09:03PM -0800, Bart Van Assche wrote:
>> The following two issues have been introduced by commit 1811977568e0
>> ("nvme/pci: Use async_schedule for initial reset work"):
>> - The boot process waits until all NVMe controllers have been probed
>>   instead of only waiting until the boot controller has been probed.
>>   This slows down the boot process.
>> - Some of the controller probing work happens asynchronously without
>>   the device core being aware of this.
>>
>> Hence this patch that makes all probing work happen from nvme_probe()
>> and that tells the device core to probe multiple NVMe controllers
>> concurrently by setting PROBE_PREFER_ASYNCHRONOUS.
> 
> I am finding that this setting probes devices in parallel on boot up,
> but serially for devices added after boot. That's making this a rather
> unappealing patch.

Hi Keith,

Thanks for having verified this. However, to me it is unexpected that my
patch results in serial probing of NVMe devices added after boot. It
would be appreciated if more information could be shared about how that
test was run. I'm wondering whether the serialization perhaps was the
result of how the test was run? My understanding of the driver core is
that the decision whether or not to probe concurrently is taken inside
__driver_attach() and also that PROBE_PREFER_ASYNCHRONOUS should trigger
a call of the following code:

		async_schedule_dev(__driver_attach_async_helper, dev);

I expect that calling the above code should result in concurrent probing.

Thanks,

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
