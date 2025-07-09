Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DCCC83F03
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GFLqhBmGowcpiiQwNum256VPL08ZNDpLKbHxe0rNTSA=; b=ZqoJt6owj4Bblu9sY9Xv6u7gsV
	zgMzY8+kFp7AVmfKUUneEDQ9n8ky90x7A6jep63Cob2Wut3UTJigaO16rAvhmUu8pxYdmZN1J7u0i
	WIl5If/mqZLXsrS5CrlO1xkK8ALf93KiNE6LJ7oJS3nBABrjNYoAp927nmisjt6R2ONv4hITgDUi4
	03mlLXcnVeb2ZBrQrEi6JkjeEI0x1rkq8WV8ycG+0SIMjHHlmU/Jb58vt6O6jf/iKh07+KORvsYfv
	CI+7+MqCRGSLft2bluch1OeWAq5qDCHTwoWk4erVLHfTVkST3LIv/cYPHlqxg9xn7PF1NrqPXooBQ
	EGu6dwiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZQqr-000000085KN-2YFq;
	Wed, 09 Jul 2025 09:12:29 +0000
Received: from mail.bizovo.pl ([217.61.16.222])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZPIQ-00000007p60-1moG
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 07:32:51 +0000
Received: by mail.bizovo.pl (Postfix, from userid 1002)
	id CCC828371D; Wed,  9 Jul 2025 09:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizovo.pl; s=mail;
	t=1752046295; bh=GFLqhBmGowcpiiQwNum256VPL08ZNDpLKbHxe0rNTSA=;
	h=Date:From:To:Subject:From;
	b=lTWuMaGKFzUomiF3UavenrkA6sun1RvyLB9XGZsc4zwjUckK1z47eI3n+gzDtoGNP
	 YtbLY+uqv7A6BMq1Sf3rgPbDTQyjxQOSx/2fpstwgfvxf8/1/tmtqxlGfjRtnBe55/
	 5bjiVj8Vz34bmdUHJY0QLrsNPezxelF2XroioBJXI9ODp6gvGo73AVQA/6aYTjrFp+
	 slKliO2HIvCYkx6qOJ1lufinLu/d37M4xdSISbvp0koaRb4zgghOGS2H6kqii+lWOq
	 huomv/HbY6XfM+XptNRe9gF5y0jT9QDiZOmUPP+bmKpGqZIcLobfuK0ZWoIQg+a1oH
	 fRGTjjQlQpEgw==
Received: by mail.bizovo.pl for <linux-nvme@lists.infradead.org>; Wed,  9 Jul 2025 07:31:04 GMT
Message-ID: <20250709084500-0.1.8v.19c9n.0.6b3ad69on0@bizovo.pl>
Date: Wed,  9 Jul 2025 07:31:04 GMT
From: "Wiktoria Bielaszka" <wiktoria.bielaszka@bizovo.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Zamro=C5=BCenie_ceny_energii?=
X-Mailer: mail.bizovo.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_003250_587493_D19DDF83 
X-CRM114-Status: UNSURE (   1.53  )
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

Dzie=C5=84 dobry,=20

czy planuj=C4=85 Pa=C5=84stwo optymalizacj=C4=99 koszt=C3=B3w energii ele=
ktrycznej w swojej firmie?

Chcieliby=C5=9Bmy przedstawi=C4=87 nasz=C4=85 ofert=C4=99 XPOT, kt=C3=B3r=
a mo=C5=BCe przynie=C5=9B=C4=87 znacz=C4=85ce oszcz=C4=99dno=C5=9Bci. Ju=C5=
=BC od teraz, mog=C4=85 Pa=C5=84stwo uzyska=C4=87 cen=C4=99 ni=C5=BCsz=C4=
=85 o 40,9% w stosunku do obecnej ceny ustawowej.=20

Nasza propozycja obejmuje lata 2025 i 2026, a start wsp=C3=B3=C5=82pracy =
jest mo=C5=BCliwy od zaraz. Gwarantujemy elastyczne warunki umowy (3-6-9-=
12 miesi=C4=99cy), zapewniaj=C4=85c minimum formalno=C5=9Bci.

Jeste=C5=9Bmy pionierem w sprzeda=C5=BCy energii w cenach RDN wed=C5=82ug=
 TGE dla ka=C5=BCdej grupy taryfowej. Przez ca=C5=82y okres trwania umowy=
 zapewniamy Pa=C5=84stwu dedykowanego opiekuna, a ca=C5=82y proces Zmiany=
 Sprzedawcy i wszelkie formalno=C5=9Bci realizujemy za Klient=C3=B3w. =20

Ch=C4=99tnie porozmawiam o tym, jak mo=C5=BCemy wsp=C3=B3lnie zrealizowa=C4=
=87 Pa=C5=84stwa cele energetyczne. Prosz=C4=99 o wiadomo=C5=9B=C4=87 w p=
rzypadku zainteresowania.=20


Z pozdrowieniami
Wiktoria Bielaszka

