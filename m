Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B24C2D0EB
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 04:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3F520732
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 04:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFa12byF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3F520732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0tiGTpyWL853HEemHQWTJUCyNgSMEZYhnH6/+TzU9VM=; b=BFa12byFK5Y9T6yVrkqh8JP4P
	zO03EkFPD/30iQJkmOZPBl3I1YHfhzTzVx9CBev9akJva+cibKG+SS0nIyk/8IHfkEUlFbfsHPrBG
	YyeU0olKrCblqxuTxw/CyV2GuIRtyXcd89ogMNCn4aZYLzeNWtoiohFZFMZhm0izUKa5qiHnTeFWO
	uFQ5Iv4eG6vSbS55lFYm5L1eN1FqGlgHTINSwhPElI/KrNgnVYb6u+m4PV/16S32omRSAdgkj1oob
	IjCdHr2hvS+pKNhBV4jawTtKzO8IIJX56wQ6MsCbjnLt7z4NxPKmcN3LZ05aIM2bvhobgid9b9q9q
	Or9Zi/h6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jImCX-0006Cw-TB; Mon, 30 Mar 2020 04:39:05 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jImCW-0006CQ-3J
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 04:39:05 +0000
Received: by mail-pj1-f66.google.com with SMTP id np9so7035043pjb.4
 for <linux-nvme@lists.infradead.org>; Sun, 29 Mar 2020 21:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gPU77G2FE4lT9YIrWcmhIDNMXTdwhEad6tRQu3Tddd8=;
 b=Dp6U/RJqeYOGJML7kE8mNPnLjhnpaZMaY8DX+evJoya7FbX/j40JyWurJxZtH0YsAG
 MWQDxHpWnl8m5WbVrTYhZYvHTEbkuw+strezqC4ovicg7yQV72gNMfkRUc22Fupv7Xal
 MHZAB2TtfzTyDEzEjrVwoC6pOXV+gjytuKe0/gqIzDwhW98teUTmP4lSCf5sGPo+TaaX
 evS6olBX0zD5NeuBlkhkrDe1g4m2hXhQ2OXuY+rgqhBr8oPYsmDry7uZpGUa8bBqqTDL
 O2K+gpJpARGAv0HoXb3kUugRcJ0QLcSRJlQZGiQt8Im0tsITHQlYnOFwajIHnf/1+FdH
 +rTQ==
X-Gm-Message-State: ANhLgQ0a/CfaIa0x6fcThB2XxQB3PHKELUgdquLXVBeig5LohUPCBIin
 zEcv00X8bkCgL0uJulEZ0tnFDUQG
X-Google-Smtp-Source: ADFU+vv7vtQQ8qQUwIZ5xZGrDwRsw+ukfgiWJKSnUEoq28jqLkNzsuWlS98QmjSR55ntmhjW405/fA==
X-Received: by 2002:a17:90a:e50e:: with SMTP id
 t14mr13255353pjy.98.1585543142957; 
 Sun, 29 Mar 2020 21:39:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8cd5:23c1:2c2b:d926?
 ([2601:647:4802:9070:8cd5:23c1:2c2b:d926])
 by smtp.gmail.com with ESMTPSA id u18sm9163258pfl.40.2020.03.29.21.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 29 Mar 2020 21:39:02 -0700 (PDT)
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Anton Brekhov <anton.brekhov@rsc-tech.ru>, Max Gurtovoy <maxg@mellanox.com>
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
 <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
 <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
 <CABY-YC4jSOZJW2zEx5dS9BRj8+ipNF5aF_0cgkuDo9oaLbhvew@mail.gmail.com>
 <9024d7bc-d55d-06c1-65b3-61027f81fda6@mellanox.com>
 <CABY-YC7yGBk5xLpxYHUW_sRO6LspRWG6sMc4To1uggkXPjBvWQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a82f314f-f294-3cc9-5b94-f550c0538297@grimberg.me>
Date: Sun, 29 Mar 2020 21:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABY-YC7yGBk5xLpxYHUW_sRO6LspRWG6sMc4To1uggkXPjBvWQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200329_213904_145008_1EA4763B 
X-CRM114-Status: GOOD (  13.69  )
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
 Konstantin Ponomarev <k.ponomarev@rsc-tech.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Then I'm afraid that we can't reproduce this, cause we use Intel omni
> path drivers that is not compatible with the latest version of the
> kernel.
> Today we've tried to install new version of kernel, upgrade to Centos
> 8 and 8.1. However nothing is compatible with our technologies in our
> HPC cluster.
> If there is any other workarounds or ideas we would be happy to hear
> it from you.
> If no, we'll stay in touch when will be upgrading whole cluster.

Given that this is 1 RH issue, then probably you should open a ticket to 
RH asking to backport a fix or report a bug if it still exists upstream.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
