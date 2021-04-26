Return-Path: <SRS0=AvHe=JX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25322C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:16:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65866127A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Apr 2021 15:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65866127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MSvmASNJQIvrlrrwRS5WcUoaQ5/3fHWwdeBBo7N8Stw=; b=ktkbFUoC5by3ASev9EaH50tt3
	S+gixlSslU9pMUlDtlulOociUgAzWpJXYvoJM0cxc6cnLvTpx+1pOah41tWpLY2CicJ2o3GGKRGz6
	a5BKpaSPOSaqntrJ9MeRtiaLc/HBQ75Um8GcvRSYgB/EEVSGbAW59gZ5tCkmfkkH4OCIMRUtKehab
	G/yudBGrZ4EigegMOk2QlX4eJ/7p1VO29QexLCrl7i/EAKgBm3EMRKQnvd9abim6UGsb4VGJRH7de
	siA1nyEijz6zZ9ud1zw6L0Y/hh/9+bsnL/2JkIVKCR+v6UDoMaoOF2mN2S8XqGPBRiL7KkdbOvi9M
	QKrcbwnWw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lb2xe-007wZv-6b; Mon, 26 Apr 2021 15:15:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2xc-007wZm-Tg
 for linux-nvme@desiato.infradead.org; Mon, 26 Apr 2021 15:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xEjo+0o+oUfDviPJHCpq5Amdiuu479DJ39vCTdivr/Y=; b=aTVnPW6yPR+N/KPub2/c22dbgJ
 EgYP4FKw6qZ+Q1DXZzbjgqDM0kwvMxAbkFoep7TNY7nMYYEsN8iyVFJA0kEOBDJzejvn+x42it3hE
 h9LsASLk3o7CIVlEEGAxW1VNFAtaBAOgp+18x1r2tjSpUzJ8FiEDgUdgLEL3zrkLBO/7J/NZwpNd3
 cs7pMFgd33AQr7Q9EDf6fL7/KH4DbCmDc/QwmWhHyMM4AnEnbVqN20+iYvf+tbZWgRns5TVpn0cnY
 Gff34cjeUzvEBWSijQPuz1Ab2+02HTFdtU+IOdvYHeclrYZMSFUScaWQFxNkxdR3CHVgTGaQgOZAl
 7xqYHNwA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lb2xa-00G2XR-H0
 for linux-nvme@lists.infradead.org; Mon, 26 Apr 2021 15:15:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0024D61178;
 Mon, 26 Apr 2021 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619450140;
 bh=TvfpsmgvZ2FA72prfYrnZr+UaAU/xsQv8DOrfXFrwVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tK4M+enpvQz1JSFUzCh1M0CnaG7unwOhtVrd9dKAVaF0xAyc0lYwyaVRog4aTSrol
 5ArkX4XPy5OXVB2s7J22o7KdULLYhzIqOkt4ZKRJ925XpvIvLGEZtqtykdR7WSjsk5
 yzhC21IFthMkU2yGpwc/LagALhJHSGnP3tjgbFFluvMMhM3GpZ7HSHOxdmvM1xWiCi
 EtNauQZiimsGJcd0RSZyGbAo04AWoTI0jpppx04XkeNceHB3nB21l/ZWjXM3aUoJhw
 gYIGZcuVMi9EvrJpfb8OjDQidtobz/PRay4y1nNtTlglsuRGem/SGZr+SY7XCwHO3O
 wmmIDQ6OF+fEQ==
Date: Tue, 27 Apr 2021 00:15:37 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 linux-block@vger.kernel.org, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210426151537.GB12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210423220558.40764-1-kbusch@kernel.org>
 <20210423220558.40764-6-kbusch@kernel.org>
 <20210426144316.GE20668@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426144316.GE20668@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210426_081542_615564_06E2998F 
X-CRM114-Status: GOOD (  14.60  )
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

On Mon, Apr 26, 2021 at 04:43:16PM +0200, Christoph Hellwig wrote:
> On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> > The block layer knows how to deal with polled requests. Let the NVMe
> > driver use the previously reserved user "flags" fields to define an
> > option to allocate the request from the polled hardware contexts. If
> > polling is not enabled, then the block layer will automatically fallback
> > to a non-polled request.
> 
> So this only support synchronous polling for a single command.  What
> use case do we have for that?  I think io_uring based polling would
> be much more useful once we support NVMe passthrough through that.

There is no significant use case here. I just needed a simple way to
test the polled exec from earlier in the series. It was simple enough so
I included the patch here, but it's really not important compared to the
preceeding patches.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
