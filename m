Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF04C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJEqaZnwaqHIDBttaQK32cmu4xFKEuoEEBTEJJb0tbo=; b=WsBLOFEiHrMQPZ9PGC3rWH/LKp
	r3St1xgoApwzuz5lEoxF7cGLcHg663zK5suLTSjjTiBHv9XF0FX/K3GalXOpoADgD/NQkbtHqyhKp
	ldVugKfkoOXFF1t+UtD9MnZAogm0rAJRIhikGvn3f7KX+FRP3pa4e/4hO6Md/6OdFD2W4nEFFQuZa
	yFvgASYMEShjNFpMGlou92lf5SSVbfA+ul4UBWp0lYnYC1aEIkfxpaOry5kizwfD1atxMOXR/8Tvq
	uRTt4ZuO+xO4Yx040goIPkBIOrHhsbrbDrEGodgCOPe+cSWBZdzay7IaXMW63Dkylb/F5o+lJLxN6
	sy725S4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxgLz-003Iaw-MA; Thu, 16 Dec 2021 02:18:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxgLw-003IaI-Pb
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 02:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639621117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJEqaZnwaqHIDBttaQK32cmu4xFKEuoEEBTEJJb0tbo=;
 b=WdEClvA9DPcWQ2lovfkgrqz+Pv0HzO3LnejOrR/K0DKpMxE+fKCzHV1guqYB6FDSpEKzj8
 IytxKuJ6+hKI1yaTpsUELwJM1n5Cy5QNMPd7Ep5pxbcnZiPT+XTFr5SP2dfB3eeQFpDX9B
 /J1ht1xk0Vay8IvN9gajK+aZ+drU5pk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-aEQ7q9UZP3WjCQ4gXYpmGw-1; Wed, 15 Dec 2021 21:18:36 -0500
X-MC-Unique: aEQ7q9UZP3WjCQ4gXYpmGw-1
Received: by mail-pj1-f70.google.com with SMTP id
 w5-20020a17090a380500b001b112521410so1319976pjb.8
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 18:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TJEqaZnwaqHIDBttaQK32cmu4xFKEuoEEBTEJJb0tbo=;
 b=bKwcMEpG9hWXerKCN3B9rNH43jqVyZtsu8VVYW6qkdT+lEjDfUHHzGEyncThZamRnS
 ejmJP9Qp+PeQCnOuQtDgZg6AEsiyKpK4ECMV78mZb9qKvF6pju2i1wtH/wq9VEWVCXa+
 JVlWEw6w4eCN1wPmHbvF3IjjqQBdy4hUVcSqUh9qVPO4S1z9Yk3Bu4nukH4CysHs4AgT
 5gVZsBUsZj6u19uDPqHXJ/sMs+m+JB+zbQ1UWFXORLiwtFev3alg7TzOWDhFxRtDUIrt
 /JHPiEUkmszOEyKOlUAZQRTj8wNPBdXDb4hjLhslBTkydsnM8PBq1FKEtGeHcqphGUCs
 Aj8g==
X-Gm-Message-State: AOAM533xviu+CxJL76NDHlBJUcNYtn+ZMB3IURwhU/aAl9aXzJGex/iX
 +Ny1rrpHX11wMrHDikXS53Gxs8TtnTv43aqfQsx1zv28n2l0mSlNfCAn7U2m6ThTCQ54/vrIcRo
 uVYp0Q68GhQNB9Ft1ORtvKP2TY0Q6kCTAzgXkqtLPfpM=
X-Received: by 2002:a63:d811:: with SMTP id b17mr10022726pgh.562.1639621115489; 
 Wed, 15 Dec 2021 18:18:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTVTrHKuXk9QF8yS4tD1ghF4iafol+pBJGEpf7dAgfVW8fm3L4m5qCHScVjeqrtQbMWWL1MoQ23XhWUQr1tZM=
X-Received: by 2002:a63:d811:: with SMTP id b17mr10022704pgh.562.1639621115230; 
 Wed, 15 Dec 2021 18:18:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
In-Reply-To: <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 16 Dec 2021 10:18:23 +0800
Message-ID: <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
 RDMA mailing list <linux-rdma@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_181840_949803_5A54A19C 
X-CRM114-Status: GOOD (  22.99  )
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

On Wed, Dec 15, 2021 at 8:10 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 12/15/2021 3:15 AM, Yi Zhang wrote:
> > On Tue, Dec 14, 2021 at 8:01 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 12/14/2021 12:39 PM, Sagi Grimberg wrote:
> >>>>>> Hi Sagi
> >>>>>> It is still reproducible with the change, here is the log:
> >>>>>>
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real    0m12.973s
> >>>>>> user    0m0.000s
> >>>>>> sys     0m0.006s
> >>>>>> # time nvme reset /dev/nvme0
> >>>>>>
> >>>>>> real    1m15.606s
> >>>>>> user    0m0.000s
> >>>>>> sys     0m0.007s
> >>>>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> >>>> Yes, with -i 4, it has stablee 1.3s
> >>>> # time nvme reset /dev/nvme0
> >>> So it appears that destroying a qp takes a long time on
> >>> IB for some reason...
> >>>
> >>>> real 0m1.225s
> >>>> user 0m0.000s
> >>>> sys 0m0.007s
> >>>>
> >>>>>> # dmesg | grep nvme
> >>>>>> [  900.634877] nvme nvme0: resetting controller
> >>>>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
> >>>>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>> [  917.600993] nvme nvme0: resetting controller
> >>>>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> >>>>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> >>>>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
> >>>>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> >>>>>>
> >>>>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
> >>>>> Then I think that we need the rdma folks to help here...
> >>> Max?
> >> It took me 12s to reset a controller with 63 IO queues with 5.16-rc3+.
> >>
> >> Can you try repro with latest versions please ?
> >>
> >> Or give the exact scenario ?
> > Yeah, both target and client are using Mellanox Technologies MT27700
> > Family [ConnectX-4], could you try stress "nvme reset /dev/nvme0", the
> > first time reset will take 12s, and it always can be reproduced at the
> > second reset operation.
>
> I created a target with 1 namespace backed by null_blk and connected to
> it from the same server in loopback rdma connection using the ConnectX-4
> adapter.

Could you share your loop.json file so I can try it on my environment?

And can you try it with two servers that both have CX-4? This should
be easier to reproduce it.

>
> I run a loop with the "nvme reset" command and it took me 4-5 secs to
> reset each time..
>
>
> >
> >>
> >
>


-- 
Best Regards,
  Yi Zhang


