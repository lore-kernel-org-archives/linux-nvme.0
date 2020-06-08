Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6068AC433E3
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5E22053B
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B8wbzHlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E22053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sZmojqNAD/IjM53jEK2cCODv9u7JQUNSR/QKvdEDZBI=; b=B8wbzHlO9VFTkAFZI+SpjnnYs
	RqHWFyJONqB/KBHokSzPH/yxnXAWFOt1lO4iOZanr60S5UwLVhsJW4druXk5NNBV+ZQakm2Ss3n/l
	5h0hEwDWT1qSKAJGxyLCHE7XDM5fq4A9YCT0CBpVd2gk6fF634qEPJJUoPddqRDaH9sEzj1NeB7PJ
	R+A4X9o872OU6CTme3LfxiJwyXdlhZ5becjGGhFCrffwpVNmEbVMKt0ZgPNLi8EYmPsvyFjHkpPQm
	TGKu1vhnMsxE6np4SaM2EKQkFched/lqicwEmv7Py4KqznyzmO094sk2zHqKnKNpicFtu0qpuQoa1
	69SaAC8Ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiKic-0005Yf-4c; Mon, 08 Jun 2020 16:33:50 +0000
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiKiZ-0005Xn-0D
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 16:33:48 +0000
Received: by mail-pg1-f179.google.com with SMTP id t7so9003618pgt.3
 for <linux-nvme@lists.infradead.org>; Mon, 08 Jun 2020 09:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hykB/JpGC5RWFoK9p5Lc2COHbAX6bTmlMCUqo+DDdg8=;
 b=YRcljSIFMEugYFmsV5OTlrx3s20U7aN7d9B/tQiFI4qS2R9Z+dTIS9kXyP9Ow3In6L
 NoaU6ex+4jfvmrqHdVTNo3Sg3mPxbnWBFj0XVRJpHFMrN5myJ3QgfUBitwQoOwbsf3Nq
 Bv8COKtfCWqX+iQ1FHXg2yocslSIhLNSRoL2XYqEmJm1xKwhvL4gEpbRnLz8c+oLM9Ao
 MdL6Lw6UT/2Qk9Ug+mA/f5aIggrAz9XnqO4hSBKnT/iAojpl5yjALGw0s7/amcQfyaC1
 j7ntWvNcc5B4Fb/Pdoi4+MYkytJtthSsdS6NM7csbsreoQJwNkFyy9B533oeQTiCNU49
 8S4g==
X-Gm-Message-State: AOAM530Ctj1NHTW9w1ZaPLasHepbrtRlgYsZKiVGbASUzAq7Vij+5wSz
 rBqL8+knNs/DNXByPydBSmg4D6/7GK0=
X-Google-Smtp-Source: ABdhPJzbd9Fzvky+QGLXlOOy9lYD887PkIPHjAF1iqdWjStOeOhs+gbSk6sDs6fNQVEm9v+JFOcxpA==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr20091790pgi.384.1591634025070; 
 Mon, 08 Jun 2020 09:33:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5183:321c:38f8:ee16?
 ([2601:647:4802:9070:5183:321c:38f8:ee16])
 by smtp.gmail.com with ESMTPSA id d5sm7787840pfd.124.2020.06.08.09.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 09:33:44 -0700 (PDT)
Subject: Re: blktests test nvme/003 fails
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
 <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965217373E87DFEE2398D3F86890@BYAPR04MB4965.namprd04.prod.outlook.com>
 <96530c68-0cc0-8b88-4d3e-c2a66be44167@grimberg.me>
 <e110c297-a357-5e8d-754b-09a5faec7399@grimberg.me>
 <BYAPR04MB49658EAA5D722230E5036DE686850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <d3a692a7-bc4b-215a-4d02-a6711d542d97@grimberg.me>
 <BYAPR04MB496561CA8847308360CBFDA686850@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6aae715c-0b00-34a2-c66f-b0b907e1297a@grimberg.me>
Date: Mon, 8 Jun 2020 09:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496561CA8847308360CBFDA686850@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_093347_042620_2854938F 
X-CRM114-Status: GOOD (  11.17  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Wait, that was the bug I fixed from initial patch to Bart's original
> email which was running while loop infinitely since
> ctrl->nr_async_event_cmds >=1 and never could get back to 0 due to
> outstanding AEN, are you still getting that with following fix ?
> 
> With following fix I can run blkttests it does pass and only generates
> one AEN from target side :-

If you tested it, I trust you.

Please send a formal patch, and add:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
