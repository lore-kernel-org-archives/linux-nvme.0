Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE64C282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:02:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D1220678
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njIbWpNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D1220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UJsleKByWrpwqaZX0DrUK0JbUOx/scLNmGmR3nQJzaA=; b=njIbWpNTNSGhFo
	OtCz7rFb/TnxDGDYgY3CEkGot8qwmphDF7Yr4mVy9bm3w4gQXO2sONfn7nM4v26p0bVnD/vwVrgxa
	mYGY4Wnq3kY0BWB5+PJFM6ywTMRTTQ8NFWF/83wao+A7f8//DIl2wed+FEtldo47TqRls/G1FfZjy
	jWi5cTw2K106iJUCD2dtIHE4MJFSdfavdz9WQSUsCKBHdccTskRjSS/FKlsrSytgp7aORpThZEXFG
	1ibwcQOSLcBvkysiZvK8YZS5Vfu+pbRirLJ6pUcV/tZnF3gIPJRsaDFp0zPj+XPzf66qYVcOTvTMW
	qMxO1Me4BBQkjZ+TZGbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipCrI-0006aM-2V; Wed, 08 Jan 2020 15:02:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipCrE-0006Z9-MS
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 15:02:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5230B68BFE; Wed,  8 Jan 2020 16:02:45 +0100 (CET)
Date: Wed, 8 Jan 2020 16:02:45 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
Message-ID: <20200108150245.GA10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-2-sblbir@amazon.com>
 <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749EE1549B30FCECEC1154B86230@BYAPR04MB5749.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_070252_882156_94C6C291 
X-CRM114-Status: UNSURE (   6.77  )
X-CRM114-Notice: Please train this message.
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "mst@redhat.com" <mst@redhat.com>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ssomesh@amazon.com" <ssomesh@amazon.com>, Balbir Singh <sblbir@amazon.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 03, 2020 at 06:16:39AM +0000, Chaitanya Kulkarni wrote:
> Since disk_set_capacity(() is on the same line as set_capacity()
> we should follow the same convention, which is :-
> 
> 1. Avoid exporting symbol.
> 2. Mark new function in-line.
> 
> Unless there is a very specific reason for breaking the pattern.

Why would we mark it as inline?  It isn't by any means in the fast
path, and there are no easy opportunities for constant propagation,
so the only thing that would do is increase the code size.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
