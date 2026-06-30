Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E24C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=el81ILR0ILUWqApWuwQH7mrJuoQfOrZlrgKYe2SgS58=; b=SLRFsd3BvRI9Uha4AZiNwzD8eS
	73AQfmNAVApkBgv94MPHXBh0Tfgo3OO8TgvrmFi21zC1zaehI1A6tceGi9v1wd9exql0oUcpeT3TJ
	3mBBoZsGzC22impiimH8xPBotpZd3TO5xXkUWBHHOunMP59r3unwc8xeCNcjz2gax//0ulscXdNXt
	nKgphRzc2/mk+B39Aos2VkHB7WWIGWGSLXMLKQDQyYblDRq+BKPzlp4m5st1WHiMy0xUXMFDNs58o
	0V30mEADZw3H5jD8OFCGTY5YJPAH93sZHqbssApvLEo4XaTV9tjt1ybJGTikXIv0+WaApx5p1QzZm
	IrLxDq3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weey7-00000000Atl-17Ws;
	Tue, 30 Jun 2026 20:22:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weey3-00000000AtO-3pbc
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 20:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782850922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el81ILR0ILUWqApWuwQH7mrJuoQfOrZlrgKYe2SgS58=;
	b=UNNZ2PXSwabm5pSGN3kCOr1diM1WWAA/lDK7xi8kOrlo2XrJ7eVKBSixrkuHL7jlaPGiLF
	eRmn2EeNZjBUl0OUcAssuGkGwPI2zp3iB6x05w25YsWWqGlxQ0RZZxozRt1WvwgNpvDN4V
	xjPQyh/tYTiDAyWnb+6bCpxetVEmYXw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-LSVbitJ8MCyAH8hCo2GVfw-1; Tue, 30 Jun 2026 16:19:41 -0400
X-MC-Unique: LSVbitJ8MCyAH8hCo2GVfw-1
X-Mimecast-MFC-AGG-ID: LSVbitJ8MCyAH8hCo2GVfw_1782850781
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f1d3eeab92so31484706d6.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 13:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782850781; x=1783455581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=el81ILR0ILUWqApWuwQH7mrJuoQfOrZlrgKYe2SgS58=;
        b=IQ+e/6SKrUTHrnjf2jVMYF/meNtDQhk/xQuPXLwSPlONvaeDXDQ08j7o3vw7xjQpir
         dOTGzeBdVVmY/9vUTKNn4vkpwyPLKAX4yOf1L1kQMG6HweWojN0bWorTjJEkT4d934cT
         AOquIr932/spteN/X7QDhpKLPq2dmTwXLi0jq6B1/T4W9j24J6nGHgNtFZYtV3HvqVY0
         0I3igNR/TQN73RodTWIYMq37H4a5YU17L2vstH5Sv8zEOaLEHBdXwPENkl6aSB2tHUF4
         ePQP2Wrgv7aW2hILQCPx1TVVYMwaZJBjuIZ0AXTxGDao54N2n47P6wlKOceR3fy+ezXn
         VKqw==
X-Forwarded-Encrypted: i=1; AHgh+RoKuTwYs0X9wbwCsSpF1N0LV2utas909L1dL65FKzVCVfbS+RC6mgE5zVQyptc7UGk9KmD4G+16CW1X@lists.infradead.org
X-Gm-Message-State: AOJu0YylF64azUuBod3pSmSZphUvLjs3nI2sy/y0oYS6QEWIerYtWX9s
	1eaQDrxM1jp+MO4ANWf+l+uNeDroSdL3qreVuqvzawef65FdP3zGSwjU86wB4itwzq0MuxIf/Ob
	Zsm99mySwoZDWB4LnK4uJgDZ2H/uBlHB2mEJFZkU2gMsm5wEyUa+jIM9+zkoj9j+WXU1t
X-Gm-Gg: AfdE7cn4+t8pjWigRZu54CPua0E/x+DeCfBhNNKwop8EKmWU7nz8523GlwUN7xsrJm9
	yh0mbrFv70bez6BMjXVZtXtivXV46nCt9+HCSiPsHMck2AAraOLBc4/8SV62l0bR0EI/OCz768f
	iCy1bnwE6cCuLpdTrPaR7q7fMMdicSsH/IUqRiss6NRAgudBzU4Qry5Q+4Sf/oEosKwhd4sfc2h
	hb/vFhGzVh+4stkmfy3VKK9xCMHoyrpYwdnH1Mm+C80Xr3veiD1RKrL+8vmaAi9EHqEtizqs1U7
	3rnq4U/7zwFFZUBk3qzczBtCHtn8Qj/fdndT5u8yFwvoYPLXoa6CIB4/i43+KDQMpCitN05m5yu
	ExTswN55uUyi8FLMpMtSrL6y1jE64NC4qyvIaKN4SWaPsy4M=
X-Received: by 2002:a05:6214:498b:b0:8e9:f62b:bedf with SMTP id 6a1803df08f44-8f1bbdcbda8mr81372326d6.47.1782850781012;
        Tue, 30 Jun 2026 13:19:41 -0700 (PDT)
X-Received: by 2002:a05:6214:498b:b0:8e9:f62b:bedf with SMTP id 6a1803df08f44-8f1bbdcbda8mr81371576d6.47.1782850780359;
        Tue, 30 Jun 2026 13:19:40 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a717edc7sm31813576d6.36.2026.06.30.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:19:39 -0700 (PDT)
Message-ID: <bc8ecded9145e89cc1a36e93afe37d431d7141c3.camel@redhat.com>
Subject: Re: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue
 deletion in error path
From: Laurence Oberman <loberman@redhat.com>
To: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org, 
	justin.tee@broadcom.com, Johannes.Thumshirn@wdc.com
Date: Tue, 30 Jun 2026 16:19:38 -0400
In-Reply-To: <CAGtn9rkvFU0aKz6ktJyK3Z8TSGYz0F1YfopeFV+LswUP5yE3ig@mail.gmail.com>
References: <20260513192551.892309-1-emilne@redhat.com>
	 <CAGtn9rkvFU0aKz6ktJyK3Z8TSGYz0F1YfopeFV+LswUP5yE3ig@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0zQcotiFEU33TfkXHjS1cFl_IaC63rutXx2LXLvid3U_1782850781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_132204_023936_A8CA409F 
X-CRM114-Status: GOOD (  24.55  )
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

On Tue, 2026-06-30 at 14:56 -0400, Ewan Milne wrote:
> On Wed, May 13, 2026 at 3:27=E2=80=AFPM Ewan D. Milne <emilne@redhat.com>
> wrote:
> >=20
> > nvme_fc_create_hw_io_queues() will call __nvme_fc_delete_hw_queue()
> > for the
> > last queue on which __nvme_fc_create_hw_queue() reported an error
> > when deleting
> > all the io queues if they cannot all be created.=C2=A0 This is incorrec=
t
> > since the
> > last queue did not actually get created.
> >=20
> > The most recent change to this code was commit 17a1ec08ce70
> > ("nvme/fc: simplify
> > error handling of nvme_fc_create_hw_io_queues") which moved the
> > cleanup to the
> > delete_queues: label and changed the loop bounds, however the code
> > was not
> > correct prior to this change in a different way.=C2=A0 The original
> > commit
> > e399441de911 ("nvme-fabrics: Add host support for FC transport")
> > had a
> > different error which called __nvme_fc_delete_hw_queue() on queue
> > index 0 which
> > is used for the admin queue.
> >=20
> > Fix this by correcting the initial loop index when deleting the io
> > queues.
> >=20
> > Fixes: 17a1ec08ce70 ("nvme/fc: simplify error handling of
> > nvme_fc_create_hw_io_queues")
> > Fixes: e399441de911 ("nvme-fabrics: Add host support for FC
> > transport")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> > =C2=A0drivers/nvme/host/fc.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index e4f4528fe2a2..f5a83798f3a9 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -2318,7 +2318,7 @@ nvme_fc_create_hw_io_queues(struct
> > nvme_fc_ctrl *ctrl, u16 qsize)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=20
> > =C2=A0delete_queues:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (; i > 0; i--)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (--i; i > 0; i--)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i],
> > i);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > =C2=A0}
> > --
> > 2.52.0
> >=20
> >=20
>=20
> Gentle ping for reviews.
>=20
> -Ewan
>=20

Looks good to me, loop index is corrected.

Reviewed-by: Laurence Oberman <loberman@redhat.com>


