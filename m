Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE2ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/yTzZRPtajfG3x8hpxO11HsERRLuovkW26WkgPdAso=; b=JnUZmlsG+b76e/qu5qb6bNcohZ
	1Dj5yHrV/NbJaLJbNYNQuqb/ZMxivHBHJy77krI+jO0DOJ0FQgqHcgaADe4d+6E/e8fEN4bGeCZja
	vzzceU9aWswwHwN12dJRnqMqCm/TKqC+TUeIyNGhmF7e4/w7mHz7qiSymUjpKaJ3MKDsvHHf2LpkS
	oCfmnNiQ54HtKd732l1CekPeBQR2YFt27hg1vC6DkVwzkufcV3LmKqjfmtkYysNW9+sNhNDTzQGib
	9m4zjr0X9T6QVEa2shJRRNL7zpducgIcGWQnuxsrSTor/2E+gfq9mlkkePRTE7GmjcKsBufrG1TrI
	ECJAWP3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooLL7-00GFGt-Uc; Fri, 28 Oct 2022 09:07:45 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooLL4-00GFEB-BY
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 09:07:44 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221028090731euoutp02412be12ca78db320f369bc42a2221d70~iMGu7obuQ1665916659euoutp02d;
	Fri, 28 Oct 2022 09:07:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221028090731euoutp02412be12ca78db320f369bc42a2221d70~iMGu7obuQ1665916659euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666948051;
	bh=3/yTzZRPtajfG3x8hpxO11HsERRLuovkW26WkgPdAso=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bv6mv1Agmvnr7ibxcrNcNPeGQSHbHwpodqV9c069qvLAfERkg/uSqXRj3Ds9uaRZj
	 4FyDH2L+9gklqemnoJR1jvZwVyqOtBRR12edW5Bpq9bxQrVUxSx7R3AGgfJd7FnWff
	 o57IC7iYObIxtJfizSlCGH4iIQvjiqhNQEjvlwPQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221028090731eucas1p2640e363b1d6174b378325c9cb70c69ad~iMGurFA_h0190601906eucas1p2w;
	Fri, 28 Oct 2022 09:07:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.A5.19378.2DB9B536; Fri, 28
	Oct 2022 10:07:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221028090730eucas1p2171e6124d95e521a15c7ac9905c1177e~iMGuEaBFm1460514605eucas1p2k;
	Fri, 28 Oct 2022 09:07:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221028090730eusmtrp25598a36d726aa5ffb5218927e424dee2~iMGuDw2wr0292202922eusmtrp2k;
	Fri, 28 Oct 2022 09:07:30 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-e1-635b9bd2fcbe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.FB.10862.2DB9B536; Fri, 28
	Oct 2022 10:07:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221028090730eusmtip12a066c8c3d3d7fc5d6c09cb1c0a23d18~iMGt6pbap2273822738eusmtip1D;
	Fri, 28 Oct 2022 09:07:30 +0000 (GMT)
Received: from localhost (106.210.248.238) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 28 Oct 2022 10:07:26 +0100
Date: Fri, 28 Oct 2022 11:07:25 +0200
From: Joel Granados <j.granados@samsung.com>
To: Keith Busch <kbusch@kernel.org>
CC: <sagi@grimberg.me>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, <javier.gonz@samsung.com>,
	<p.raghav@samsung.com>
Subject: Re: [RFC 1/3] nvme: Return -ENOMEM when kzalloc fails
Message-ID: <20221028090725.4qhcfdgzxpm56sew@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mwybhoaafzzgfx47"
Content-Disposition: inline
In-Reply-To: <Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
X-Originating-IP: [106.210.248.238]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87qXZkcnG8x9ZWOxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDJurn/K
	VLBGpGJ++zKWBsYuwS5GTg4JAROJXeePs3UxcnEICaxglNg0eyIrhPOFUWLPpKnsEM5nRolD
	u6+zdDFygLVcm6ECEV/OKNG55QQLXNHJN2egnK2MEpPXtLGCLGERUJVYO7+DDcRmE9CROP/m
	DjOILSKgLHF3/kywfcwCaxglWrvXMoEkhAXsJPY2zwFr4BUwl+joBpkKYgtKnJz5BMxmFqiQ
	uNHVww5yErOAtMTyfxwgYU4Be4lrU6ZAXaoscfqpJ8SftRKnttxiAlklIdDMKXGxaRMrRMJF
	YsbCrSwQtrDEq+Nb2CFsGYn/O+czQdjZEjun7GKGsAskZp2cygYx31qi70wOhOko0dnnBWHy
	Sdx4KwhxI5/EpG3TmSHCvBIdbUIQM9QkdjRtZZzAqDwLyVezkHw1C+EriLCOxILdn9gwhLUl
	li18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA5HT63/GvOxhX
	vPqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8J69EZ4sxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nJdthlaykEB6YklqdmpqQWoRTJaJg1OqgUludfha7ss7c3xDW293vJv39/2esx1eab0Coa+i
	zzyMLC9+0uF9/2RY4sKlBdN/BSx/m1Sc6+O0M75krvmOj//Fn/PbO0V/nx7KLdVyat0Mi7e6
	Jdc/Cv+r3jxzVe59gTkXnn/psy24JJxuqC//7eK955Xrqq0bj2Sv3bh2c8h6FhW72xs/Vese
	MD0S68LYfto/1rjSMC1dr1oi0Lfm+P9cww2K1V/jK2Kq93fxKrzctmapOov2ZlZt9aWaTwMO
	JT62DzvWtGcK73mOp74+yV+5Y3xNuRI3rLcTee6wlWnLx8s/w6dGdHH4XX85Y+PZFcapu468
	vah0tzR6ZtNjVfPos/MCcjyVjt+bav7uT7sSS3FGoqEWc1FxIgAoEysByQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7qXZkcnG8xZJGaxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAlii9GyK8ktLUhUy8otLbJWiDS2M
	9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJW79rEVrBKpKLz50uWBsYOwS5GDg4J
	AROJazNUuhi5OIQEljJKtL+ewNjFyAkUl5H4dOUjO4QtLPHnWhcbRNFHRomJ768ygSSEBLYy
	SkyYXQtiswioSqyd38EGYrMJ6Eicf3OHGcQWEVCWuDt/JitIM7PAGkaJ1u61YM3CAnYSe5vn
	gDXwCphLdHSfYYHY8ItRYsb67UwQCUGJkzOfsIDYzAJlEqeXrGICOZtZQFpi+T8OkDCngL3E
	tSlTWCC+UZY4/dQT4uhaic9/nzFOYBSehWTQLCSDZiEMgghrSdz49xJTWFti2cLXzBC2rcS6
	de9ZFjCyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM023Hfm7Zwbjy1Ue9Q4xMHIyHGFWA
	Oh9tWH2BUYolLz8vVUmE9+yN8GQh3pTEyqrUovz4otKc1OJDjKbAUJzILCWanA9MIHkl8YZm
	BqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwbJ6U4vs2N+BG6Nf/Cnd4P
	YrMFmXax2/7n8ah9y6vywHzT6xgWrqcbNu9P6Wwu/7XJZfmuba+dT6aY3Zo+6Tfjvj0PfPcu
	3fjsx/ndB19NPlJV+LPA0G72vL2Zl4W2mWo120VH6xcXmR3+f3Dh4QyewAuKD2fpaibZz3l+
	7u2s/4LbptbYaq67G631LuHYK511M9dnnxbtuySvEcr8ZOt7O8O8B1dkE1j7uObz31yaELnU
	9lvt8dQJ3yZd4leRldhYsGDn7ifBi3eVxNcaeQgfl5kl55egdPpN6cpfGZN1/so/eSO67khe
	g5LuBsn/EVuf10yX1nzJc2I2S8A0t9L61W9KzAySq6emukzZaHqKS4mlOCPRUIu5qDgRAEVW
	h1poAwAA
X-CMS-MailID: 20221028090730eucas1p2171e6124d95e521a15c7ac9905c1177e
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed@eucas1p2.samsung.com>
	<20221027155724.1161670-2-j.granados@samsung.com>
	<Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_020743_036670_BFF204B4 
X-CRM114-Status: GOOD (  17.07  )
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

--mwybhoaafzzgfx47
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 10:26:57AM -0600, Keith Busch wrote:
> On Thu, Oct 27, 2022 at 05:57:22PM +0200, Joel Granados wrote:
> > In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
> > failed. This patch corrects this behavior and return -ENOMEM
> > Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")
>=20
> I'm pretty sure I had this returning 0 on purpose. We can proceed
> without this optional structure.

Looking a bit more into this I see a couple of things:
1. If we fail in the kzalloc, ctrl->max_discard_segments and
   ctrl->max_zeroes_sectors do not get set but we return 0. On the other
   hand if nvme_submit_sync_cmd fails, ctrl->max_discard_segments and
   ctrl->max_zeroes_sectors still do not get set but we forward
   nvme_submit_sync_cmd's error code.
   * Shouldn't we just set ret to 0 before returning regardless of what
     happens in nvme_submit_sync_cmd?
   * If we are returning 0 no matter what, shouldn't this function be
     void?

2. The function nvme_scan_work will not rescan the controler if
   nvme_init_non_mdts_limits has a return value that is less than zero.
   * Should we remove the check in nvme_scan_work to let the scan move
     forward regardless of the return value from
     nvme_init_non_mdts_limits?

3. I think what makes more sense is to:
  a. Make nvme_init_non_mdts_limits a void function
  b. Move the warning of failing to read mdts limits inside
     nvme_init_non_mdts_limits
  c. Allow the scan work to move forward after executing
     nvme_init_non_mdts_limits

What do you think? I can spin up a patch for this if it makes sense.

Best

Joel


--mwybhoaafzzgfx47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmNbm8MACgkQupfNUreW
QU/jlQv/WrE6O+nWJbpCYJhchyzJD0GYfzJHnUKyPr2PeRUeK9KWMZdndh2JXo6a
TBPCOByr9++RSPiE6pDPbH3IV1QCMSgRBnedKRv5SplCOzwNmyDJ005Vf+EO8TwM
1gjzHMJ6k5q60Qpmeu53yEstR1OhlqTV/y30U2yLLEorRhjKWw4izOD3LWcGsjGF
WsjX1+BA+T4ZDH89QTscKIjVxcIWuvjf2SjmJHy2lLujzBiGEcFaAiWPEcH1AL8C
0R3G+fZLnJeZxlZpwQyh+XpKLWutgi5qxcHjqZPr0zx0wFDtDPMGTIn/Y63sNmtv
F2xwM2dfzt/vGfWHL8siy3JkKujCzG3eW8bDIl2yG/QflA38uQ3jTkXNbQ8JrxtA
/GP7xBN1uPU7pw+O+A8oI5W4YOSU7Ju+5PqolYORTWCT4ysvxvaML09P55ZrRxMN
eRpeHcdw3lQlFYo0fNfbrlY7Snnj2u9C9BWrmzx+yGagDQcgPgNo2QYY/Zribdzy
TTV4LClp
=xhKB
-----END PGP SIGNATURE-----

--mwybhoaafzzgfx47--

