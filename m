Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC2C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 19:12:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9C022208
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qUV4hCaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9C022208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R9avWdGdznbMX11Er/pJp2iKyErvMojWuNOHWQLR+pI=; b=qUV4hCafFQ6CCJ31c3vKCRixY
	PvZWKo6SGKiSuFd5r/84qgHlWngbkDOqWwOmOiS4rJ17Thjhos5QaQzASlK/RJ26RQEcq+a1MpBAV
	4i+5RC9hJvUkjt+iNHlPAqRJfl9jFCQjhpEdHbdzN/TWr1ysdjkntTz/oeaPUbHgQ/t26JZrqxQmY
	9vK7+uPyuty98cDPN2W9ku+SJF/jSCzMvSOh3bH3tcaOfVKCowm/YmEc1EPMu0SnDhJbzT+DXODnr
	rco1NmlkOW0oqTsBMP8O4tryQs1h3fbDm+Hs41CNfmM6A+0K99WFHZVP8ceHomhW1A2GqBleDEeA0
	67hRV4/Mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGoTS-0007UY-HN; Fri, 11 Sep 2020 19:12:42 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGoTR-0007U9-1j
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 19:12:41 +0000
Received: by mail-pf1-f196.google.com with SMTP id b124so8077910pfg.13
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 12:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0EZdsEbsw4gysyiAKGMhLHWhQpRqzgR7hyI3NYj5RXU=;
 b=Cwh4EpQdbmHkgVHr0eOznUO8/GdpR8+AMxj7rUP7w8zpFgB1iJ0W6D1LKqdNBLr0WB
 tpW88WXVbl3dwi6dIS0hWWLYNdNIan8a4jifCdJYACv5ffoHxjXoUAxJdorYQwmY71yu
 nkDJoDwV8NXN/fgOZJrcS9gSbrWuyFUjqSzvTZ8wDJlvCLW8pqVaZBfJkpGr8PA78gux
 8I6eykRSt3ONcGJYN5TV76xO9J9amGF7PizZVSTWzHEdUZs4s2DMA1b1uKXGTzB1q9ZS
 5GYJ6/VQpa+QQoeFkNdY8iRnWiHudE2jSeD4eSY4e7mAwvl2OS4OxaH68GOgCx4OiOLS
 WZIw==
X-Gm-Message-State: AOAM533M3qP9/Md01pKdDO6QCH2bsrXjFpvtq2hHWpk7GrN6b2TptzE/
 aSuTTfpSlxf81cYe8ZZ1ycA=
X-Google-Smtp-Source: ABdhPJwagpZDui+DFScg0zjWY4rW/dHBBpm2xj5uUcagDXDgwN9y1ye1szOhTd/Wr0bLY1mbXSsVYw==
X-Received: by 2002:aa7:8756:: with SMTP id g22mr3462404pfo.37.1599851559621; 
 Fri, 11 Sep 2020 12:12:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc?
 ([2601:647:4802:9070:4428:73d8:a159:7fcc])
 by smtp.gmail.com with ESMTPSA id i62sm3030204pfe.140.2020.09.11.12.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:12:38 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
Date: Fri, 11 Sep 2020 12:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8bb90a44-c088-9b10-8665-ec083063e49c@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_151241_130297_22F7AB09 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Jens,
>>
>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>> and prepares for replacing srcu with percpu_ref.
>>
>> The 2nd patch replaces srcu with percpu_ref.
>>
>> The 3rd patch adds tagset quiesce interface.
>>
>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> What is this series against?

It didn't apply cleanly to me too until I realized it is
on top of v4 of: "percpu_ref & block: reduce memory footprint of 
percpu_ref in fast path"

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
