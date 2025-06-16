Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B4C71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 08:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nKFyL6kHGsUkO+q8agC+zR0Go57BP4LT86ehYkplXn0=; b=gZatpAV86qDYb4q9r/S+xTiBpY
	msVhEAqGdWpEi1EPDfZliL9tsJ9Yd+UqWRSXMMoPv3FRe9jYYVWBQEThSro7NqeL+Fw0z3a3t0DuK
	K4uh6jUHTIhiz8dfLB2ogNEMjowX+h1v4SCP9eBer6KKnybr4+dVnKdaFBdombmRgStbkvFL3soL2
	JWMEDOsl4KmTEde6SswhB0heLR+FMJZIcf2EzPi7YRWUvy9YPSEtktJsPnHJwl70xu7gjlxaTkOAb
	8GgoI8gJ+l9TqQEbvk6AAJ1B5aPTTf7AV+78r6OEZTgIdMQl7fmvne1iVI9YFchVlirobfz9uV2CX
	09nmgD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR5cU-00000003qyX-0ADd;
	Mon, 16 Jun 2025 08:55:10 +0000
Received: from mail.quantro.pl ([51.195.47.38])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4wS-00000003kuq-0LZN
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 08:11:46 +0000
Received: by mail.quantro.pl (Postfix, from userid 1002)
	id 7447B2503F; Mon, 16 Jun 2025 10:10:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=quantro.pl; s=mail;
	t=1750061464; bh=nKFyL6kHGsUkO+q8agC+zR0Go57BP4LT86ehYkplXn0=;
	h=Date:From:To:Subject:From;
	b=H6nun2k4zhzuyGOmETMXjs06k6KFzsRjoaZjxGBZl6/3VPq9pNA0F1LpyCm8OD7+4
	 whCIM2GGw5/ygnsMWdoTfov2i7vRc4iPtJ4XCVrjseZhH8uVwN9qxzCHvG7ckR05nb
	 bNE5jcMVpQ6WQYgM070eKcok0T47SCrSiWX2cEWYBuqBbMF3vaHO/l201qdFWDvQEZ
	 ji3xPJJ6kTO1C8y998l3j3pt84ynA4Xr9Oq/iehMoufj2I5Il+iXZwHVC0vyGg5gHY
	 v23p/2JxP9QCo5e6Ejxt2SrdT/GJRy/J5NhIh1Ivn51WGXU1zszpRR/52/J3vw5g7s
	 JJHOAVz51qxRA==
Received: by mail.quantro.pl for <linux-nvme@lists.infradead.org>; Mon, 16 Jun 2025 08:10:48 GMT
Message-ID: <20250616084500-0.1.i7.5hng9.0.cjzpif2sm2@quantro.pl>
Date: Mon, 16 Jun 2025 08:10:48 GMT
From: "Ewelina Koprowska" <ewelina.koprowska@quantro.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Karta lunchowa
X-Mailer: mail.quantro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_011144_861121_222514BC 
X-CRM114-Status: UNSURE (   1.02  )
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

Szanowni Pa=C5=84stwo,

czy zastanawiali si=C4=99 Pa=C5=84stwo, jak zwi=C4=99kszy=C4=87 zadowolen=
ie pracownik=C3=B3w i jednocze=C5=9Bnie zaoszcz=C4=99dzi=C4=87 na kosztac=
h zatrudnienia?=20

Obecnie jest mo=C5=BCliwo=C5=9B=C4=87 zwolnienia z op=C5=82at ZUS a=C5=BC=
 do 450 z=C5=82 miesi=C4=99cznie na ka=C5=BCdego pracownika poprzez dofin=
ansowanie posi=C5=82k=C3=B3w.=20

Za pomoc=C4=85 karty lunch pracownicy mog=C4=85 p=C5=82aci=C4=87 w restau=
racjach, zamawia=C4=87 jedzenie online, korzysta=C4=87 z cateringu czy ro=
bi=C4=87 zakupy spo=C5=BCywcze. To doskona=C5=82e narz=C4=99dzie motywacy=
jne, kt=C3=B3re tak=C5=BCe wyr=C3=B3=C5=BCnia firm=C4=99 na rynku pracy.

Ch=C4=99tnie opowiem wi=C4=99cej na ten temat, czy mogliby=C5=9Bmy porozm=
awia=C4=87 w najbli=C5=BCszym czasie?


Pozdrawiam
Ewelina Koprowska
Senior HR Manager

