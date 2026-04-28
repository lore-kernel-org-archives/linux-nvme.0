Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71744FF886D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L63kir0oraa1O0a5FNlZgqpFU+dHh79zTJavs+PwJMg=; b=zDk+PalFVTKb1vJa0/6r8TdN5q
	19y/7ZSirjgVTDdg5ZufRHjI9O5rSzWeFnGJXI7UM9fhyMUIHswQDxT0tthK/oJuWngc30sDPjnlj
	jDBKl4Vc2x21legFHjcMmuVzmZaR0/onTan3w8+4POrdI0NFZ0hnoJRN0U0Ri9tWBppNoLktZTQwZ
	3qzlct3CbBaWpHGf8PvZ0BXbUDX+wI1LTK7dJSYGXQth0kY7AsEgF4Lbd0+mNfvN/kyp5/6nGUYYn
	krbge85di6+RHoK4wXRtWxEXiI3UbLBSarcubWe47zMFBfRvYotHuvzkIWyCtALv3BsUeYaLv/yF1
	NCS4MPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHoqy-00000002OEH-43Z4;
	Tue, 28 Apr 2026 20:16:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHoog-00000002Ky7-1FKL
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 20:13:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D89C161119;
	Tue, 28 Apr 2026 20:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532FC2BCAF;
	Tue, 28 Apr 2026 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777407236;
	bh=Mocdum+4ccsVNSW4/Hbf0FEyZt/P34rANsDizjp+jaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WOMTa1C3ayu+OxdYiKkdy4H2FWuRyY3QlgvwIh+MSCLxA4KU3w7hasmwXERM4sPuB
	 KguTzW/Ic2Nb9yCaCuTQMyavutqTHSuKJNX+vn+qjKkpuWORQhjMwitiGmZbhkAYgr
	 L3O6kohvN+kVYramE6APRJIy8u+hfx/SAi7zNBbXJNadWKSHmVQueiVAQP+CUtccCZ
	 lwHsaiqcTkZ2gAE3dsacFJR89YX5nWlp7/1X1iduAFtgTvUCeaJN5Z+v8HdncFkFEX
	 L/M9mvBwUHbjT7e2rjIXCradZ2Nz3c69kAnhycwvjLJBB0d4TAmrr9bkeA4/vEMbX/
	 BE2r4q8BW5pSA==
Date: Tue, 28 Apr 2026 22:13:44 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <p5rh5oky5nsizmpb32yxj6x52xu7rszjk6ufqy33predhh2ux3@66an4nga5xev>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
 <2fe3b30d-1614-4c3a-9f74-1c7576a7123b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5zbsgn3x24wa7rj"
Content-Disposition: inline
In-Reply-To: <2fe3b30d-1614-4c3a-9f74-1c7576a7123b@nvidia.com>
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


--f5zbsgn3x24wa7rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 02:57:24AM +0000, Chaitanya Kulkarni wrote:
> On 4/24/26 4:37 AM, Joel Granados wrote:
> > This RFC implements Controller Data Queue (CDQ) support in the NVMe
> > driver, a variation of my original RFC sent last July [2]. It exposes an
> > ioctl interface for userspace to create, configure, and delete CDQs
> > backed by DMA-mapped user memory with eventfd notification. In this
> > version I explore how the CDQ protocol logic might live outside the
> > kernel; the ioctl serves as a testing tool but is not necessarily the
> > final interface.
> >
> > This RFC exists within a broader goal, which is to enable NVMe namespace
> > migration. The timing feels right as hardware with CDQ capability
> > exists, NVMe fully specifies the feature and there is growing interest
> > in Live Migration which by extension includes CDQ.
> >
> > There is however, no clear consensus on how NVMe Live Migration should
> > land in the Linux kernel. The 2022 discussion [1] explored a VFIO-based
> > approach but reached no conclusion, likely because the specification was
> > not yet mature.
> >
> Above description has significant gaps and there is already a common
> consensus about this work. Here is a detailed status [1] to avoid any con=
fusion
> for the work that is actively going on since AUG 2022.
>=20
> The correct description is :-
>=20
> Based on [1] the direction of this work has already reached a definitive
> conclusion, we will be sorting out remaining gaps between spec and
> upstream kernel in the NVMe LM SW WG approved by NVMe consortium.
> That also includes potentially fixing gaps we may or may not find in spec.
> Hence all the development for NVMe Live Migration is moved under NVMe Live
> Migration Software Working Group.
>=20
> This effort has involved active and continuous contributions over the past
> three years in the NVMe TWG and the upstream Linux kernel, with participa=
tion
> from multiple organizations, see below all posted RFC where this work sta=
rted.
>=20
> This multiyear effort =E2=80=94 from us publishing a research paper, shar=
ing the design
> across the industry, and working on the specification definition to align=
 with
> the kernel implementation, to forming the NVMe LM SW WG so everyone can
> participate and share the work =E2=80=94 has now reached its final phase.
>=20
> This work has been visible to upstream maintainers and industry participa=
nts,
> and has progressed with their awareness, approval and active
> involvement. I'm following their guidance and feedback actively.
>=20
> Hence there is no need to host a session at LSFMM this year, as we
> already hosted the session for this in 2023 LSFMM (see below) and has
> everything we need to upstream the work and everyone is aware about the
> status, see [1].
>=20
>  From the start of this project I've collaborated with all the necessary
> entities involved in this and make sure everyone is included.
> I'll be happy to collaborate with you as well.
>=20
> -ck

So you are saying that there is an agreement on how NVMe live migration
will be upstreamed into the Linux Kernel? -Pls correct me if I have
misunderstood-. I did not know that it had been reached:
  1. What was decided?
  2. How is namespace migration included?
  3. Did the nvme_submit_vf_cmd function make the cut?
  4. Is there a public exchange that describes the agreement (I may have
     missed it)?

I don't have a particular preference for any specific solution. My
interest is in understanding how NVMe namespace migration (migration of
actual data, not just controller state) fits into the picture.

AFAIK, The work up until now focuses on controller state migration use
cases (and rightly so, as that is a valuable use case). However, I'm
still missing a discussion on namespace migration which has only been
mentioned sporadically.

I believe that it makes sense to have the session in LSF as it is a good
opportunity to=20
  1. Discuss how namespace migration and CDQ fit into the upstreaming
     effort
  2. Clarify what the agreed approach for LM is (This is still unclear,
     even with this e-mail)

>=20
> [1] Status So far :-
>=20
> 1. We published a detailed research paper on NVMe Kernel Live
>     Migration in collaboration with industry experts AUG 2022. This was
>     presented at SNIA SDC 2022, where we received valuable feedback
>     from a broad audience. The design presented there was generally well
>     received and helped guide subsequent standardization efforts.
>=20
> 2. Based on that work, we submitted an RFC to the kernel community in
>     Dec 2022 and invited feedback:
>     [https://patchew.org/linux/20221206055816.292304-1-lei.rao@intel.com/]
>    =20
>     We have also conducted NVMe Live Migration session at LSFMM 2023 to a=
lign
>     with the community, Dr. Stephen Bates conducted an awesome session :-
>     https://lists.infradead.org/pipermail/linux-nvme/2023-February/037786=
=2Ehtml
>     We didn't receive any feedback from you or your team :(, hope I didn'=
t miss
>     anything.
>=20
> 3. Incorporating the feedback received, we proceeded with specification
>     work and standardized Phase 1. This effort aimed to ensure alignment
>     between the design presented at SDC 2022 and the evolving NVMe spec,
>     as well as the kernel-side implementation. I was one of the leader in
>     standardizing that work and enhancing the design for phase 1.
>    =20
> 4. After completing Phase 1, we shared an updated RFC aligned with the
>     specification ratified TP 4159 and received input from maintainers:
>=20
>     [https://lists.infradead.org/pipermail/linux-nvme/2025-August/057717.=
html]
>     From RFC cover letter :-
>        4. Patch 0004 implements the TP4159 commands: Suspend, Resume,
>        Get Controller State, and Set Controller State. It also includes
>        debug helpers and command parsing logic.
>     We didn't receive any feedback from you or your team :(, hope I didn'=
t miss
>     anything.
>=20
> 5. Given the complexity and compliance requirements of this feature, diff=
erent
>     organizations initiated the NVMe Live Migration Software Working Grou=
p within
>     the NVMe consortium and NVMe consortium has approved NVMe LM SW WG.
>     The goal is to develop an end-to-end solution within the consortium b=
efore
>     broader upstream kernel engagement. We have a growing group of organi=
zation
>     who is committed to do this work in the NVMe LM SW WG and then involv=
e upstream.
>     NVMe consortium has already approved this NVMe LM SW WG and everyone =
is aware
>     that I'm co-coordinating the end to end design and development.
>     We didn't receive any feedback from you or your team :(, hope I didn'=
t miss
>     anything.
>=20
> > To move CDQ forward, I would like to understand where the LM logic belo=
ngs. I
> > currently see two options (of which I have no particular preference):
> >
> > 1. VFIO: Implement NVMe LM following the VFIO state machine, similar to=
 what
> >     was proposed in 2022.
> > 2. VM manager interface: Bypass VFIO and implement LM logic in the inte=
rface
> >     between the VM manager (e.g., QEMU) and the NVMe driver.
> >
> > One aspect that has not received much attention in previous discussions
> > is namespace migration as prior work focused on migrating state and not
> > the actual data. Migrating potential terabytes is IMO a distinct use
> > case worth considering. LSF/MM/BPF is in a week. I hope this series
> > encourages folks to revisit their positions, give their opinions and set
> > the stage for face2face discussions.
> >
> > Best
> >
> > PS: I'm including the regular NVMe contacts and the folks that seemed to
> > have strong opinions in [2]. I always find it difficult to decide who to
> > include in these so let me know if you want to be removed in the future
> > or if I have missed someone.
> >
> > [1] https://lore.kernel.org/20221206055816.292304-1-lei.rao@intel.com
> > [2] https://lore.kernel.org/20250714-jag-cdq-v1-0-01e027d256d5@kernel.o=
rg
>=20
> You have not documented the RFC that I posted for 4159 above which is cre=
ating
> lot more confusion.
That is my bad. After your recap, I see that I had missed part of the
story. I appreciate you filling in the gaps - I'll keep this timeline in
mind going forward.

FYI: Adding Klaus Jensen to the CC as he might be able to add more
nuance to the discussion

Best
>=20
> >
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Joel Granados (5):
> >        nvme: Add CDQ data structures to nvme spec header
> >        nvme: Add CDQ data structures to host driver
> >        nvme: Add NVME_AER_ONE_SHOT callback handler
> >        nvme: Implement CDQ core functionality
> >        nvme: Add CDQ ioctl interface
> >
> >   drivers/nvme/host/core.c        | 312 +++++++++++++++++++++++++++++++=
+++++++++
> >   drivers/nvme/host/ioctl.c       |  53 ++++++-
> >   drivers/nvme/host/nvme.h        |  20 +++
> >   include/linux/nvme.h            |  50 ++++++-
> >   include/uapi/linux/nvme_ioctl.h |  29 ++++
> >   5 files changed, 462 insertions(+), 2 deletions(-)
> > ---
> > base-commit: 028ef9c96e96197026887c0f092424679298aae8
> > change-id: 20260424-jag-cdq-lkml-cd9b7c79983d
> >
> > Best regards,
>=20
>=20
> -ck
>=20
>=20

--=20

Joel Granados

--f5zbsgn3x24wa7rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnxFPgACgkQupfNUreW
QU9anwv/XhWRceuWABKjWZbreI62k1HdoajfDxaReJhH8rZuvkJ9kTu1KXmUGexZ
WnPl8tvhdM580ZRDE1zdO9hZ2StqpZ4J7PG292is+5Ihw9nJ7AzUA6gpYqafLK0i
rCakEfm2VgaCydqPyYf9XOtqvHp2Fhx+p6RJTKeAnUgytfG5vVml5xLZRSCYprTD
dlH6H6xX8MrcG9LRJ2H9d0WUOYyDGQqLctSsb6xoWlPhzOplBqzrU6IHCvf/bS2G
ZxvezPOjT40EBvjXxIV/getkh9Xr2UQm6Iu3ZY88aDp7maG1cbh7WXbfMChbo74r
LzbcKDIjmS3TvFC8RleICv97+kLd/bbY+Y2PN+MP+CyPoCY7BdhgDT6Z9s9yCWKi
nhxe/lWNlYjqF+Rahdgbmvi6Pb6wkiXPdrCMs23HX9wqT9ZN396Zb3c0xLYImW+6
QcaEZXJX8Pj2fTuXz+wbPK3p2AoYzr7ZekAC596oerS28qqITlyiZt9CMZtAoIvB
kQSvioCk
=Xfs6
-----END PGP SIGNATURE-----

--f5zbsgn3x24wa7rj--

