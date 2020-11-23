Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B0C2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5FD20719
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 19:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qt0psczd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYytjaOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5FD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T+OOPH+BbLVuWOwOgcEzWvn273O/ud9QfBObxpq0RrM=; b=Qt0psczd+A8y171sDBXRKCWLS
	q2T/ojDhxcUUR9o3j1MuEeSp6ROg1i/c+0+1rDVgx/a8PWukty/1G9oRgHwjfgSdangggkiZ416Bv
	3bWsJ2jfWqr5CZdDQLlK1ncaZwjkGgeuEIGhqvE57AnX5aNOZzY9oZ1aLcjiWLkkfOg78ijVD3BOE
	GLs5MnDUxC8FvBoXxBCiooLnkO0MwJ1ZbT6EtOd7JHDqiejOY2nfTYI/OfWd3GyYMzVL68mm7Bjli
	V02oOUbBIaGMcpoRHtBqsJ5C4BTNjXa9tgOtVO/BZjtdjC5FOJ1J4ZTVy/ceHjDr1+kgSnPsFlrYW
	H/mkHELtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khHkW-00061k-Js; Mon, 23 Nov 2020 19:43:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khHkT-000613-TM
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 19:43:42 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E14C20719;
 Mon, 23 Nov 2020 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606160620;
 bh=fpPiGlvwYzvfxVVtERcAoHZ8mphoCOxHEuidbVABeWo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lYytjaOTfpUYvEzLU+Hz2+SdxBr8oJA9fZpSOEk0nM8KbuKRocOGI9/2NJ2clsDuj
 vYmJAVfG5KUfhX+Bg01VcMXd2YlMVppTZ3JXeM9niHCvMKouLk1cRI069bKBRbk82P
 ehbqQzOA7S2/LfFn3PwX+VxmWRuExyqQpIIxIFzg=
Date: Mon, 23 Nov 2020 11:43:37 -0800
From: Keith Busch <kbusch@kernel.org>
To: "George, Martin" <Martin.George@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201123194337.GC2865091@dhcp-10-100-145-180.wdc.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <20201123173611.GB2865091@dhcp-10-100-145-180.wdc.com>
 <f2afd4dc-dd4b-d7d0-7421-11daac94b61c@grimberg.me>
 <d50766c203d849fa97003ef9585af47f059dc42c.camel@netapp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d50766c203d849fa97003ef9585af47f059dc42c.camel@netapp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_144342_033572_BD19940B 
X-CRM114-Status: GOOD (  17.13  )
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
Cc: "anton@lightbitslabs.com" <anton@lightbitslabs.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 23, 2020 at 07:29:05PM +0000, George, Martin wrote:
> On Mon, 2020-11-23 at 11:16 -0800, Sagi Grimberg wrote:
> > 
> > This looks like a good simple solution to me...
> > 
> > > ---
> > > diff --git a/drivers/nvme/host/multipath.c
> > > b/drivers/nvme/host/multipath.c
> > > index 74896be40c17..300cff8c616d 100644
> > > --- a/drivers/nvme/host/multipath.c
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -667,6 +667,8 @@ void nvme_mpath_add_disk(struct nvme_ns *ns,
> > > struct nvme_id_ns *id)
> > >               if (desc.state) {
> > >                       /* found the group desc: update */
> > >                       nvme_update_ns_ana_state(&desc, ns);
> > > +             } else {
> > > +                     nvme_read_ana_log(ctrl);
> 
> Shouldn't this be nvme_read_ana_log(ns->ctrl)?

Oops, I just did a quick copy-paste. You are correct.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
