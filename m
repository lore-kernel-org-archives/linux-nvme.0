Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE14C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:40:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93266206A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 18:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S8iCZpmN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPtqh+bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93266206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SO+IDxcUgbDaoVAIqv55bqX2cXGgAmYZAt+S48MtwnM=; b=S8iCZpmN8MoDWbIp3ZUd6oEX3
	DKZF9jp4jigN06PMyU1J84Zj45F2hi0kIDjxF0rltyp1eKW9f1wTj/Lq+jVrD3GFOTHT6t3iHr4xF
	doQSvWUXg9Y3D3cULokcD8d+d17L9qni4wr4D3f34NnSdis/Kp2vurqrqabfZayH8n1JRiQ+WjbEV
	z5y33b7bAcYiJLMQ+xGYzQ7bUrSfsRzewkoUKX2lfa4FrA1RfRyOg6wDDUFPxNY95fWQ3X21XSNAL
	4Sw/2RSBIoWZ5M2FVJwsy2D6B8XKnKbPDKEFkFkdbr89wWLFfLN0n7SC8KYvsljCB7Egjh0am9ojN
	AbvhI45wA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joAJr-0008WP-Pl; Wed, 24 Jun 2020 18:40:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joAJn-0008UK-O3
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 18:40:20 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 095E4206A5;
 Wed, 24 Jun 2020 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593024018;
 bh=1Ayf49uhgE7vr8uKG6gfOWWzcGP7/yzm4SH4WSWuvA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cPtqh+bm8K2onckaiVIEGIhxyVjyv963gJ4NMXh4trAq4tva2CdHrLq3ceQZ2G3eB
 PN6HcPmRuwLPD2ui2rZY/Gdyz/FIe+I6nLz19EIUfhiCCSjCUawdUCgaLiB4EJ+FgK
 WY2wrva8ZzMTTtZrPPKxAIxsVR9gV8x3LWEqsiHg=
Date: Wed, 24 Jun 2020 11:40:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 11:33:25AM -0700, Sagi Grimberg wrote:
> > > If the controller does not support the CNS value, it may return Inval=
id
> > > Field with DNR set. That error currently gets propogated back to
> > > nvme_init_ns_head(), which then abandons the namespace. Just as the c=
ode
> > > coments say, we had been historically been clearing such errors becau=
se
> > > we have other ways to identify the namespace, but now we're not clear=
ing
> > > that error.
> > =

> > I don't understand what you are saying Keith.
> > =

> > My comment was for this block:
> > -- =

> >  =A0=A0=A0=A0if (!status && nvme_multi_css(ctrl) && !csi_seen) {
> >  =A0=A0=A0=A0=A0=A0=A0 dev_warn(ctrl->device, "Command set not reported=
 for nsid:%d\n",
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nsid);
> >  =A0=A0=A0=A0=A0=A0=A0 status =3D -EINVAL;
> >  =A0=A0=A0=A0}
> > -- =

> > =

> > I was saying that !status doesn't necessarily mean success, but it can
> > also mean that its an retry-able error status (due to transport or
> > controller). If we see a retry-able error we should still clear the
> > status so we don't abandon the namespace.
> > =

> > This for example would achieve that:

We're not talking about the same thing. I am only talking about what
introduced the DNR check, from commit 59c7c3caaaf87.

I know you added it because you want to abort comparing identifiers on a
rescan when retrieving the identifiers failed. That's fine, but I am
saying this fails namespace creation in the first place for some types
of devices that used to succeed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
