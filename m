Return-Path: <SRS0=D+H5=A2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4CFC433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:42:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE59C20674
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2020 01:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="22PFzjqE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztw2/pY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE59C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Of2dueiGaFm9LzQ+FBNPrbOd9WEWERyGnIz4rrc1Hw=; b=22PFzjqEfVF2uPSA7iQR+Ixay
	kst0mQsk6ayctbhkh+IqY6jlAF2/d39bcVhjHKBP+VLfoGeCyJ3Zkib4pCnTLxvr0NFMxqXnkVt95
	fZnlTN3+7WD+jX6HNe6JdzKKYTyEjLHtqYxLIW+I8QpbiciuZkXcy5yt+lLf0+EvhTANQ91sGL5K7
	SrXCR32WHAkRvqOv8ibUJG62NudPK+Gga5eKlKY6ir7iaG0M/2d+++7rv06de6BHhJZ9TaKiipQcG
	JOdE0iXgDmAY0wxKy6bIw4B48DYIucRxCDfj8zEZogz7ybG6ld4KUfIwZpM+iMTPZa4Jh1RFXZRLZ
	DZcoqUzRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvWQn-0005VX-0h; Wed, 15 Jul 2020 01:41:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvWQk-0005UM-O8
 for linux-nvme@lists.infradead.org; Wed, 15 Jul 2020 01:41:55 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A46520674;
 Wed, 15 Jul 2020 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594777313;
 bh=8/7RW2pcCghDDEyMPHqIa19LcJ0Uo0KSpNY2cZKjs2Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ztw2/pY/oNw0WFTQyryPMYl2eCjPEjaE9ZMH6KORaOgSgSf18Ssmo2Ae6b65CfqG0
 xhE2rPqxoqg8DG0hbOTKoEoBWwZOniwT8/QPDYQj/maferYdAhLn0L/8cD0VezAd+R
 6yq7H6bKTeTJEl1WTfs8pDdFovbVkS58VIk13BNQ=
Date: Tue, 14 Jul 2020 18:41:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V3 02/10] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200715014151.GD2772284@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-3-chaitanya.kulkarni@wdc.com>
 <20200715005509.GB2772284@dhcp-10-100-145-180.wdl.wdc.com>
 <20200715013342.GD12769@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200715013342.GD12769@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_214154_875112_4E67C56E 
X-CRM114-Status: GOOD (  12.20  )
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
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 15, 2020 at 02:33:42AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 14, 2020 at 05:55:09PM -0700, Keith Busch wrote:
> > On Tue, Jul 14, 2020 at 04:30:49PM -0700, Chaitanya Kulkarni wrote:
> > > @@ -3933,9 +3918,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> > >  			blk_integrity_unregister(ns->disk);
> > >  	}
> > >  
> > > -	down_write(&ns->ctrl->namespaces_rwsem);
> > > -	list_del_init(&ns->list);
> > > -	up_write(&ns->ctrl->namespaces_rwsem);
> > > +	xa_erase(xa, ns->head->ns_id);
> > 
> > Since you're using rcu to protect the kref_get() on load, we need a
> > synchronize_rcu() after removing it from the xarray.
> 
> No, synchronize_rcu() is expensive.  We should instead use call_rcu()
> to free the ns once the refcount hits zero.

Yeah, that is an even better option, though namespace removal is so
infrequent that cost isn't really a concern: this function already calls
synchronize_rcu() and syncronize_srcu().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
