Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C51C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:03:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE786128D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE786128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X2TWkxHZjbF2GeK83HMnhd68KlE5f1+xB2TmiKJjWFY=; b=FSpWDAFTWiRtNHwOz5tKDhmoL
	tlDlP9cdOYA5f8achVPE84H9L1/I4riejZPJjeIXcDGmd7L9K/XpiytR2gN3ZyggRB+Lu4KB37eGM
	ReCUlhAuNhdbsjt1F0QrRTII78km615blmgYUZolVYk9j5glgnY8q2Lz2/r39L5qD5QuwNrYA15r2
	D9hLVDx8XuqKfvzJlrMGk6zJZaLJr5/P4tipj77+rB4IscFZmGoDkglXCYb+xfqRH+fyK3ROtSX8g
	t6efkiMWc/ve1E1y7il6+SRmjJFWsXboMiXbVJfDTGd5QgISisjR5zkv+mcaHqCsAdCLfQOc9qVuY
	esMYqdcKA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU1HL-004AQq-St; Wed, 07 Apr 2021 06:03:04 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1HD-004AOw-UI
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 06:02:59 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 b8-20020a17090a5508b029014d0fbe9b64so674522pji.5
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5marzlTMzRaM1Jrb//GCyMv8IHL4Wjh2YfuobjIOkgA=;
 b=h+BrMrKBebIire1w7Iypjc81JwFHH9VnQ84Wn5RZi3vN2OjpL3sJJvOtyLEcDs+fgR
 7SHgYP4qK3+9KKyToQ9A6wYvk9CaSMgYLrn6HRqPuKMc/1aXiuTSPwyMKsbfsAsjQlOR
 EyX5AUP2H+ZGuboOxHKt0BQ8CDU47fe29ACc8vILzJ12+7XYspk73dMP18pGSmHM1hP6
 YS8aFWmVKASbIwSN1ve9ycc5VR7ZrsBiZBjyxws1PQg3LaVFE+lChjv4wlFocGvRjkWh
 mpLPmWq6npE9DfBjDBibMrcO7evNUKd1d++4LL2NWyA4kpjOiRHF51ZemysY97gkbun+
 04Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5marzlTMzRaM1Jrb//GCyMv8IHL4Wjh2YfuobjIOkgA=;
 b=uJfsFntfHfHYPzvqjhMhwPvvCOS8EcxZjIHTzah+Ex4fw2OJEMO5C9DXAVR5pfsnlp
 n/K/0gRnkabk4w8nxly/CqapPYmJv1e8HZDIWUBM3w7JTsh+VQYTlUnlYNMgi9C2gz9N
 w6llUH0BRfNwDt9eKNAu+3I8PGCainDfMAbMBxiAUyuilLJv6b4054UvYIGjN0mx7ZbN
 e7/oo0K5LoAFK9Y4BfanbC7PafsGUMM81xE8Z9XQkzFmu+jPZ5/2IHlRa0dxHn4bFug9
 o+icHwLB8vepfQsoPKmfhBa1WoIpyJAlU17sbl0Dc0JPq3vMXu7AoqHWT7s8P/sGfqVL
 dO8w==
X-Gm-Message-State: AOAM531tt5LjzvEz/FPLVMA8CS2UJItbuFvjWS1J1k1qCgwe8t4f2HzB
 00Z5Gpl7k4boj7q96X88D+4=
X-Google-Smtp-Source: ABdhPJyDwJmKQa5r8sDQgjuJ/IA7u5cNvZPQ1fXQJFKUAtMD3cM5+ox0xm9g4Monw5QvjHemXsyWsA==
X-Received: by 2002:a17:90b:945:: with SMTP id
 dw5mr1736072pjb.143.1617775373460; 
 Tue, 06 Apr 2021 23:02:53 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id js16sm3911707pjb.21.2021.04.06.23.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Apr 2021 23:02:53 -0700 (PDT)
Date: Wed, 7 Apr 2021 15:02:51 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210407060251.GA2044@localhost>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan> <20210406133533.GC2594@localhost>
 <20210406145948.GB7790@lst.de> <20210406162309.GA165675@localhost>
 <20210407060016.GA19224@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407060016.GA19224@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_070256_455344_324DFB50 
X-CRM114-Status: GOOD (  14.83  )
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

On 21-04-07 08:00:16, Christoph Hellwig wrote:
> On Wed, Apr 07, 2021 at 01:23:09AM +0900, Minwoo Im wrote:
> > In this new series, we have created nvme generic chardev along with the
> > block device(e.g., nvme0n1) which is not path-specific (e..g,
> > nvme0c0n1) in case of multipath.  I think now we can say that it
> > supports multi-path.  What do you say about this :) ?
> 
> Yes, that is the right thing to do.

Thanks for your feedback!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
