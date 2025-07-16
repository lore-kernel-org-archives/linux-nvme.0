Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F8C83F22
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMiPG79BaSZ4L1hLtwrRDyKYn96Armmq5Ph/ugdG+P4=; b=dIp1bG/xiSVe87B8XbRri/nlEQ
	q6usuGZ50yxHRIbHbEPDIfAzhI5IpXbMKpW5V4MGI9kF+AsGjTtZZIA7Lv6PvfxlMmXzWQWDhxt79
	b4mqRXxuzRe/v9dZVoU6R4EQWBwxlvE9upX8wcakxDdrt8Cd6mS/lXhSuPdDP4XoqL4Y6wn3liTVQ
	KyAYs1/C0/1JEPD6zvfHd+65G0Xu7Lt6XnCnRFANH5dH+cE8SLKw+wlMbhJre18wp1Jl641mTcZTX
	2ut/k95jYszgZCQ2Z4axBcKEpoVKlKN5ifICrAvKlomQwVsa68sopJJWxBbo8Liei2qC3h2uBVZjp
	xhDVs11g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc5v0-00000008INa-3n0b;
	Wed, 16 Jul 2025 17:27:46 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc5uy-00000008IMr-2wFr
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 17:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1752686843; x=1753291643; i=christian@heusel.eu;
	bh=vMiPG79BaSZ4L1hLtwrRDyKYn96Armmq5Ph/ugdG+P4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O3hAp0CifQ/eTBlPNqTIXYqKCCZatysp5C04WaQwjcR/FbHaaiqOPCYqgTaZBsFL
	 D19/Fv9Kum/PtSSyDDBT6wmtOAfUtHYrZRjSCz1DNDXHAvioJB8sabEhAnX05VOCM
	 Ichs/TvnZ6aDbEf+qH2l5gr4rQFUZe9wGO6/myUP94SSa9XeIxFmy0AvbSijLQlyl
	 ULoTSqPdI20VHL50awZKDl2c7/4jNqcBb/rhoAJqUfEKrcXHM/NLG1w1+YdrUhACC
	 jA1jcQLwr7WanqJoaszkZvYXcBO83E+DQADLsT7cZTyghA56Trho/j4cbA1O1Ugvc
	 WpFGYK3fwbkna7D8Bg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.36]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8oKc-1uect32ncE-013Nfz; Wed, 16 Jul 2025 19:27:23 +0200
Date: Wed, 16 Jul 2025 19:27:22 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
Message-ID: <2e4ed0b4-2842-4800-aa66-f61daef0b8f9@heusel.eu>
References: <20250715130814.854109770@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7sica6oli6b7agoc"
Content-Disposition: inline
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
X-Provags-ID: V03:K1:K6XnB3JWmNPX0QTV4zAROE7BZa14Co9A+1RIQI5s36x5KERsKud
 D+u6I+gYRJyOodI3u2Gak/RMy8h+mAzNo/xhGKXj3xVMJZ2pAms4P4mtVbx2x83O6I28yFa
 acAM8rCFQCyWR3m3LANEHCTjLFOV/+mGxvnpLgWsA6C46tbXycH8bp4ocTB8OLhTYbbFz7q
 t++2iiE4+qVYNGKyOC1Ig==
UI-OutboundReport: notjunk:1;M01:P0:q2cKHfps5vY=;77Q1iHgHs+55l35VF827FJYriFE
 U06oey8YgU20iuMtDTvsG8z2ej52dqCVWxpnq8+N54ZKJjszKG0PHMoqllnpwwJecSETH/ext
 Y2Xj7xT/f2DUTQSX+fMnanlmfACreHydgpMc2gAlt62ZgQjJKBAl1MXPLxqA7k9xCxmCVQHff
 atrOrcpAAH6HG6DqAitgZxNqVslFIbnLBXxMcX7Dm+3pZrUsINBaUpPX4HMCPuO85rQehYme2
 nwtQ9Z/IEBvEDCzsgTg4N7gMlKrSXT33EvpuiXBEBWjCwOn4XDMjZe1eD1AemDK84sSopvFs5
 eA1/Ps1d9JnYaD7uO9dED3wYEF66fex6Ac0Qsif4BoXr6Y+eGbfInxceY2y7pw/rrFYjQjWo3
 P6qTgYj0aUTYw0Lx5BvQZFnnqw4BGAe1kQxIKIScmAPCu9q9elTgBOyYCteozLK7BJoKs69rA
 Ys7oJGo7n5AlqG8HNpUHCndEmKbcUwCXhxs2W8BtJY4DpZy3TLNA5MF5c7XnHL+oknD7QBHjq
 s5UsvtW0/+NxBwXbNLngJAKenqJrXi4/z4qxs6HqS+Vr8jo7INkaVVYehhU3IDt6m8vjAmkMr
 BMWJaBALHF/vgcSrXlTbCfmr4pAhojfxUm17xCuqWEyk/nJR6S2cgBqVlAmdmsBzWnkvi0sAR
 hDJYlRwwDSnDYNecKatpEsHC20Zk2TYLlc7oHRqe6bTE6nT+qP6PvgjHUPGq9Uw1b1vG/tHG/
 Pi4xpx5WatVm+OYtIs2X8zyza3/8Yv2rMHRksM0d5NOjBNcIcPz69JkVRrny6OPO7VglhMZJW
 5cQ+HRRKSjbOUDXU/A+XZ/2berTOefSi6MGyc39QDELVl0j6ko+C0LDgcQFcYmXuNYcAV0HJy
 ui3BeeWqXCW8osuQaKcRhcobpnFGukA+hDQmNaZb9x3YNrh58XQCRJiuLyld1hzqD1dMxwIx+
 Z63ScXHSoxFZY9Yla9VzZPEDnqbttQAbDZuPmyne7Jrti/WLzULABOjFGNDSYQHDVScmyokiC
 DubpyKdFIYli/3Cwx0dXN2br+BO6oGfE+tM4Pue/CbA3QdkzM4c53CazUhpnlA4gA+CGvF11S
 XyU4d695wyQCTY4JhXDCEXlOXCdAo8tkgBSiGDV5rWofm2b+S/I6QBA/UvQaF1U3DXRW+5fwn
 nwCepZg6Xge82m68fsVEA4dHChlBuUSodx/55wnIuGJnHDk5NduecL1IubsETphg1wuwwvOv5
 PeXrec0iVKstkyzy1ZzWn2adGOo7HpRGFVXyfOuz9bXWiTFmVqcVj4vfBG5NEDVI6ICINGE0M
 ijjmrtcnvGtSSpY+gxagRhioHpG2akSpzLwr7rGFb9Mihg7LfH0lr3uSkkMddoZ6KQt0RtuHA
 NZnmUh8XbBjBE1mavlxkzYSs8i1LS0CRQlVbO42BeOKKH+3s7Ds+/2rzkVpIsOqOQeiFvQtsZ
 w9THoldTDLWRaB+jr8gqTzh4O+s10t1TLk1hv0vD+lMTF3aJDuLdCYYpQ7V9ZurmN2DPKfQEI
 XKLg8WYkNJF50nTxkXPC1s1AGVpXGFvZ0sMkeOzQRv9HJZ7o8vjBcod7x1PQvQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250716_102745_177103_FB050C1E 
X-CRM114-Status: GOOD (  14.62  )
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


--7sica6oli6b7agoc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
MIME-Version: 1.0

On 25/07/15 03:11PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU.

There was one oddity though, that under high IO pressure the following
messages were emitted and I can't judge the severity of that:

[65524.312500] nvme nvme0: I/O tag 956 (f3bc) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:8192
[65524.312530] nvme nvme0: I/O tag 957 (e3bd) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312544] nvme nvme0: I/O tag 958 (d3be) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312556] nvme nvme0: I/O tag 959 (d3bf) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312568] nvme nvme0: I/O tag 960 (23c0) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312580] nvme nvme0: I/O tag 961 (73c1) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312592] nvme nvme0: I/O tag 962 (13c2) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.312604] nvme nvme0: I/O tag 963 (13c3) opcode 0x1 (Write) QID 11 tim=
eout, aborting req_op:WRITE(1) size:4096
[65524.515650] nvme nvme0: Abort status: 0x0
[65524.536423] nvme nvme0: Abort status: 0x0
[65524.581238] nvme nvme0: Abort status: 0x0
[65524.628017] nvme nvme0: Abort status: 0x0
[65524.661905] nvme nvme0: Abort status: 0x0
[65524.702179] nvme nvme0: Abort status: 0x0
[65524.723759] nvme nvme0: Abort status: 0x0
[65524.779577] nvme nvme0: Abort status: 0x0
[65524.871981] nvme nvme0: I/O tag 2 (8002) opcode 0x1 (Write) QID 11 timeo=
ut, aborting req_op:WRITE(1) size:16384
[65525.019778] nvme nvme0: Abort status: 0x0

I'll loop in the NVME list that they can maybe judge this.
I also double checked and the device has no SMART issues whatsoever.

Cheers,
Chris

--7sica6oli6b7agoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmh34PkACgkQwEfU8yi1
JYULEQ//ceaDj9+CH3XzBg48rQqsXWWdGAGcISr2cvNeb4c00Kjv4/p3p3q2IH0y
hRCrtVLwffRzReZiJgFual8AfBxcYvM4f4IwwQAV9lPkfggpSONPxXUoTyrG35K7
jWcJ4XgoV1tGCnCb7iZOwgvvUgDexa3SRlcFwJinNGyRN529sIwUfvIDR4VxGjuz
1Y26oWUUuvXq6Es5uWMsYm8rv1ouwbTtFBA4+QFdrhNZT6ShDprMWRWAOml6hI9C
QtOwTGJx91Lq2wkDSzJ4csbC7C4JxZwpHL89vNM1VQGvD9X+Ar1lfQPAMvdKDYKS
I5pBsvBWZa7AG8QnIGS8a+RbGd/l1DFwpr3k0ZfXnECIu+H8IfbWUcVgYV5lIe01
OnsA36NwRlAWvfXk791A0p4lIFRIGtDjuoQsNi0fU/MlLssdvHHwY5CxaMHnADqm
Q6mJout05zaMVL4t6QfNGziDmLkUJfWNBrDuCt9lrvS5oJBuX6m6VjSR+lNo0nWC
XdUQo+thpggBV0F+hs1cZwDPaD9ehdlpI4BZ2T0xKSMRC5bhjdOX4hgdM59HLmzt
MaXnfC7XUN+fe1pJS6RfrueJjkSmpXaISUaNnJ5hMsUBlEl+At2u6cEzyOA6njYi
DSIKRSp2rY+rjvXUMKFjnJ/tuwRgkAwnc5/kzZqh6RRmtapQRhs=
=/7Mt
-----END PGP SIGNATURE-----

--7sica6oli6b7agoc--

