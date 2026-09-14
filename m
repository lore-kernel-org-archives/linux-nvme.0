Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6933C88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vkIgfjj6EKjueSe1qWQ3m6t2HeKMs0pT4UrWClGPsao=; b=V1JhYwLocAWYByvKCCZuYRD6Na
	eclnktQQv/hYRcAnqZRDSxPpmBad6+0TD5vDvVlkFPTeP+QkAllAIFqr9Peq2Zm9YAZHqvBMq2LDs
	2hrLI+sfRt3DW+h19/zW09Copz+9Kcnr798OyASsxHBB23GCBrq4BDWr5NPGtyqsuxhtRimNBxwpb
	PYDkzYAljFR2JPrQTr88+N2i+YWRGXL+5YR9l6hgxRkHLDP9x7dvjWT2FYbjDwkWiUdRXW5R+cjuu
	NfqAGKpgLBga86LJB3L8q7M6DuDuqXLCIQwkvfhBeiGUrP4pCmU/DUN9Ni2IvRBlQTr/mtmOTp2f0
	9HcAnO7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x63kC-000000034mk-23kX;
	Mon, 14 Sep 2026 10:17:00 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x63k7-000000034lv-2N0r
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 10:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=QtSVqDzz28J+/k
	j5f9nh1TvvBhDcfYvZhhdFPufVLrA=; h=in-reply-to:references:from:subject:
	to:date; d=arkamax.eu; b=DsT4K0RXX85eSjEZmf7kHJZywvxtIgs83xopCse9ps1XJ
	Pa/GTuXbcTrdoiZ+tY4gTFppFq8DsB5l7GH9yY5dRF6wCL7S59KkJV2YBC/5TpLNVx4Gz7
	uqQk/OCzNmoSZIXBm+51Ko+CHGc4DV7ldfDZaHXQZKsKvKIPIcfEGIHyvSpb2Fmn6BC66Y
	pNZAPnyTuyVrz0wlPOb5UpEnO3CsqWmPKe/P1g0cQv3OoQJM4BbVbHUROYEAkITAlVMuRO
	217icKOdUQb5h5kFptTid9CS7OWOZXxJ9q+KWQdpHCOMcF2FHdUAqkobB9z8awa/mzVkBQ
	lYWKFpg9mqfJvG9Ug==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id a9f77aeb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 12:16:53 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 12:16:53 +0200
Message-Id: <DLEYMPA5WF42.2GHC28RDZX90E@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@arkamax.eu>, "syzbot"
 <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>, <hch@lst.de>,
 <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.22.0
References: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
 <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
 <DLEXGM8VZOW9.1J9A20FEP43RM@arkamax.eu>
In-Reply-To: <DLEXGM8VZOW9.1J9A20FEP43RM@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_031657_481080_56A68EDA 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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

On Mon Sep 14, 2026 at 11:21 AM CEST, Maurizio Lombardi wrote:
> On Sun Sep 13, 2026 at 5:34 PM CEST, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    2f0c1cf72f46 Merge tag 's390-7.3-3' of git://git.kernel.=
or..
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D159b19f95800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8c5c3949d762=
a91f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4a1d521d19d632=
1f5aad
>> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for =
Debian) 2.44
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1074f6155800=
00
>
>
> It seems that a reset operation is enqueued before the controller
> initialization is completed.
>
> when the nvme_loop_reset_ctrl_work() finally runs, it will find the
> controller in LIVE state, thus hitting the WARN_ON().
>

Maybe moving the controller to CONNECTING state before exposing it to
sysfs will prevent the warning:

@@ -570,13 +575,13 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
                goto out;
        }

+       if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+                WARN_ON_ONCE(1);
+
        ret =3D nvme_add_ctrl(&ctrl->ctrl);
        if (ret)
                goto out_put_ctrl;

-       if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
-               WARN_ON_ONCE(1);
-
        ret =3D -ENOMEM;

        ctrl->ctrl.kato =3D opts->kato;

Maurizio


