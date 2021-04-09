Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D5C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 08:06:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B9C610FB
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 08:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B9C610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gJgfrOf5B+jIqkl90U9u5iaiZwHKaZ5ejViwrOkyH2c=; b=WHdCxE8pV9YB2kI2tNnbguhwM
	1DEkcWAkDJQQ0lQQ5VIGPaz/9g4qbvN6eOk7jU5sxTID+z4stY/GRTOSgySe1eZ5F0Zz8HoF8rH5w
	iNvBE1DPpYZ5MTPvVTKJcSIgswqXFh74q8mv5hoq4aWCzek6HdOzveGa6cwnJcpWoGowny+na/jHN
	pYGH7Q2lm9zCRxxf0qe9XEsTE+2ZtL43jzT65uucAwAq+xmcklfPms18duVJ6I9Cvrc2dy69mgBWd
	u16wRVhlv8SpPqcP9E73e+mMTCKWSy22Bz5m4YSsV4tu7leHZQcmb5CFvK0M5zgyVrA/DygI/rFiR
	CDPhUsMVw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUm9M-00AXrS-GN; Fri, 09 Apr 2021 08:05:57 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUm5q-00AXZ7-TH
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 08:02:24 +0000
Received: by mail-pj1-x102f.google.com with SMTP id i4so2502926pjk.1
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 01:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=qUpyDqVFjLT5vOVHDTo5o7tEi492n1FMxNBtjaCFJNI=;
 b=fzYrNJ7SIlYI4XMPShW1Yh48LOPDGj/X2PMfIdTNoOpTzsWiPG7fTe/y8xPgb+/6ja
 Poqh36FB25djMt4y4VgUCrTgoap9nmZ6YRZoQQArq5Ge5gXaYX8JfHHD+pqeAaArIHb2
 NWGUS2zKPdCSkmmNbvnVOiaE4CWj/XN+DMtOVzrf2pp4s8+AIl7/SzCMoylir080ijwh
 UFv67cvx7/6kGxNSlxVFSIQddxJg/EEvzVSbLHm9CAGgG49/mbhgR5cQQRzk4BADE1Yn
 c+h2AL3RxApCzsyNFgWlFTV7694ajcriliF+Ih6a+0jDbUDdudi0A9oNuAu3LbnMvFM3
 8SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qUpyDqVFjLT5vOVHDTo5o7tEi492n1FMxNBtjaCFJNI=;
 b=J6rrQO3IfIp8kLR0aZPGjNvRvvoD+K3lUzBxvbUCLZDgDA5XhUGJyYZSTEcYlsSMU/
 b0H/zh8qz47M2/Ru6NlGHZstByXX7mFAUjW/MgSqocgGQs1sL71EMEOpB0iDz/SDKFHB
 YGkVGvNtospWADmv61V44jTv1gDFaGbvTKRomm4dyVxXmrjQI/FYGMXkoRvE8l1GNVjv
 4FKmIjnegJgX8GW9yjZvLFYq3jakSDL76nqdCMxT4IYqfb215gdCriLtfO5EH5e9yDvQ
 b89k5rAsRKD3L/+Jfi5c9NG+2l7UeGkhkgJsETnsBKmdMWSBu++nCTlSnjcA/LnLqLhA
 zxBw==
X-Gm-Message-State: AOAM530/2MFu+9gFHBQxPPT7KTin2ZQGUfNhS8tpR/zoq3lHWjEF7NGr
 0dQIK1HwBwqXyIpbphupDUfsSh+C+Q0wIA==
X-Google-Smtp-Source: ABdhPJwPeA1BIRW7HP8j6nyhrO2swu5ljd3j4wLZAVTUTjGfTW1Q7qogMI67SfMOLPdr3hO28OXI3A==
X-Received: by 2002:a17:90a:d345:: with SMTP id
 i5mr12473395pjx.107.1617955336717; 
 Fri, 09 Apr 2021 01:02:16 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id j3sm1560323pjf.36.2021.04.09.01.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Apr 2021 01:02:16 -0700 (PDT)
Date: Fri, 9 Apr 2021 17:02:14 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 13/13] nvme: introduce generic per-namespace chardev
Message-ID: <20210409080214.GB2085@localhost>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-14-hch@lst.de>
 <20210409072901.GA2085@localhost> <20210409075415.GA6991@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210409075415.GA6991@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_090222_369497_6C733F0C 
X-CRM114-Status: GOOD (  13.90  )
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

On 21-04-09 09:54:15, Christoph Hellwig wrote:
> On Fri, Apr 09, 2021 at 04:29:01PM +0900, Minwoo Im wrote:
> > Tested with namespace-specific admin commmand (Identify Namespace).  And
> > it fails with invalid IOCTl because we don't have a route to the
> > controller IOCTL for the generic chrdev.
> 
> Yes, that is intentional, as supporting the per-controller ioctls
> on the per-namespace devices is a mess.

In multipath case, head blkdev is also per-namespace node which is now
supporting the controller ioctl by nvme_find_get_live_ctrl().  Is there
any different policy between the existing blkdev and generic device in
the current series ? Or should be just deprecate the controller ioctl
from the head blkdev ioctl in multipath case ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
