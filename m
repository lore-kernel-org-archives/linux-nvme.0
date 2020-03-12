Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D286BC10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A627B206E7
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 14:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EnN4p3J7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zssgGwlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A627B206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ExXageesC23bnCzfdURtdEziul5DFly3x+YvShqFVuw=; b=EnN4p3J7cy6hId
	1h68sl3t+krk46v8Dph6c/9oFqnnTb+PfAhvcHsNzlE5pVBGU4l3rjomn12A7xXzz21m5q//xV9mz
	8c35vfj8TDuP59xL/ba9Nyfydrvx8yDTk6fLTmBIVJu9csUMlm/p8vhxxsb23+zxUs2Lhg1XEp+xS
	o3B9/eZCdA0StaZiFail+EWn1gm0L2CYRroCisYLuTaNXQxeEoTZvpXxOnVziFdOZdFvwirhdSc6h
	DlVUJcInUxT+ar5xVaFv1VI2Ad5WFkY6QTmN6MYduAOUeHp1B8kCywj/ig0yDevKbC+Rv94jUX3fh
	EmAlhxOeI3IpwH5pzkEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCOTb-0004rY-II; Thu, 12 Mar 2020 14:06:19 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCOTW-0004qz-Su
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 14:06:18 +0000
Received: by mail-il1-x144.google.com with SMTP id a14so5560536ilk.6
 for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2020 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
 b=zssgGwlH8/VmLMRtLhaCwqZbq9RREsK0T5bf6PIvtt1VGFFLfPPnQnZejqOTYcE66h
 YC0y2su0NF5zACw1HZZsr7rjtUkogTsWqTu6Vm6/ie+LuGi85xrZGApcNLASkl90rCNH
 N3iKNDAKYS9oq8i9IEow8BJeJKPxUsJrlebRdwIF5eJPTF0cAwRj9ggXLmAxIDhdEZuG
 PvnpPrEInwbqPNIjvL3PzflYawxDa3mZi2TgaKLvf7ECZzHSxJx3KAoa2ry7Pf7aKJ1S
 y7gpjNa2PHKgoNp0XyIc9HwCBIQjRNDXD+/sV+kacNjm7ivwd82D7IAXuee/0UJ8BEOm
 eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
 b=IvZFcVgcWtjDMxOce2DN1GcxctKMPRFZLRsYaiNNhZ2moD7UsMbbtN6vRb+QoLPdVF
 Fc7b/sX4ESBnbspZKGEcYEFIw4J0r2WaJ68GN/c2ytJwTzYqnt+8D/Dj8DFQDe04RQma
 pcwpysmEcg++SBey94LNrHvHx8HLosmn5HuYo7xhP8ZkpeF89LUhPiKar5jRcqDe+Qbv
 xn5exAZ8+LymJQcIsb9DYS/d1paRm8lhuSk+DOT74QhKXStOkg7+g9QftSbFpgEf837h
 Kt6DARpe7Y+xwVRnB6WxBMDHIq+SoH5VNFP0WUUGEHifjbY/kSvD0nETvlEwHP2p1mQ9
 YXCA==
X-Gm-Message-State: ANhLgQ3CrQ2PtTd0uiEYiPR/0qUlUPopHC1RC7Gyd6fQdZrDvehgaUwT
 Bv0dWM666dsXArSvq3t3u3KWuA==
X-Google-Smtp-Source: ADFU+vu/XM+0n/FArOrrpYRuqpoofr0nhTgegl8nM9GcEZ0Y35AWlXD9wYups+i8jASk7u1s54i1cw==
X-Received: by 2002:a92:c904:: with SMTP id t4mr959353ilp.209.1584021973514;
 Thu, 12 Mar 2020 07:06:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id d1sm6126275ilq.9.2020.03.12.07.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 07:06:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
To: "Singh, Balbir" <sblbir@amazon.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200225200129.6687-1-sblbir@amazon.com>
 <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <05bb1606-4cf1-dba3-22a0-5f8624b43767@kernel.dk>
Date: Thu, 12 Mar 2020 08:06:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_070614_928499_9184FE7D 
X-CRM114-Status: GOOD (  16.06  )
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
Cc: "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "hch@lst.de" <hch@lst.de>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/2/20 9:03 PM, Singh, Balbir wrote:
> On Tue, 2020-02-25 at 20:01 +0000, Balbir Singh wrote:
>> Allow block/genhd to notify user space about disk size changes using a
>> new helper set_capacity_revalidate_and_notify(), which is a wrapper
>> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
>> notify
>> iff the current capacity or the target capacity is not zero and the
>> capacity really changes.
>>
>> Background:
>>
>> As a part of a patch to allow sending the RESIZE event on disk capacity
>> change, Christoph (hch@lst.de) requested that the patch be made generic
>> and the hacks for virtio block and xen block devices be removed and
>> merged via a generic helper.
>>
>> This series consists of 5 changes. The first one adds the basic
>> support for changing the size and notifying. The follow up patches
>> are per block subsystem changes. Other block drivers can add their
>> changes as necessary on top of this series. Since not all devices
>> are resizable, the default was to add a new API and let users
>> slowly convert over as needed.
>>
>> Testing:
>> 1. I did some basic testing with an NVME device, by resizing it in
>> the backend and ensured that udevd received the event.
>>
>>
>> Changelog v2:
>> - Rename disk_set_capacity to set_capacity_revalidate_and_notify
>> - set_capacity_revalidate_and_notify can call revalidate disk
>>   if needed, a new bool parameter is passed (suggested by Bob Liu)
>>
> 
> Ping? It's not an urgent patchset, I am happy to wait if nothing else is
> needed.

It doesn't apply to the 5.7 branches, can you resend against for-5.7/block?

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
