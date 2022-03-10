Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14C6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHNjL9avEQ3GbSezJI9Z9sjpWskBgOA73Vmh3aoxwSg=; b=DSX+eHGYAaPC6JzP/iviZifgc8
	ucsLgMI/6ZPAGoEt/zZZY/V4vfDF8MAqWrppky5pJgXEVQRzeCzTrsUEEAfUG54SgPA1peevF+Ete
	0JZoVUD7vdulm8uVATcUPOV5FrvwsgIzu0yp6qUwanHOCV2qaPENl0UbWDRemNk85kH0sTn3Brm5E
	mtrJA0+xIfUXrA0IMcknYwsPeeP+UFDiawkf932w9lyaiE7/NudCuSz/oP+4yuGaILV53S4aweqOP
	XUvxaHJZi8tnI89bIAkxDllQy5s2SAedmmIdgk+RVh3vtjwwIHOnn8IOHC1GtoiixIiRHhi3eSlKR
	7mNP46iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSGdD-00CZV2-VH; Thu, 10 Mar 2022 11:06:56 +0000
Received: from smtprz02.163.net ([106.3.154.235] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSGdA-00CZQi-KE
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 11:06:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by vip-app02.163.net (Postfix) with ESMTP id CB254440136
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 19:06:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646910402; bh=vdMbham87nueBroCLlJ2VhqRb0D2htyLRWWtWLeBjLA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rGCtqyfrn2WC+gKb2sFHJ+OaDuCebkUOqazPEdXEeMu6MsZg8nXdsGEhne8yI4DGR
 IBrjtzHTUdsB6WXP5I1plgISCNZZIibP1iHjqlEsuyJIo2hOme6JkmYDqvNq57DDcc
 0IG7DX/HhjcfP/u1xrFAxCnVV6LyydeDqUQCCjC0=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
 by localhost (TOM SMTP Server) with SMTP ID 1993725042
 for <linux-nvme@lists.infradead.org>;
 Thu, 10 Mar 2022 19:06:42 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
 t=1646910402; bh=vdMbham87nueBroCLlJ2VhqRb0D2htyLRWWtWLeBjLA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rGCtqyfrn2WC+gKb2sFHJ+OaDuCebkUOqazPEdXEeMu6MsZg8nXdsGEhne8yI4DGR
 IBrjtzHTUdsB6WXP5I1plgISCNZZIibP1iHjqlEsuyJIo2hOme6JkmYDqvNq57DDcc
 0IG7DX/HhjcfP/u1xrFAxCnVV6LyydeDqUQCCjC0=
Received: from localhost (unknown [101.93.196.13])
 by antispamvip.163.net (Postfix) with ESMTPA id 3E67B154153A;
 Thu, 10 Mar 2022 19:06:37 +0800 (CST)
Date: Thu, 10 Mar 2022 19:06:36 +0800
From: Mingbao Sun <sunmingbao@tom.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
 libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310190636.00001695@tom.com>
In-Reply-To: <20220310083811.GA26953@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
 <20220309061541.GB31316@lst.de> <20220309175203.00006ee2@tom.com>
 <20220310083811.GA26953@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_030652_909137_1C643A7D 
X-CRM114-Status: GOOD (  23.61  )
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

On Thu, 10 Mar 2022 09:38:11 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 05:52:03PM +0800, Mingbao Sun wrote:
> > On Wed, 9 Mar 2022 07:15:41 +0100
> > Christoph Hellwig <hch@lst.de> wrote:
> >  =20
> > > On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote: =20
> > > > +		if (port->nport->tcp_congestion) {
> > > > +			icsk_new =3D inet_csk(newsock->sk);
> > > > +			if (icsk_new->icsk_ca_ops !=3D icsk->icsk_ca_ops) {
> > > > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > > > +					icsk->icsk_ca_ops->name,
> > > > +					icsk_new->icsk_ca_ops->name);
> > > > +			}
> > > > +		}   =20
> > >=20
> > > What is the point of having this code? =20
> >=20
> > Well, this could happen in certain circumstances.
> > Take the result from my test as an example:
> >=20
> >     - The congestion of the listening socket of the target was set to
> >       =E2=80=98dctcp=E2=80=99.
> >=20
> >     - But the congestion of the socket of the host side was set to
> >       =E2=80=98cubic=E2=80=99.
> >=20
> >     - Then the congestion of the socket of the new connection at the
> >       target side would automatically be altered to =E2=80=98dctcp-reno=
=E2=80=99.
> >=20
> > In case tcp_congestion was explicitly set for the target, it can be
> > supposed that the user attaches great importance to performance.
> > So we=E2=80=99d better make the users aware that the system is not work=
ing
> > in the way they expect.  =20
>=20
> A warning message really seems very severe for a condition like this.
> Maybe the better interface is a way to figure out which congestion
> control algorithm is in use by reading a sysfs file.

Well, a target could have a great number of TCP sockets.

I feel it=E2=80=99s not proper to create a sysfs entry for each socket.
And for those sockets that do not have the exception of
congestion-control, it=E2=80=99s merely a waste of resources.

Also, since these sockets generate and die dynamically, the info
exported via fs may even do not have the opportunity to be seen by
the user.

Anyway, if you insist that the checking and warning here is not proper,
I can remove it.=20

