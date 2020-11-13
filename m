Return-Path: <SRS0=D3vR=ET=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7959C4742C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:36:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7ED20A8B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2020 21:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zCrIi84c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7ED20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mUsClIg6dzZHqXV3x4bCbgpOYbYYJgm+d2uC2YLoXYY=; b=zCrIi84cwoUWLKN0B3y1//+PJ
	UKJIrEoDdEMl4rQzkuS2PJttoscgecrIV+TAS4wSoLcW9OIwpK/Vp3LJ5mS2ihPQHIWfnFaS5KkHy
	fP3PmFm6ga8oea+0F3Om6PhUUe/214jJz5oe5HV+03R014dEpPyxdfd9hez+eJt7yMsdDkAbSiVBa
	r5sjKiARewuPfJRe9XCEqKRMQIriogoVIXiAlZxd8oxxCHoN73KZ/qkdVKzPAYkE51mkGXhb/LoS6
	UaZ0IR2741TIDjs4JbQeyvmZu66sKasPYy3eiGpeUngZWNT3eX3xuMyHSTQeUVKs0wEv1VWNkLaZH
	LLY7JZ/Pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdgk3-0005NG-DY; Fri, 13 Nov 2020 21:36:23 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdgk0-0005MR-N7
 for linux-nvme@lists.infradead.org; Fri, 13 Nov 2020 21:36:21 +0000
Received: by mail-pf1-f195.google.com with SMTP id x15so7403478pfm.9
 for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2020 13:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jm0UQg+mdszuwGSP+rSGtDVxYjXFAKTIf/hP3qOCt5s=;
 b=bndVdSR0/6m1hYOU0ukJfsLRRI+3vf5fOX1Q8A+4xq+a7qVjvQYu5izyVUIQ8DmseW
 2xQQLskJOd4Em0vTtzTuQmjrYuy7G64vbM/SIwWbGR8IMCrz03MenuEEDAG7fwdKiPV/
 lbDxRXqX1nYPd6nj61465Xg7D7I8aDM43OCu0vqSYpLhEWvSvw1y9c9B7RZ97bVAdSB/
 36gbK8+aA+ZV+hO3MtvQjv+FU1yxQ8T4qcYK6Vw4hG/VXLUYW0o168mc33vCB9Aum/9U
 RaUiw9fnQ7LKMIfXWViOphT3sVmvx6iX0qM1FUvXhnCw8/LLnHOVVijpxhnWtjhfJwbf
 4mlg==
X-Gm-Message-State: AOAM531uHced6rKHcddUaYqfjDxjEXr/W10mYcZlJ+90SEbmcdByHIIE
 PwDIaDlROoSn7QEMXwDkerk=
X-Google-Smtp-Source: ABdhPJyd2mq3CcH87fe4TuuOQePNIWrpkvt9hnJ7sQTx3mTF7rd18fMqO1nNSZ6lKYfYZ9gwY9KR7A==
X-Received: by 2002:a62:8cd6:0:b029:18b:ad92:503b with SMTP id
 m205-20020a628cd60000b029018bad92503bmr3670399pfd.77.1605303379651; 
 Fri, 13 Nov 2020 13:36:19 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:be97:ffd:339d:919c?
 ([2601:647:4802:9070:be97:ffd:339d:919c])
 by smtp.gmail.com with ESMTPSA id a84sm10727208pfa.53.2020.11.13.13.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2020 13:36:18 -0800 (PST)
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
Date: Fri, 13 Nov 2020 13:36:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201113_163620_787360_779775AF 
X-CRM114-Status: GOOD (  16.38  )
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
Cc: Qizhe Cai <qc228@cornell.edu>, Rachit Agarwal <ragarwal@cornell.edu>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> But if you think this has a better home, I'm assuming that the guys
>> will be open to that.
> 
> Also see the reply from Ming. It's a balancing act - don't want to add
> extra overhead to the core, but also don't want to carry an extra
> scheduler if the main change is really just variable dispatch batching.
> And since we already have a notion of that, seems worthwhile to explore
> that venue.

I agree,

The main difference is that this balancing is not driven from device
resource pressure, but rather from an assumption of device specific
optimization (and also with a specific optimization target), hence a
scheduler a user would need to opt-in seemed like a good compromise.

But maybe Ming has some good ideas on a different way to add it..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
