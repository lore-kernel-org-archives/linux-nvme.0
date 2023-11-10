Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DE5C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnjW46Abv0ej124limqrwWwe0lfQZ5JkYvMeGFC1Tqc=; b=Un8PpSCzfE9kAtxewHVoJS09kA
	XAc08t5iW6RFeby4dYWhPrXaxfyVK7sxURnihniCKJVyGKfyYXWGfzCzLi9xfFWZwet69zrnZOBpM
	CblMKv+ZJyVMgt1kSOkpI341AyGd4jV8scunnUDGJdrzB2pwEwWVvd1wUwFMIZpi9qqm0D1v22XNc
	bu9EI7TTvL013QPawmJlNdJ6sk6Meg6tmqaslUj6UV4GLy6XvuEo9NNDlqs2Lf6oiWY3UgLriplii
	NAQUBdUuZVc8Z6vB8hcncb3R2Zfj2jcm5g2r4qukUOrdF+2t2JY4dsj2Qwb6Q8GpWvpOEACdVk2Nm
	fntXpn7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Rnx-008rnj-2q;
	Fri, 10 Nov 2023 13:44:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1Rnu-008rnQ-2z
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 13:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699623849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DnjW46Abv0ej124limqrwWwe0lfQZ5JkYvMeGFC1Tqc=;
	b=KEDFZyYAcoVhr5TU2L7S7bq0hmWxZ1QtmBsqVqAALyxIcUf7pPnUXzVty9L4IJEfbCtdlF
	Zv5aP2p2DtHGA+VDeJ0ADtZi5X1IYtA+BI8KOlGvEU5/R+TXBakTqW/GX4xXeOLnUaC881
	gmVDD9m2tESadZ6aSXRb+g5TpBK5tW0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-nRS1UJC-OhW6fwcbWsGiUA-1; Fri, 10 Nov 2023 08:44:08 -0500
X-MC-Unique: nRS1UJC-OhW6fwcbWsGiUA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28079cae9fdso2174581a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 05:44:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699623847; x=1700228647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnjW46Abv0ej124limqrwWwe0lfQZ5JkYvMeGFC1Tqc=;
        b=WMLC9hzsv/J6hNOY429PQgSSRmjn6w+HDZlBjQEyfs62Dy7IN7B/FWHxI3YoVKqL6Q
         Cq2qDjCG2xYzke15efzcZIODcMpk89sjxZP8Orn9CoKYHi4syIYriXXd5EYcB2QKq/q3
         sLtTUE+ZBJaaLIAyjAIBnaj4Ums7ZUyU7QldJ6LTEvrBHxtybfBaLprpC4mlxUQKzHzZ
         aCSEVrPlZ0HsW8w22Hw3ELlSTAo5xC1pKLbJPX0JMXW4kp9YzvC9qW5Wbcqwn8f6Z/Um
         3eC4HbUkPKS6m3lVdP80tWBCsIgIC2fZw+mJcJ1tU9klbD3LL8aXTim/qXv3mixa7Sd7
         IE6g==
X-Gm-Message-State: AOJu0Yx7a4OAi2B2GppJHwV58xMVr1xbJ45eaixtzlA0ee6k0DUZO78b
	AQiYWtKV305PFzJ6C6VYhlCMvYLT1S11z60g/3HwUxbAbzZSTEGhOkse61YvHCb/AcELmy0q+SP
	m3hN7A7rlfj9Tt5UlRgJ6Xxzn6usHJxwe1Zc9q+tRaf4=
X-Received: by 2002:a17:90b:224f:b0:280:2c16:2186 with SMTP id hk15-20020a17090b224f00b002802c162186mr5009643pjb.30.1699623847063;
        Fri, 10 Nov 2023 05:44:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwGDKgTGsCWIuxpPtl3GMkMC2r0R+YMM3Xh/h0luoEWAAEtgkR451YJ/4Zt5QgiQCYMvTKuLukHgtujEsvAao=
X-Received: by 2002:a17:90b:224f:b0:280:2c16:2186 with SMTP id
 hk15-20020a17090b224f00b002802c162186mr5009622pjb.30.1699623846740; Fri, 10
 Nov 2023 05:44:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
 <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
In-Reply-To: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 10 Nov 2023 21:43:55 +0800
Message-ID: <CAHj4cs9HvFCB4XKwu_jtkV1HDVE_dY7XKOZ_aJrGS8tA8ROLRA@mail.gmail.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
To: Hannes Reinecke <hare@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Maurizio Lombardi <mlombard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_054411_052374_01A6F6D2 
X-CRM114-Status: GOOD (  18.97  )
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

The issue still can be reproduced on the latest linux-block/for-next,
do you have a chance to check it, thanks.

On Thu, Oct 19, 2023 at 3:16=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi Hanns
>
> Bisect shows it was introduced with this commit.
>
> commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Oct 12 14:22:48 2023 +0200
>
>     nvme: rework NVME_AUTH Kconfig selection
>
>     Having a single Kconfig symbol NVME_AUTH conflates the selection
>     of the authentication functions from nvme/common and nvme/host,
>     causing kbuild robot to complain when building the nvme target
>     only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
>     host bits and use NVME_AUTH for the common functions only.
>     And move the CRYPTO selection into nvme/common to make it
>     easier to read.
>
> On Wed, Oct 18, 2023 at 2:57=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wr=
ote:
> >
> > Hello
> > Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> > latest linux-block/for-next[1],
> > from the log I can see it was due to authentication setup failed,
> > please help check it, thanks.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/l=
og/?h=3Dfor-next
> > e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-6.7/block' into for-next
> >
> > [2]
> > # ./check nvme/041
> > nvme/041 (Create authenticated connections)                  [failed]
> >     runtime  3.274s  ...  3.980s
> >     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
> >     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> > 02:50:03.496539083 -0400
> >     @@ -2,5 +2,5 @@
> >      Test unauthenticated connection (should fail)
> >      NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test authenticated connection
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test complete
> >
> > # dmesg
> > [ 2701.636964] loop: module loaded
> > [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> > [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> > [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
>
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


