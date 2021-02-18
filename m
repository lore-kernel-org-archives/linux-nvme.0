Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E862C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 08:40:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F1060C3E
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 08:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F1060C3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z7h6CEKXaSZOJV3P4w4QkkkwuDyNwzQcmEIHGRWRHYc=; b=Lc+CE+Ytn7dU0D5jRge/3a0Bm
	uII2F99EMQ9+VJ9Vbu/AD0+BSD/1nfl2zkRx+Kf7JebQSlgLY0e6P0MITXhy2zz9N/gGTkTxe+OIi
	oucPjhTbj3CeBy8IqUQRcPkwVwBdWWRjTMci6dnld/3zlCnSiI4gX82ylWkaZlkPpTlOAdnMmkZyO
	2A+PLi8Lfv5vym01ZuXplM+5YAetDgSpa0bwx52/uIUde7OPb+117PIfafoxH405LfbKON/FtcquK
	upaTJSmnD4lM4BE5ikdU2QJU5kmVb87r8znLDqU5z2Izlq6cZ7MSu8SgZ86gfCdAI/NOIJfqmzpc2
	pRU7NXE0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCerE-00085t-2d; Thu, 18 Feb 2021 08:40:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCerB-00085R-Tp
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 08:40:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0BA3B6736F; Thu, 18 Feb 2021 09:40:15 +0100 (CET)
Date: Thu, 18 Feb 2021 09:40:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210218084014.GA17997@lst.de>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
 <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
 <20210217021455.GA2251@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217021455.GA2251@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_034018_131836_6B3CFB82 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 17, 2021 at 11:14:55AM +0900, Minwoo Im wrote:
> > A container could read data from namespaces assigned to a different
> > container.
> 
> Now I got your point! Thanks Keith, please ignore this patch :)

Note that Javier has been working on exposing access to namespaces
with unsupported command sets for ioctls.  If that is what you are
looking for.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
