Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF22C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:23:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8874E208E4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 22:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkHG5NtK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YoR6c5kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8874E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x2W+JPU5nmXJvp6BEKJMSSF2vR186sBUmd3IMYwanZw=; b=TkHG5NtKhVbf991IaK+ceg/QQ
	6KLCh4gPXHK62LUO9zKH/ul63t2Mt+5mg5XqVx+K8UlgdqGr9Nk5uH0q2LV3dOSN624bxXQOmU7Y7
	sRkZzezGi6ccs2EtHu5jYnZ+9njM5HhVPmTP7ddWoLLKi8b2gP1x+6abxYhplWjs73MvWH5MPyPj1
	+v0yax8ZN9AsyzXgIRt+2Qq8ZqHEBMmu5ttnH5phczj67wqReQYy1mnK3O3g0ZTanvdXMGySPEhi8
	eDXNYDahbL8KvjxNB1k/pISq+meSsziOW8i5mla3iLUDjbS9eNse5PO4Oiae234JK9R+1aiH8TNZr
	B893kWAOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHwsz-0001e6-8x; Mon, 14 Sep 2020 22:23:45 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHwsq-0001dc-Bc
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 22:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dqw1SaPMocuQT5PB+DtX7iJhle+q2CX18bBEWWD5sKs=; b=YoR6c5kkwh6cnaHidpiEswvMVr
 YDba6YAenPqeZjwYEv+FvO3MR6XhBPFup4LUv6JGHw1K/Dwdy9HUDwBSmu34GQe8aHRAWYpH9U9cJ
 r/yz2Pka32rfhf2WRJMOAxLnPNQ/QIdYQRW79b9rVHlOMhGe+hyGk+5O4RuFKfeaS6p04fhF4H3UO
 ylBYHDPdLZmyKW2OsXERo31r/jAgf/TcIAY5IeBR0AOZ2dPStoxHSwkdTYwYUqiD98LtxEXqFj1GA
 SQZi9jb5wNicuQol6EFAnRuTENwRlHly2SBs0PC8e7CROKzRhfOb0ovStYt3aBE2AB4Rgh7NP7jxn
 Twjhtvnw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kHwsm-00066X-MU; Mon, 14 Sep 2020 16:23:33 -0600
To: Omar Sandoval <osandov@osandov.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
 <20200914220951.GD148663@relinquished.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
Date: Mon, 14 Sep 2020 16:23:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914220951.GD148663@relinquished.localdomain>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
 osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_182340_970166_C6244378 
X-CRM114-Status: GOOD (  14.56  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-14 4:09 p.m., Omar Sandoval wrote:
>> I noticed this too during my review, but based on my read of the current
>> blktest code, the return value of the requires() function is not
>> actually used. It seems to only check if SKIP_REASON is set.
>>
>> If we want to ensure the return value of requires() is correct, perhaps
>> we should check it after we call it and then consult SKIP_REASON? And
>> WARN or fail if SKIP_REASON is set when requires() didn't return 1.

> Oops, you're right, I actually changed this a few months ago in
> 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
> Totally forgot about that :) IMO it's still cleaner to chain them
> together.

In my opinion, this creates a bit of confusion when reading the code.
The &&s make it look like the return value is important when, in fact,
it is not.

It is also easy to make the assumption that adding any bash command to
the && list will skip the test -- however that is not the case and
people may introduce subtle bugs that look correct, but go unnoticed.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
