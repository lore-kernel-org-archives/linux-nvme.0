Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9170C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:16:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7601364DFD
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7601364DFD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d5yUEsNIlXCluY23ClqlRsKq9/9+Y4l8YrB2jesk7Cw=; b=qlOyLkMXeO8FQjda4IpxQgQLl
	cXPq5BBzajl2fmpBYG+31LPHEt9Gx/CnmBefIH53bTlXXlS5tOYO0F+6t40/RWtYr6nu4J3kDOoKr
	l4GmPQoONbjbcNVIViqq7noQIhHYNuIwyS2EoQTyxE6YnBFxGRJ+pUex6zCQH2u6h8oSqMmqu/uaQ
	FY0z8IgeaQBNZ05iTGxiiZp9Mrr+rcZSsTZxEMK449rWAWbhSNZQ4jMtD5/Gh4ljXIhNTdytic6ud
	nf/kMHaHHzFa8IdN0cH0cUdTClwb6G5LYOA+CymEsPOsr/44Hdlf1nombP37oTiu2T81uIuT4SHEl
	eSs0f+ulQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLqpJ-00GU33-SD; Mon, 15 Mar 2021 17:16:22 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqpF-00GU2H-7t
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:16:19 +0000
Received: by mail-pl1-f180.google.com with SMTP id d23so12418267plq.2
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NW+eXND38mNlb3ZqG2dmVqWyYEV8WBK57NAHmFqZFYY=;
 b=CquikcTQvh/dbkXHwe71rh+pBA9ufNfijS8i2OFSKRCAQRbhC/WAuq8DUxDRi1Lvy+
 NpQKgDDjXDvYB5nOMvM2a4hnRJjvNK2vSb038O9Gk5MmC952QRPG3ynZW509NOrEI6PT
 2eUA5SJM8LpwMXpLHMuymWjtikXdVU+4XZoEFmShy6YOj7klPeSH2vN+UkuE7mZfzpCT
 a86vqBu0IodGA1+TOZBAQkpFvamO9L+s2uZXCQEs5Mb3K4brztP2QEcqSySKlR8bYvqB
 4qbm93F7dbw2smD/kW8G0rlapsfyUEgIYJCwQNwbTgk2ocm+gdvFxTQeV/TLH0C6wZjW
 0N1g==
X-Gm-Message-State: AOAM532U4HQ2BMbwoZ56bG5y7U6I7dv+QQGNUppI2h+hOZXjV0CG3rpu
 WzTpol92fvlyXB5v8W5VUPE=
X-Google-Smtp-Source: ABdhPJwiobUzDkmGkjLB6bhTKEQ8DPqu3/A1XDIavy2tRuDicMt3YJjAzVpVPxhLi0MBkjEYjwBYSA==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id
 x23-20020a1709028217b02900e62875b1d9mr12202035pln.70.1615828575563; 
 Mon, 15 Mar 2021 10:16:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id bg16sm188680pjb.43.2021.03.15.10.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:16:14 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
Date: Mon, 15 Mar 2021 10:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_171617_553673_907B1556 
X-CRM114-Status: GOOD (  22.97  )
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


> Hi Sagi,
> 
> On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
>> Daniel, again, there is nothing specific about this to nvme-tcp,
>> this is a safeguard against a funky controller (or a different
>> bug that is hidden by this).
> 
> As far I can tell, the main difference between nvme-tcp and FC/NVMe,
> nvme-tcp has not a FW or a big driver which filter out some noise from a
> misbehaving controller. I haven't really checked the other transports
> but I wouldn't surprised they share the same properties as FC/NVMe.
> 
>> The same can happen in any other transport so I would suggest that if
>> this is a safeguard we want to put in place, we should make it a
>> generic one.
>>
>> i.e. nvme_tag_to_rq() that _all_ transports call consistently.
> 
> Okay, I'll review all the relevant code and see what could made more
> generic and consistent.
> 
> Though I think nvme-tcp plays in a different league as it is exposed to
> normal networking traffic and this is a very hostile environment.

It is, but in this situation, the controller is sending a second
completion that results in a use-after-free, which makes the
transport irrelevant. Unless there is some other flow (which is unclear
to me) that causes this which is a bug that needs to be fixed rather
than hidden with a safeguard.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
