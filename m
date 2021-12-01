Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CFCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Dec 2021 04:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b7gZUOdzVQidUkCgddob4WitrLX9vYPiAZfu9bmug6E=; b=r/csVbQTCzGA1wNvaRstUXom00
	YEV5DpVdJdlOLEXo/Feb3Qs6j3qMomng8RNvpqshi0Rvch0f0FMR4+PEk4G7g2TP4NFuP8Ye6KHUI
	PH4TH+peKORqOW5XTojXw+km/kuKjgaBr0zsGmWPGH5Y8ejkDeur7kXZFR+ENHhVviMXNhdfIwC/X
	qUSufEJo7AtgV69K6cilhpbrsJ69EZb59U/vTJ9Eewni7JQ73rP0N9dRWuLfRUe1aZcMoHJGiFEl2
	SlJqVBHSiOAcSNYHgndDGv3C7VRyj65RXg27JcSpOqKy4HvEixRyNC5NI4HIQ8xkIMjw9pPAcV1Md
	Y6wn9gLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msH4b-007Rfi-B2; Wed, 01 Dec 2021 04:18:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msH4X-007Re7-SM
 for linux-nvme@lists.infradead.org; Wed, 01 Dec 2021 04:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638332298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7gZUOdzVQidUkCgddob4WitrLX9vYPiAZfu9bmug6E=;
 b=dAh24/vH77dvUiq9ZrHzyM9pQRrSY2NPu+eVFHdoV/kAUfy/AscNaShSCw7IC7+0xDoDQQ
 eXQht3XB26wzUSm0BYqzVtDeAaPffUGRH7Y29Y8kDT/c/UCCqibDNFl2WDDRkMd/87m+qk
 S33iVs2/5QFOJDq4+kxZx2TXldccXIw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-jdTizPQKN7iGwZjMB3sKBA-1; Tue, 30 Nov 2021 23:18:17 -0500
X-MC-Unique: jdTizPQKN7iGwZjMB3sKBA-1
Received: by mail-yb1-f200.google.com with SMTP id
 e131-20020a25d389000000b005fb5e6eb757so33560285ybf.22
 for <linux-nvme@lists.infradead.org>; Tue, 30 Nov 2021 20:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b7gZUOdzVQidUkCgddob4WitrLX9vYPiAZfu9bmug6E=;
 b=IKoTiuelHTUClHbzzwF8esAjx2TI1d8rvN3/FU0w4R0w6IqkajDvpt7rxaBKzRYBOS
 W1ARippXWKn4BJBv7iNljX3qYEQgRZPbNJL0re9gzXnfu/oi3rggy7wDSptPn0O9i38y
 F1bPABFMtc5aUsgtoPVWsWGRgNSUk+Zy0H67RY9Q2p+JytQHFvW6p4sFsF0JhKy4LtVJ
 Q78626vLzLzC2mUcB46jdRjJxNBoOXGj+WBMVtXaFyyUnpF+ZrkfW1vi4uA6TdJE0iHe
 AUbx4H6Do1aWZtxXfUvmo3er76sOhjrk0zOE40BVtnGEJBJHOtEVe59NMdQzs1Y1Gmx6
 BUnQ==
X-Gm-Message-State: AOAM533H11X2GFbFkB2C14F0AMoFPGCCGkQoF28Efk3g3yA0JMakpI3m
 iIe8WQ5j8rfkY3SJKg/5Io7ixwm0dlH9AyjF2kecR4gbDs5AdBpWkZydNZslTvpmwxzCeaYt9xY
 paEzMf/VKn0wxnBP7cPdH8dq23QohknB/QSq5DfabjXo=
X-Received: by 2002:a25:ab4b:: with SMTP id u69mr4350809ybi.724.1638332296750; 
 Tue, 30 Nov 2021 20:18:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4GCQzT+b9y8MOg0UA8r593jKEyjx+fVZGzLapLDx0+gOXjtjK+06yYm6Yn9ulH9iNQQc7b66MlxyHzlZM8HY=
X-Received: by 2002:a25:ab4b:: with SMTP id u69mr4350787ybi.724.1638332296521; 
 Tue, 30 Nov 2021 20:18:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs_i-94okB1yu2d8gEbn_We=7qJfqG9Ev0K9qSgsGJSkBQ@mail.gmail.com>
 <27141b1d-918e-59a4-4b8b-af07d10acefe@suse.de>
In-Reply-To: <27141b1d-918e-59a4-4b8b-af07d10acefe@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 1 Dec 2021 12:18:04 +0800
Message-ID: <CAHj4cs9bZDQn0K1XQmM4Wo8w_ZbG4e76ijdvE2kF965cM1WK4g@mail.gmail.com>
Subject: Re: [regression] blktests nvme/002 nvme/016 nvme/017 failed from
 v5.16-rc1
To: Hannes Reinecke <hare@suse.de>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@osandov.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_201822_047942_80016429 
X-CRM114-Status: GOOD (  21.08  )
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

On Sun, Nov 28, 2021 at 9:02 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 11/27/21 1:39 PM, Yi Zhang wrote:
> > Hello
> > blktests[2] failed from v5.16-rc1, and the bisecting showed it was
> > introduced from [1], pls check it.
> >
> > [1]
> > 2953b30b1d9feb1bc555682e64e6479d197b9231 is the first bad commit
> > commit 2953b30b1d9feb1bc555682e64e6479d197b9231
> > Author: Hannes Reinecke <hare@suse.de>
> > Date:   Mon Oct 18 17:21:38 2021 +0200
> >
> >      nvmet: register discovery subsystem as 'current'
> >
> >      Register the discovery subsystem as the 'current' discovery subsys=
tem,
> >      and add a new discovery log page entry for it.
> >
> >      Signed-off-by: Hannes Reinecke <hare@suse.de>
> >      Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> >   drivers/nvme/target/core.c      |  1 +
> >   drivers/nvme/target/discovery.c | 17 +++++++++++------
> >   2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > [2]
> > # ./check nvme/002 nvme/016 nvme/017
> > nvme/002 (create many subsystems and test discovery)         [failed]
> >      runtime  2.092s  ...  12.200s
> >      --- tests/nvme/002.out 2021-11-27 00:28:12.066040369 -0500
> >      +++ /root/blktests/results/nodev/nvme/002.out.bad 2021-11-27
> > 07:31:13.452891961 -0500
> >      @@ -1,3003 +1,3006 @@
> >       Running nvme/002
> >      -Discovery Log Number of Records 1000, Generation counter X
> >      +Discovery Log Number of Records 1001, Generation counter X
> >       =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> >       trtype:  loop
> >      -subnqn:  blktests-subsystem-0
> >      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
> >      ...
> >      (Run 'diff -u tests/nvme/002.out
> > /root/blktests/results/nodev/nvme/002.out.bad' to see the entire diff)
> > nvme/016 (create/delete many NVMeOF block device-backed ns and test
> > discovery) [failed]
> >      runtime  7.444s  ...  7.894s
> >      --- tests/nvme/016.out 2021-11-27 00:28:12.069040481 -0500
> >      +++ /root/blktests/results/nodev/nvme/016.out.bad 2021-11-27
> > 07:31:21.446186124 -0500
> >      @@ -1,6 +1,9 @@
> >       Running nvme/016
> >      -Discovery Log Number of Records 1, Generation counter X
> >      +Discovery Log Number of Records 2, Generation counter X
> >       =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> >       trtype:  loop
> >      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
> >      +=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> >      ...
> >      (Run 'diff -u tests/nvme/016.out
> > /root/blktests/results/nodev/nvme/016.out.bad' to see the entire diff)
> > nvme/017 (create/delete many file-ns and test discovery)     [failed]
> >      runtime    ...  7.578s
> >      --- tests/nvme/017.out 2021-11-27 00:28:12.069040481 -0500
> >      +++ /root/blktests/results/nodev/nvme/017.out.bad 2021-11-27
> > 07:31:29.103467922 -0500
> >      @@ -1,6 +1,9 @@
> >       Running nvme/017
> >      -Discovery Log Number of Records 1, Generation counter X
> >      +Discovery Log Number of Records 2, Generation counter X
> >       =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D
> >       trtype:  loop
> >      +subnqn:  nqn.2014-08.org.nvmexpress.discovery
> >      +=3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> >      ...
> >      (Run 'diff -u tests/nvme/017.out
> > /root/blktests/results/nodev/nvme/017.out.bad' to see the entire diff)
> >
> But that was precisely the point, returning more information for
> discovery ...

So it was expected, thanks for the info.

>
> I'll be sending a patch to update blktests.
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=
=B6rffer
>


--=20
Best Regards,
  Yi Zhang


