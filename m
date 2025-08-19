Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E2CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIwYX0lJxoelLUZimygw68QlmeInOjegRT+TxaimM1o=; b=j5NTUGOuDEEu1IDRzyBvxhhLNx
	flde6Hd6GKd7wozSf6g5MvgMBxI1M2J2+F2q8fykC0x+Rs77QiL60jSPC0yQhFi2wy9X1uJ5dcWuP
	a5+L8uv5XvqilQFSqgCvUCSVrstUDc49SZFgx6zvd65mDtJVVxFW+eiBi4dc9GGCu5G2lbn8wjFyV
	T53KWdWBGbt8YpvQTiRyj0C29I9XGGAlT9L4lbffDlKMrz7mOwTxtsA/SSItQd95qqcMGGtEDmGCO
	6f7Xr4Xk6MbzPrDk8D5Z6c9d3ivQqB4LkHtoELhLaisIwASj9pXaAHrzviI34WXuxnBtP8powwfKI
	yQ3w8V9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoLd7-0000000AT2V-1DtC;
	Tue, 19 Aug 2025 12:39:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoK0B-0000000AC2c-2D1n
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 10:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIwYX0lJxoelLUZimygw68QlmeInOjegRT+TxaimM1o=;
	b=F7mXmjFJO52sfizEgzLn6ACpH8JBwrkQWMkrJzFQtBt1NSIuycevCWpdRRzGuXSueOZTS5
	msPvMHS5Ja8NWesoA804jwE4t2jqE5VRSp3pX5x59Elj75pBUea6vQyXiCcdxrZK0WHXjB
	DdRiYN0VVk90TXN4v6DTa2P/OD5gVYQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-5IZm3QvROr6hDUUqloRjlg-1; Tue, 19 Aug 2025 06:55:37 -0400
X-MC-Unique: 5IZm3QvROr6hDUUqloRjlg-1
X-Mimecast-MFC-AGG-ID: 5IZm3QvROr6hDUUqloRjlg_1755600936
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-333f8f9b00dso15172031fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Aug 2025 03:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600934; x=1756205734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIwYX0lJxoelLUZimygw68QlmeInOjegRT+TxaimM1o=;
        b=U1hgOEfR6V0yKqGxUvrFYw1/alBjTs9QIi6al6BEHIcvjmHb/TYdf45PT3RLOjfMZs
         R3AANJzmtLDqgzqRKyr6DYpdKax+KgTrQHEooHQmd/5ITCwekX5smMd4dpbH5fKujZ+Y
         xCllVG/rl6P6XDMGlf+ZbbIN2FkFH3jXUPHn3EEY/vVNgx+KWTNAXnRsiCZ00Q1yJkLo
         2XYz6Bm7OcqY4LDvjVL2NkuPNQC2R1OyH6925rsSKJLiK/4zn0RIpaQ9PuMwhedosbSu
         WI3P8m/j7aW7XOf4Q5eHSuIpeDEQ21rtffhinBVk6f+A8c+lHBoRA48lXWu+QNaAzoJB
         kfew==
X-Gm-Message-State: AOJu0Yzwi456EcFLofV/CLDaZItKS1+DsopP4R59CBJPKx4euGeOh8uO
	L5GlQA7/wZxGTxto69RCnPYY2eyDJqVfRAuCjAFhCrzZDzXUIEXl6caUd9g4PE8hX9KwD6j06HX
	/kV4SZ5RfhQ7KF46eeaWGn6vfGzEPtWNv/l3k0gNRP+641d3DsadJafo6iQlR/4yaIdZRXoU2I6
	6J5SigHcmxYj7IIaSRLgHjSkPsbbKbZ8lF4vUd2AC9dVY=
X-Gm-Gg: ASbGnctIR4k+zR26mFpsEquuo9wM7/VLHgY8a2ysxGjsjESXNRoGwDnSpSBiuwhwSPP
	dyF+p8zigWsiUlN/TRI6f0h6oaOzLImQJlHjojDhrW3e2OYei0eXfsECiUBOEc0PvhaL4NNDctv
	Wh9kvbbCkYNo7b1mUf5qrV7A==
X-Received: by 2002:a2e:a98f:0:b0:333:9b93:357f with SMTP id 38308e7fff4ca-3353078bda5mr5455151fa.38.1755600933877;
        Tue, 19 Aug 2025 03:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhptDw0dZF3LN0e3TkqrpvvCJP3c9IY/U9gr5CgaytpXNe9i+qx1BQkVE6v4nEDvEXwEJKmkfcxbgkJF/qktU=
X-Received: by 2002:a2e:a98f:0:b0:333:9b93:357f with SMTP id
 38308e7fff4ca-3353078bda5mr5455041fa.38.1755600933349; Tue, 19 Aug 2025
 03:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
 <7a48ed7a-bbc6-4847-94bb-8fb08def0ca4@suse.de>
In-Reply-To: <7a48ed7a-bbc6-4847-94bb-8fb08def0ca4@suse.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 19 Aug 2025 18:55:20 +0800
X-Gm-Features: Ac12FXwwwfeYpoXxWF7ArzCdeCY7CulSAap1oe0_bgOVYpsvayNKUniL4Oz7P5k
Message-ID: <CAHj4cs91w8-PRJUsMJVBqp=WLSgo-OnT7PuovpALQmqX=f4abA@mail.gmail.com>
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Chris Leech <cleech@redhat.com>, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zoG5x30AjuY9epSvq-cAZ3lE3LeRhqjonKB3vX0ej-c_1755600936
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_035539_638750_20CB6D35 
X-CRM114-Status: GOOD (  18.48  )
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

Hi Hannes

I tried with the upstream kernel v6.17-rc2, and it can still be reproduced.

# dmesg | tail -30
[  219.560691] nvme nvme0: Failed reconnect attempt 3/-1
[  219.565784] nvme nvme0: Reconnecting in 10 seconds...
[  229.795215] nvme nvme0: failed to connect socket: -111
[  229.800369] nvme nvme0: Failed reconnect attempt 4/-1
[  229.805450] nvme nvme0: Reconnecting in 10 seconds...
[  240.034918] nvme nvme0: failed to connect socket: -111
[  240.040093] nvme nvme0: Failed reconnect attempt 5/-1
[  240.045165] nvme nvme0: Reconnecting in 10 seconds...
[  250.274619] nvme nvme0: failed to connect socket: -111
[  250.279776] nvme nvme0: Failed reconnect attempt 6/-1
[  250.284855] nvme nvme0: Reconnecting in 10 seconds...
[  260.514102] nvme nvme0: failed to connect socket: -111
[  260.519261] nvme nvme0: Failed reconnect attempt 7/-1
[  260.524340] nvme nvme0: Reconnecting in 10 seconds...
[  270.754031] nvme nvme0: failed to connect socket: -111
[  270.759184] nvme nvme0: Failed reconnect attempt 8/-1
[  270.764263] nvme nvme0: Reconnecting in 10 seconds...
[  280.993410] nvme nvme0: failed to connect socket: -111
[  280.998591] nvme nvme0: Failed reconnect attempt 9/-1
[  281.003653] nvme nvme0: Reconnecting in 10 seconds...
[  291.249090] nvme nvme0: creating 4 I/O queues.
[  291.264959] nvme nvme0: mapped 4/0/0 default/read/poll queues.
[  291.271975] nvme nvme0: Successfully reconnected (attempt 10/-1)
[  291.273897] nvme nvme0: identifiers changed for nsid 2
[  291.283631] block nvme0n1: no available path - failing I/O
[  291.289139] block nvme0n1: no available path - failing I/O
[  291.294649] block nvme0n1: no available path - failing I/O
[  291.300159] block nvme0n1: no available path - failing I/O
[  291.305665] block nvme0n1: no available path - failing I/O
[  291.311197] block nvme0n1: no available path - failing I/O

On Tue, Aug 19, 2025 at 2:11=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 8/12/25 17:48, Anton Gavriliuk wrote:
> > Hi
> >
> > There are NVMe/TCP target and initiator servers, both running on
> > RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> >
> > NVMe/TCP target exports single NVMe SSD
> >
> >        "namespaces": [
> >          {
> >            "device": {
> >              "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
> >              "path": "/dev/nvme0n1"
> >            },
> >            "enable": 1,
> >            "nsid": 1
> >          }
> >        ],
> >
> > If NVMe/TCP target is not available, initiator tries to reconnect
> > every 10 seconds
> >
> > [ 2586.071048] nvme nvme9: failed to connect socket: -111
> > [ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
> > [ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
> > [ 2596.310921] nvme nvme9: failed to connect socket: -111
> > [ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
> > [ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
> > [ 2606.550772] nvme nvme9: failed to connect socket: -111
> > [ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
> > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> >
> > when NVMe/TCP target become available, initiator failed reconnect the n=
amespace
> >
> > [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> > [ 2616.793080] nvme nvme9: creating 16 I/O queues.
> > [ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
> > [ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
> > [ 2616.834446] nvme nvme9: identifiers changed for nsid 1
> > [ 2616.835618] block nvme9n1: no usable path - requeuing I/O
> > [ 2616.856602] block nvme9n1: no available path - failing I/O
> > [ 2616.856811] block nvme9n1: no available path - failing I/O
> >
> > and there is no nvme9n1 namespace in the "nvme list" output.
> >
> This looks like the missed re-scan issue I found recently.
> Should be fixed with
> 9546ad1a9bda ("nvme: requeue namespace scan on missed AENs")
>
> (And you are running RHEL. Please open a bugzilla with RH.)
> (And why am I even answering that?)
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich
>


--
Best Regards,
  Yi Zhang


