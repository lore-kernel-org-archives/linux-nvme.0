Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964DC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 05:54:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6536F2313A
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 05:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6536F2313A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KrEwrBKJ2fIiBoVcbooQTsB1BHhh6lJY6bVYhAXzRmE=; b=psQgy/HnhcS0ouWBNAWdRyxo/
	jE6WIV9b1+cjVhL7ZgLs43VmJ5eFbJHdid51rTzW9kEYZZwte2DTve2uql/99TOEgwbqrJw7sxKkb
	uQk936jUsooOyho9Es86iuQGrqe4kfvYlkAc7YM4A0K8KYCOHjA6d5jPtlZKTUW20J3nzMVPa9kHa
	uxtJzsW/ESGCRTFOElEE2vK0J37RugIdO8CRr6hUhxKnt+aSHFKms8G6tnOHH4y+1Ow/htRJi1j90
	hGawIQXdBc8YGgakx3w2ccpGSWLR5UqFnQT8a/cPO1LAf3Xr38DpBWDf/svommUjf3S0koJVHSq3p
	xhxh/1pjw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l26Rx-0006CT-NR; Wed, 20 Jan 2021 05:54:37 +0000
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l26Rv-0006Bj-9s
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 05:54:36 +0000
Received: by mail-ot1-x32d.google.com with SMTP id d1so1816149otl.13
 for <linux-nvme@lists.infradead.org>; Tue, 19 Jan 2021 21:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jcUrJq8bElF+GtTYiNtOdM5ulvv6DF2JIr6HnL0z8XE=;
 b=tEos8qGoi+xT3TlT9seZZ4ZaqR14Ef+t/b45yz5Si0YZyYDJ/Ug0tjyvT9h0FTcamX
 G88CbaVPO0N7I4r0e9t0i9+SB1TAf6NVl1Rg4auT8dHA3ovah9tMD2/dkrH/oJ+kqYBZ
 RUQvHlI3Aw+Vrh7iHNLEWQ10N7mek9U4hPYNgFEDwewi5P1dKXHeFagMJ1H+6aOQ4z0k
 WzEt4QaQbqwsbxscWOqVLGpud8fIGacs8PCGaYMaPxFCZSwdu40BlHthWtc/seMacn54
 kMPlaodLW0rZ+GZxODdjutOf02XEOAxr0qiFlrwamwCo1ioKOXvZIfKpo5cmlgTCPhfh
 0hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jcUrJq8bElF+GtTYiNtOdM5ulvv6DF2JIr6HnL0z8XE=;
 b=b0dVJKej5VyRzsYDpB0vepHw0EIeFLfyNZ93CbuXEMH/9yP0RQZIRVRLt1AqssXAh1
 uZLO/8SJF2kP6imRziYIfh6y51P5S7WzhPTWCWYJPK07nZqy0ZTx7GCj8UyVsPMoZHmD
 lzTe9wbYXItvs8HqFdCPxb+17PCbqxK5R7II/dIV42wsxyAa8MAk5G2IdsBlcE/gYqoS
 3zXFrsUQs0qrSQL3JxGGGhgiM2UaI2ahb7m2mtJgRcd+W7brz1/Zg9EfDcpqD8VL6KDF
 ttWCOYmkRRknFnlb2ziKYEU4Gkl+J1TDUtDukfne6uaSBPCbkCxOejZZSnaKTtiw5wG2
 5mWw==
X-Gm-Message-State: AOAM5326lR/GuFpKQ+0L5veWqO6eDUFnThk0hiK7GVjwZHlY0dUgY0rL
 dq88U1DX8yeJFHUk4LTovl3TOv+eAQw=
X-Google-Smtp-Source: ABdhPJw9yKYMpVHFzzyG5tVig7VLOLjBXUao/kbc/0/bw0pYWahHM+FUOr01qRYN0b3ZbBiS645FTw==
X-Received: by 2002:a9d:4b0d:: with SMTP id q13mr5999402otf.325.1611122073312; 
 Tue, 19 Jan 2021 21:54:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w5sm210763oow.7.2021.01.19.21.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Jan 2021 21:54:32 -0800 (PST)
Subject: Re: [PATCHv2] nvme/hwmon: rework to avoid devm allocation
To: Hannes Reinecke <hare@suse.de>
References: <20210119064318.124415-1-hare@suse.de>
 <20210119145632.GD54031@roeck-us.net>
 <1093bedb-9b6d-b365-85d0-de8ef7eceb95@suse.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <efddf566-a5a1-cda0-5fec-5e8a1d6bffb3@roeck-us.net>
Date: Tue, 19 Jan 2021 21:54:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1093bedb-9b6d-b365-85d0-de8ef7eceb95@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_005435_383280_E5826307 
X-CRM114-Status: GOOD (  23.15  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/19/21 11:07 AM, Hannes Reinecke wrote:
> On 1/19/21 3:56 PM, Guenter Roeck wrote:
>> On Tue, Jan 19, 2021 at 07:43:18AM +0100, Hannes Reinecke wrote:
>>> The original design to use device-managed resource allocation
>>> doesn't really work as the NVMe controller has a vastly different
>>> lifetime than the hwmon sysfs attributes, causing warning about
>>> duplicate sysfs entries upon reconnection.
>>> This patch reworks the hwmon allocation to avoid device-managed
>>> resource allocation, and uses the NVMe controller as parent for
>>> the sysfs attributes.
>>
>> I don't really know enough about the nvme infrastructure to understand
>> this part of the change. Couple of questions: Why is the parent change
>> needed, and does the "sensors" command still work after this change ?
>>
> Problem is that it's not really a 'new' infrastructure, it's NVMe-over-fabrics, which behaves slightly different from the PCI-based NVMe devices.
> In particular we can and will have connectivity failures, requiring the controller to be reset or recreated.
> And as the hwmon sysfs attributes were never removed correctly in the first place we're seeing these errors.
> It isn't easily recreated on PCI devices as the sysfs attributes will only ever be removed on shutdown (or module unload).
> So I fear the issue was with us since day-1.
> 
I understand; that is why I suggested to add a Fixes: tag.

> As for the parent change: for fabrics the '->dev' device points to a static nvmf_device, which is identical for every fabrics controller.
> So you really need to use the actual device in '->device' to have a different parent device for different controllers.
> So for PCI that means that the 'hwmon' device moved one element down (from the PCI device to the nvme controller).
> But shouldn't make much of a difference; I'll check on if 'sensors' continues to work.
> 

It needs lm-sensors version 3.5.0 or later. Older versions
don't support a device hierarchy.

Guenter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
