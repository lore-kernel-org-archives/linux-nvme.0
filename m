Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DF2C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:
	Date:In-Reply-To:From:Subject:Mime-Version:Content-Transfer-Encoding:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/qXWT/0Fi+KjASICzzKTtJPP+nXwtVvlilPfML2jeU=; b=ddlqYhi0q/EJzv7cmd7UIP1vsk
	Guf/GHAlUudfCakPWvoOJAaKJOmBtGbhfzvBtblUW0qOQwCk3oyifRo6dnSQw7PTkdHYHDS2U0DFA
	QXSQioVF0gLAtaXFiw5PAI52EEXl4fUeh3JQshESljww+ga5evErCqJLlFiN9i3ojCYcbUZX9PvIv
	3oxvsWxbwJJ9xzLHXXqXQthw4XntJ6Dk3TYgKINKff7fAepYOrZfahQrmoS34xSjnfabsI8XyVK/8
	ktz47B7mONV1BOAVq12Z7mOhOzcpd7Dm+YeDGaPU9ZcydTblGLHzZS3V1TY0ze1kyCCZUlSuxrZEF
	8fVG8ASQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6zQ-0000000GX6R-45kh;
	Wed, 17 Apr 2024 15:14:24 +0000
Received: from mout.perfora.net ([74.208.4.196])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6zO-0000000GX4w-1ABG
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 15:14:23 +0000
Received: from smtpclient.apple ([98.97.139.223]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mg5Ap-1s8sZO3tpt-00WiDz;
 Wed, 17 Apr 2024 17:14:08 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: nvme-cli spdk plugin
From: Jim <jim@thebergstens.com>
In-Reply-To: <57262e48-628c-43df-8365-80763d9c2d3d@kernel.dk>
Date: Wed, 17 Apr 2024 08:13:54 -0700
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Message-Id: <0EA7899A-89A2-43DA-9633-A0475829BE5D@thebergstens.com>
References: <57262e48-628c-43df-8365-80763d9c2d3d@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (21F5058e)
X-Provags-ID: V03:K1:2EzECedMZMKRjPRgPoyIF8HV/KPUBLJVCL0UmWQxrp5NXiQ4Sxy
 2lAg8dtlALiAS2AokZB2mHJu6MaiZol9XIC626XnAuNXh4poJsEEVi2UBz66WrdMUgbVhaB
 a7UCf3P1pbXkLY4i3c1wbU67kjU6ETjVLAYXR4FXjRXdlzGy9bAunMQpoeX4WmzS77QGs3g
 9bx46u0VY78RUEus55mKw==
UI-OutboundReport: notjunk:1;M01:P0:jsw2MTRQdkk=;h/mNbwPnEfmHNxwiIU7K8Pd/Rjh
 sk3M18EuBVhz4N5Jq1K6PNCtOZCEED8Mct0B4ca0LNnpoOKmdFXhmChoR5QwGKd6HJuT74x2c
 vUuP0mvyVbYdiR/SIBQqgu2TLkp29rPCbXyt5waUN3QoNVbDljaeMhyOPV2kumGTW94fz/xvf
 Ynkbp4uofHf4YLC9Xkx61+19yMtLR5bC1Uj8f0FYuvsUgyxDp1jUfzuuEPgm+sw2iuje5Znvn
 JepfhPwNAjD5G8I088JCHpgsHM/eo/2EHNyHdEtzqs4lhnDo4hiawj0Y9xVG1057S4S+OzutO
 t5xP5ici/T+8HpvL18fwZ/8+yaxyUMB4Me+Hcl6jqymrG0SP3GsueJJSUgqXt0kGA/Zpdj/yY
 IoQvZEPU7vtfeQ1tzjfEfzoeFhwA1SbVNIYs0bSzGQPSu+A8dSZRhBqZaNoBxlDbDKR6tMIn4
 HetRftV0m3gbydwnzZkn9reodWAsQd+PMvaQymofrFQzUCqnXa+7fJerfcgAA7ciujXh1SQfB
 Dc7jucJ2PXa54a6jv94/E6U0QU0uRsWOJjpUzd8+/kSrlBEIYdx498hU09T+y5zG/969KqptS
 JaDMi+40KKDjPPdcwd/wcwsZtts232dCi1iySBayUVsiWB80e/cpkoBPrNxEYpZnrKB8lgTGP
 IwbDd+hANAr72KpXYQ4SHi82Bo1BUxu9OU+cS6llsLfSexSzdfpk41JS7bMfHP7Xvb8EFhsEB
 GQS+ALUhXvQj+0WPvbKH8UWyu9LoZymK4TmYNlSWm4K606Xc0XAoic=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_081422_427454_3D00B431 
X-CRM114-Status: UNSURE (   8.90  )
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

You=E2=80=99re quite welcome, Jens.

Here=E2=80=99s a quick story - years ago, while working for a large company w=
hose name starts with =E2=80=9CI=E2=80=9D I was testing NVMe memory access o=
n a frankly obsolete controller when I discovered a bug in the Linux NVMe dr=
iver.

I dutifully reported it, together with supporting documentation including th=
e test I wrote to reproduce it.

The sole response was, =E2=80=9Cwhy aren=E2=80=99t you using mvne_cli for yo=
ur test?=E2=80=9D  Sound familiar?

This got me curious so I looked at more recent driver code and found that, n=
ot only was the issue already fixed, the person who flamed me was the one wh=
o had fixed it.

When I pointed this out, my boss literally YELLED at me (yes, the sort of HR=
-firing behavior) for having the temerity to disparage one of the NVMe drive=
r elites.  Said elite has just replied to my email.

So, yes, it is useful for the rest of you younger folk to fully understand w=
hat you have to put up with to keep on collecting paychecks.

OK. Perhaps not useful but very self satisfying.

PS If you wish to drop me out of this list for this disruption, please do, I=
 really don=E2=80=99t need to get these and it just clutters up my local (NV=
Me) storage.

> On Apr 17, 2024, at 7:57=E2=80=AFAM, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> =EF=BB=BFOn 4/17/24 8:39 AM, Jim wrote:
>> This, right here, folks is why I=E2=80=99m glad I=E2=80=99m retired.
>=20
> Thanks for your useful commentary.
>=20
> --
> Jens Axboe
>=20
>=20


