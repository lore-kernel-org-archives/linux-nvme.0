Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXrSOQWM6J/zDhOO2WJd2IQEsGUhTwCK5I2ZyA7IcBM=; b=NBfIdIMMFRAPFaJ+EeSrJoHvC1
	oR3a0P7aZjBm0TD125fPw8uND3/iXHuFQf2VjmwiUJJJs9VHcJP6bwZbWJlk4MLhB4EHZsvZzd5Cv
	53f+DtwO75jcncxczs9U9W9coOfQC8ijqktHJJrGmXtq0YUG65kfTeBygn5htQ4tVPu6+OPEy8agJ
	3RTpb6WHpmbXaMkwJYt33gQMhFFrhTt9OjENHp5X+VChn68yUA1K3Ot9Sf7nMYIsoXL9xkqA2A0Xx
	Syz0PtZSm4KFR/nRAvvsrM/cy5EmmmmVIZyS2RpIlb0JmHLhgILaGPrJwFfNlj9cIvqHd3ANfkaYq
	3PU9s2zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRszX-007zrG-MK; Wed, 09 Mar 2022 09:52:23 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRszU-007zmn-4k
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 09:52:22 +0000
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 0157FB00D47
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 17:52:10 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID -1427907281
 for <linux-nvme@lists.infradead.org>;
 Wed, 09 Mar 2022 17:52:09 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id E2F69B00D4C
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 17:52:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646819529; bh=dkS+wrRstCkqxCRo76GBz0Ojn6oVfokb7hed3lNt3e0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GLh3ESVURsAe7nEhxRVfDOnMuAYUt3iaXgNLr2+ur7jMQzPLFJWxiYl4dPkfzm6u5
 vx4GL138q06oRtgzvnxMAptl8xpz2Wnm5k9fgANYQXP2IGbZPr4nKKfp+4QCu2aJPX
 s92zmDX4GAULgBy95+6Feuu3c6PMx/8J1ar99lCE=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id 9ED57D415BC
 for <linux-nvme@lists.infradead.org>; Wed,  9 Mar 2022 17:52:06 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmjRxx5rF33a for <linux-nvme@lists.infradead.org>;
 Wed,  9 Mar 2022 17:52:04 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
 by antispam1.tom.com (Postfix) with ESMTPA id 954CCD4155F;
 Wed,  9 Mar 2022 17:52:03 +0800 (CST)
Date: Wed, 9 Mar 2022 17:52:03 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309175203.00006ee2@tom.com>
In-Reply-To: <20220309061541.GB31316@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
 <20220309061541.GB31316@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_015220_574126_D8E5DC6F 
X-CRM114-Status: GOOD (  15.48  )
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

On Wed, 9 Mar 2022 07:15:41 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> > +		if (port->nport->tcp_congestion) {
> > +			icsk_new =3D inet_csk(newsock->sk);
> > +			if (icsk_new->icsk_ca_ops !=3D icsk->icsk_ca_ops) {
> > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > +					icsk->icsk_ca_ops->name,
> > +					icsk_new->icsk_ca_ops->name);
> > +			}
> > +		} =20
>=20
> What is the point of having this code?

Well, this could happen in certain circumstances.
Take the result from my test as an example:

    - The congestion of the listening socket of the target was set to
      =E2=80=98dctcp=E2=80=99.

    - But the congestion of the socket of the host side was set to
      =E2=80=98cubic=E2=80=99.

    - Then the congestion of the socket of the new connection at the
      target side would automatically be altered to =E2=80=98dctcp-reno=E2=
=80=99.

In case tcp_congestion was explicitly set for the target, it can be
supposed that the user attaches great importance to performance.
So we=E2=80=99d better make the users aware that the system is not working
in the way they expect.=20

Thus the checking and warning was added here.

>=20
> > +	if (nport->tcp_congestion) {
> > +		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
> > +		optval =3D KERNEL_SOCKPTR(ca_name);
> > +		ret =3D sock_common_setsockopt(port->sock, IPPROTO_TCP,
> > +					     TCP_CONGESTION, optval,
> > +					     strlen(ca_name));
> > +		if (ret) {
> > +			pr_err("failed to set port socket's congestion to %s: %d\n",
> > +			       ca_name, ret);
> > +			goto err_sock;
> > +		}
> > +	} =20
>=20
> Same comment as for the host side.

This will be handled as the host side in the next version.

