Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F8C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:31:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17A961026
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17A961026
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hN5FJWTWO9keBMv1i8CQUqk8TevtLsS+dvNqDnEEyaM=; b=GzEMjI/6MAl0oh4fWyTHoRKsd
	fFcJ2iEjLOisBc49BvBOgDvJxQa9kRnIKkLHfD/lVrmlNKFlrHb7Ubm+hcM/TADoNS+oBByArHL57
	uPRzFaGSZncq2M5GR0HxTcfkFeTbia7NoqOESt30AHb/74NMPYsFSj25VW2XNIa2frZEHj+9bT6JB
	LhOFI2K+1ejlMEGJXsDL340rSzlHs9NRSIYYkPxcLeV6y70OtiBkcFXldeKU/dJypumzYSc5g9QlP
	XYE0mmU0UnyKQRLxg6tZnLPSIOr/ClInsH4wHe3R7c/szeOeZh7/6wVy2tVIhruRnVSpC94LZ+nso
	WlYfCGXvg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbIAz-000yNp-KK; Tue, 27 Apr 2021 07:30:33 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbIAv-000yN9-AS
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 07:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=zm/oxYNPysKVs/BfMl/YoBZSkDAOMzzSUUeSQwEAG7c=; b=aDQLenNGZPDDBu4n2ah8DkjTti
 7yC8dAr8zHGJOem17bp3py27L+zgCH4JXSafvQUgTlnHY3Fza9p/62ZHMvM27vZS8Cxk/Hbd316lS
 FmykCImNscauAU6LZvcnJQTgS6ULxgWetbVbRD8Mq4vyUv5weN7hdVee1a3DH4nW1M4Eke5bdlttd
 Q6liRVBHFhycLHZaWSLei/JIif9gCp8np594ILWxGjG7NXU6obyG0FHuvgEoES18hb89rPgoLJTxu
 Bp8P0RUfQJsCviFg250IpkL2K/C6VUOUjW3usEn8j76psuQuRUt50pt0SvCvkWToyBz49bJkZT76m
 vCBMYStw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbIAs-00GVSE-AW
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 07:30:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619508623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zm/oxYNPysKVs/BfMl/YoBZSkDAOMzzSUUeSQwEAG7c=;
 b=qRqSc43r1cyz6hd137v/mxARQFR13+53GFionLG5BioDhueUlOkKoUzLL3U0CUL6H5ix76
 Pw3G+SIevv0SbbdQIjV0Ibwaa4OhTC4Wl5TjV0J6UdI3uXlLd+TSbds84qUS0DVZS7wTxd
 19lZ3+ziMH/G2+9O0ocUSZitCbBXWrI=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2E391B0BD;
 Tue, 27 Apr 2021 07:30:23 +0000 (UTC)
Message-ID: <069d47c70946bb5b7aabc2f0650c312fcc0b4157.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, Daniel
 Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Date: Tue, 27 Apr 2021 09:30:22 +0200
In-Reply-To: <8b5c6deb-82d1-8803-48db-d104264e17dc@huawei.com>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
 <20210426145105.GA22120@lst.de>
 <2df7213105b42f08fdb021e084f277bb881fb230.camel@suse.com>
 <8b5c6deb-82d1-8803-48db-d104264e17dc@huawei.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_003026_526740_ABB03D8E 
X-CRM114-Status: GOOD (  22.57  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2021-04-27 at 09:45 +0800, Chao Leng wrote:
> =

> =

> On 2021/4/27 0:27, Martin Wilck wrote:
> > On Mon, 2021-04-26 at 16:51 +0200, Christoph Hellwig wrote:
> > > On Fri, Apr 23, 2021 at 05:21:03PM -0700, Sagi Grimberg wrote:
> > > > =

> > > > > diff --git a/drivers/nvme/host/rdma.c
> > > > > b/drivers/nvme/host/rdma.c
> > > > > index be905d4fdb47..fc07a7b0dc1d 100644
> > > > > --- a/drivers/nvme/host/rdma.c
> > > > > +++ b/drivers/nvme/host/rdma.c
> > > > > @@ -1202,6 +1202,7 @@ static void
> > > > > nvme_rdma_error_recovery_work(struct work_struct *work)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > > =A0=A0 +=A0=A0=A0=A0=A0nvme_mpath_stop(&ctrl->ctrl);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0nvme_rdma_reconnect_or_remove(ctrl);
> > > > =

> > > > Its pretty annoying to have to needlessly wait for the ana log
> > > > page
> > > > request to timeout... But this is also needed because we init
> > > > ana_lock
> > > > in nvme_mpath_init while it can be potentially taken in
> > > > ana_work,
> > > > which
> > > > is a precipice for bad things...
> > > =

> > > I also really hate open coding this mpath detail in the transport
> > > drivers.=A0 Didn't you at some point have a series to factor out
> > > more
> > > common code from the whole reset and reconnect path?
> > > =

> > =

> > So ... resubmit and cc stable as Sagi suggested, or work out
> > something
> > else?
> Another option:call nvme_mpath_stop in nvme_mpath_init.
> In this way, transport drivers do not care mpath detail.

That would require that we determine in nvme_mpath_init() whether we're
called for the first time for the given controller, or whether the
controller is re-initializing. It's not obvious to me how to do that
reliably without introducing a new state flag.

Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
