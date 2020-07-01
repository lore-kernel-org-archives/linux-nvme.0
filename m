Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC147C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBF2207F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uO56EIEW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOuK81+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF2207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DRYsxgUfYNqeEmg+crUK1cnSnhm6VLAjToXMJ9tcLpU=; b=uO56EIEWpcDc6tULSpusj4ZvP
	S1dJdsNtge42vQMZGKYDH6cjnbKOSvoezkSa70rlc+ZOr7Cm+hLG1PObKoBCgQXD2Jdi9cpKPBMAc
	bC9GQ0MiTDASrNbAjwmJNF375yGrAxcFPqNcb/j5N7URa8w3qaAQIEn/I5V9Dd9+er1tUwZNulTHd
	dzIHx9XTFjcnmUTEZAuE2TQlwrV+FKk1Lp9qgTz3Mdcbw2Cq4dgKcnjtjLsx8TP2UVlx2SdB2QWW4
	mZsI6UQDvRnuzMa8iHe62HM3vp8ztwcidPeJkO3ebw3qFHnG+PE0/RLJHkKMTQXiQ4fJnypAtZMAa
	h3rdAiTmw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhUB-0007T9-Hn; Wed, 01 Jul 2020 18:29:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhU9-0007S0-G0
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:29:30 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E270207F5;
 Wed,  1 Jul 2020 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593628168;
 bh=oXCMGdOOdZqHCoqqpDThAo8wcQ0OnVyOyERJEkvVi9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JOuK81+4+unsYaVY6oIiqZLZ8PRwuOrP4r44KXDPrPrREguBa6ztj/Mxwww1oiA3q
 kMwKGNanDpf+skezUcWo6KKwyvgSNIDiTXVPQcv9E0xUDqoGbPRYQIVLMCAGFW2N2k
 2UFvo236+OceeF+1jTmmZNnGU633WiEEv2EXjzww=
Date: Wed, 1 Jul 2020 11:29:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200701182926.GD1988944@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
 <20200701131235.GA17919@lst.de>
 <BYAPR04MB4965B6A3EE4591E8A05A2982866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965B6A3EE4591E8A05A2982866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_142929_632707_3DBDAD60 
X-CRM114-Status: GOOD (  22.28  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 01, 2020 at 06:19:50PM +0000, Chaitanya Kulkarni wrote:
> On 7/1/20 6:12 AM, Christoph Hellwig wrote:
> > [willy: a comment/request on the xa_load API below]
> > On Tue, Jun 30, 2020 at 07:25:16PM -0700, Chaitanya Kulkarni wrote:
> >> +	if (le32_to_cpu(id->nn) > 1) {
> >> +		dev_warn(ctrl->device,
> >> +		"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
> >> +		goto out;
> >>   	}
> > 
> > This code doesn't make any sense at all.  Why does a patch changing
> > data structures add new calls that go out on the wire?
> > 
> Yes, this should not be here, I'll remove that and only keep the code to
> check multiple namespaces and if needed this needs to be a separate
> patch.

This isn't actually checking for multiple namespaces, though. It's just
getting the highest nsid, which doesn't tell us how many namespaces the
driver is bound to.

> >> -	down_write(&ns->ctrl->namespaces_rwsem);
> >> -	list_del_init(&ns->list);
> >> -	up_write(&ns->ctrl->namespaces_rwsem);
> >> +	xa_lock(xa);
> >> +	__xa_erase(xa, ns->head->ns_id);
> >> +	free = refcount_dec_and_test(&ns->kref.refcount) ? true : false;
> >> +	xa_unlock(xa);
> >>   
> >>   	nvme_mpath_check_last_path(ns);
> >> -	nvme_put_ns(ns);
> >> +	if (free)
> >> +		__nvme_free_ns(ns);
> > 
> > This looks very strange to me.  Shoudn't this be a normal xa_erase
> > followed by a normal nvme_put_ns?  For certain the driver code has
> > no business poking into the kref internals.
> > 
> 
> There is a race when kref is manipulated in nvme_find_get_ns() and
> nvme _ns_remove() pointed by Keith which needs ns->kref to be guarded 
> with locks. Let me know I'll share a detail scenario.

That wasn't the race I was pointing out. In your earlier internal
implementation, you had the xa_erase done after the final put, and I was
warning against that. The erase needs to happen where you have it, but I
don't see a need for protecting the kref like this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
