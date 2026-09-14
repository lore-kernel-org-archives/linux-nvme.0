Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEE5C88E64
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IE3x1+aPgF6StQlE1BpPeGDPV7PpWkGV1ky5NgC+txY=; b=JxPVk7KfOyKMcSvlOxV/RV4gds
	SvgKLmpry++1PI4cVklUnvhrgEbus3YKYXuWEJtYKjvEYSpqRuwnOolvdx396+UUOQk7mg5Xp2VVd
	ht67qP7ZY0Uh8ytp8BZ7FxhY0iZNfGmL+nKiugzu87nnDbbskmoKHVQoLv+uWYksaPXqnaIhStrGc
	KAm+m++vWWKxZiJn+2libtJSj2Nghx5ZWmmc9dyUvkedG82HOOTMY8OKwOYQqqtlbga49FAPtpxWq
	tofTUIf/2IaNZjzrw6U+oFMf2xdYk5+NpV2pDFh/5fQhir+chYSPRVfszOSak8ygd+Wv5hAnoTPYY
	408sxCPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x62t3-00000002uFC-1pF8;
	Mon, 14 Sep 2026 09:22:05 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x62t0-00000002uDx-02jN
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 09:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=B3Z+znTM9B8bpn
	cXq8heSxOsMWGGrWDybfw7VJSgOxw=; h=in-reply-to:references:to:from:
	subject:date; d=arkamax.eu; b=hG1dbGCJHx1Llgjb8O3BZ0QTkf/24M/v7KSaTsMw
	9/80PwPgHK2Ia4OlUdgoxlB0CBpZ6rp/ecw2QA1GpoiE8gMCs8w5wSK/WIMPt32xbIOFdT
	DG4H0mjDHIc9lzSYg89VJCz9sBaaQISKHHctL4B1PZOoOn4wjfHFJLcHwh9p+t9FjtTCIh
	VjRmW75j++Gn+leHnZoOstWTf3UXsDNWQqIL6sIU5IgXyQUptkrzBYwndJUc1R9Kfre4Rp
	d4oSKom03LaclW3MIlxRVuK0/F/19+4O1eQbQErzuke0nsKuWOuA9RuZv63uwydNnBl9N3
	jhYDT5UwOv1LoRGFcBol3w==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 82239975 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Sep 2026 11:21:55 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 11:21:55 +0200
Message-Id: <DLEXGM8VZOW9.1J9A20FEP43RM@arkamax.eu>
Subject: Re: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "syzbot" <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>,
 <hch@lst.de>, <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.22.0
References: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
 <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
In-Reply-To: <6aa6c282.4c28b7d0.c1bba.000d.GAE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_022202_704004_5973523E 
X-CRM114-Status: UNSURE (   5.64  )
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

On Sun Sep 13, 2026 at 5:34 PM CEST, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    2f0c1cf72f46 Merge tag 's390-7.3-3' of git://git.kernel.o=
r..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D159b19f958000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8c5c3949d762a=
91f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4a1d521d19d6321=
f5aad
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1074f61558000=
0


It seems that a reset operation is enqueued before the controller
initialization is completed.

when the nvme_loop_reset_ctrl_work() finally runs, it will find the
controller in LIVE state, thus hitting the WARN_ON().

Maurizio

