Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CAFEB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afg3TLHyLv4e9O3fSrY9AQcdmPSo4WOz31stNabhwHc=; b=g3e1Uq2iT8u3hbFtRqt1ulCNXV
	RWDKR3mnmenOfZhodQovVGI7biym1hrAmU5z3jir9a2dwmhT6Hg71k/JDqJdd/fblQzxvWnk8WdMt
	xvRokmJVotDVGndoDscScr0QghyOO3pYHE/eTB983R+CZLDzbVViZ3pXgxf3Pp/pnvylgV2UgnfJz
	HJX2UXESwOzrSCWIz1nYPs/7cmWpsBodBHak47dZYMOySz/7OgRqG5YXGZBUjadXiM3TopwYwP+Tz
	k6vXFKPF87xHKn1D9GIgMOrXmVLl3rHa4gCwoNjp5cJLFhBCzjf6X1MNtYvqAmcG/J8AgUsuwyA49
	70E/QK7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q97My-008ea1-2q;
	Tue, 13 Jun 2023 16:59:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q97Mu-008eZQ-3D
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 16:59:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F1D6C60FE2;
	Tue, 13 Jun 2023 16:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAE3C433D9;
	Tue, 13 Jun 2023 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686675583;
	bh=p3Yw2rUkTRlAoK9T2Y4CWC+o8mRVbMG5a82yEDfn6ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4WAWBtcpTQSXU4tllFckqEED8+Wk6VZ2zAfiHK83vvuJj9+yqpTJb37Q95aHqzXT
	 rwLL9pZnf4gp8sMa44dw0c2StOGlyvFQa8jY0d8+r0uB/hr4Csps3xdDbEZ3CZczlr
	 PoHOYvsPZxewFVA7Gv39rPEda9uyZI7bJRMg22iH7iqFVcyCXLbq08Bp644RIq+/+A
	 dHrlOKl2KbBAxsK/j+18pPVzeo8vgW13QBPFRnAGYX2MrufFQwOT53Q4IIPwq72sqR
	 1v8GNinZ+LC+P9+mLF5apDLZ44CNo9mzLgig7J5LjqF+56mBiIQnBkl5SsICkBKtx7
	 fXA5rDs6fNKcw==
Date: Tue, 13 Jun 2023 09:59:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Message-ID: <20230613095942.2b3063cb@kernel.org>
In-Reply-To: <acdb1a68-3180-0099-8520-24feb9a71efa@suse.de>
References: <20230612143833.70805-1-hare@suse.de>
	<20230612143833.70805-3-hare@suse.de>
	<f560c8fa-d6a1-7bd2-3fd7-728f90207322@grimberg.me>
	<acdb1a68-3180-0099-8520-24feb9a71efa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_095945_163854_5E4CC304 
X-CRM114-Status: GOOD (  13.13  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 13 Jun 2023 10:11:01 +0200 Hannes Reinecke wrote:
> >> +=C2=A0=C2=A0=C2=A0 if ((msg->msg_flags & MSG_MORE) &&
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (msg->msg_flags & MSG_EOR))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP; =20
> >=20
> > EINVAL is more appropriate I think...
> >  =20
> Guess what, that's what I did initially.
> But then when returning EINVAL we would arguably introduce a regression
> (as suddenly we'll be returning a different error code as previously).
> So with this patch we're backwards compatible.
>=20
> But that's really a quesion for Jakub: what's more appropriate here?
> Return a new error code (which describes the situation better) or stick
> with the original one (and retain compability)?

EINVAL sounds better, EOPNOTSUPP means not implemented yet, once the
thing is implemented it's natural that we'll start returning more
precise error codes.

BTW you need to respin on top of net-next, David's multi-page sendpage
has rejigged this code quite a bit.

