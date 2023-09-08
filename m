Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D045EE57E0
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0rgbNw7BUwBRddaM++rwGtgjG0PXIVYwgNEH9FOJZQ=; b=KzRUsPe8hWEly08kJNE8NIW+6I
	6rm9uF9t7evKMB4FhXHBOVeoNyqJzLebSJ+xfcdSllTuW/jElACIv5kBjWrBVt1fg4tjcq31Wz2Mq
	pAdhEg7kRwSsbALePzHzJU2IFzK+QrvYiW2SVWkUByW3oUnRdblnJoc0dC0+J681q9DyQcQQDzuz7
	f7KR3n74w2tzBOMJj7VJ2IBUGooBXyfEK3IGa1oo0ACmPmoOaTm79OUqEJtivVMHEHGerccXOMmj0
	8nzGIY1Fdi1OgSrndxvlcekvvuYGdySGiq5kEbVZdnfZjptwrVsJUi5qVBmFMQMB3swqhEnGKpnvM
	Bpi1mfDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWYn-00DIHV-0A;
	Fri, 08 Sep 2023 08:09:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeWYk-00DIGh-1u
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 08:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694160584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0rgbNw7BUwBRddaM++rwGtgjG0PXIVYwgNEH9FOJZQ=;
	b=CL5rmBuC9HrZdERaH0rvWlWngvbtFMSw3SDV4+MwLBKDHSKvkvvVffor66mQFHPNn0tTEr
	OWVgdp/6zECZm3RDYNnSkADxkslSuk385kSy/xuVShim58XFqP8JhvI/pUyC9Yd0NA6mmJ
	5+Vcwdafn/xe4gquDEWFuPqtMmh/KTw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-j81IIoLFNZiuou0sFhBOeg-1; Fri, 08 Sep 2023 04:09:42 -0400
X-MC-Unique: j81IIoLFNZiuou0sFhBOeg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-57013c62b3dso2237296a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 08 Sep 2023 01:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160581; x=1694765381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0rgbNw7BUwBRddaM++rwGtgjG0PXIVYwgNEH9FOJZQ=;
        b=DV66lezoDNtNkcOroRlRJ9cz8V2n6P9Qc93M4GOSfaiz0mGQIxs7GSopQU/1QoZx7o
         aFHYI9Q9c4H3FJzZOrXZZCgEYYlFfWhovjshA4kwBQ0LPCxgC/Ioo581sFtvWsMVHxEb
         C9o2SMCuxZPoUyWdq/qq/afHOrXxUR8DWHcCPO0431V5PqPTcyiwZlziwAaQ2L562lZA
         KkD6TPkH8H/Q6/PW4561DviiOIs4W4N+GjRNhRsGBGQdpGKGjwZjs6bb14/phS7sh1q7
         oaTQsL8UPEoQv38QdoUzczIG1szktY/6IvepGxHWd9LlXv3RxrJX8ktCNFnbpPCGZBJ7
         /Iqg==
X-Gm-Message-State: AOJu0YzJCBmk0ODwplruRRQuQIYbBGCfEkx8klrDXv531bA9HxpOJyxl
	WUdF9JcbPXAjhuybhjfEA+tw/qpvRq1SGxi8a1glacCEpV3ylaMAQG5SUxwEDPChHs/RM1gxw+Z
	ehWXsRl7XK0HnJdlwjnjgmsmHJB8pZOZeLjTxdx4zj8h37E8L3so=
X-Received: by 2002:a05:6a21:7988:b0:14c:d0d2:325c with SMTP id bh8-20020a056a21798800b0014cd0d2325cmr1710455pzc.55.1694160580912;
        Fri, 08 Sep 2023 01:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+k4uusfhLN3Pm5AONrhEkOLSxWjBsp+vuDfJubRB+c4QWL5gY4IjIQvMVmQXe7222d0n1zH6KLwlZ9yBIjVw=
X-Received: by 2002:a05:6a21:7988:b0:14c:d0d2:325c with SMTP id
 bh8-20020a056a21798800b0014cd0d2325cmr1710445pzc.55.1694160580576; Fri, 08
 Sep 2023 01:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev> <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
In-Reply-To: <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 8 Sep 2023 16:09:28 +0800
Message-ID: <CAHj4cs_8iC5rn+xA7_bvRifE+1Uu9jjj0wHf=5EmuW7zvaxeYw@mail.gmail.com>
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep warning
To: Hannes Reinecke <hare@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_010946_700604_B1225D0B 
X-CRM114-Status: GOOD (  17.58  )
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

On Fri, Sep 8, 2023 at 3:15=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 9/7/23 10:12, Guoqing Jiang wrote:
> > Hi Yi,
> >
> > On 9/7/23 14:41, Yi Zhang wrote:
> >> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> >>
> >> Confirmed below issue was fixed by this patch:
> >
> > Thanks a lot for the test!
> >
> > And I had got another similar lockdep warning about nvmet-rdma.
> >
> Please note that this issue is fixed by my patch 'nvmet-tcp: avoid
> circular locking dependency on install_queue()' send earlier to this list=
.
>
> Can you please test with that one to see if it fixes the issue for you?

Sure, will try it later this week.

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>


--=20
Best Regards,
  Yi Zhang


