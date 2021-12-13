Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56361C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 06:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5eyy1HO+IU7Y6V2b9JJ2wD73RzINwwNXz7T1ohguGw8=; b=LR6pMfcynTQdvhpkJsr+8FwZrb
	XdLvKFfw/ZIZGel0Rjq/EJh+OIrsrMe6aDf6H5BNEOaNKj6ZtABSPOzu2xL1zEb1uBDf6ogwohG33
	lEsiTRu2OT5xIB1eh/Y7LmrED1SIz6W55lb4BVHhXFOjuako/x90sPO2Bm33TA0W/2PGGQYFknSWc
	EdZYEVowoCBya22cA4LAwK9bVtHEzc9WC0QT3hYmQsv1Em/8kheizIjspfaMzlfT34PUaa5YrxpCI
	cdSnEUV18YvHN5OGQJZIBXQJHak8TgowVWEfnRfxIdGeF7NIX4vS//y43Fn+6uXr4w5icUea6f6qT
	MnCanQRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mweZn-007vMr-Bb; Mon, 13 Dec 2021 06:12:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mweZk-007vMV-La
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 06:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639375959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5eyy1HO+IU7Y6V2b9JJ2wD73RzINwwNXz7T1ohguGw8=;
 b=Lp5qUusvz9DEO5qYbW2eM33Y3hKpEElrFDaX4FjGRcqoHNPccx0pF5Bto1qLSyhVqCIS0a
 ihRZgVBqxIXTHBRSx0gT6lTJhoXOvlcsaoBbhaUuIIJAj0kS2YGghJu9D9MTofl+uG3DW0
 AwrVwA2hRm0wQPKoDlQuvr0TOOBFOQc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-4WahjKXuNV6orWls3u0NHw-1; Mon, 13 Dec 2021 01:12:37 -0500
X-MC-Unique: 4WahjKXuNV6orWls3u0NHw-1
Received: by mail-pj1-f69.google.com with SMTP id
 l10-20020a17090a4d4a00b001a6f817f57eso9621178pjh.3
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 22:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5eyy1HO+IU7Y6V2b9JJ2wD73RzINwwNXz7T1ohguGw8=;
 b=nhUvw7LJF+VybTPdvXUfaglEvGjCPRURMTHvjqSbCBzzk+IopQhk9R+6+5BYX1mOV4
 WuSbL+1M0Mge/FFT4aIiYCNet9aZOYdJT8ad45X2CegCafH2+4jFXGtzvSjwmnULwy21
 ZF+MAbkBSv9cGX3FvsBfn0ped8lJdRwdsKPk8xcgiIykQ6UaDAyZIK2klLdbF4jtnnWK
 mfNxXfr2yntcVRJaRlpkZi9jzVSypN+60y36EasLAezRWCzjH1tUaO5p37m8NqFjPjjW
 tOyy8BedzpEB7xSY2SeyEy4y93As6WBdzgBrbOc8o4aEWzyJPO5a47EP8iY4oVq7GMH/
 0Owg==
X-Gm-Message-State: AOAM530K7NBt6USIG0s5AribIq6OqWN2ak/imXY8MAm8jol+b4zTId+w
 NgYhzmzBysFJTX4iZrlaS4kAyRy0AmCmOcG53FBvrb2lbC9dOk1ooowDPT9Zs7utJaCm8tTlOXF
 DaBo6ZrmXvRtKK5KZCN8SN6zgwRk5TU+n80tT199T/Es=
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id
 6-20020a170902c20600b0014206315ffcmr94516313pll.38.1639375956419; 
 Sun, 12 Dec 2021 22:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUlwGd2f7ZhIQhO5WmZ4p3+5f1C9vaFZ+q2l6rAWIfgqz+p2EgTGre6Ig4y4MlhIVCCLqzx6ujWsY66nnoCQ4=
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id
 6-20020a170902c20600b0014206315ffcmr94516278pll.38.1639375956088; Sun, 12 Dec
 2021 22:12:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
In-Reply-To: <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 13 Dec 2021 14:12:24 +0800
Message-ID: <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_221240_828247_2D84344A 
X-CRM114-Status: GOOD (  27.24  )
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

On Sun, Dec 12, 2021 at 5:45 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
>
> On 12/11/21 5:01 AM, Yi Zhang wrote:
> > On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
> >>
> >> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>>
> >>>
> >>>> Hello
> >>>>
> >>>> Gentle ping here, this issue still exists on latest 5.13-rc7
> >>>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.636s
> >>>> user 0m0.002s
> >>>> sys 0m0.005s
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 0m12.641s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>
> >>> Strange that even normal resets take so long...
> >>> What device are you using?
> >>
> >> Hi Sagi
> >>
> >> Here is the device info:
> >> Mellanox Technologies MT27700 Family [ConnectX-4]
> >>
> >>>
> >>>> # time nvme reset /dev/nvme0
> >>>>
> >>>> real 1m16.133s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>
> >>> There seems to be a spurious command timeout here, but maybe this
> >>> is due to the fact that the queues take so long to connect and
> >>> the target expires the keep-alive timer.
> >>>
> >>> Does this patch help?
> >>
> >> The issue still exists, let me know if you need more testing for it. :)
> >
> > Hi Sagi
> > ping, this issue still can be reproduced on the latest
> > linux-block/for-next, do you have a chance to recheck it, thanks.
>
> Can you check if it happens with the below patch:

Hi Sagi
It is still reproducible with the change, here is the log:

# time nvme reset /dev/nvme0

real    0m12.973s
user    0m0.000s
sys     0m0.006s
# time nvme reset /dev/nvme0

real    1m15.606s
user    0m0.000s
sys     0m0.007s

# dmesg | grep nvme
[  900.634877] nvme nvme0: resetting controller
[  909.026958] nvme nvme0: creating 40 I/O queues.
[  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  917.600993] nvme nvme0: resetting controller
[  988.562230] nvme nvme0: I/O 2 QID 0 timeout
[  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
[  988.608181] nvme nvme0: creating 40 I/O queues.
[  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.

BTW, this issue cannot be reproduced on my NVME/ROCE environment.

> --
> diff --git a/drivers/nvme/target/fabrics-cmd.c
> b/drivers/nvme/target/fabrics-cmd.c
> index f91a56180d3d..6e5aadfb07a0 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -191,6 +191,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl
> *ctrl, struct nvmet_req *req)
>                  }
>          }
>
> +       /*
> +        * Controller establishment flow may take some time, and the
> host may not
> +        * send us keep-alive during this period, hence reset the
> +        * traffic based keep-alive timer so we don't trigger a
> +        * controller teardown as a result of a keep-alive expiration.
> +        */
> +       ctrl->reset_tbkas = true;
> +
>          return 0;
>
>   err:
> --
>


-- 
Best Regards,
  Yi Zhang


