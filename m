Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13396206E2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ufBlC2mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13396206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0kDogrh7cGWmRARwlApHu/KrC9rJabV/b6ua/lc7n1g=; b=ufBlC2mVBl++TwAj7XRTXXCNg
	VjzRH/n4Op8oDH0j/ycrPZqA/p8EAzdccZAAeMxSYIYokeMTwMuQFVHwYI9csuyuy2vj+DUapn8iY
	FM9TPaHq06LHqfDOvKeM0iwpPQUCXskNxLM21TBZtlJ5/xYwtP0ymvMLauPynBBoRG2CMpXbYQQF5
	4jnV1HmU+xQMGOu0x0QK6n/RGn9lOKZg2nyQc7Su6trEyURsv3wlkeUaTxbLDZwZRW3WdTBIn5nBm
	kJp5QK48RRnmzqXXMkei7PfV5qjeArn1SO4PHZzgIBoGhUUIVyF+9nw+OjDerU2yHGQNO9bGQ8nWb
	gHB75VUhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzPE-0003w0-AZ; Wed, 24 Jun 2020 07:01:12 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzPA-0003tf-Mg
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 07:01:09 +0000
Received: by mail-pj1-f68.google.com with SMTP id b92so754859pjc.4
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 00:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rKCctVlmZEjvgwsD4vBsMkpXA1+I2NyNgWUFqHoJUeU=;
 b=KP8qFByvfeT+hPssZsBOm1mkAl5yeus6y4KRWrxYos8x0voLuYZdCcwyZS0375/uJb
 mh3IQB/H/dsUGdfHedd3q8j8uvwdbzM6jCw43QR7rtYUcWXoiv/nsyow0NV1aO6PpncW
 9wgPloYoHLwOKlc/VwAiS7O4Yb0DqWI91Rq44fpFFW9EkbEUnFbLYD0tbW/pkzxAJiH5
 E5RFw1AFRJBaaN87xIPBC42utbUaGAXONLTo4dGaTDqCkKToKse+K3KkY17l/fWKPpZF
 Xh6upa7RPzz5FEQeYPnNvpAKiEp00iVT28pw6PbcwERj+OoMH8VlLQJrQEZ1N/TLX4Wd
 d55Q==
X-Gm-Message-State: AOAM533wuVFBd6q9cBFxZvYCpw7VFyuB/XWoF5vR9x1Oi+ey7s+SYF9T
 x077hhQEPC9CfIKnFh8E1NDkAHqV
X-Google-Smtp-Source: ABdhPJz4U1Ia1nNCGFh2q8F4hcf8WjfmIbWAyRMdzeOI1DTY7MCt/9jhKz7pwiAK4alRoQZUo+T1Ig==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr13451038pjv.191.1592982067461; 
 Wed, 24 Jun 2020 00:01:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id m20sm20406323pfk.52.2020.06.24.00.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 00:01:05 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 4/6] nvme-multipath: fix deadlock due to
 head->lock
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-5-sagi@grimberg.me> <20200624063903.GD17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <12ca5689-e5e4-ec23-6772-01de5a5ed9ea@grimberg.me>
Date: Wed, 24 Jun 2020 00:00:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624063903.GD17594@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> -	mutex_lock(&head->lock);
>> -	if (!(head->disk->flags & GENHD_FL_UP))
>> +	if (!test_and_set_bit(NVME_NS_HEAD_HAS_DISK, &head->flags))
>>   		device_add_disk(&head->subsys->dev, head->disk,
>>   				nvme_ns_id_attr_groups);
> 
> The HAS_DISK name is a little strange.  The disk obviously is set
> before, otherwise this call would dereference a NULL pointer :)
> 
> Maybe NVME_NSHEAD_LIVE?  or NVME_NSHEAD_DISK_LIVE?

I think I like NVME_NSHEAD_DISK_LIVE, which indicates better that
it relates to the gendisk and it is live (we called device_add_disk)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
