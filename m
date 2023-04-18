Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2807C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zuk1wNUtTNJLgzmHb0fnSO0Pbw4VMXyzz++0V+ePhek=; b=JMSzSx/kNsturE8isi2/pVVIkv
	Vwr6XE1ukWqsNF9hUkd2fXbtDxOT5FNLxI6mNWzopM8V42vzOKbX1Z1t76MsKEeuxPb/oo1NVVqM7
	54GqyuVa53CxOt9101gIk76aPDpCP7SVjllwbWfsz59NnAYwmcbdwDXfYGkmo/SYmVPeXRomdOIwY
	mt/X2SvAqxWCPAI+f1fR+UUjLZfAlAAN9l94+tOuXl9nd7XkjFP3qsVx+s05mG7fs6olU3nsvchAV
	6zft6iR9jXJRMIi0uo3DA8tp0X0mMh/y7Wk4hSv2/QdLo/BjEKC9o4gTf3q8aW7XS5XpbyoNMZ5QH
	9YlD8omA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poq46-0034BL-2d;
	Tue, 18 Apr 2023 18:28:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poq44-0034Aj-1S
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 18:28:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DFBD562C35;
	Tue, 18 Apr 2023 18:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06463C433EF;
	Tue, 18 Apr 2023 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681842507;
	bh=eam+mtDADCEwI1H0MVDXucCJcW7vmK8XfMM2urrvNd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WGA7V90k1HX+YLYrkLXa0E9GhEdhsNbPSllZ8gwhp7yt7HxuzStwS7tupU+NSZa+F
	 GF0/o+pZMDK4ZRGBxBd5FIPpGIDiee83v9brKx09VUnJ7a3wbUMaB7o48ARGWZaYUM
	 5vI7x7vii3qir9F/BV6HwuxOw1jabrrNQqKUn2JUSjWHgEDkDC7/hPLEQa/l9nfaHn
	 jzJclgjqG2BZkHlBl5DroNrqR31I63qlQM1POQskIPr8k4yGuTCyJ1aHBtCLEhtddW
	 rVZzFZI/e0JomgtbEVvUilSaYuPcQuDRnMt5jE7BrTpnAqlMM6Qca9k3MDKgAa4+/j
	 lu+php+B2NuKw==
Date: Tue, 18 Apr 2023 11:28:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Chuck Lever
 <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Message-ID: <20230418112825.789eadba@kernel.org>
In-Reply-To: <ab73a25d-8b2c-17de-d4ea-edd844c600af@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
	<20230417130302.86274-8-hare@suse.de>
	<20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
	<20230417131048.66b6b3a0@kernel.org>
	<beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
	<db39fd2d-6da2-852e-70aa-7499fedf8b48@suse.de>
	<b313144b-f510-f3d5-6066-6123c27039ed@suse.de>
	<392cfcc6-c4c7-da94-4e00-f6961c548867@grimberg.me>
	<ab73a25d-8b2c-17de-d4ea-edd844c600af@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_112828_524229_898F92ED 
X-CRM114-Status: GOOD (  13.30  )
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

On Tue, 18 Apr 2023 13:02:34 +0200 Hannes Reinecke wrote:
> >> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> >> index 827292e29f99..7b28b11ff611 100644
> >> --- a/net/tls/tls_sw.c
> >> +++ b/net/tls/tls_sw.c
> >> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr=
=20
> >> *msg, size_t size)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int pending;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (msg->msg_flags & =
~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MSG_CMSG_COMPAT))
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MSG_EOR | MSG_CMSG_COMPAT))
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
> >>
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (MSG_EOR) =20
> >=20
> > You probably meant if (msg->msg_flags & MSG_EOR)...
> >  =20
> Of course.

Neat. And similarly for sendpage() and in tls_device.c, it should be
fairly small changes in all 3 places. You don't need to worry about
tls_device itself using EOR, FWIW, it's just to try to make the offload
start on a skb boundary. Adding more EORs should not confuse anything.

