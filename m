Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B718EE77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4H6BYBpPYkRFZnQPMJXxpY+I4Pkepc44pNcpMerJ+s=; b=pKryByJjjPF5QeuvSfrbdszLzo
	wePojn/DfMTXDXEos4p8lbUBR8cKMxwESsm6C8LTYocQhOUq7WlgChIt35SKjhGKr6jB4g1Il3KUx
	Rp82AdHkz9WEwSh4NvNm1R8kb4/YaRVhu8iVx4aUKTS28P7Ut4549QkuweWNyfuG8ULEncQAr4gCe
	eOqJmfEpGT8wJkhOR0VRJ7GQiavqpqpOMd27ES81ex5CGWZoipR2QdeGjHbWChYWYs9KGvWHNH7Sx
	fGNWmf4pNYn6QzSOYspU8ExKmaPsupzadLhyzHFo7kBtV4SGe8z9seM8R6F7UZKnet3H8W4eySsSE
	5tKYTesw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTlos-0000000DclN-3wc4;
	Fri, 03 Jan 2025 17:50:46 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTloo-0000000DckA-392e
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 17:50:45 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so2664506a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 Jan 2025 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1735926641; x=1736531441; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4H6BYBpPYkRFZnQPMJXxpY+I4Pkepc44pNcpMerJ+s=;
        b=VDUfrSZky6na9lGw8girBhpW21h2mYn3QgXTv/dCqopH5XP+8+nkDu9vz7occDh8SE
         o/p8BCKBZb7irSl1zM97jM2/qP9rD0FESli9RtLNYWuK5837qD8ZaZ4DjquOJyA901kb
         dMsaFUWpBOaKqfrwFQSGdVVX5PQYNUt80QA3bcO7SRYFkO8m7SvsKLdGZkeupBXYEWBr
         QJv1u4sFWuk6kYJ32qjWwd9OWf5GJrB9FrWearAN1CUN9dMsdntobzp4VSPTvqHErrlD
         hnmxzvOAI+OMs4ocLKiixQi3BU7/OuLagxwsbzbzYE6fY7p61xzq087vM1nXAo9gEX7W
         3IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735926641; x=1736531441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4H6BYBpPYkRFZnQPMJXxpY+I4Pkepc44pNcpMerJ+s=;
        b=og/oDMn+OuIS7Stll8TKDU18bz6sMqDmiUznhvTTyJTK0JvHISIiZfxZiBAGctG5AW
         W/CqByBbEbfqp2ONtYdHI+szQSLr5OtbK/H/1U5WAAIcrRTWmiWpvDBaPSkLGJ6InxKu
         c8U0mWe/UDm3j5cc+Rz9lJpMSYEPE7htyVxkcL62mEENjIN6AVfT5Cv2yaJ5jUI5zEZL
         4zPtvCRQNSMHmY6HI65/xk6rdTYq/CUJNEZ4H/LLIZ23N4N6PrrLcD7/UYesCaG003fI
         mWHmiHxi7xr/1umuSJw13t+/sP+ML73Qs/NTOHJRxsaf402UgsoPFWJhhnctaqvAPPPv
         8tvA==
X-Forwarded-Encrypted: i=1; AJvYcCUVNgoDeiOlxf0S+BbyZMhR/N0jI2ESSi7slSUOVsIrw3DIkUHYj9H3aIzn5oockX3VagJlQXNvlXdE@lists.infradead.org
X-Gm-Message-State: AOJu0YxxnvRyDgblH69f3gJoK68R90QR6BEK5wZuoORaV9PO2OIHYwKD
	uN1M4qHzlR0HU+Z3BsYzofeX2IfBgtvyGhLud2lwfQdjxcvaD1QNwq0Tw/jj5XLILxLjB6/f/Te
	mjpaolMloEd+QOrlkcM9GIbPnZyIqPWyrga8hnA==
X-Gm-Gg: ASbGnctvDDf2rQXVUQ50Vxc/gMzwOJuA++Z1xEgM+cc3+R/gPu3BPVUsOTrmNKnpGgP
	9tioU5MdPkY/YpOONHi8a+09y+4hAd1BgKcMJjQ==
X-Google-Smtp-Source: AGHT+IE612wA6ryAX221wIT/7SaY5RIUdIP8axL1NqLx4f/wEM/pAhj7ctZ6LtmmgsKO/79stsvyHzwFG2BWgTgynZs=
X-Received: by 2002:a17:90a:d650:b0:2f2:f6e5:d28e with SMTP id
 98e67ed59e1d1-2f452e16399mr28584893a91.3.1735926641405; Fri, 03 Jan 2025
 09:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20241226104546.13705-1-arefev@swemel.ru> <20250103070130.GB28303@lst.de>
In-Reply-To: <20250103070130.GB28303@lst.de>
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 3 Jan 2025 09:50:29 -0800
Message-ID: <CADUfDZo2+_Au=3g6_1OOMGcBcJYKuCccWnJUKENVsq-j_8umFA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_nvme=3A_Enter_string_size_calculation_=E2=80=9Cs?=
	=?UTF-8?Q?ubsysnqn=E2=80=9D?=
To: Christoph Hellwig <hch@lst.de>
Cc: Denis Arefev <arefev@swemel.ru>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_095042_822827_BD28FAD6 
X-CRM114-Status: GOOD (  19.60  )
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

The bug has already been fixed in commit 4db3d750ac7e ("nvmet: Don't
overflow subsysnqn"). It is using the kmemdup() approach (technically,
kstrndup()) suggested by Christoph.

On Thu, Jan 2, 2025 at 11:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Dec 26, 2024 at 01:45:35PM +0300, Denis Arefev wrote:
> > When memory is allocated, the size of the string
> > is calculated nvmet_subsys_alloc(...).
>
> s/is/is in/ ?
>
> > When memory was accessed, constant size was used.
> >
> > Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
> > Reported-by: syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Da84181c81389771eb46a
> > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > ---
> >  drivers/nvme/target/configfs.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/confi=
gfs.c
> > index eeee9e9b854c..2f74204d000e 100644
> > --- a/drivers/nvme/target/configfs.c
> > +++ b/drivers/nvme/target/configfs.c
> > @@ -2247,14 +2247,15 @@ static struct config_group nvmet_hosts_group;
> >  static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
> >                                            char *page)
> >  {
> > -     return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsy=
snqn);
> > +     return snprintf(page, strnlen(nvmet_disc_subsys->subsysnqn, PAGE_=
SIZE),
> > +                     "%s\n", nvmet_disc_subsys->subsysnqn);
>
> This doesn't really make sense as %s already calculates the length
> of the string internally.
>
> >  }
> >
> >  static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item=
,
> >               const char *page, size_t count)
> >  {
> >       struct list_head *entry;
> > -     size_t len;
> > +     size_t len, nqn_len;
> >
> >       len =3D strcspn(page, "\n");
> >       if (!len || len > NVMF_NQN_FIELD_LEN - 1)
> > @@ -2271,8 +2272,9 @@ static ssize_t nvmet_root_discovery_nqn_store(str=
uct config_item *item,
> >                       return -EINVAL;
> >               }
> >       }
> > -     memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
> > -     memcpy(nvmet_disc_subsys->subsysnqn, page, len);
> > +     nqn_len =3D strnlen(nvmet_disc_subsys->subsysnqn, NVMF_NQN_SIZE);
> > +     memset(nvmet_disc_subsys->subsysnqn, 0, nqn_len);
> > +     memcpy(nvmet_disc_subsys->subsysnqn, page, nqn_len);
>
> The memset should still happen for the entire field, only the copy
> needs to me limited.
>
> But i really wonder if we should do away with this mess and just
> use kmemdup()ed allocations for the nqns.
>
>

