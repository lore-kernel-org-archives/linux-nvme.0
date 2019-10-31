Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86369CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 14:43:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5427120873
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 14:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HQlcz6rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5427120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qj4aF38BF/fi5K92Xdd0EgA6Rk4OYa3VdeHwDdFYYkU=; b=HQlcz6rXfC6m+P
	bQDEzLc2mpo16VVn/MeCykPuwQuMJehyF2NOTqqWEo4+Ar8kj77rWb4lxm17M1o1VBxShpmhzzyme
	lTKBaQRWiMUswRJ3vp9jM0hWxhQijF9PgunRzVUR1GxhzsziiAfHr5B89TCcewzaEB1QzR7/Wq3ne
	F0tPuWWqTo4Pz8meZwokmlPBBRLHDH2JVbeMtrFyyiuWQQNh2d7MSPsJ66ktHMTIewqiS5l8nrDVf
	59lzi1CKHy9KtTDsutzCoADujJeERla4VGeGTpIiS41xEXkMK1utcvuPNtS60J/jyV38NyM0JeVWt
	MRiDEGLOoZY9SAC3KrvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQBf6-0005us-KJ; Thu, 31 Oct 2019 14:42:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQBf3-0005uA-7n
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 14:42:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BAB5168BE1; Thu, 31 Oct 2019 15:42:47 +0100 (CET)
Date: Thu, 31 Oct 2019 15:42:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: allow block device to use buffered I/O
Message-ID: <20191031144247.GA6024@lst.de>
References: <1572409583-3109-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <20191030063609.GB16863@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030063609.GB16863@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_074254_648146_DE358306 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 30, 2019 at 03:36:09PM +0900, Keith Busch wrote:
> On Tue, Oct 29, 2019 at 09:26:23PM -0700, Chaitanya Kulkarni wrote:
> > NVMeOF target already has a support to execute requests in the
> > buffered I/O mode with file backend. This patch allows=A0block devices
> > to be used with file backend code so that buffered I/O parameter can
> > be set for a block device backed namespace when newly introduce
> > configfs parameter use_vfs=3D1.
> =

> Is the fs overhead so bad that we can't just remove the bio based nvme
> target? It seems low enough that having a single path to optimize is
> worth considering.

Once we go down bemchmarketing for latency and iops it matters, as it
is significantly less code and cachelines.  The actual I/O pattern is
the same, so for more usual setups that do bigger I/O or have slower
devices they'll be mostly the same.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
