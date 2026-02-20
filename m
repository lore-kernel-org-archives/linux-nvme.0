Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB7FC54FD0
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4/9aUSUE6n8w/uHcL3Lv248KWBbX6SR//eeHdKv99E=; b=4BJhmmPJGOhmjNW//mV43AR0ku
	I6Pb33k5NUeGUuJpsvWto0ftUqj3sFr5fFiJRSw8uYuxmC99KyF72NGsc+9YHSRxQ7x876dtftinW
	M0wz9VRYpxXyH65rlJinyO9GmGFRSGkkxwjb5jmsU0ii7nxI6p8UQVsTS/ILsZIhZ8k2COC2dJ86D
	uNPu1nMFzdKgyhQOFFBnylA+i6A0+swuHuYHJ0id4hVFgZa63PVNhEeiISUKwNOpYjirZj8JlpROo
	VOw98mcLCf19Se8Xrrv8zJk6sj3V6EZ61zwxk/y8buayLYBdgymWwxWVVTGhPtry5w2Vb5bjr8fu0
	kIRzNLMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtLXd-0000000DO4n-20Sy;
	Fri, 20 Feb 2026 08:07:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtLXb-0000000DO4M-2OXu
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 08:07:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A192061843;
	Fri, 20 Feb 2026 08:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBB1C116C6;
	Fri, 20 Feb 2026 08:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771574830;
	bh=BMX+FLAheQXGPnaX7sizexLdF65tScxmZFF35Gjo90I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5KKNjK2sWe7TkaGQ/HrqsT05AKynaFbQkOjSfBV+kBgcewnL4k37JwC9d/wP7CrI
	 clzc7QMYAHJJKyBJCWe5JpI7sEJjf4agYY03MPfTT/Je3rT4+8KlqPVQMLYTggj2Fh
	 2nMbx7PsF0I48Z6GMmuag6p+sdFoSkv+alD9La5T8oV0Mzi+Lqa1+Et5RN/mx84RV9
	 dPgfm/IdCI/s+5FeKBEx/Hss8jZ3e2S06JABj+ODSWuAD51vwTUFrJ0CEiMWVamV6J
	 Q8pQaXOY26WSIY4MeFmFQdEa0CBX0lW2nZUseAEJscryndYt0G7kFiqD2neWUF68bm
	 KVpKG4JdcanFQ==
Date: Fri, 20 Feb 2026 09:07:04 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe Controller Data Queue (CDQ)
Message-ID: <gk3kjqjcwcrt2uefswjhkv6hucwgciwdgdextubt4hv5nbc2l6@45sqjeotyyvc>
References: <jrhwaqetlzkyo4gvjql2of2gohxlbrzezkyccqliyh2rybtpqb@kykxmeta5gx6>
 <27b4c014-adb1-439e-b3f6-bc2030b6009d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adov2m5zeh4lmmgw"
Content-Disposition: inline
In-Reply-To: <27b4c014-adb1-439e-b3f6-bc2030b6009d@nvidia.com>
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


--adov2m5zeh4lmmgw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 07:26:35PM +0000, Chaitanya Kulkarni wrote:
> On 2/18/26 04:04, Joel Granados wrote:
> > Hello all.
> >
> > I would like to propose Controller Data Queue and how it fits into the =
NVMe
> > driver.
> >
> > I sent out an RFC back in July [1] describing the first version of a Co=
ntroller
> > Data Queue implementation in the kernel. Technical feedback at that poi=
nt
> > included:
> >    1. CDQs are useful **only** for tracking LBAs during live migration =
(LM)
> >    2. LM needed to be in a "proper" state for CDQs to be useful in the =
linux
> >       kernel
> >    3. CDQs should be managed like any other queue and not through an io=
ctl
> >
> > Since then, there have been six additional versions [2] that included t=
hings
> > like exploring different ways of allocating memory, interactions with I=
OMMU, use
> > of the tail pointer trigger and how to involve (or not) user space. I h=
ave been
> > reluctant to send out a second RFC as the implementations are still hea=
vy on the
> > user space side.
> >
> > # Discussion
> >
> > Here are some points that I think would be interesting:
> > 1. Should there be special considerations for the fact that CDQs don't =
really
> >     have a submission queue? Specifically: How does the current NVMe qu=
eue
> >     implementation need to change in order to include the fact that the=
re are no
> >     submissions for CDQs? Do they need to change at all?
> >
> > 2. Should the memory backing up the CDQ be segregated from the one used=
 for
> >     "regular" queues? This is relevant as CDQs might live longer and be=
 larger
> >     (proportional to the device being LM'ed) than "regular" queues.
> >
> > 3. Live Migration is the encompassing subject and it would be interesti=
ng to
> >     note if we can already define requirements for the CDQ based on exi=
sting LM
> >     POCs (if they exist) or LM implementation ideas.
> >
> > This proposal came out shorter than I expected, but I believe its a good
> > opportunity to address the question of how LM/CDQ will look like in the
> > Linux Kernel.
> >
> > Best Regards
> >
> > Joel
> >
> > [1] https://lore.kerne.org/20250714-jag-cdq-v1-0-01e027d256d5@kernel.org
> > [2] https://github.com/SamsungDS/linux/tree/sam-cdq-v{2,3,4,5,6,7}
> >
>=20
> What is your usecase for this=A0?

Not sure I understand your question. Do you want more clarity on the
usecase for LM? or CDQ? Clarification on the motivation of the
discussion?

Best

--=20

Joel Granados

--adov2m5zeh4lmmgw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmmYFicACgkQupfNUreW
QU/iXAv/Uw3ueiPY1j34ywnTK80VRoveZl8xMpIeei2E/0uPrAFmigDu55JlbEq3
nSk3FkyhGDkx4b0aOkLDPKHf6/6ATNCdyaADLm+F7eQX80krlwrNWW75YNvr5EtN
P+W2ghNc6t3dSwecYWGWhxHkitUeiZjchHKQFRj/rC7rpSEt+gmY2n5iLDeF9wxX
YpCrHuU9uE4hcKIkpEuKuulik8YAzvLILcXSq8e47P7ABZ773AcaIZEVWjU8V5sb
+3ZHkHaglSYr4/3du3RNfvpZMDBlBXTC4Tn/IDaQSlLFExvURitQLFT8Bty8qk2V
T4+oZuHQ3XKQxbNNSCWtZO/vWeaaGWB81ED9TQ4VQNKEdtVWnmDIPiS8/HTSSeu/
uHAE4Mt+2H0n2kp2Zdz7PusXzahwpkp0AahsP+wj/cW9RXyrNAIu99wvgH+W+43F
Ia5Lklfz9r1Po3QzUEI8SMCpMgYJg5ntkD5nYmg2iGk0loy+bWmx3YmgktEcS+c/
MWyOW/PF
=+o7R
-----END PGP SIGNATURE-----

--adov2m5zeh4lmmgw--

