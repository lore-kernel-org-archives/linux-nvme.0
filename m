Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E0C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 08:27:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7746191F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 08:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7746191F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SN1JTNMnKYkSUxmUPn8Q8MvTuYZDxwDwqn7ylGmrP/4=; b=pG1IoJxRP8yp2eyxCRUycxCPb
	OV+UVoyF7LF6pSZaix5FRMaVveZGch95txGgCNMnbLDcd9G6msfS04OaKDZsdgilOzLYLqSWYQzVU
	Zs5aFrrq/uUmBB2QYzeLzWIvnqd102EAG5bR1SDwoeWu62g6H8U3yxRCGMqgXivTGUv9klV8iEfYo
	Fq3RPf5L9ZqyKka6JGDcGhicb+Xjs39b4SHlAMiPnRDOJoMdJ+aEd9l+rIHMxAZVmxvGXzLHC4Qd+
	57n4G2Mwl19gXx2vFiGY9IGQn7XiTb2EhhaT3UJO43bwoa2ooqo1tnpf2nwmHEYH/gnh5Dn7orwZS
	4LkPn2Gzg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPLKc-000wWf-O0; Thu, 25 Mar 2021 08:27:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPLKN-000wVw-Tq
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 08:26:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EE2A468B05; Thu, 25 Mar 2021 09:26:47 +0100 (CET)
Date: Thu, 25 Mar 2021 09:26:47 +0100
From: "hch@lst.de" <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325082647.GA27622@lst.de>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan> <20210325020951.GA2105@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325020951.GA2105@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_082652_177996_F7CFF90E 
X-CRM114-Status: GOOD (  27.32  )
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

On Thu, Mar 25, 2021 at 11:09:51AM +0900, Minwoo Im wrote:
> > I was still allowed to write to NSID2:
> > 
> > sudo nvme zns report-zones -d 1 /dev/nvme0n2
> > SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> > 
> > Should this really be allowed?
> 
> I think this should not be allowed at all.  Thanks for the testing!

It should not be allowed, but it seems like a pre-existing problem
as nvme_user_cmd does not verify the nsid.

> > I was under the impression that Christoph's argument for implementing per
> > namespace char devices, was that you should be able to do access control.
> > Doesn't that mean that for the new char devices, we need to reject ioctls
> > that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> > represents?
> > 
> > 
> > Although, this is not really something new, as we already have the same
> > behavior when it comes ioctls and the block devices. Perhaps we want to
> > add the same verification there?
> 
> I think there should be verifications.

Yes.

> > Regardless if we want to add a verification for block devices or not,
> > it just seemed to me that the whole argument for introducing new char
> > devices was to allow access control per namespace, which doesn't seem
> > to have been taken into account, but perhaps I'm missing something.
> 
> Any other points that you think it's not been taken account?  I think it
> should map to previous blkdev operations, but with some verfications
> there.  It would be great if you can share any other points supposed to
> be supported here :)

Agreed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
