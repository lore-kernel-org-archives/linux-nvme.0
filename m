Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 05:36:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067B620722
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 05:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kq9uaKn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067B620722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PRBW9E+4qntP3z+SveVV3Ws9JjR8EGz6nDRwFqgyNxI=; b=kq9uaKn397b8NUTNNO3kwaKxZ
	yVJLLJSKRdwVkIhPic22gMQCtI4RziwllrtV3C1lx0jizwP0QADEXU8zPNBzf1RpvI3sQXWkeoVK1
	Ez6MRf91bTnkZxDFIQunWOgXw4m9IpZNWsINPLJtrz6rlDKU5etOFzqDEAIvuCBeoWAyyio5MLJvT
	rSxq5HAmDC4FdC56D6/6nPCXTQNf8UysvVm6HhsPhrebyJEs8zuZDCXltRc1y6+Ku8ebPPGMD57/T
	XNLx8FeqzbrCD3evIWVumCV2Duto3A/wjQIJgcxaGFGODeXi9kRjHP+toED4KQ18Emem6P3H0xvcs
	as4djuHCg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqVPs-0007wl-Q9; Wed, 01 Jul 2020 05:36:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqVPo-0007wK-By
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 05:36:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE0CD68B02; Wed,  1 Jul 2020 07:36:09 +0200 (CEST)
Date: Wed, 1 Jul 2020 07:36:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Message-ID: <20200701053609.GA28056@lst.de>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_013612_545471_7F6DD9DD 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 30, 2020 at 07:25:15PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small patch-series which replaces ctrl->namespaces with
> xarray for host-core and target-core. We can see following
> performance improvement when running fio with 32 parallel jobs where
> first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
> detailed performance numbers. 

Why would that make any difference given that we don't look up namespaces
in the I/O path?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
