Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE3C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:15:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA51B20738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1UWVuBrc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tLEYjKPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA51B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AM+U2an7Sfbt/QlSn5o3S7APbcu5F56dBsGaLE/7Zgg=; b=1UWVuBrcS11qp1EUuteGBvY0Q
	9jobhZFVjje4Fza8kht2QCJuxdpb90jMzGY3ZSyaiOA7TiGHQ+m9qlvQhQA3yMr8sGQRR3veUeK1A
	N8xXNXqAvuGxv1QO3qa1KLYQzHU3A5edRKL5+IDFHUGRHb1is416dk010vLaEC3Q4KSgCNpVsKb6T
	sd22rmyWRrh5pcr4AJEzPyPY7NN0ShZ6yFivaJ83QbIjpgxZJ5Fpur04iM+7ejEyfzzal/SLbGtJy
	NgSfXKFfAH+OBPqQNRRPfVbU3NMxDocLgicQp42hYXKI3TLejIszJKNgajgVmy6tiTSqrLoJVvztO
	ey4+qrNLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aIb-0005co-7S; Mon, 17 Aug 2020 08:15:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aFq-0003vq-B1
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 08:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=X8W6PqZfzZLTtcnmsFrRFLEA1W9mfaVEDzBIsw7x3GE=; b=tLEYjKPMnWir/BKka6LaSAXkRK
 Sg1TuETo6RW9MngxjBSGhCTEjLz4AoLvjuvt/mMWgk3f817loO4o0EkxnwgB/i9cxQIkDH184eBTz
 n6Mj6Yebn40qcaxW1lSx+NEehGOOTCRf1EOD30gruE31EQQ682QKF0gEShmtOJNQofQIFL08vP1lA
 ipuLBvCIqsV3QphoZb+WtxgJ99HmKId2H+3hIlCwQK2doiumC4kaZoQpJGRnc7SCSnXwFRCuJXQsV
 bnh4BHyS8uK1AVw8tZIpJwU8pLKMIMKXUIeYaxusfcuBsTTdt+4Kic9iFcWAp+nvwQx0FsF1SO5BZ
 MpuGZkSA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k7aFn-0003j8-QI; Mon, 17 Aug 2020 08:12:27 +0000
Date: Mon, 17 Aug 2020 09:12:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200817081227.GA12680@infradead.org>
References: <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
 <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
 <20200815070134.GB20460@infradead.org>
 <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 "Engel, Amit" <Amit.Engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Anner,
 Ran" <Ran.Anner@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17, 2020 at 12:56:47AM -0700, Sagi Grimberg wrote:
> 
> > > > Amit,
> > > > 
> > > > can you try the branch below?  Pretty much hot off the press, but I
> > > > think this should address your problem:
> > > > 
> > > > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix
> > > 
> > > I like the approach, but I think we'll need a bit more path awareness
> > > like we check for available paths if we requeue or fail..
> > 
> > If there is no available path, nvme_find_path will fail and thus we'll
> > error it.  This is the same mechanism as used by
> > nvme_ns_head_submit_bio.
> 
> nvme_find_path will return ns=NULL even if none of the paths is LIVE,
> but we want to requeue if we have an available path (e.g. ANA state is
> inaccessible temporarily or ctrl state is RESETTING/CONNECTING).

nvme_find_path will return a namespace if there is a namespace with
an optimized or non-optimized state, and which does not have the
NVME_NS_ANA_PENDING or NVME_NS_REMOVING flags set on a controller that is
in the live or deleting states.

And that is exactly what nvme_ns_head_submit_bio relies on.

> Only if no path is available for request execution we are failing the
> request.
> 
> If we are providing multipathing for reservations, we should give
> the same efforts as we do for normal I/O. This could mean waiting
> for some indication on the ns path states (wait for a completion in
> nvme_submit_sync_cmd_disk and wake it up in nvme_mpath_set_live).

The only difference in nvme_ns_head_submit_bio is that the bio is
queued up if the controller is in a suitable state.  But that isn't
something we can implement for the passthrough path as we don't have
an inidividual bio that we can queue up.  Note that not other retries
are handled by the pr path either, so there is the need for some
amount of retrying in the caller anyway.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
