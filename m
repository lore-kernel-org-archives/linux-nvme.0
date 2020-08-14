Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A4C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3688920774
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irQMZT3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l2vZHAunNFMhjl7Qm1Vnlqd/NQZr2hFAGgRNi8xswMM=; b=irQMZT3bPzv/KC0O6KAKtO6nf
	yi2L4mJGdRfZKUCi0TjcVkQWDDGG0AwhanPADBtfhwOSt4S9reoohZFJ7O5atkPkVKsM0jVRRf/6O
	3NYrbxBdK0dA+hpjvs0lJ245g9NfJUVkxgCpaUslBhRheHUOjrZ1R4l0gSts+0Z6+2blT93kLaGQp
	GsW/oyDU2l580jVNlLmi+mFGvKZCS7cSkMOv7oXVFuJtNaXOU13mUmWgjQepDLcuZtBb9WTqfxFJV
	dbbOu2kCOx9Hv5xjeWVlgHEVfKJ4+uvM2GLF9/PjsqYG2iY84Zf31y3UbPBEBLs5/iy8RzmtyLsgS
	bFnAAeaqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Spg-0000UN-B0; Fri, 14 Aug 2020 06:04:52 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Spe-0000U3-3B
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:04:51 +0000
Received: by mail-wm1-f67.google.com with SMTP id g75so6937551wme.4
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vPALidMW+fF/GY55nQjLH9o8dJ+J86ReCVm/X6/kzsY=;
 b=WZ7TrhnLUbncHlVSTcE1/LlszNbNBimIyPYAuDvERZEZCK7lU1OX32WPkxqgbnr92V
 ZNbj5iLqZNAk3y1Zw9+2/t5aJkvhEsz2WRTm9wrQHGaIuGYD4rwbJSWFE3NHQu1QLlQx
 yDVltY41mSixqhzPwqcxkFTn5LO7O93Ce/6k5VDEbdcobFv5VzFFQL1SKBmJ0tYXqmCU
 E4uKXOa5jjkTGAA5WWIBx+Vse//eYgOavOUeLms/buJvA+4JG38adpvxbH+ck2cFFiOH
 24RLSgtlPTy+pD7ta+ctY1woOFgmI7UylUkV9Ba1QMVLisAlnxuHW9X7F6gYG6gHV8QA
 5sXQ==
X-Gm-Message-State: AOAM532DmAPv1OGeY/OWUK/VKPaylY7AupIOhu4LmVYeoHEVZ58k1pOc
 8swkdaQY6kemeeX1PoS4hYw=
X-Google-Smtp-Source: ABdhPJyLfOoJ39cpyJDuUL+tU5wQhF112G02dJXAZioVEhaG5hyPc5D1oW/NxBT9ROo/KumxVB3xQQ==
X-Received: by 2002:a1c:4b0d:: with SMTP id y13mr1008363wma.6.1597385088054;
 Thu, 13 Aug 2020 23:04:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id k4sm14550383wrd.72.2020.08.13.23.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 23:04:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
To: Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>
References: <20200812232444.18310-1-logang@deltatee.com>
 <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
 <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <498ea4cf-1edd-e50e-35aa-b5529616337b@grimberg.me>
Date: Thu, 13 Aug 2020 23:04:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_020450_167237_8A62ED5E 
X-CRM114-Status: GOOD (  11.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> There's an unrelated whitespace change in nvme_init_identify().
>> Otherwise, looks fine.
> 
> Oops, sorry. can this be fixed up when it's merged?

Fixed and queued.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
