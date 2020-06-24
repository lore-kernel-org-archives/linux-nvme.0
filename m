Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91174C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:24:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA3420823
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="v/14UVcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA3420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r/1OCX8nNefyejlxCxJb7cPbNFL2esuB1XDpZ70QKUI=; b=v/14UVcZxJDAVXm9svfR/GGgw
	XYX/+74qC6D5S0Xzgp1ozr8P7a1LK+N26y6f61Aq7Yy2U4v8tP3tRKa4p6UqYPmWnKfZnoj513y+e
	Fa+b3sRM1cE7g6M5cJkfrHVyz5RW03lJJG8e1Jl7GRk6mTntZRJ8yFByCpj/Hxn8pXRJZSWJyt6X5
	Em+PmcnbKga84IrQlBJOvIxuDZX7lZvQK2yNqPMm6VuNEcqqwdaQFmoEl9mK1N/TmE3wNF1+OA3X9
	JD0Jbc0Nvahnksw8FoOd8ELFn2+rBVF/PdgGocWDbjw7s7GEEkq7ebpXAtmfzpwjsgBzxdkfnhMiB
	JojXju5dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo0i1-0006T9-Ie; Wed, 24 Jun 2020 08:24:41 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo0hz-0006S5-WB
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:24:40 +0000
Received: by mail-pg1-f194.google.com with SMTP id t6so1089584pgq.1
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 01:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uhV/uJV8puuvddp1IlK4KAcPVqkcz8logfCJOayxW6o=;
 b=OTyOQLmIRcuQrr+7uowlJtmpp+bSOlcVb8Fze3EfQe0Rsry0ooQNrTI1YmpCpg3aNj
 SgM84Tq66WlwrP6OoZHhFRcKYrGsgaP/NW0pGiHqHu/HX/NE31ssf0kMOo1hFjnJcEw4
 P3rPvw35ib8tmDlssqv+XBZP/IWokkI3kiDxnVcG0XWBw04OiR2rUhtoHQXTDaTU/M2g
 aUjWYlP8Oa6MqounwSlk4IqzKeGB1fpFWfAzaxs+exM60OZAHpVbVhLE46VLo5dHo1e7
 uiQH+eeHtWuCPDfAZEPC2gQjynuR7ygR+bK0AsD22s6Fcf4+yw9Bsuncn1kL5vbiRemK
 xezQ==
X-Gm-Message-State: AOAM5303WUcZ6WKEtCkX2F/uiw+JDb7HByvQD0SHtRAH5kx5BUnAwuJd
 D4qkDTZs8nIwiQ7YSUXgOis=
X-Google-Smtp-Source: ABdhPJwaq1HtM5IHS4JhiuJM2pxxF1Pq7L14CAlMHQznUX3pB3bOviLewesWh7S5b/7MhObXgehBFw==
X-Received: by 2002:aa7:94a9:: with SMTP id a9mr28531019pfl.191.1592987079098; 
 Wed, 24 Jun 2020 01:24:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id mu17sm5065519pjb.53.2020.06.24.01.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 01:24:38 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 3/6] nvme: don't protect ns mutation with
 ns->head->lock
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-4-sagi@grimberg.me> <20200624063719.GC17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d2f4e5e-9d0a-e145-2913-45f3699ff89c@grimberg.me>
Date: Wed, 24 Jun 2020 01:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624063719.GC17594@lst.de>
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


>> Right now ns->head->lock is protecting namespace mutation
>> which is wrong and unneeded. Move it to only protect
>> against head mutations. While we're at it, remove unnecessary
>> ns->head reference as we already have head pointer.
> 
> The changes look reasonable (nitpick below), but this changelog doesn't
> sway what the problem is and how it it fixed.

I'll add to v3:

The problem with this is that the head->lock spans
mpath disk node I/O that may block under some conditions (if
for example the controller is disconnecting or the path
became inaccessible), The locking scheme does not allow any
other path to enable itself, preventing blocked I/O to complete
and forward-progress from there.

This is a preparation patch for the fix in a subsequent patch
where the disk I/O will also be done outside the head->lock.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
