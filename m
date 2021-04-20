Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D440C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BB9613C3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BB9613C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2SFVErusIOR8ELUnXO6hgngRTcGPNuC0YE1jN4znyD8=; b=M+nQ4apnTITLzQt488MN/jdWs
	dq9R2rLsWFFiREIHsKDV/N1QQ9q2VMFidfk/jOiqG6SKk3lnIYQxI9JntJbe49GQ8TfAdglXA13j8
	/AcdTzlH/I4B0I3ypXaWAmHYIpKYYn9j25khjqOLKMHbVsoOCXZHPgs+SkcqdfLSWzOhRPPZyF+Ca
	FxeSSMGl+hc/5erQRG3gKcvTvTlF1lZj6VhpocVNoFJ+PEwCKTI5GWNWJcw+Jk1ZfyxLSWgBRTALO
	w959BH9hnTMb3guDkQGiYvLD4YXAsekaFXR3a6Me9PvpmvmX/ttdFNglp5BAGNpm+emghnnqj9NXR
	ksNjeLaAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYrX8-00CMwQ-Bt; Tue, 20 Apr 2021 14:39:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrX6-00CMwG-My
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RzX/Idl717k6gwtKKJs6SWXnbJKCM63mTmZeFfZ4KZc=; b=eFB2ksp2kGo/Dq3GXaMjL3aqr3
 uM97N9ZVI5nxmkZFwdGMdfjI340pA+6zI2TlSyYSWz2qBdtkKGajNb5ulWA/3IX7c98SD8WVAEB1L
 lH4TVi8dnG8ld7tFggsLXhjwEV0f08I/0gBlPnrkLxNoZZ2X4n5WFrshGLKGIdy41OwXe4TzcmrzK
 PgfNDqx1SFBJPwVRbKBAjuP2z5l/30GzKhbUuBuxVj86gusjnRlX/9gfMxyIB5vsgnNq6JPihqpd1
 Of7bqj16xR59lDEEAhw6sX3XBfgKuR9SxWgxkPjIcQXWdyTl8I88qYa0M1ttj81xuZkskb8Nn8O9x
 TyuWw7Dw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrX0-00CCTr-Ox
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:39:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3B02768BFE; Tue, 20 Apr 2021 16:39:07 +0200 (CEST)
Date: Tue, 20 Apr 2021 16:39:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420143906.GA19417@lst.de>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
 <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_073914_979117_E2BD8EF4 
X-CRM114-Status: GOOD (  24.61  )
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

On Tue, Apr 20, 2021 at 11:14:36PM +0900, Keith Busch wrote:
> On Tue, Apr 20, 2021 at 03:19:10PM +0200, Hannes Reinecke wrote:
> > On 4/20/21 10:05 AM, Christoph Hellwig wrote:
> > > On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:
> > > > With the proposed patch, the following messages appear:
> > > > 
> > > >   [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
> > > >   [  227.516807] md/raid1:md0: Operation continuing on 1 devices.
> > > 
> > > So how is this going to work for e.g. a case where the device
> > > disappear due to resets or fabrics connection problems?  This now
> > > directly teards down the device.
> > > 
> > Yes, that is correct; the nshead will be removed once the last path is
> > _removed_.
> 
> The end result is also how non-multipath nvme behaves, so I think that's
> what users have come to expect.

I'm not sure that is what users expect.  At least the SCSI multipath
setups I've worked do not expect it and ensure the queue_if_no_path
option is set.

> > But key point here is that once the system finds itself in that
> > situation it's impossible to recover, as the refcounts are messed.
> > Even a manual connect call with the same parameter will _not_ restore
> > operation, but rather result in a new namespace.
> 
> I haven't looked at this yet, but is it really not possible to restore
> the original namespace upon the reestablished connection?

It is possible, and in fact is what we do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
