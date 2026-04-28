Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D74FF886D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+KnAEWPVq4ANU9RLheQWSteQdDM0ZbEH1SjTViIC9c=; b=shGhVGXjOCm1YQusEDEDcw7Gf+
	CW7LU8tDTI0O7sV+HfTZl+gZ7YsubjnKQmJjKHn6HVHBwRZDgUXZYyBl6lM7BQoXrzCbtn/LYjv0F
	vJZ43z1Q4CocwqwzY7nd3WTLV+5UP5raP1tm3eCqE9xiUT/4ohGv/f0WUzzoM7mc3yU405NuMgajF
	1fJsSRbNUgQXabm8qz1tvfo+7CNCz+i7RnF0/gzKRJzYZer3jF/Cpnvt1z2ji67r7RotLEDQWe45w
	EuRyxfwTOjmcosDYLhXXuCYOCtRkOa493o3/SoWZ9/ENSC5LB7IwuMqqRMeA9e3tcyavzt0CgXQsG
	4CoSgN1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHoqm-00000002Nxx-2zJ7;
	Tue, 28 Apr 2026 20:16:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHolG-00000002GAr-0jWM
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 20:10:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3935E61119;
	Tue, 28 Apr 2026 20:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6579EC2BCAF;
	Tue, 28 Apr 2026 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777407023;
	bh=ugcpNPXiI2/nswa7buIxAzzGBxdVSEYyfWI8t8/wCaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLgSOKrR8Y1wsfaVOsXT5B4OuYL2w4KfCVOr01fl0v4zx0eMh1xKMiH2AP4hd8Co/
	 9DpZGXwoqEnvf4xLo6BZBPMXTzGkA+9VCBUeK8cdXInWX+D+I64tymhf1VWF002WE5
	 zU1cFKKBEhK3KBRgZswToADmOwesXk7ilJ1PdK6J4kTvyLeTIt7YHD4Ug6pFYMoNl0
	 yQmESApD2IZWEqSmu2DGeXRQbVDoOiniImeQKZQyG0NUEA2Pi2zA6lvd93WdvIJyI8
	 g+624U2rhc7ntATaOtt23qWeaR7TD6QlxsOuHI191JHa5nfaYGioxHaNFnEDM50qAp
	 f6PPzBiexyPrA==
Date: Tue, 28 Apr 2026 22:10:06 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH RFC 0/5] nvme: Controller Data Queue (CDQ) support
Message-ID: <al5vjzyxuzfsylcaacrtnzuptoywhv7tcbcqwly3rdzrt65zlr@6bnz3oayiyym>
References: <20260424-jag-cdq-lkml-v1-0-d773343a717c@kernel.org>
 <20260424130615.GW3611611@ziepe.ca>
 <20260424132423.GA15833@lst.de>
 <ieeora3jekprb2h2lhs5xcm3wnchgmd3z7f3c3hf3wl4x6npoa@5uqwtljasa3s>
 <de162155-b03a-4626-a416-3425db9235c7@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdccreybr3xqmtqx"
Content-Disposition: inline
In-Reply-To: <de162155-b03a-4626-a416-3425db9235c7@nvidia.com>
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


--cdccreybr3xqmtqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 03:56:28AM +0000, Chaitanya Kulkarni wrote:
> On 4/27/26 11:24 AM, Joel Granados wrote:
> > On Fri, Apr 24, 2026 at 03:24:23PM +0200, Christoph Hellwig wrote:
> >> On Fri, Apr 24, 2026 at 10:06:15AM -0300, Jason Gunthorpe wrote:
> >>> On Fri, Apr 24, 2026 at 01:37:50PM +0200, Joel Granados wrote:
> >>>
> >>>> There is however, no clear consensus on how NVMe Live Migration shou=
ld
> >>>> land in the Linux kernel. The 2022 discussion [1] explored a VFIO-ba=
sed
> >>>> approach but reached no conclusion, likely because the specification=
 was
> >>>> not yet mature.
> >>> Yes it was paused until the spec matures, then I expect it to go
> >>> forward.
> >> And it will happen in the nvme software working group.  Which should be
> >> up an running if Samsung hadn't done everything in the power to torpedo
> > There is nothing that indicates to me that Samsung "torpedoed" the
> > creation of the nvme SW working group.
> >
> >> it.  Because of that I do not exact Samsung to have any major impact in
> >> how this will be implemented in Linux.
> >>
> >> Note that we also can't discuss any of this at LSF/MM in public, so
> > I see no reason not to have the discussion at LSF/MM. It is the perfect
> > venue to unpack the (potential) interaction between the vfio and nvme
> > drivers. Regardless of what is currently brewing in NVMe, there is no
> > reason why the fundamental architecture cannot be discussed. Of course,
> > we need to be careful of what is mentioned in public, but I see that as
> > a detail that does not prevent from having the conversation.
> >
> > Best
> >
> Thanks for your perspective =E2=80=94 I agree that LSF/MM is generally a
> valuable venue for cross-subsystem discussions, including vfio and
> nvme interactions.
>=20
> For context, we initially brought this topic forward as an RFC in
> 2022 and followed up with a dedicated session at LSFMM 2023
> where we received detailed feedback from the kernel community.
> That input has since shaped the current direction of the work.
>=20
> Going forward development and discussion will happen NVMe consortium
> approved NVMe LM SW WG. To keep the discussion focused and productive,
> it would be helpful to continue deeper architectural and
> implementation discussions there.
>=20
> That said, I=E2=80=99m very open to collaboration and would be glad to wo=
rk
> with you through the NVMe LM SW WG. If you have specific questions
> or concerns around vfio/NVMe interactions, please feel free to
> raise them there =E2=80=94 I=E2=80=99ll make sure they receive prompt att=
ention.
Thx. Its good to know that that channel is open. I'll be sure to get on
that bus when the meetings start.

>=20
> Also, there seems to be no response on your LSFMM topic, since this
> work is moved to NVMe LM SW WG it will be great you bring your
> concerns there.
IMO, Having the NVMe LM SW make sense as there are probably discussions
that are easier in that context, but we should not cancel the discussion
in LSF because there is an NVMe SW WG. I believe both can take place and
can complement each other.

I was given a slot in LSF and I'll be there to try to get clarity on the
use case that interest me (NVMe namespace migration).

Best

--=20

Joel Granados

--cdccreybr3xqmtqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnxFA0ACgkQupfNUreW
QU8UMAv7BbFzDr/eeGrR3ZXRvn+hxKiq0iDyW/Mm949U8XrzskPtNZsY2vKYVXOS
YPsMcW6T25dWaPIave2WSOA+G7V8lZYG59KTQLbsK/JIMo7q3bv1i34Q5kov1m0o
VGmGE0q+YiRoFuQFJTOnl+4rtdpqh7609sRI6f9jGrAVAgo2IzY6KDg8L/F15FIv
K7HEvflvIq/tRK4YWC2pfgWQ/V/548HzeV4vG1HQmkgP+joSdSrAA2rcnVeX3BrE
uR2en3p5eCFceZtaGsbvNe0eeQOhS5KfUk4QnMesutWDDYu+Rs16a7mddCv4k0Tu
pwL91xaILvX4L8zSX9oL83/QNdW7hWLNuOzvUfniHumIUVijsw9Rdb5ybAB4ku3Y
b93koGmwqx9eGdlY82kdmtoqm2VaIY6hXgSmee+nu8rJk9meu1erIJ/nU/C/9yWa
OBTK2epmLMPhxcTYcZ7nazxjndzbQFi0qACCz0GtioMrSEHO3khDyfKQRLc7+eNL
2ChxQbxH
=TGLB
-----END PGP SIGNATURE-----

--cdccreybr3xqmtqx--

