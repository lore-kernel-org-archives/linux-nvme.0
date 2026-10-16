Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97079CCA46C
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zAXJRVD0+zjmhCjAOJwlVikEKzNagnlo8V5sKOCNPVQ=; b=Rdz2Bm27oDNRhyh7Gm3Qd2AQWR
	hUcxT2399zJ0Rf14anBZUkJIudixK7i/uPNvmAfAYLoK1YASGM/thyiGEVJc1drk5visZKYKXbjUr
	tuvUrq79v5s3FjCJWVRJ9ItlR2DgAuQX8oIdKS+SrOGPpg/FRMYzeiJZvbkN+czU1cOLqTO9yiFpG
	zrU7EsnDHSPfZN0PtVfXE1YxqKAfcH3j03p6H22mKG6w0hI9m0LVAI8gzWDZk/70ZLROCzpY4zAOX
	bl33VCRtCu0Ia8IJuOouKUPv/pa9WTwTUEk70z+BHLdzuOprgY1QdO+X7hWFioIK5R5QS9ktUL50p
	3t2VaXQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkKd-00000003MCN-14KS;
	Fri, 16 Oct 2026 15:58:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkKc-00000003MBF-04tG
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 15:58:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F264602D4;
	Fri, 16 Oct 2026 15:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E191F000C7;
	Fri, 16 Oct 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166333;
	bh=zAXJRVD0+zjmhCjAOJwlVikEKzNagnlo8V5sKOCNPVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PnzRhrTxtmrs0vxoRTiqRQZtWr7ZWBXGUE2PS6g7cnqaIhra9Y78aV05+0ky3TOaQ
	 rJNjmUneGm/qWiWOMTQ/jmajw3VbFvx4nj7o0xf3rzwKzREdzWteVQpsYa0Lep9q83
	 6zWhbo+RojVrXxlT4GFRtCSUaDIVc+V9PvFSPmariU1l0LFGQsg8RGqRgL/4NbXVSu
	 41LgnEv8m+grSc5ph6dsb1HOOu5p5jnXXMfTsR1QDG5FpqFskCFDVB8AzbXFn3UmRK
	 yJrbA1hgmQJ0aqpUaq4ql/oaJ+jbDSg0eHX0SbNU2vjPpnrRZ8nAcfH1aQjzZgp8tX
	 JXnaBJAixk/gw==
Message-ID: <sashiko-outbox-174590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet-fc: skip port entry rebinding if already bound to
 a target port
To: "Nguyen Duy Nhat Anh" <neganhat@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261016155415.10521-1-neganhat@gmail.com>
References: <20261016155415.10521-1-neganhat@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:58:52 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-target/fc: reference count leak of tgtport on rebind confli=
ct
--

commit 69be6b42e2f6eef3ebd6d221309e5ccb64969922
Author: Nguyen Duy Nhat Anh <neganhat@gmail.com>

nvmet-fc: skip port entry rebinding if already bound to a target port

This commit adds a check to avoid clobbering existing target port
assignments during rebinding. It prevents multiple concurrent or duplicate
target port registrations from overwriting an already-assigned port entry.

Closes: https://syzkaller.appspot.com/bug?extid=3Dbe62d4b375542ecebd17

> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index eecdffefa24fa..ac3194497a1e0 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1324,7 +1324,9 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtpo=
rt *tgtport)
>  			if (!nvmet_fc_tgtport_get(tgtport))
>  				continue;
> =20
> -			WARN_ON(pe->tgtport);
> +			if (pe->tgtport)
> +				continue;
> +

[Severity: Medium]
Does this code leak the reference count on the target port?

The commit message states the intent to check for an existing assignment
before acquiring the reference count, but the check is placed immediately
after nvmet_fc_tgtport_get() has already incremented the reference.=20

If pe->tgtport is already set, the continue statement will move to the next
iteration without releasing the reference acquired by nvmet_fc_tgtport_get(=
),
permanently leaking it and preventing the target port from being freed upon
unregistration.

>  			tgtport->pe =3D pe;
>  			pe->tgtport =3D tgtport;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016155415.1052=
1-1-neganhat@gmail.com?part=3D1

