Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30680C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:51:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0A02080D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mIiLNGoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A02080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QX536hrwp6ADiY19AT0+mhLHKuuJy8QVG+7PzjvdBc=; b=mIiLNGoW2PRiBdn1tErFecIRQ
	8WCt/QPOrYw8EBPwTuZSV/xJZ57KUlNxODV+VU1eXb+xmAX5+EiOi62HS0cS5kdVRMEICaqTua3A1
	G/2RKNPvT81Zf6vwwmjBB7CIQS2GiuIVliZ57+5KXbDodzAf3uGweOuA1uuuX3YJhwYPlQOUQeiIZ
	oSG/+wvRBbqvjK90ezo1lmXHRpHCxELXgMZ8uk6Yp8a7DK/eDKuPJMeYG+fKJ7nzzLJBalXyBEWNW
	lfrGgzn4EGw46Fvaep62gTNHWJeR2hXEMxaWB4DNueAa3yay3pjTBTVHIj+LZp+7uSmrfvo0eGPA8
	KCBCSXDbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxbp0-0002Dc-Ur; Mon, 20 Jul 2020 19:51:34 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxboy-0002DC-Bv
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 19:51:33 +0000
Received: by mail-pf1-f194.google.com with SMTP id 207so9575198pfu.3
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 12:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r9feMsWD+irIaN7WZsInShVxKyGp1uWME6Arz8tAiLI=;
 b=N+QXI5N26q3A6Q4lNE8seTds8o2vsUfUma6kSgV8DYZ66QVsuncIYwNfiHLSrLEX7h
 P1uJ/4+qdxQURMpIb7Xlewd4t3fg2+BLNEB+t/bQYOG1D1kAyIo75m3P3zoc2PunZCXw
 o/OI24KWtBvSeYVh1kwKofaaHkB301YnQ2U3NQkDflw9ieVQTmAy7wV660EaHi96xGQ4
 ZSuecl5boITOwnXfo9mw4Odax9YY3J8qmbMnANjpfswQZ1cAYmVhA1fwO4Dx7OhnmQj3
 h6DTp7cZOZzLSefaPbiyZJpQOmwIMJUHb861XuAn+tCMe8CGDGIOcLaLMJvZwqnzl0Z9
 Gq+Q==
X-Gm-Message-State: AOAM532IFcWFkd089cVo4IgdQPp9TV8A1qGznlddngr81sTruRv9xpzo
 nPWVIzTkBI6HNRZcrHj4RBJhJ5Jm
X-Google-Smtp-Source: ABdhPJx669V7yXGRMvYNj5c6EXph/33YSmClEMHcH7Z3cRy/Zv8Li05wE6a7QqZe2ATKhvziFwIsTg==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr20523562pgs.60.1595274690891; 
 Mon, 20 Jul 2020 12:51:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id y80sm17324916pfb.165.2020.07.20.12.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:51:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix logic for
 non-optimized paths
To: mwilck@suse.com, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>
References: <20200716195929.28399-1-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fcda06a3-ac59-60dc-7200-ce22b9c216bf@grimberg.me>
Date: Mon, 20 Jul 2020 12:51:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716195929.28399-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_155132_433440_05A95BE9 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: marting@netapp.com, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Martin Wilck <mwilck@suse.com>
> 
> Handle the special case where we have exactly one optimized path,
> which we should keep using in this case. Also, use the next
> non-optimized path, not the last one.

Not sure I understand, does this patch also use nonopt paths if we
have a single opt path?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
