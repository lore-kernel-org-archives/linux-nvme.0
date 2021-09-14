Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5848C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:24:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23C1610F9
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A23C1610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTOwSQqpv1o+lStDz1DE86a86uZZ72jV+8JnJ9XL4JA=; b=cjfVeLCphwwJUB5MOoxvH7m9yG
	tELBd1DUIy9eICRpjaSB6Slt+YnGdsuTpHtNZ5D5Rb2chSg3g51XwdNayjwJV+Cvprkb7nrkBdvv6
	QJBBq5O/qImfwSQfeAHLb3J8cvRwW0S0N3prLqULZJUrohLk9IwBWZQrsUzJs3iT07JyqlB92pNa7
	WSo8YbAQGn+U7pTyfJ3eo36COIbTKCeRLoDKmKKv6Z+HJwH273jksvMSEDgVkYxWNbtBqvchd/xV3
	nnBo5cc4CbaVuaDdQfkdrBhibKHrRH90JvwNczR1dEfJm36a27kg9uDMaGyjKpAAwWAi1Tg7dtNby
	cjpjNi1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ1rx-004GZW-GA; Tue, 14 Sep 2021 06:24:37 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ1rv-004GZ2-1p
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:24:36 +0000
Received: by mail-wr1-f41.google.com with SMTP id i23so18338620wrb.2
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 23:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NsoKb0j5+UBRmej1WMOorcrT8qX65wXrD+8O9SvMeDU=;
 b=ahDCClxj8HkxHuZ3TujJv5qX4sW3Awn5Y7UxPyV9MoLfY5MSS7kF4qSKpiSIiF+/W3
 NiW3yS1tZHu512VsoW61RVSTJJKOg/6nT2f4K4DZDE4n260o5zMvsCYhSnmcBl/JP1jH
 vHz0cEK613xn7dbVzvMMiyOSKUye3+WnEFzQJN6Fjeoft8cxhUo1Wln74ZdsWnS0cODA
 MkUTz+qkJ3iVvXI9Pw2KnsQ8zCXfN4xt3KDDrb2MXpORcUJZV0+2n9B74ugw5UAIcTsV
 2+pX1OxC7KIB2jzYUIt9kcR3R7aTo2yC1GerXs4hIqARVghRVkhJ9oQaTrMQ0UpckxD+
 lW+A==
X-Gm-Message-State: AOAM533xtBmW7FX54rC/mvqL6hvwpUkjFqQt8WHoGhl2HMmrJjIJLCqy
 +LJLAarSeruMq0d/u2VZQTM=
X-Google-Smtp-Source: ABdhPJyqwq04Urbj7xBl+nKEecG0O7VyM8U5nwIARKxGNNeadAmKOXk3vOA6zNVJOkG0qZDkaT0aEg==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr16611492wrn.251.1631600673171; 
 Mon, 13 Sep 2021 23:24:33 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y15sm160397wmi.18.2021.09.13.23.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 23:24:32 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for namespaces
 just added by scan work
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
 <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <520b56e9-cac4-3cd7-9d2e-16633c6e7df5@grimberg.me>
Date: Tue, 14 Sep 2021 09:24:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_232435_144359_F0FF4DDD 
X-CRM114-Status: GOOD (  16.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Scan work initially adds new namespaces to ctrl->namespaces TAIL.
>>> They make the list unordered temporarily until nvme_scan_work()
>>> finally sorts the list.
>>>
>>> Solution:
>>> In order to preserve the way ctrl->namespaces is updated and sorted,
>>> make nvme_update_ana_state() deal with the case where ctrl->namespaces
>>> is not fully sorted and has new namespaces appended with potentially
>>> lower nsids.
>>> nvme_update_ana_state() keeps track of the nsid seen in the list,
>>> detects the unsorted case (rare), and restarts scanning of desc->nsids.
>>
>> Can we dust off the patch from Chaitanya to switch to an always sorted
>> xarray instead of papering over this delayed sort?
> 
> Yeah, that's what I was going to say. :)

I agree it should not happen with xarray as inserts preserve sorting,
but that patch has the non-trivial removal of the namespaces_rwsem which
synchronizes in a lot in a lot of error recovery flows. It's very
possible that xarray will introduce regressions.

Anton, is it possible to rerun tests with the xarray patch applied?
The latest one is:
[PATCH V6] nvme-core: use xarray for ctrl ns tracking

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
