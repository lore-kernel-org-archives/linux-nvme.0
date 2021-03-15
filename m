Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8902C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:46:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EFE664DE7
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFE664DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fK4coqlcyV7Q5Q1YCDp+Sy2MV2ABfae6MxZTSxiKaS8=; b=ntdb2C75sBzSDcwTCjPfqxEzx
	Dg/oyH3Nc4/Odted8x0BgR3Cipnoygk8tsAwTyL09w5I4P9F0JgUQHCsM3aiAs5dAMLkhBCtH5sur
	Dysn7u8R0nebvxsr7bL7/ut38RObb9MyuhdMcENL3ky3Of+cTa0zZaOkfZf6EftMr36a0gnjU6lkE
	Ut7yLbSkqrtuAokQKUezwXXSSM2qSd5BkAcjmZQs3yon6SINz/oNnxU+8SPbd+4HoWmyGEU5MgJVe
	UWIoLoAI+YI6byWPzlfXodVZdyzWpQIIUPP+ku3uLsIiV3hZVIiRaR4pGy7y1eT1b70PPF118OyqP
	FdpzGe+1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrI5-00GaAM-NB; Mon, 15 Mar 2021 17:46:05 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrHs-00Ga83-FW
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:45:58 +0000
Received: by mail-pl1-f171.google.com with SMTP id e2so10410952pld.9
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m0f19zo7fY6j16YcTDM4bl+phGjBvmUqgJ8R28qtAVo=;
 b=pwcJ96VNa8gis2REY7kFIb6+bvwTiBvQM4mpHHQJJbJBslKEmBXHQ6XPB1rg7sc5E2
 NUx4+5USyBu5lDDJc1Un43Koicylaqa/SwjuDPC36Pt8av3JUIRxP7FcL5bGr1vGp3fR
 B7PY1eHRG4LR5CIFn6XxA+XVZ7Ly7u1kKchy29onMNfZu98AgJAEbNam5zA6Z6mrUwd/
 P2XybDi0nquMx75Tf1qDl/6v8iBzJT/i/t9rL3oMaaXbDoXWKemnwe4ZBlZS4XgW/PpJ
 hNcFSIi3OPruCLApA3tF6akPjCcWQNBexxRwSqmmWP2YXT/oj4YPkcrHcNTZvXvG/FM2
 RQ5w==
X-Gm-Message-State: AOAM533PDvpcfn5PTQf9cxdWZ1ZSg1OIBp1VVwTxYpoeGCLR0ngZ7XNE
 BN0nTuPK5dVBDeeXfmB+xH0=
X-Google-Smtp-Source: ABdhPJwbfZp6glVqhWPJIwx9voNUysp9nBtjITswyQko/5OeYX+tmS3VbO/gVfptnLvTNGFTuRw++w==
X-Received: by 2002:a17:902:fe0d:b029:e5:ffb8:1c28 with SMTP id
 g13-20020a170902fe0db02900e5ffb81c28mr12508381plj.62.1615830350850; 
 Mon, 15 Mar 2021 10:45:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id fa21sm255762pjb.25.2021.03.15.10.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:45:50 -0700 (PDT)
Subject: Re: [PATCH 06/10] nvme-cli: add generic logging functionality
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-7-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28137147-9fce-1581-e55d-b190f7666cfa@grimberg.me>
Date: Mon, 15 Mar 2021 10:45:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306003624.21102-7-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_174553_473238_A269778B 
X-CRM114-Status: GOOD (  15.89  )
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


> From: Martin Wilck <mwilck@suse.com>
> 
> Add a msg() macro that allows more flexible customization of logging
> both at build time and at run time. Allow several log levels, using
> the well-known standard sylog levels. Also optionally allow printing
> of log timestamps.
> 
> Put '#define LOG_FUNCNAME' before '#include "util/log.h"' to enable printing
> the name of the calling function before the log message.
> 
> Use this functionality in the fabrics code for now, wherever fprintf(stderr, ...)
> had been used.
> 
> No functional change except changing the output channel of 554db7d ("print
> device name when creating a persistent device") from stdout to stderr.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   Makefile   |  2 +-
>   fabrics.c  | 85 ++++++++++++++++++++++++++++-----------------------
>   util/log.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   util/log.h | 34 +++++++++++++++++++++

I think it makes sense to do a wider sweep also for nvme.c and friends
no?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
