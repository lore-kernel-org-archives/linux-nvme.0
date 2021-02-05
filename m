Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02143C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:42:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A5A64D9D
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 18:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5A64D9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3SmQ5OksuZDDJiwr2HPf/I0VMjsIPUV/Pmkfw12Kb3A=; b=W3z3IhAo3z7XFKUynWSKDVE5o
	c+7WSLnz+zZeg3L6zSaTqgFQd/6BxGLPMkSfymD28AsBRQu7ozGbJ7p74RezAt7x1w7meMmcMemM3
	Iey1KR/dmRr9odflsRXXHvq0tZqNtekOK34w2GnuNVAxh37+Nq5iDRDQ2ADdhVXpjpDg2hQmM9Bnh
	qVs0dUf9BUfKP8t8NtYHy6AAsHTAYhalpCEb15fToDzuTR52iN6SYIfCJYZf37bVgzstxabtSJHnk
	tY4H9p3e1KTz3T4ff3DU4BpLKcd+CvJBUu3YNq1h7R2Rjl3/3NETFK9MCloBIexO53szxCIODqeo1
	L7S4dGOAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8646-0005e5-NZ; Fri, 05 Feb 2021 18:42:46 +0000
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8643-0005d9-2i
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 18:42:44 +0000
Received: by mail-pg1-f181.google.com with SMTP id o7so5184061pgl.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Feb 2021 10:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJE0H/OfEp4LQzqXBB/RvIxBrCslywyWBfDq2fuRvzI=;
 b=nJRSHqJjEMyWWWDxmHyiDaNHszRksRO9tvmMqOp8/aDn1n2WPO23yVbThxMRp9v2XJ
 phl7e735SRdaCdnQc0FyJjqqUzNQq+PNKJicFZwE8Devuj1HCvFbYoUkK39kTeTnG4d7
 /bu+KJtfcMwCXCKcUw5iaWzkZCnltWYfPOq3qg+O1rN0DkADkHcx9myoipashgxGLVbL
 q+INOhxAAgnMQLtdPNsAuaEVm/EtD05HLYPprkT//frS8lF/+oeAJ2BetdBEM16/qL79
 kYxJoJx6wtlt5Qt6zHrTMxY/qSN8bNpwFXpJtMN32u4yzhRAzXQcoRbkwMK0+wrSyv19
 4oeg==
X-Gm-Message-State: AOAM530qJafBwKJfiX6jSbVMsKgQxm6kx0+4E+u7cWLe02ZEne7NN0GH
 KhH7XbFF4ojzSkHypLWB0/5FTfAS/BU=
X-Google-Smtp-Source: ABdhPJxTPOkFUtNVif2t/60gadRnAr+Xtmq4z9mtva7hP4McDM3rp56MjqmRTEHzOL6sz4N/LhZUxQ==
X-Received: by 2002:a63:347:: with SMTP id 68mr5762425pgd.164.1612550559717;
 Fri, 05 Feb 2021 10:42:39 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e569:9026:928e:73dc?
 ([2601:647:4802:9070:e569:9026:928e:73dc])
 by smtp.gmail.com with ESMTPSA id k15sm4303877pgt.35.2021.02.05.10.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Feb 2021 10:42:38 -0800 (PST)
Subject: Re: [PATCH] nvmet: per-host namespaces masking
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210205092926.64161-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6be00c89-90cb-1bfb-a3a3-33949bf5dc84@grimberg.me>
Date: Fri, 5 Feb 2021 10:42:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205092926.64161-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_134243_166262_A5A31DD4 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Implement per-host namespaces masking, allowing to expose
> different namespaces to different hosts connecting to the
> same subsystem.
> The original method of adding host nqns to the subsystem
> takes precedence over the per-host namespace masking.

What is preventing a host to go ahead and issue an I/O command
to a ns that exists in the subsystem but is not exposed to
it in the nslist?

I don't think this can be even considered without a protection
against it. And given that you don't want to take the global
semaphore on each and every I/O, I'd say its a bit more involving
than what you have here...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
