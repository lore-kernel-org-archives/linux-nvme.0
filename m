Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518B2C67861
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvtBlLgsjPeILqVN/9Yh5/QMH6Mpc6x+YJltBI2Ylcc=; b=VIFWY7Jlgf0MplLWEqg1HKPeo3
	Fcf5lak5Z+8DxPlVrzUN9wH6An6deGIb+RH8ZvOBHpgEvFcTVl3oqGqdpAnv1Y6PbYtb4NbBejN0e
	ouuVPH4Wz/bmvLhMz9co/vKLzzcYj8W97TcsBYGJOh+YiLOxpGzj+v+WHXqpJXefGNkYZ04LWCOp4
	CnzxRb47gfJ/r3ktMCdwPH3xGHkCLsMBdDWzYnvFvKNlhpc/YN6MQYabuEdwdRwKTDZovQsdHQYYK
	dQqLlZhFe8TirBP6EkONkp2iSDymZaLlDFd2FKMzExNK7x6/haY8dOgLglduRO6yGah+1fWWHtm1V
	c6+7AcNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMJh-00000004VsV-3UUo;
	Wed, 10 Apr 2024 00:59:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMJY-00000004Vkk-43GT
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 00:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712710783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvtBlLgsjPeILqVN/9Yh5/QMH6Mpc6x+YJltBI2Ylcc=;
	b=I8zxOk9JJlQ7agflufeRr8HTNGgXrzv26pAgkWyf6R6Od4+43p31wuWLqKjqHn6I4eCEwx
	wXkjXxW4LVY2uxoSHiwVySLV4PnRnthGQBsVXftOZ0ap2qec1L0X9KSRFq7JyN9NU9kzOE
	j0xbd7X256mF8ygjEoCSU2Jhga4DOTw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-PVlxDicjMTusZCuVlJK7dA-1; Tue, 09 Apr 2024 20:59:42 -0400
X-MC-Unique: PVlxDicjMTusZCuVlJK7dA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso4403585a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 17:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712710781; x=1713315581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvtBlLgsjPeILqVN/9Yh5/QMH6Mpc6x+YJltBI2Ylcc=;
        b=QnT8TIueV6jt7COxi7u7kFd57zL48AnUY3uYiszF66jg3lRYynQRnneNK7QSvIDvMz
         O1dX7ZRy39JrQSP+c8N33dgyW+KhRNNtWRNA/WSSjkJEsmODIVGZST8eVg0Pbaksmdv8
         l5PdLB0K52mI/oSOu29uNjuYdHA1O1ewEQ7n0pCJA6iiIxfHVK5wAamsGHEJsZlEq19Z
         UIXti/N1zjIT4rl9YAytbVvwmiLzBRZ4kQnXPCxu6rJbrWPiMmWBmqCo/YyfVnUZA1A0
         zVnpvhSKdwz3dayanDtgx4+D3/A9nbtz5aQqK53TB1DACepfgOzWHRoKhOCdC+Vjp8MR
         X2Ng==
X-Gm-Message-State: AOJu0YyfVjyYf2JiA5XpA1px/sUrBRWN4r+6u0jrBoGVHHRRAzql3qZL
	Q+7MDpuk02Duylraq9GKrYD6t8onVkeo8JUo809iprJWh7TNmkJQ0niFDVGPzUsqe4PGZNmWonl
	zwa1smeeyC4s+IvfQpmSPpeBVWdTcmt+cmJ5B14s6rdJd8p/oek6ABl+V+euOIiNWTz8gJlElyL
	mDfA1l593FdIlokEhZZSa+iWrDLh77lS5XsIvfa54=
X-Received: by 2002:a05:6a20:3215:b0:1a7:a6d1:2d09 with SMTP id hl21-20020a056a20321500b001a7a6d12d09mr1317518pzc.55.1712710781305;
        Tue, 09 Apr 2024 17:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZgCg9ZPiKbUebaSIperd6RXnT5MwiyrdEnpeLiMxvtOVg017guNok0rOk3FzaAGtscKanTuKAEFmZXS7Y60o=
X-Received: by 2002:a05:6a20:3215:b0:1a7:a6d1:2d09 with SMTP id
 hl21-20020a056a20321500b001a7a6d12d09mr1317503pzc.55.1712710780977; Tue, 09
 Apr 2024 17:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240408061809.4010087-1-yi.zhang@redhat.com> <55aa5526-ab31-43be-8ca2-d554fc22603e@nvidia.com>
In-Reply-To: <55aa5526-ab31-43be-8ca2-d554fc22603e@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 10 Apr 2024 08:59:29 +0800
Message-ID: <CAHj4cs806xKKwK8JcxwzNhnY9hL3reVwBVmihZmwFbS4-EDZvQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_175949_805465_ECACD5AD 
X-CRM114-Status: GOOD (  17.23  )
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

On Wed, Apr 10, 2024 at 6:40=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 4/7/2024 11:18 PM, Yi Zhang wrote:
> > Only print oneline log about shared namespaces without CONFIG_NVME_MULT=
IPATH
> >
>
> Consider following commit log :-
>
> Move the period '.'that is currently at the end of the line after
>                                                      newline '\n' to
> before newline character which is the right position.
Thanks, just send v2 as suggested.

>
> > Fixes: ce8d78616a6b ("nvme: warn about shared namespaces without CONFIG=
_NVME_MULTIPATH") > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 27281a9a8951..e4bec200ebeb 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3681,7 +3681,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, =
struct nvme_ns_info *info)
> >                               "Found shared namespace %d, but multipath=
ing not supported.\n",
> >                               info->nsid);
> >                       dev_warn_once(ctrl->device,
> > -                             "Support for shared namespaces without CO=
NFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
> > +                             "Support for shared namespaces without CO=
NFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
> >               }
> >       }
> >



--=20
Best Regards,
  Yi Zhang


