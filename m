Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED4FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+PMi7irkA4XlRgpdW2HqpqcJeZNxKGysf407T0katTE=; b=feLwCDPDBmssMikh9UGb8tlQId
	L43ccJ1nCuoWH/PTivRupkG/e9mt/hmckEZl4oqneNZEVAUgX0hryZfczwj/DwUSkHGm2tiTHJil/
	JHKBLJ7j8whl0k626J4K/s2xB3wku1PKV+YXGMvXoSluJhCexmDZLGQo4Gyek/0r7FdevFcFLXkfX
	BO/rxPxl+qgkWT8ytsAKOL/OJi//qGOgM4ecszueystCFqdInQdYIl4Sy+0rvSDjkE5+KogSuur3F
	2+x2GBBWBjvFdMf5PVewgu9jeErda6w8U6t0v+GkexX26nflCIzW2aVqumXJklrcPOZqSl11EZEpL
	YYQ9WM5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBvNy-002kEo-OZ; Mon, 24 Jan 2022 09:11:38 +0000
Received: from mail.portyid.pl ([192.36.61.58])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBvNv-002kCF-VO
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 09:11:37 +0000
Received: by mail.portyid.pl (Postfix, from userid 1001)
 id 27EB241455; Mon, 24 Jan 2022 10:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=portyid.pl; s=mail;
 t=1643015490; bh=+PMi7irkA4XlRgpdW2HqpqcJeZNxKGysf407T0katTE=;
 h=Date:From:To:Subject:From;
 b=DvKGVCxIQCs29HbHaoSprbzzooQAWgMQMjVMcdt6Dymh8hR1SsK8flHFP9mkNNOGp
 0mDiSmJxWyCWDDmwB4SBJooSoxIuOI0okK4AiruL9b4tnj4A/5+znJAD/a3vqeOESb
 DjhVW/TVApuPw9905InkuxhUJLQcFin+tTziyW8Dq3BJJ69qQyp15EzspWL0Ksj9Dr
 s05ZLWFdmxGt465NHkqq0n0RdRk3xzgy0xTgqvdryeRNbmExrXj6YGauVy+YDrO4hI
 X7DtEXaYg8Vyp8yTXvWDyvHcr8vdvDsMHzgPABUH6pQrlE5xjYkduOvauMaowW1Iau
 DN5jLDurooo4A==
Received: by mail.portyid.pl for <linux-nvme@lists.infradead.org>;
 Mon, 24 Jan 2022 09:11:00 GMT
Message-ID: <20220124084500-0.1.1b.5fe7.0.68h8gg8r2c@portyid.pl>
Date: Mon, 24 Jan 2022 09:11:00 GMT
From: =?UTF-8?Q?"Pawe=C5=82_Jasi=C5=84ski"?= <pawel.jasinski@portyid.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Fotowoltaika - nowe warunki
X-Mailer: mail.portyid.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_011136_189626_B53DE4D3 
X-CRM114-Status: UNSURE (   2.73  )
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

Dzie=C5=84 dobry,

jeszcze w pierwszej po=C5=82owie 2022 roku wzrosn=C4=85 ceny za wykup ene=
rgii dla posiadaczy fotowoltaiki.=20

Aby unikn=C4=85=C4=87 umowy na nowych zasadach trzeba zdecydowa=C4=87 si=C4=
=99 na instalacj=C4=99 paneli PV do ko=C5=84ca marca.=20

Jako firma specjalizuj=C4=85ca si=C4=99 w monta=C5=BCu i serwisie fotowol=
taiki ch=C4=99tnie podejmiemy si=C4=99 realizacji ca=C5=82ego projektu. S=
=C4=85 Pa=C5=84stwo zainteresowani?


Pozdrawiam
Pawe=C5=82 Jasi=C5=84ski

