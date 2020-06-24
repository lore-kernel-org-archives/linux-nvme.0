Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C390C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:25:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D328E20578
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jG32CjNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D328E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1gsrBNIKd6exh5bbyl4RIc0LRCGGf70nDDRtqqkqivM=; b=jG32CjNYYI41+cLkh9MwPyKKl
	Mjw2M/4U+nfAsz6fbLAB13QrR9ky9Zj/Rj7UFQyQvJWXYpDi7vvF2qLWKH+tfI9Y0fk6l2CvCFRgn
	hMMtb+sMEOnjBFKhTwSt2yhQ84c8aMYPljAtlTwTfIsWTa0yrl1+WOxG2VxMwc95WJW7kL1PXHXZd
	K8Ry+JKbpHQ8F/ZlV9XdmKZriwQPDC8HcMWdZku7iDKUixrFhOkLTD431/SvTKjpxGnVnTdc0EHSv
	AWTc03Atm+UTuERnW7/ogl4cFi5k/AO0yzGiITIpTGyE/nMone/IjaCeZMtcLTBlrGIrsr5qYuU8I
	6IpgK97gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joB1R-0000Iw-5f; Wed, 24 Jun 2020 19:25:25 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joB1O-0000E2-Ge
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 19:25:24 +0000
Received: by mail-pl1-f173.google.com with SMTP id n2so1443368pld.13
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 12:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqxHv6EUt/1Hjs69yPTwlNlJVhX8A0LwzLNhS3AQIck=;
 b=HG0dCCYYoD/1XEc4qpKz5jh3TWi2qZlLkU2yfb1oWrMViLT0KxiFUHr9UvZ4CXwUwB
 yWwB3RryBKvBQP722RPx9hL8ac1gMu5Aq/d1QjQiASy7WZ53vGXS0hxQwobHasMDOIXO
 FMueNgAnmecTEjHsgKXeoKdbKC0kIBU7197pb3T80iaTcLhzH/t1kFY1xYpebGVyUGvL
 SA4bI64L48/GdkHYZv2YLsjTl3qyL1R48IBN1ecnu053TUzXpMtD+9Fs6SE2DoeAG8RR
 /y6Hd3NyneRkUaN2pIUrMOzhykVf4dMs8JNDv0Su1d7T17/BuWBMP4WSlyqGnrudh0t3
 T5yQ==
X-Gm-Message-State: AOAM530SqLVJIbrUWauIGAYo1v3D2qHjO/qjGmUfwKUiNc3+bbxT72ue
 +dpyk2jq+/FUKepAI5Q99Cocm6+C
X-Google-Smtp-Source: ABdhPJz7TfqQBo6YAgmauAMDPfB36SYG/mrb5654tr/PORKyIf+dwIfeGHtk3hnKsQLVoYk1ZzTcHw==
X-Received: by 2002:a17:90b:1495:: with SMTP id
 js21mr29933580pjb.48.1593026721315; 
 Wed, 24 Jun 2020 12:25:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id p19sm20764184pff.116.2020.06.24.12.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 12:25:19 -0700 (PDT)
Subject: Re: NVMe over Fabrics transport requirements support
To: Alex Talker <alextalker@yandex.ru>, linux-nvme@lists.infradead.org
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
Date: Wed, 24 Jun 2020 12:25:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
Content-Language: en-US
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
Cc: Or Gerlitz <ogerlitz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Alex,

> Is it true that setting any value in addr_treq attribute of port in via 
> configfs
> 
> only affects displaying TREQ on discovery page and doesn't anyhow inflicts
> 
> "whether connections shall be made over a fabric secure channel"?
> 
> 
> I can't find much about whether RDMA(RoCE in particular) is secure
> 
> but for TCP TLS is must-do these days I think.
> 
> 
> Is this functionality planned to be implemented in near future?

There were some discussions around adding this. Currently there is
some infrastructure work that we need to do first to have a kernel
consumer utilize ktls (mostly revolves around the fact that both
ktls and nvme-tcp are socket consumers and implement sk upcalls).

I'm CC'ing Boris and Or who were very much involved with the
ktls implementation in Linux, they can maybe provide some more
input.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
