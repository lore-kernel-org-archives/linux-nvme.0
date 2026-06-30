Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA71C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 18:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/2F0OT12gxVntauriOqGt1uDxYyh35S8fb73suRQ5o=; b=C+vv6AtMllGJHtaRlIerki3t9a
	AAqvU4o2KBUf2cvUd/5qwkAcZbnrKktBFqR4ARJoHA9nJXlu9nK6EuRmwB4+iO5iN9jEOyZB1+PZR
	5ypASCtE+1RHsdDOfHo462yssdgRe+Yzr/+l+aCO3kkCCvQYCJW6fgDjSoP5aEYt6WY7pYjcxgine
	+Oq6Dc9rSseRszXLkeI4Fb6htKp8G+ywV56XiB9CK/zYdmkEZBlkcNW0uZRAMFIqbBODf9Di9D8eP
	9gIx6bu0hZZH2c6+Uq5CEREOSUcO52oBdHyvJRYV1Sf8GT8/EQuL/EfVwbcwpxgHo9gKOhY05CAwS
	Wl7nBJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wedfm-000000004ak-3Pmm;
	Tue, 30 Jun 2026 18:59:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wedfj-000000004Zo-3Q9d
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 18:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782845941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/2F0OT12gxVntauriOqGt1uDxYyh35S8fb73suRQ5o=;
	b=S7Gwv2hYn/6LsHuiJeDsE6yyWixXXoK1Pj1Ijh87n/KKYCqAAlTwPkL0WWXbAU9GDb5bdR
	hKPDKQUDNTHb761jRDOPgTqVND+XoNoderfs9e9pCT9nuccwFto/Hesh5gCLVS1XDwJWnQ
	Jp3+hWtarHwXfWZSSqj4ex0uwmJK/cY=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-w9o5ZUsGMbG_WjYzNr-tIg-1; Tue, 30 Jun 2026 14:57:10 -0400
X-MC-Unique: w9o5ZUsGMbG_WjYzNr-tIg-1
X-Mimecast-MFC-AGG-ID: w9o5ZUsGMbG_WjYzNr-tIg_1782845830
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664d8e6c178so4034954d50.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 11:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845830; x=1783450630;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/2F0OT12gxVntauriOqGt1uDxYyh35S8fb73suRQ5o=;
        b=Jmcqlah0EeHvIzreX721RJNiAVWbxEjk09d5DhCZR2PPaHyuCwbceG+0/DwYnIBsje
         oBAWJj80UMBGuKkJiomf11QecSZe7l9anHVUOheX/Hy0tLGgZRe5d29+M3mrS7Hgq8cq
         vh9W+8nmigkf3jJ7eH3ODEp0cEfSTLeGgyy11KfIaQKYEhsVRIzo4H0/9YvDzpKxxo7t
         UfsMTfHG5iYT1YifqUbEnAjuRFu/rXIWgUUQk/VND4IOm9UFWtTub7gqrph5yP0GJTCK
         JvMsvjZS0CuVSB/FNL1ONRmKWeB1TtjZAO7IIcWzOnNG6nU/z1/MtGgJ9uadR4Fsat29
         mLDQ==
X-Gm-Message-State: AOJu0YzMpxCWdH1LhlHarz+k5nHD0clanVwD+jKycrK0n2UsiPpMYoqi
	mN3Sijkr6P3igxaFZHikTRe6qnLm9eLp+/YmY0yHARdf1qIsFIlfFmxULbj6TLQhIrVIJwKGLsZ
	uUHkFYfT6BvGEqb3U4pRKLV61YchuqHM7Pi6uHeY3D3OeOd64ISU1o+sRolV6BxZmD4p6/RNApS
	n4Ue4QFvJZaGVHml8lWWC3sMiVYWg+O+PddTH+GALr3ySFTxbbfEE=
X-Gm-Gg: AfdE7ck28HPbrFjUFhiD2A2n7kd+csIkB51cYVQCKsFpFCYitXkACLcBnwDcqBGSMcR
	tAyDEO7fHhSZdbu4AI/l8YwnSNrIho80EoFnsT4pJswxuSb4/Ktr1pNmiRq64i3NCeTl5/0EbJK
	1jzN6kO3zu/Rom4uMMson3P20bhfNiFAZra0/loQT73ULWJAwKVdS5Fyxvidf7BfHL4yTnSnd0y
	2lzf7Xyg7H5Yv0/nKoAjdCq5a3FyzNOdmv+gYBmrwpRdrvqUOkI
X-Received: by 2002:a53:acd5:0:20b0:664:7d5d:4396 with SMTP id 956f58d0204a3-664f979c8admr4415784d50.23.1782845830205;
        Tue, 30 Jun 2026 11:57:10 -0700 (PDT)
X-Received: by 2002:a53:acd5:0:20b0:664:7d5d:4396 with SMTP id
 956f58d0204a3-664f979c8admr4415758d50.23.1782845829753; Tue, 30 Jun 2026
 11:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260513192551.892309-1-emilne@redhat.com>
In-Reply-To: <20260513192551.892309-1-emilne@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Tue, 30 Jun 2026 14:56:57 -0400
X-Gm-Features: AVVi8CeuOAlYM3Hfkb3TGFjhqYP-TcOdaNtVAFmCgtQD3h0qVOUkXiiAB48UvsI
Message-ID: <CAGtn9rkvFU0aKz6ktJyK3Z8TSGYz0F1YfopeFV+LswUP5yE3ig@mail.gmail.com>
Subject: Re: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue
 deletion in error path
To: linux-nvme@lists.infradead.org, justin.tee@broadcom.com, 
	Johannes.Thumshirn@wdc.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CYyONyv5bVb2NBtQMgHZ3cPKyKAfHIDsL465_wO1nVQ_1782845830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_115903_954252_B8D73138 
X-CRM114-Status: GOOD (  19.73  )
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

On Wed, May 13, 2026 at 3:27=E2=80=AFPM Ewan D. Milne <emilne@redhat.com> w=
rote:
>
> nvme_fc_create_hw_io_queues() will call __nvme_fc_delete_hw_queue() for t=
he
> last queue on which __nvme_fc_create_hw_queue() reported an error when de=
leting
> all the io queues if they cannot all be created.  This is incorrect since=
 the
> last queue did not actually get created.
>
> The most recent change to this code was commit 17a1ec08ce70 ("nvme/fc: si=
mplify
> error handling of nvme_fc_create_hw_io_queues") which moved the cleanup t=
o the
> delete_queues: label and changed the loop bounds, however the code was no=
t
> correct prior to this change in a different way.  The original commit
> e399441de911 ("nvme-fabrics: Add host support for FC transport") had a
> different error which called __nvme_fc_delete_hw_queue() on queue index 0=
 which
> is used for the admin queue.
>
> Fix this by correcting the initial loop index when deleting the io queues=
.
>
> Fixes: 17a1ec08ce70 ("nvme/fc: simplify error handling of nvme_fc_create_=
hw_io_queues")
> Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>  drivers/nvme/host/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e4f4528fe2a2..f5a83798f3a9 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2318,7 +2318,7 @@ nvme_fc_create_hw_io_queues(struct nvme_fc_ctrl *ct=
rl, u16 qsize)
>         return 0;
>
>  delete_queues:
> -       for (; i > 0; i--)
> +       for (--i; i > 0; i--)
>                 __nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i], i);
>         return ret;
>  }
> --
> 2.52.0
>
>

Gentle ping for reviews.

-Ewan


