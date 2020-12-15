Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3DC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 13:34:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8564C22482
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8564C22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SMWuszBn4Lf0FE8FZADg/0Ijec5JXOJagxXb5y70mvk=; b=BFdMaT3i22s5JIOj5sOJwGnqw
	CL85lwPpHw2Q1/oK6o0JICR9ecDxpccmpofI/BNRJwYneZL4jtPgir92qqgv1YnLW2ZFv+iD4EH03
	hhHTSOhssjRmoo4fbgNPN8f4U+mU0fm+Fq5Io/nHHSdBDIVFFhXvT2oxSFN7UHMzFPJbII87zo8a+
	rQ1wQuSyWasGWqKNvW+6Vlg4BhpkSHjDJGLN8qfR+YhPoJNQJHAri6iUWJqjNnInb7ooWZZdhQhi3
	4WkJNneRLYfM30DhdL7rQqYs5LWZ14y32AlqW8AcEk32rWfWq+a+cOMEl09xvIETCpfAJcbe13fQ4
	q8/3xC0aA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpASy-0002dK-DI; Tue, 15 Dec 2020 13:34:12 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpASs-0002cx-Ar
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 13:34:10 +0000
Received: by mail-ed1-x543.google.com with SMTP id b73so20982860edf.13
 for <linux-nvme@lists.infradead.org>; Tue, 15 Dec 2020 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8fHZY8jQhIBpusF6yf8e92qQDUahX34y07cjU+x+4Lc=;
 b=cO/R8zqzXQWaqT/sxc9QrhmMQ2504daZiE8+OwYV4SXqyBvDGUtrz9RfITI24qs9Wo
 j/eq9yOerSXt+zy1In85b1+nscjDqMKMC+0peh5PgLjQ+9be35aZyQJEi//jyAtT4Oe3
 fE1VKs79YGUHzNdq9eOcX2SXWF831SNcnGl5bngL3X6j+HOl0oX+ZKNmKySDU3LYYine
 JQwFUUCETA/CngNdVEkHP4jTArbiUAs/TaPaKrV5BqM0BUxv+I4/GP9NGkhwQoanUMt6
 bA9cuoCvN/zEet9oHUn/36WFPydl4hsLpq7HTFoSaLVEuckDOL/fmUYojEhtdTyiLE/l
 Wp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8fHZY8jQhIBpusF6yf8e92qQDUahX34y07cjU+x+4Lc=;
 b=hkCFvSht0USI2QLfAX3qdWrTkvBSEFgt8joCuntxmTmn1vzjNbmfD1i4HYgU5qcvTe
 G7gTwgmQnkyT/pGwMwbu+zuK/MpeaZd7yg28yVzmxhEf9DHF17NPiu7YdA/7hxVAMJ+/
 C0S1IJ11XenX8AvEOrouB6T5VKatus6mNRQ4MYpfk/pJ1E1TYJNFqYsMqIAsTX9OeTCq
 6B/El9mT8+1ci6AFzGq5kZU7Lr9GNcFM38+PGNYnhciDcvZckG1sYv5e5Mz2LeZ5Lu0Y
 iFP0rWJTRqkkL+pnvWwmvZNvISdT5cfcc5FHTzBEsig9oFPq21BoGtbABQ7dL7j26A0X
 lPiw==
X-Gm-Message-State: AOAM533syv8MgeIXh4LAeYR0nGG7hliiXSi3uZ4j26zAtJJuNUkIceci
 hQ92LzQd56lIvqFF41oIwpMvp4IdYfLfi1ZAEfg=
X-Google-Smtp-Source: ABdhPJyOR8l+ibYSEWSbxbgeDrfjSe24miZDy1PKnHAvU2OPvW5AecKexf8MaJ2VVOKAVGTZVgbXdYNr6BRVh7dc5yo=
X-Received: by 2002:a50:8744:: with SMTP id 4mr29241136edv.362.1608039242936; 
 Tue, 15 Dec 2020 05:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-6-borisp@mellanox.com>
 <PH0PR18MB3845486FF240614CA08E7B4CCCCB0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <0a272589-940c-6488-9cb9-1833400f38b3@gmail.com>
In-Reply-To: <0a272589-940c-6488-9cb9-1833400f38b3@gmail.com>
From: Shai Malin <malin1024@gmail.com>
Date: Tue, 15 Dec 2020 15:33:50 +0200
Message-ID: <CAKKgK4xvS9SeM3NmNKDNe5oFxxfi0m_=iHCXeXX0DGcgzG_BBA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/15] nvme-tcp: Add DDP offload control path
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, 
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, 
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_083406_408917_EAD1C206 
X-CRM114-Status: GOOD (  20.49  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>, Shai Malin <smalin@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "benishay@nvidia.com" <benishay@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, Shai Malin <malin1024@gmail.com>,
 "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/14/2020 08:38, Boris Pismenny wrote:
> On 10/12/2020 19:15, Shai Malin wrote:
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index c0c33320fe65..ef96e4a02bbd 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/blk-mq.h>
> >  #include <crypto/hash.h>
> >  #include <net/busy_poll.h>
> > +#include <net/tcp_ddp.h>
> >
> >  #include "nvme.h"
> >  #include "fabrics.h"
> > @@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
> >       NVME_TCP_Q_ALLOCATED    = 0,
> >       NVME_TCP_Q_LIVE         = 1,
> >       NVME_TCP_Q_POLLING      = 2,
> > +     NVME_TCP_Q_OFFLOADS     = 3,
> >  };
> >
> > The same comment from the previous version - we are concerned that perhaps
> > the generic term "offload" for both the transport type (for the Marvell work)
> > and for the DDP and CRC offload queue (for the Mellanox work) may be
> > misleading and confusing to developers and to users.
> >
> > As suggested by Sagi, we can call this NVME_TCP_Q_DDP.
> >
>
> While I don't mind changing the naming here. I wonder  why not call the
> toe you use TOE and not TCP_OFFLOAD, and then offload is free for this?

Thanks - please do change the name to NVME_TCP_Q_DDP.
The Marvell nvme-tcp-offload patch series introducing the offloading of both the
TCP as well as the NVMe/TCP layer, therefore it's not TOE.

>
> Moreover, the most common use of offload in the kernel is for partial offloads
> like this one, and not for full offloads (such as toe).

Because each vendor might implement a different partial offload I
suggest naming it
with the specific technique which is used, as was suggested - NVME_TCP_Q_DDP.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
