Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935BC433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:53:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34CC761008
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 20:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CC761008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iYwPXJRyld1gziOGZGF4u7v8hxOuk0BF/BsRJUiM+pI=; b=TCkl7DCM8U8rr3rg3Oe5zvlD/
	PH3yRJjEIZmmTQ+i7/7PV2xh4fj2Nck4UgZS8giTyA0hvHc6taQwok3QqHHWsCh/4kiBEVAMf6aJA
	jVrBXTUESD65xsl9PNBu/dMvuORXpG8CY96z0+0ig4zmmDLBDQX9i7Fy09j6WPP0KzZPBzh7N22UH
	CDphQFbrokTgVtppfhT/LOMES56/+x3unD+tDvu6URSD445k7JlYfits8xMnZxsx7KOkNX1T6Wf5x
	VEh0SboR0FQzkzyNQpI8ozb8z++F8JWZS5pmAbnCpyPP21TEQhly/D676sWy6eWKXU7nXeL0DosyC
	4OsKkhCTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lalks-006HBh-3V; Sun, 25 Apr 2021 20:53:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalkn-006HAQ-Mw
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 20:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+fAv3IcCB/xNBG+VkrylC1h4GKQjcXLE+QYZ+nh7+VY=; b=YLgaALqpMxpob1MSUVov9wrDgi
 Gh4RClmHUj3MPOHUt5Z/dukfuu9IJVGlDj8l3dlqobsUToCkRbwlwLmGyBZw/VYmuSg4xmo+CwAtX
 uDZ6wJsQgNK68tHsSTdpC+qSK6rE7qLy0pZuePIe8+GM+fa3+HT3j5FOJn0YH7LV/S/vIjuQd84iF
 WM3Eg+yrVvBt054ANL8xwugByntg79lrwyQO07yV+wpWcKcfhgsayKT21mMKKd+aW4z/MgHRXqSz/
 bJuRhWkfch9H/BaybSLC+XsouDg4z0dbcHm2IW3IqoBku0+KN/tzQz2xIyLYqV4BrfzCta96sOfIb
 foq8LBQw==;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lalkl-00FauH-0r
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 20:53:20 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 m6-20020a17090a8586b02901507e1acf0fso4073195pjn.3
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 13:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+fAv3IcCB/xNBG+VkrylC1h4GKQjcXLE+QYZ+nh7+VY=;
 b=NJDcYWyZ0cDmArtvGpCFQdQL68mLDRwYIDNVxc52cZa+eNRdRL8qcMSqyTnE0m2Ep9
 sQoLwnfd1KwovyuAsB1R5OF7mUIKOaeJdYp2bXQNorUF39dQ0blJ4/jm5j3IX2TAmIeH
 cLAYC2gFy0BD2gyMRttZ3kLaUPGaRVWVHDqNdXOJr1bM+WM5s6A16DsSDc29uvMFpL3D
 /otYlrf3RlJ5/Z0I2EB6pEeyc+X3Q3hjwLmmu6bHVswqfFPSlIOLcaJiKAnijt7yqsbn
 bT8jEUFXuwLdKuo/Io4rntZwVVOthQX3BFmXY980bmABFq6ojuFxT1j6PjbLnrSD1C3S
 37SA==
X-Gm-Message-State: AOAM533Iir0zY/BHklY0NV6oSiN8MLQThhmPqP6HrjEyrX5QaR14J58J
 ygTzLhiISz7+9FUgFCs+qnk=
X-Google-Smtp-Source: ABdhPJxg5YL5TENzJDyoYWHMvcZsQ2EnGLCYQTDLcAfYC8v65xlvKk/3SpSr4i60vTuZCMKuh3CP6A==
X-Received: by 2002:a17:90a:b112:: with SMTP id
 z18mr17565855pjq.18.1619383998074; 
 Sun, 25 Apr 2021 13:53:18 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id i9sm14400312pjh.9.2021.04.25.13.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 13:53:17 -0700 (PDT)
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
To: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <YIU2BhuYZAAgonN0@T590>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <5c1ef3ec-dd6a-4992-586b-6e67bcd1a678@acm.org>
Date: Sun, 25 Apr 2021 13:53:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIU2BhuYZAAgonN0@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_135319_092062_CEED10F8 
X-CRM114-Status: GOOD (  15.08  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/25/21 2:27 AM, Ming Lei wrote:
> On Sun, Apr 25, 2021 at 04:57:45PM +0800, Ming Lei wrote:
>> Revert 4 patches from Bart which try to fix request UAF issue related
>> with iterating over tagset wide requests, because:

Where were you during the four weeks that my patch series was out for
review? I haven't seen any feedback from you on my patch series.

>> 1) request UAF caused by normal completion vs. async completion during
>> iterating can't be covered[1]

I do not agree with the above. Patches 5/8 and 6/8 from this series can
be applied without reverting any of my patches.

> 4) synchronize_rcu() is added before shutting down one request queue,
> which may slow down reboot/poweroff very much on big systems with lots of
> HBAs in which lots of LUNs are attached.

The synchronize_rcu() can be removed by using a semaphore
(<linux/semaphore.h>) instead of an RCU reader lock inside bt_tags_iter().

> 5) freeing request pool in updating nr_requests isn't covered.

This can be addressed easily on top of my patch series.

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
