Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D251CC5519F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 15:26:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0E4221E2
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 15:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qz/LFdBT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1k+4n1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0E4221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jMHxf1dgMSmLHuH0xUuE1X9bMxWDdCKdXoEvCDB6Oxg=; b=Qz/LFdBT0q94OXqoGjjoX+dlo
	WW8td2GK/u1Le+WwAmILHd5Ule9sSRZlu03jGLATkcNR3DZhjPmqzwm6c6mMPVOHJVqNhwgzpXTUo
	A1McVY1QC/SoB+cON+pCFf2koFakwJUvDchG89Gr3SojLfX1r7KphyfEsjnX9lRFajpsYRJc9Oqb1
	h/z3kPTT7jcCN4QVtrciV6xeZIKbbQnnHcSkfF7SsFALsIO45hj17P6ZX/ybQ6Fqj7452fRwrR8Bs
	gacPqN/saksjiD80hz7YVWigXGtDgy7DLGKb/0xhwQfH3NxiLOFx9CkIhV2QOVRlzV1omOv4WQqPu
	htux/mpww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kf2sV-0002xV-2v; Tue, 17 Nov 2020 15:26:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf2sT-0002wo-8d
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 15:26:41 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2743221E2;
 Tue, 17 Nov 2020 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605626799;
 bh=cb5wYiLA0aL3jqhI1UffLG2/Qg9z20Fv4MmB8FXK4eQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f1k+4n1sLkSzDSEMGGactFX/o71OmkpydRgQUrKODCdKbiM/F3uT0uHbYJqjlZgDo
 cV7f39uk0nyWwkq5i1hsHGDRmeTesO5Y4KtlHF8bK2tVpL/sR+MZq8ti4RdMn76tbx
 ZJiNt19OEV5A5OYDTUnz9GgDSiRqvK+zQ+FTd9zg=
Date: Tue, 17 Nov 2020 07:26:36 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: fix memory leak freeing command effects
Message-ID: <20201117152636.GD2715864@dhcp-10-100-145-180.wdc.com>
References: <20201113184545.2707853-1-kbusch@kernel.org>
 <BYAPR04MB4965BC005B917A995976649386E30@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965BC005B917A995976649386E30@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201117_102641_404721_7D780BF2 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 11:23:30PM +0000, Chaitanya Kulkarni wrote:
> On 11/13/20 10:45, Keith Busch wrote:
> > xa_destroy() frees only internal data. The caller is responsible for
> > freeing the exteranl objects referenced by an xarray.
> >
> > Fixes: 1cf7a12e09aa4 ("nvme: use an xarray to lookup the Commands Supported and Effects log")
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> 
> Thanks for fixing this up, it'd nice to have a common helper
> which also erases the itmes from XArray so we don't have to
> repeat the code to erase item indivisually.

That would be okay if there are multiple users that have a simple
kfree() on their elements when tearing down their xarray, but I'm not
finding others so far.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
