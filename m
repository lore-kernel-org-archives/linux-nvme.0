Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068DC07E99
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 05:30:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A02E61042
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 05:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A02E61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZWpaOxJ0tReo9fR9hJEJvNknU36WgbRNn7MunDlfygA=; b=njCWU7T0TGeX4K
	teWWrwBh20IRaAxmTXU8ysH2haJPmZyqft9BjIzXa/gEnKHJXGf3tfxTuYiRitgQ+jA8PcNWLaul1
	8Ae8fa9nBFpY0r5q4wcxvFV2Kyatd/+ZAsPlMVOofWJdOnHa1eF6yMlpv01uD972+8pWJcP1ETVsQ
	71aPv4p/OsQZm+UJLvzbC35FR7lzODn9/E850AFWhlfrPLbF5YR1PN11IAp87hR9eu4j0Q+rIblrv
	6jgEk3dPBIjlcyW3DoEPInAgoavoxgEjNaF/6pUsjb4EhQEEZNt/6qrJX5h3EZlEs1Ibfqgg2V4PJ
	DOENZqsiR1oS9bbKmINg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2oWe-005vFk-PN; Mon, 12 Jul 2021 05:30:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2oWc-005vFN-Cf
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 05:30:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A48768AFE; Mon, 12 Jul 2021 07:30:27 +0200 (CEST)
Date: Mon, 12 Jul 2021 07:30:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 kbusch@kernel.org, axboe@fb.com, martin.belanger@dell.com,
 aelior@marvell.com, Omkar Kulkarni <okulkarni@marvell.com>,
 Shai Malin <smalin@marvell.com>, malin1024@gmail.com
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead
 dev_get_by_name for OPT_HOST_IFACE
Message-ID: <20210712053027.GB8599@lst.de>
References: <20210618133956.10637-1-pkushwaha@marvell.com>
 <20210624063551.GB26612@lst.de>
 <CAJ2QiJJ8cUL2fOfuYeLqa=LOvCBRgZ3wJ=-t4t7CL-xOpS2dtw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJ8cUL2fOfuYeLqa=LOvCBRgZ3wJ=-t4t7CL-xOpS2dtw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210711_223038_624061_D73AE100 
X-CRM114-Status: GOOD (  14.53  )
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

On Sun, Jul 11, 2021 at 06:47:37PM +0530, Prabhakar Kushwaha wrote:
> I am not finding this patch on updated "branch nvme-5.14" having the
> latest commit 0755d3be2d9b("nvme-tcp: can't set sk_user_data without
> write_lock").
> Am I missing something?  Please note, earlier it was there with commit
> ff5af4bfb6af.
> 
> Issue can still be found on the nvme-5.14 branch (top of the tree).
> Are you planning to fix this problem using any other approach?

Sorry, it looks like it got lost in a rebase.  I'll pick it up for
nvme-5.14 again.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
