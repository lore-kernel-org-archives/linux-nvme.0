Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16081C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:08:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D052342B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YbvRWcuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D052342B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qrPWMyDrJC2jlb1m3lpqHwjccT4lrvzQM4qzwYjNkCg=; b=YbvRWcuVTCRTavaIXISUvgG0A
	HBZMZZUQQarg9TLgtI8MGEd3RLu23LZjldyR3UzChX/0NFn3nGZWiAHUB+tZ+XhkOt7yxUgbGD7/6
	T5TAp+P+em4/v4unbuzRS2xx3oOzaH7TmEqgr9meCpPZ5kXhC2uXBoD0owyjCO8nIWA/H9ebr9Qqw
	+i+XGECXOaEVrAeqJkDjjUS6FLPYmKh5Ru+gRAEVJ9YpNT7n0z7m2MY4dlVxFIiYlGCtiAce2os7K
	pVp0fW653LDiC9ufSFSxFwYJ2xnLdzqTSwLSo5tmacRg/5VqDqK2Uwn4xQaCdRO4V2c4JKu+vEzYL
	5gVf1srsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lJx-0001Gp-UV; Fri, 30 Aug 2019 18:08:25 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lJv-0001G9-0c
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:08:24 +0000
Received: by mail-oi1-f194.google.com with SMTP id n1so6044949oic.3
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8WcqhFY+HXLsWaR9k6uq7mqcDR/FvX17iR08vwKJNkg=;
 b=SHZdxSWJClDGXkrrj/3w+r/Ex0ulcOendYqppJ7VW5yUEkzAm3OuUQOs7zIf7Iq9wu
 1QMM4X1njOHwPX0pw3TPHlJRmAoKwIvVtE218wznSocwA7SmpqUBojd5NB3Kcdcj3qzT
 lL+2gaiLKw8rJZpWD8jF6A8E3yNaHvYqVkaIXo6xVAGoqfOmrnBcd+KJO0fRkpUfixFT
 eODlUiCM5dRB09X72IcpW91v63zgo/n/ob3sodAXh6aP10JMj2HYXEgaQkkvwXYbd6qT
 3nSidjIQQ/1JW8Nrtn0q/7NEWnYN2prcFzGQzua3vE1RaCUX+A+oXKKKBdZryjGV8QuR
 iprg==
X-Gm-Message-State: APjAAAVvLWsHcaU1b/O9PlBdcG5CimMa4uUp/UOhvQ+jNHD5xcw5owqd
 FwduDWuHPAdYt86eDZa2KfU=
X-Google-Smtp-Source: APXvYqy/r+B34kWyM1uoSMAGuaDOErtirv5P6iSD1QVBLVfIYjMhC3Jv/g6vrbd1ORP6cWObumfZAQ==
X-Received: by 2002:aca:75c2:: with SMTP id
 q185mr10615384oic.134.1567188501705; 
 Fri, 30 Aug 2019 11:08:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id 59sm2340442otq.9.2019.08.30.11.08.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:08:20 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: Christoph Hellwig <hch@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
Date: Fri, 30 Aug 2019 11:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830055514.GC8492@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_110823_060151_29BC2C02 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Yes we do, userspace should use it to order events.  Does udev not
>>> handle that properly today?
>>
>> The problem is not ordering of events, its really about the fact that
>> the chardev can be removed and reallocated for a different controller
>> (could be a completely different discovery controller) by the time
>> that userspace handles the event.
> 
> The same is generally true for lot of kernel devices.  We could reduce
> the chance by using the idr cyclic allocator.

Well, it was raised by Hannes and James, so I'll ask them respond here
because I don't mind having it this way. I personally think that this
is a better approach than having a cyclic idr allocator. In general, I
don't necessarily think that this is a good idea to have cyclic
controller enumerations if we don't absolutely have to...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
