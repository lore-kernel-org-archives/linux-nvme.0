Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC59CA5FFC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4IDAEWUM5goHy4cCtU/RvHHI4fpSYagB5nlgyoCVks=; b=fJlFgsQ4mNMl8fSc6djIly9zGd
	emL8E/5dUKHmr6wtcFjY4KmKB0+D0X63dboxW3CiPxcHBLrAm6JhkYf/iYQLfbCvrf893N8y/5mf2
	nA9OOEcqhIP8BU1hJyvQeXa5URzlkEGK1dFDUvid5XP6+Wmvw0XfZYxGcEprERmS3TlPA2LXY77+1
	nEJdIG1xIrvSgbdZG4icYPF7hNMzVnxcFTpVTb2CmYc0ud2vgmwRgWKsu5DypHN2L2r7PeOKZ+54B
	QvWkxIMsPkxB1/hEd/Wc4qMq6t6639/YfF+S3UfiRdn2tSopziTG7lWCjM2/AVeyhEt8OcIk3TeUD
	R2dYWHZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeoi-0000000Fz5w-0kDA;
	Mon, 05 Oct 2026 09:17:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCYi6-0000000B00j-1W9k
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 08:33:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7CAB960A81
	for <linux-nvme@lists.infradead.org>; Fri,  2 Oct 2026 08:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FA81F0089B
	for <linux-nvme@lists.infradead.org>; Fri,  2 Oct 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930021;
	bh=w4IDAEWUM5goHy4cCtU/RvHHI4fpSYagB5nlgyoCVks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cXZ/vgUCZgLaMpyiIPgB3rJT4TzVgO3zOCcJ1gPBaCItJvklxFcBZMdtto7Vv57j7
	 WtPnQ9vq1tuDS5CQDM1xCaDiB8HsUENjLZd072V53xNDundlLTzOfApih5IAQQEEwq
	 kw+0zUFn1/q1lck7rju1TxV0KHv7tOtmG0P6Fyul1xEFb17OioyhCUTQ3FSYm5UJfH
	 PbkOBxf9tNDoAhY5X3k7VSnU5XvcyndoD3H/Bddsl5x8xLzF7cKCBhKa8gYh4gO6kE
	 pU0jYjH/pfNWir6ig/xaPsMDOo3rFI0WLizKlMts4ZODGEcTULmzs0xWmDvxoqQ5b9
	 PgO6QoK6L9eYg==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-483c65c2fa7so4558510fac.1
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 01:33:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfmBsxXUy5PTG/i1Ho8mYmGPotdJ9Bdt/p5pUnjrgmIgld+45XcRwvInvIv9HLBQShC4PcO/D3N/Cw@lists.infradead.org
X-Gm-Message-State: AFq9FYJYNp2QOcpfY8DCMI8VS51JaLuqwVcIB0WZ/QsIt5+MCZBx/q12
	R70lzE9F96j20U6Ny7dOe1guxmCZG+bZXrup9nKLtFDZTy1VbvUk60psuzUTb4sOeG4V9+v3McQ
	CPz/s60SpAa0h0ZZQUd6z5DyTzg//u9E=
X-Received: by 2002:a05:6871:a841:b0:475:a153:2dbe with SMTP id
 586e51a60fabf-49e15d371demr1895507fac.20.1790930020024; Fri, 02 Oct 2026
 01:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260929071743.23624-2-edumazet@kernel.org> <179090395863.434549.3668493667259120759@kernel.org>
In-Reply-To: <179090395863.434549.3668493667259120759@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:33:29 +0200
X-Gmail-Original-Message-ID: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
X-Gm-Features: AclHuK8nVtaoGsIab0P-m2s1B3ju3ekNwAoCUlK85M2ENTXymnZNl3W63NoMomk
Message-ID: <CAL4WiipAe11BJA0rs33_0=bzYXMr0qQvQMPc+6-awyFQdQ1yCA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/9] dlm: fix send buffer backpressure handling
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, edumazet@google.com, 
	netdev@vger.kernel.org, aahringo@redhat.com, teigland@redhat.com, 
	gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev, 
	guwen@linux.alibaba.com, dust.li@linux.alibaba.com, alibuda@linux.alibaba.com, 
	cel@kernel.org, jlayton@kernel.org, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	linux-nfs@vger.kernel.org, achender@kernel.org, rds-devel@oss.oracle.com, 
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, drbd-dev@lists.linux.dev, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Oct 2026 02:16:59 -0700
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

On Fri, Oct 2, 2026 at 3:19=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] A TCP reset or TCP timeout while the connection is waiting for
>   send space can stall the dlm connection permanently.

I dunno if I want to spend time fixing all dlm bugs.

It seems TCP changes are now stuck because ood pre-existing bugs in
in-kernel-users.

Sad.

