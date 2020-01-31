Return-Path: <SRS0=aqmC=3U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5924DC33CB2
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 05:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAAE20663
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 05:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBc7Nuxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAAE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXAtg4IUoRwGAQexx5piTzIQGwaT1NIREIAKzLDGYFI=; b=sBc7NuxdGNwyu5
	v1B9uFH1IyaryDVkHoRwKPjplCFlhD94HuagNqB9rGpRv4oCJ4n3+IyiRUCVcNJ3BI4WnN2fEKItd
	famugVOMY1VwSYJ+0SOQN7TwQvB88NBb81/kCQNk0HSp6/wdJB9RlGaF4YjdL5fY/lb9IXB+MNyrX
	4Tn0mgUeh74tOAQCT51qSyitx5CIP7Sk3AqfihOsrp3D69UdN9lnpFK7c3AlI9pSJ5mO1sABitUdK
	MZinbRYGgwvglnFFuXWkxBiRamna2voKyQtlOp5zbXTCv5A8Kvvjioh9d3qyTxFmB0qOu9WzAcVx4
	3+Xi3s2RTcVjYLbBN5ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixOg6-0005nl-St; Fri, 31 Jan 2020 05:17:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ixOg4-0005nO-Mx; Fri, 31 Jan 2020 05:17:12 +0000
Date: Thu, 30 Jan 2020 21:17:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>
Subject: Re: [PATCH 1/2] nvme-tcp: Set SO_PRIORITY for all host sockets
Message-ID: <20200131051712.GA21501@infradead.org>
References: <BYAPR11MB2712EF82675196E33E29A422E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR11MB2712EF82675196E33E29A422E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +/* Define the socket priority to use for connections were it is desirable

This is not the proper kerne comment stye.   Keith, can you just fix it
up in the branch?  Same for the target patch.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
