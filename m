Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABD7CC6B38
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kuzgUNtVYy7uTXxxRnHHs1Vd1gFc8pBE1Lqtkrv64CM=; b=N5gT033dclC9Eovu6x3mzEgv3l
	mfT/c1cvIUY3XmfrgKv5sJF7EQmSKZvUoVXxR/9CXU4f1ba52VbFAJCMk4QhhVkXdIsbGlohu5tql
	z8ZeuHXyIFO9heI02XsyUA5hJapCc92Ls1fkCi5B8Ed9I5wHunWfEAiXhnyDJqTcimutq+nqNYLw7
	d1G7AwFWsXoFFQvVQ0i1Wi5vO6L/g8si/IQ8LxJaNvfOkqrZw7QQJVFAl/pOJexeRGDB/qJ6J46jO
	CgT5sx+2IUacpD8FnO4RXUCGvllaWLLE6r3MSr+vwiwSBDl+f4IphXyaMlWx/RUUnFVOZ7G5Pl214
	Z5sc54/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkFR-00000003Khh-3VdV;
	Fri, 16 Oct 2026 15:53:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHkFQ-00000003KhC-3dsz
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 15:53:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F4ED40E30;
	Fri, 16 Oct 2026 15:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94F1F000C4;
	Fri, 16 Oct 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792166012;
	bh=kuzgUNtVYy7uTXxxRnHHs1Vd1gFc8pBE1Lqtkrv64CM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CPrgvU9kPiuGtLYnfcaXlPNFOvm4TvdBlcVDy+p2SR1A9XhF/Zdf5DoQ8Xzs/76RD
	 98pRM+ZvVDln+02UXgFfPxlLMPl8A1iCgP4eDfTSqlcIAPdL3au+JXLO5HxWD5SLeb
	 XWs5J4W5m2ShPnhk6dyOxAS7Ea28oir+3d4jfUimfJJ6d0Uv76onFA8kjGxJogsEfD
	 55oCZtSDLcoKTtDkdnZkZEexZZd/62RcQp1tIpglfqD7eScf2DMByySpfCrs6nqzHy
	 a0jNMYhlx/aSQ9oDAM1ArDW7QsuodKS7TMaAK/iDmkYiedyfulNqyxhLuK63nYWCTE
	 PdH3W7kp8kxCw==
Message-ID: <sashiko-outbox-174586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet-fc: skip port entry rebinding if already bound to
 a target port
To: "Nguyen Duy Nhat Anh" <neganhat@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261016154807.9544-1-neganhat@gmail.com>
References: <20261016154807.9544-1-neganhat@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 15:53:32 +0000
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
- [Medium] nvme-fc: refcount leak of tgtport in nvmet_fc_portentry_rebind_t=
gt()
--

commit 3f22f46c30c7c3045ffe22fb5654e54b5aabd759
Author: Nguyen Duy Nhat Anh <neganhat@gmail.com>

nvmet-fc: skip port entry rebinding if already bound to a target port

In nvmet_fc_portentry_rebind_tgt(), nvmet_fc_tgtlock serializes access to
nvmet_fc_portentry_list, but does not prevent multiple concurrent or
duplicate target port registrations from attempting to rebind to an
already-assigned port entry. This fix checks if pe->tgtport is already
set before rebinding to prevent clobbering existing bindings.

Closes: https://syzkaller.appspot.com/bug?extid=3Dbe62d4b375542ecebd17

> Fix this by checking if pe->tgtport is already set before acquiring a
> reference count and rebinding. If it is bound, skip the entry to prevent
> clobbering existing bindings.

[Severity: Medium]
The commit message states the check is performed before acquiring the
reference count, but the diff below shows the check occurring after
nvmet_fc_tgtport_get() is called.

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
Does this code leak the tgtport reference?

If pe->tgtport is already set, this continue path skips the entry but doesn=
't
drop the reference acquired by nvmet_fc_tgtport_get(tgtport) just above it.

Should the check for pe->tgtport be moved before the nvmet_fc_tgtport_get()
call, or should it call nvmet_fc_tgtport_put() before continuing?

>  			tgtport->pe =3D pe;
>  			pe->tgtport =3D tgtport;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016154807.9544=
-1-neganhat@gmail.com?part=3D1

