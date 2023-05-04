Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED1CC7EE21
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 07:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5T/I5ALH265FnsfRMA5qkcy2CLiS4J17pa3P6HzpuT0=; b=WFdcvRpj5MiHGwoaG1jiqaMuvy
	ImTT9ieCEJwZ7uWyQsHKS+giSKkEi3sCLq2PGLs1hDSoD2hLZ2Xv8cfQydw55fu5F8CmUNYZKauxx
	QmXbSvZa3Ood7EiSIJqGyVGhhthcdpVB2l2O99Dd8cqy1L+yeUwyyk98UU3r8tWlgc0DcrySZDSgz
	EUmYEKrSgNow6y4fUdDCRySK17R3o0HUWlfaxPA/hdEWdcJ1BmYOibt78QpKfkPaEcUu1lmDIEoO+
	+dUPuRWhRG7z1ytnsRWFI969w5f7mkJEEkIWBGra6nTnWcMRQYf5JaJHg6Uhg7AGatSg5iyef2RH3
	WzPxav+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puTaY-006w0t-1K;
	Thu, 04 May 2023 07:41:18 +0000
Received: from mail.neston24.com ([37.187.225.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puTaV-006vzS-2m
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 07:41:17 +0000
Received: by mail.neston24.com (Postfix, from userid 1002)
	id 7CB0821FED; Thu,  4 May 2023 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neston24.com; s=mail;
	t=1683186073; bh=5T/I5ALH265FnsfRMA5qkcy2CLiS4J17pa3P6HzpuT0=;
	h=Date:From:To:Subject:From;
	b=gp+BU6anUlsvEWjmtI2JSK21zeCdu9gBwc/0PxY9zSmDI+yei2tffXZ9pkFKVmc0w
	 SyJGqet2jXwQR8ad516Lq3HTXaaU35LLzmfW8pd4dC2kWapNCMJHHGwIp5XHyrT45F
	 UEkN0c6ftho5Lwhuwno9HSN3oy/eCm3KPMy+z4gjvczX5L9qx8hGqrU/6hPDCwsWnR
	 XEAiOcYG2YMeNGHpytAdUdIi6rOXjCaK5oMd4CGRuUVPEKmaerfHgf0k/9dHIpCgER
	 l/7n6StDwq0q8wGuao4cS8JSgWJ4ctsQDnh7azDrbv/X25FVkacvpa8OOZUpEsQThi
	 jSChTAf8QtIBg==
Received: by mail.neston24.com for <linux-nvme@lists.infradead.org>; Thu,  4 May 2023 07:40:13 GMT
Message-ID: <20230504064500-0.1.6m.d0lq.0.l6opm3seq4@neston24.com>
Date: Thu,  4 May 2023 07:40:13 GMT
From: =?UTF-8?Q?"Leo=C5=A1_Sl=C3=A1dek"?= <leos.sladek@neston24.com>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Fotovoltaick=C3=A9_rozvodnice?=
X-Mailer: mail.neston24.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_004116_041146_D641E4B7 
X-CRM114-Status: UNSURE (   1.60  )
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

Dobr=C3=BD den,

obrac=C3=ADm se na V=C3=A1s jm=C3=A9nem dlouholet=C3=A9ho v=C3=BDrobce fo=
tovoltaick=C3=BDch rozvodnic ur=C4=8Den=C3=BDch pro
soukrom=C3=A9 i pr=C5=AFmyslov=C3=A9 pou=C5=BEit=C3=AD.

Dod=C3=A1v=C3=A1me fotovoltaick=C3=A9 rozvodnice na zak=C3=A1zku a jsme s=
chopni realizovat i ty nejn=C3=A1ro=C4=8Dn=C4=9Bj=C5=A1=C3=AD
po=C5=BEadavky instala=C4=8Dn=C3=ADch firem, velkoobchod=C5=AF a distribu=
tor=C5=AF.

Vyu=C5=BE=C3=ADv=C3=A1me nejkvalitn=C4=9Bj=C5=A1=C3=AD komponenty a mater=
i=C3=A1ly, =C4=8D=C3=ADm=C5=BE dosahujeme vy=C5=A1=C5=A1=C3=AD odolnost, =
stabilitu
provozu a ochranu proti vod=C4=9B, vlku, prachu a n=C3=A1raz=C5=AFm.

V na=C5=A1em sortimentu jsou tak=C3=A9 omezova=C4=8De p=C5=99ep=C4=9Bt=C3=
=AD AC/DC, kter=C3=A9 zaji=C5=A1=C5=A5uj=C3=AD ochranu
fotovoltaick=C3=BDch nap=C3=A1jec=C3=ADch instalac=C3=AD p=C5=99ed negati=
vn=C3=ADmi efekty p=C5=99ep=C4=9Bt=C3=AD a chr=C3=A1n=C3=AD za=C5=99=C3=AD=
zen=C3=AD p=C5=99ed
efekty p=C5=AFsoben=C3=AD p=C5=99ep=C4=9Bt=C3=AD a bleskov=C3=BDch proud=C5=
=AF.

Chcete si vyzkou=C5=A1et na=C5=A1e =C5=99e=C5=A1en=C3=AD?


S pozdravem
Leo=C5=A1 Sl=C3=A1dek

