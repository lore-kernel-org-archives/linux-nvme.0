Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D1C43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:44:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7162193E
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="05gsbhUb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjNifL1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7162193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bagXO+VEQxzsMT7M4uRp2JGj6gNAbDHMBUtiBXu+kN0=; b=05gsbhUbasKR6m/PttklJ8dG7
	uWrWFMsLsoN5E36h1zxE0vv/C5qfLY8W2RYYH2YbLihdECa8HoJqbYCsJHsQIM2vF7wvO/SV+hGNq
	y6L0FhsAgvwk+jtzH1iO7QqyZ8qADHAok1vtVl0b3jD2k0u3qQYqEtCJuSm1Uj3Vp2ZEanYYLzqmz
	O2oebvy5SDynlREcAv0s7VP91EjCxgNwS0VWoD4/YhT1Ro+odbn3mHXY6OArlpbDvXLcTfQvIv+2v
	YHlc6BpccB0gOgpHdWcIvjO0WqII4LetDfQ0KBuwagyMoFCFA71Qu13+psRxunfyDHbtazvp/HJPS
	hoS6BAfFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHuOp-0002td-JH; Mon, 14 Sep 2020 19:44:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHuOm-0002t8-Rw
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 19:44:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9A7682193E;
 Mon, 14 Sep 2020 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600112664;
 bh=KTbZtX/efDpBSn4dtNMsLq1dMP93J2joS3U/VCwWSmc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XjNifL1l+QUQLYZolKfcXoKPkprfWD/5FUVmunRMZhsHKh/beJzAimauhn3kIP3CW
 S21Y3eJWUxaIHfJhZg/Dq7sHOPF8MN1wlzcA2O0eZcJg8oQfdlr9bBQnTLNsxLF+Q9
 thwEqv/TuorMRouOJmP9V1pK5qvrNJC/LBBDyJyw=
Date: Tue, 15 Sep 2020 04:44:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912064104.GA19223@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200912064104.GA19223@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_154424_988178_BB313946 
X-CRM114-Status: GOOD (  24.24  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 12, 2020 at 08:41:04AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 11, 2020 at 09:35:31AM +0000, Damien Le Moal wrote:
> > On 2020/09/11 15:10, Christoph Hellwig wrote:
> > > On Thu, Sep 10, 2020 at 10:25:24PM +0000, Damien Le Moal wrote:
> > >>> I'm not sure this is the best idea, we probably need specific error codes
> > >>> if we want file systems to be aware of the limit.
> > >>
> > >> Do you mean something else than -EBUSY being returned to the user by the block
> > >> layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
> > >> blk_status_to_errno() ?
> > > 
> > > My primary aim is a different BLK_STS_ code.  But given that I think
> > > that we should not map different BLK_STS_ codes to the same errno if
> > > we can avoid it, we should probably also use a different errno.
> > > 
> > 
> > Hmm. Beside EBUSY, I do not see a nice existing errno that we can reuse. May be
> > ENOSR (out of stream resources) ? Or do we define a new one ? EZBUSY ?
> > 
> > And indeed if we define a new BLK_STS_ZONE_RESOURCE and map that to EBUSY,
> > errno_to_blkstatus() will get confused.
> 
> Yes, you need to pick a new error.  I don't really care which one,
> most of the mappings are pretty odd anyway.

Selecting an existing unused errno feels a bit arbitrary for a status
that is currently specific to NVMe ZNS. Could you provide a little more
guidance on what you're looking for?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
