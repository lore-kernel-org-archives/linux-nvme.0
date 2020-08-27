Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF2C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 22:24:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2724F207F7
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S1TAiLvb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fy3fdco4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724F207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g/JC459tbbg5MIQHqD1WD+obwQGjrqNzqTbRo43RF9E=; b=S1TAiLvb6RaqMMSAbNx0MbAJy
	ygjHNrgZjpj+yehLPjyOO5hJ0wD7PA4vrknT7494a0kHzeSuINg3MYIr9EKX4pNh9WedygVLEZy/l
	lqyAGjZVOhrAKoY85HZnondUHXaAyvZeE7KhOFC46lmW1XdMmIvzWPY2l7dYeU7c9TvHOdttTr/G4
	GVVlN/KAYO+iriZs+7q9xtwowwLKd+lJ6Zi8OajgSOAN8tb5hCk1pmPMYDCmH4LR1Oj1KtqirMR5O
	vVL9dp7zs3uvN8yKTGAcrz+4Ph8m8jRxwVeM7zNjE6ECiPQqEHqgFpm+RWrBy6PTcT/wOqAYu5YcB
	aw01dJa0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBQJu-0000zE-Tu; Thu, 27 Aug 2020 22:24:34 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBQJs-0000yk-C0
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 22:24:33 +0000
Received: by mail-pj1-x1043.google.com with SMTP id s2so2740238pjr.4
 for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2020 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H6QntW38gPEFwHNQYlgwHCDGLyNFBc96nik9uX9BQQc=;
 b=fy3fdco47vqzn6Vp73ftCFSlRR/TwRFupTxfCnAbsTdGR6I9mYuCWryGZO3c80pz4S
 4T806WeyV4cNhDmI6tK4MfMCYDYnJA5Wkf2U6AI3pg3VM+XdhFJXHKvdyquEx+MyeGqv
 F7Qi31R1JgG5wfKBaaIHFSvXJFgYyvgfnfBQNmT5hdL0RCeYZ+aeOdqkgWwjJK2KiD97
 Pc7NnTTJa25gdhOa8bKABjZOweSOToyB+gRBf6ZG4p7qvN8xoiQQIXUkeWQFRPpYf2Ef
 yd5f4yLzws3bafbG9mWqslxyfr67d/ZLzqz/iwwDs8l7FuOJQEvdqLmVWzuoYrmbKiHS
 I1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H6QntW38gPEFwHNQYlgwHCDGLyNFBc96nik9uX9BQQc=;
 b=Kbf6ocyxBY9wFBhEqIgLmOgT/MxInGXcJKCfqGBSBdMFL3SbVvMbUnq8S2K754jD4I
 l7V79J3VkaknrfkK7CKQL93y53eakMXyfzjK6qeuEgS5i0q2Ln0tL2irtdro36GEJBI+
 mKUBAWrAwSRy1E5k1+0fAAb0vKdXcTVbfdjdLJgI0uzKWpqAAkDTGVWDoPwbF9UjxbYw
 TN1ciJODHjaLPM2SXI624KNvMyTr4SQigFPYUTsIXBr6zfk45dg/YMZ/bje9CXrQMgGy
 U2EtI1pZpNLr/RILlhVF188p0HgYtB99CNNV2mf8xxRJqbAdaaT5fIRFYEX0OB9PWpro
 A23Q==
X-Gm-Message-State: AOAM533nNrMexUDbp4i5acCuMdBASoG+wdV90v9Me14mzjATi3iYNcBH
 D9aR72PGmUlgFowFGcLtclkA8w==
X-Google-Smtp-Source: ABdhPJyex7VX/0Dwiss/Xy5cPP4DMJKk2VdoL+5nqkrPKczwEG4oAtFI8PivgW6H7ExeajXGKD2BmQ==
X-Received: by 2002:a17:90a:c242:: with SMTP id
 d2mr837790pjx.218.1598567068630; 
 Thu, 27 Aug 2020 15:24:28 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id l19sm3724378pff.8.2020.08.27.15.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 15:24:28 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: api: fix kobj_to_dev.cocci warnings
To: Julia Lawall <julia.lawall@inria.fr>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2008272211260.2482@hadrien>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <68701ff1-bff5-c3f9-a970-fb7670ac112e@kernel.dk>
Date: Thu, 27 Aug 2020 16:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008272211260.2482@hadrien>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_182432_516718_1FFF041B 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: kbuild-all@lists.01.org, Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/27/20 2:13 PM, Julia Lawall wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Generated by: scripts/coccinelle/api/kobj_to_dev.cocci

Seem to see more of these, these days. I don't really like them, why not
just use container_of? The private bla_to_foo() helpers should go away,
they are actively hurting readability of the code imho.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
