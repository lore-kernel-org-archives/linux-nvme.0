Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B29CE8D58
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2024 07:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=; b=I1G9pGo2rFX1VSX8yk4+n45MmJ
	wfMl+BaDZIXsmJNeECtpGVkmn/nrfmq5aMSEBLuVxgoBiNgOHFnUlicFLAnHPPhMsqoDypgv+N4H8
	CJJi2jDSIPBDDh11aEMVwIdm81/jAdLx8MfzqW5ZK4ALL/CmWvsjhOm/itOrESpYvWGE9vXXaxC7J
	2jbsBoDBvIPgDWpkiT75FbB0R+6pIzsiAFW/+GIldkd+OlU01hYmyFS2CKUk6mAakMr3L53Nt6G1u
	9gdiFdohIsR4XFYZHDEe5xE5rj15nl85BiDp8RwgvoGG7foFiuLsiWdSUc5G07ZhE0rc4bSJZBO79
	Q8NFf11A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srBhN-00000009fAy-1HN7;
	Thu, 19 Sep 2024 07:35:33 +0000
Received: from mail.geniusthrive.pl ([217.61.112.199])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srBhK-00000009fAe-2p2f
	for linux-nvme@lists.infradead.org;
	Thu, 19 Sep 2024 07:35:31 +0000
Received: by mail.geniusthrive.pl (Postfix, from userid 1002)
	id AA80284A66; Thu, 19 Sep 2024 09:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geniusthrive.pl;
	s=mail; t=1726731194;
	bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=;
	h=Date:From:To:Subject:From;
	b=tYlJ0BW5GoO7TXAwOFTqcWvp6aKpTYV5Cwrb+KjxhOTMg3gAfRj2T90NQ9zdnw2wm
	 EOcNXmpsA0gA1hLPHgQMPCqSJHzVzzNZzCIyrsrP6GBuRGoMObOpnraev2DJr9Pen3
	 mkDtxx5hJTq7EHFo7KY2GsYqK1rBjfb1uihBmg52YqkkydUjFOfceOBZb+2q8LB4CQ
	 VIXwog51DGgNAR9mDp92qnRAuWX3/cKowtVhMNSug2kY/5d3FoGHpUYDTgGVIGvhn2
	 zL5uIyvbwxv6Mc6IZafT+wqZoKDP+iLJPox1i8SyQZfKvYSYk9QAtxOXPasGgPE7LN
	 Eftmp62TWsIEg==
Received: by mail.geniusthrive.pl for <linux-nvme@lists.infradead.org>; Thu, 19 Sep 2024 07:31:05 GMT
Message-ID: <20240919084500-0.1.9r.16bky.0.rr5diop1db@geniusthrive.pl>
Date: Thu, 19 Sep 2024 07:31:05 GMT
From: "Patryk Wysocki" <patryk.wysocki@geniusthrive.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.geniusthrive.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_003530_850524_94FCFDC2 
X-CRM114-Status: UNSURE (   1.96  )
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

Pozwoli=C5=82em sobie na kontakt, poniewa=C5=BC jestem zainteresowany wer=
yfikacj=C4=85 mo=C5=BCliwo=C5=9Bci nawi=C4=85zania wsp=C3=B3=C5=82pracy.

Wspieramy firmy w pozyskiwaniu nowych klient=C3=B3w biznesowych.

Czy mo=C5=BCemy porozmawia=C4=87 w celu przedstawienia szczeg=C3=B3=C5=82=
owych informacji?


Pozdrawiam
Patryk Wysocki

