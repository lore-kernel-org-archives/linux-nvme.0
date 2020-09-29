Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6F7C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1282075A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z2ZOKovb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1282075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=z2ZOKovbwD/NLMMWGHGZjK5K8
	0fx43PRznEZucdiqYC2VsTuDYxQjMZB6pOwXMl+1pacrIrQbCurBZzuInXbh41pvpXYDRUpOHDyYY
	oe4E4fsvIw2+MHTWvA1HxiKB1XkLV5zo4DNQ5uxhP6B8NxXvkXfVMZjizmD8QazjCXwY3wn+37ZeE
	I6DusUZWnFLOfseAYp6NEjPI+KpJB9vahsIHnwnfoTVGa91U403iDYcovfM1EQWI3Tg4aGZ00gJ0T
	iUCOBThvuxs02ihDUlMREJ/kYb6lp0vPOeHk0boLSpM6Es09MJQApc+gM/tNQh1bPgHZPIP+wI082
	E/U90jbpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNB7M-0004xD-Bx; Tue, 29 Sep 2020 08:36:12 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNB4t-0003fq-0C
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:33:42 +0000
Received: by mail-pj1-f65.google.com with SMTP id j19so1107007pjl.4
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=a+S+Vd5uXbuRpDXvr2gFFF50650wzh1/fpMNKvJe9WANs+aNx/D+WOw5TRRGX7c0s/
 ZkYQObuE8Jk6IAADgyaBzhBjRsGPbxSHfnodOSLFGaK7q0jA65cIk9MZy3sfgBJ8IIQ5
 GB8nmBUrdv6CqLd8BEYFzzfLI9TzR5su1ATEq1unFWn2GeVnBPJl0jhD8a9hPN664kdd
 Y303ME75TtKtBffssVlHJGDwbM6hDnPubLUF8vQnSOf4fGEHVdWdTd5cjLYl4nX8Q288
 mfuThreQw99HrdrSKiKUZUD4juaLYTfB3Xn55vrDcjL+tVd79brDNJoqV6LUS3A5ooPj
 rytA==
X-Gm-Message-State: AOAM533btO/YDj4iY7rxOo7lqKZgLG35hLhf+yQQ6urpLGcSIPs4cEcB
 DnxiDIxh/6BkZ9PXCRW15Ig=
X-Google-Smtp-Source: ABdhPJw8LcbxHPzuDhD1fnMt4HP24w2XRHqcjwRfSEzIujzGHwdAQyCI8lWlpnKhyaBVIDt7V1su3A==
X-Received: by 2002:a17:90b:1212:: with SMTP id
 gl18mr2884114pjb.138.1601368416521; 
 Tue, 29 Sep 2020 01:33:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id a71sm4463650pfa.26.2020.09.29.01.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:33:35 -0700 (PDT)
Subject: Re: [PATCH 04/20] nvme: rename nvme_validate_ns to
 nvme_validate_or_alloc_ns
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-5-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ce84d55c-377a-8766-34a4-ebbab209e753@grimberg.me>
Date: Tue, 29 Sep 2020 01:33:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-5-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_043339_137482_876A0153 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
