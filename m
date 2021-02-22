Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1438C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 21:05:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7737D64DF0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 21:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737D64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z/ciX4bJ9dFLcfIIHSb4L4988dQ5Wz+r9EdEl2hH/N8=; b=JptvQbmhOOuorN4j9LatYZM8c
	OPb4K4rTxB+Ri2vQCWS2/wr29bU54B/sJfk/slZ/hOhJ/mg9C1C7oF98IdEGVsw/1xc4dfqLRnlyr
	Lvyzf0lvQIUlC32WdagJXWqwM+7WlTLd5kq9j2x0G890MmDIRnIfJIiF2HRIjKWMMwOtnZeEY6SiJ
	mfIMVZFfQ9XJjI3e1GMDbF+PFMrPHWQgKr5XaScuxENZBtmdhT3m5Z+hJ7XmIbY91Pm83eiK0u84y
	cDbhgP/46Vmjw+wN4Rj7DGodDWBBEI9Tmy9EJw1wz13TyUx/G2MiCNlCfOwdRjHUcQobpPWAU+HxJ
	fGU5HaCtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEIOT-00011u-Sq; Mon, 22 Feb 2021 21:05:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEIOP-00010r-Bu
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 21:05:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614027914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kExhu8Hi3S9fQna06yD9THVNTpBY7VoNhd4T+f7DeSE=;
 b=GZzf36PFLi8ICRgl5oyKIJb1BPaN0zlstBCFZIPPFMH3rmKPry2fUrOX0PvLLnX5JCau6m
 Ti2V/+uOm9T9IW+fqMHJiZd0Obn6+j3WxpyohbQlDGTgWI50VUkr3eYJNB/iFe/czu/IV4
 Zlk1rwgPSp8zS0bQk8Jrq25ET2TYJD8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B0333AD29;
 Mon, 22 Feb 2021 21:05:14 +0000 (UTC)
Message-ID: <336498bf0c38269cb2b9bbbd33d33a3a360a758f.camel@suse.com>
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
From: Martin Wilck <mwilck@suse.com>
To: Enzo Matsumiya <ematsumiya@suse.de>, linux-nvme@lists.infradead.org
Date: Mon, 22 Feb 2021 22:05:13 +0100
In-Reply-To: <20210222190253.6ftslzvqt3iz3f3s@hyori>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210222190253.6ftslzvqt3iz3f3s@hyori>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_160521_533712_818ADDF1 
X-CRM114-Status: GOOD (  17.39  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "mwilck@suse.com Chaitanya Kulkarni" <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2021-02-22 at 16:02 -0300, Enzo Matsumiya wrote:
> Hi,
> =

> On 01/26, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > (Cover letter copied from =

> > https://github.com/linux-nvme/nvme-cli/pull/877)
> > =

> > This patch set adds a new subcommand **nvme monitor**. In this
> > mode,
> > **nvme-cli** runs continuously, monitors events (currently,
> > uevents) relevant
> > for discovery, and optionally autoconnects to newly discovered
> > subsystems.
> =

> Is there anything missing from this patch set?
> =

> > * Implement support for RDMA and TCP protocols.
> =

> I'm working on the RDMA and TCP implementations with mDNS/Avahi
> support, and
> I would like to submit my work based on this monitor solution.

I'm still working on a v2. Please have some more patience.

Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
