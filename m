Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BDDC2D0F3
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FD520675
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvcZSWWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FD520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V7IVexKojWU0k3ftuE8izrtcXozR9UfKkPUwO6jxd3A=; b=IvcZSWWXUAQnxOK8guFKFFUns
	XkCMIdLEh0wUv6x+5K2NhFFxPe2c5ZOXi3Hou+3jddIqApOYwUYfObehug6QhHHMx0X4XLmTTBWhX
	9h9iIUxfm9OoodsgfMM+1wxCHYhPltmE+VYlw/hI4j+5cuecUh3kAgthn8eW8N+wt8qa0hFIwbWBy
	hijx4EJlKwL/MX6ccfwWSaHFmI3aZYWzt7DABhh+cGeaoWhl1ZYjqUk8tje2jerfuXKA1YIBfTrrP
	Q25bQZFzuFuNOzgTQPrZSNjn2Bc5w6jUejvWarzVleFUiMQo9NsOEu/XlN4C28ZZjhu9pFqmZQPg6
	93DUHXoKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK1kB-0002jF-KU; Thu, 02 Apr 2020 15:26:59 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK1k8-0002iv-Q1
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:26:57 +0000
Received: by mail-pj1-f66.google.com with SMTP id w9so1677593pjh.1
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 08:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IIb0HoC4j78d7Sa6uZYwNVyCzCj5IxRdpLlBAsW+3jU=;
 b=Iq2IehKiVRPBqH1EyCNHi4kcUu3NWGDTQjQN+VNKHHZ9QX2OO+xYD5+afItH/6Ve26
 380Bs7l8O/BJM//bzdkdurUdjovW/dgRsgbi5nrFg+Sb/wj1idJGv+slVyivVoH/B7RJ
 OWS6jNMj5AsfrugvDzDGxvccCqrXvWRXnymeS5HjmAJn88OgEKZbhgEkOLWM/jTWvlgA
 Iya0txRGVwenLLkDmVKQ5+/owt+8QA+wVVv4+J75dZmyXgn3ZVB3LxCVG1DJYC1ZNm82
 1zA8jaPwiX5A92TTRoi9k3z14cu0aB1xsTT87NtTz2EzaqGYu5bDjNj69AWdvLhnsmh0
 TZbA==
X-Gm-Message-State: AGi0PuYtnBl2pF9xAHMeeLIUQ1vF2R/fUoJJKaas/WzmfLH7EZjJPgjE
 f9ICb//BZdcHYMJc4m0Gk/g=
X-Google-Smtp-Source: APiQypI51S3xRKyjFrMkfl285ksvEpFm5AUKPzPAHrW81QHuVgNuM+fnXZ8smlr3ybSPUdCCsTKF9g==
X-Received: by 2002:a17:902:968a:: with SMTP id
 n10mr3248061plp.96.1585841215584; 
 Thu, 02 Apr 2020 08:26:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id 189sm3645951pgh.58.2020.04.02.08.26.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 08:26:54 -0700 (PDT)
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
To: Max Gurtovoy <maxg@mellanox.com>, Alex Lyakas <alex@zadara.com>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
 <66ACE500178B47D6B39F23FE98D22363@alyakaslap>
 <b6443a7c-4be6-3dbc-0535-a8ded3261c50@mellanox.com>
 <8ab1fa5e-2d67-5128-93b5-2f32704869e4@grimberg.me>
 <28046c97-c271-dff4-5252-4b5668c7bfb7@grimberg.me>
 <B3E9005C4E4645628157970AE2A385C4@alyakaslap>
 <fbcd59ef-9c48-4e1a-4802-1cae33c5f671@grimberg.me>
 <d7caa73f-b939-41f5-793a-c9b74880f246@grimberg.me>
 <5fee46b0-0516-766a-5b1a-7114a164c9ae@grimberg.me>
 <CAOcd+r15zrG-uMuZ2M3JjOTODV9fX3qcXPW000jbp1mtc7_R-Q@mail.gmail.com>
 <5f439f61-338f-4f37-2b13-d3b743c32409@grimberg.me>
 <CAOcd+r2JSYfL66a6yLO6KDTFHo3XcNW=4mZnqAw_Wz-wQ1=ULQ@mail.gmail.com>
 <c43c581a-a2b6-62fd-340a-b20c7ca25b88@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8cc74e5f-f005-415a-e67f-0486b3999f71@grimberg.me>
Date: Thu, 2 Apr 2020 08:26:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c43c581a-a2b6-62fd-340a-b20c7ca25b88@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_082656_844286_E0BFCECC 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, tomwu@mellanox.com,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Israel Rukshin <israelr@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> This patch did not apply to latest 5.2 (5.2.21). All of 10 hunks
>> failed.

It applies on branch linux-5.2.y in the stable tree. What are you
using?

>> I applied it manually, and also handled cm_id->context in
>> nvmet_rdma_find_get_device as I mentioned earlier. I am attaching the
>> patch that I tested on kernel 5.2.21 (target side). I confirm that
>> this patch fixes the bond failover issue.
>>
>> Tested-by: Alex Lyakas <alex@zadara.com>

Cool.

>>
>> Max, will this help to deliver this fix upstream, so that we can get
>> it in MOFED 4.9?
>>
>> Thanks,
>> Alex.
> 
> Alex,
> 
> Thanks for testing this.
> 
> Waiting for Sagi's official rebased version for doing full review.

I'll send a patch...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
