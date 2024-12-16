Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC741E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=; b=JA2jbjwLYcJyuzgXcX+LkY3ngd
	KITpTo70/Ya60vtJplNBSTqxly8CssFKsMCXi8OB9SxzbL96/xIGTGCBUwUGKqd+GsL8j/LQwaFsN
	Vf2opLikRRWe/BPJsOxAoJUnn+EnDzPdVzUpZpglbqeCru5SxFTC47jzZJ6/kc9IrdUSvoDKyHPHF
	jZBBqPMWyl15jA8ipnZkcIBSSHfEqRARLcMW2uM7qkf8Iy4PgvQlLeyQBAMU2wR+GKj6QZ5ZYy2eM
	pTRJABsA4pzSA8b6ozBm329G9Tr5Wkm6W8WM4HTMeLBiW6PGpoy0rQJb/xx2zAE27Js4kXswW9zC4
	VclYxGXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tN70H-00000009U61-48Vr;
	Mon, 16 Dec 2024 09:03:01 +0000
Received: from mail.analyticsservices.pl ([217.61.0.186])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tN6y5-00000009TjN-3x5n
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 09:00:47 +0000
Received: by mail.analyticsservices.pl (Postfix, from userid 1002)
	id 697BA84134; Mon, 16 Dec 2024 09:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=analyticsservices.pl;
	s=mail; t=1734339458;
	bh=+oYP7ZwnEeonL1pLtE73TJ85xaesKIG0Ys99vCW5hiU=;
	h=Date:From:To:Subject:From;
	b=RukeqpN5VP53ywDfj0cgZwh3cNH1SqC6tPo0hLnYbuGEnM1EV/bVarEQHNndtP1IF
	 nc7tA9fPURwDHA9QEjCn7PTvy5bkgHRGWein6LQm5F/Cke2mczdVfq73VVTxY4wdXs
	 gMNaWtucIJxc+SJu/+5HJ1OB/xfwiEZVLp26ux5IPqb3L1vsDOF8b+lbyqT/v6SyVY
	 a7Ytn+V3Nf4GRSwWY5eiyitRLoNQjbxUoCuPOdN9NQ6ZGGkdDPJYXvMqO76V1EasNl
	 2SLGIr8+yHjpdLgMaij4EjsaK8UelzGQKw84xeBE/3oVTlxL65CctpNnIXhAtMTfvR
	 znyPxF6fiVikQ==
Received: by mail.analyticsservices.pl for <linux-nvme@lists.infradead.org>; Mon, 16 Dec 2024 08:56:01 GMT
Message-ID: <20241216084501-0.1.i.3n7b.0.ecmc1oy7dh@analyticsservices.pl>
Date: Mon, 16 Dec 2024 08:56:01 GMT
From: "Patryk Wysocki" <patryk.wysocki@analyticsservices.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.analyticsservices.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_010046_117714_E82A4A65 
X-CRM114-Status: UNSURE (   2.27  )
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
owych informacji?=20


Pozdrawiam
Patryk Wysocki

