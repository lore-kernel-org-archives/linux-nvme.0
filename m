Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF326C87FCB
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Aug 2025 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=Z18gCZwhhguYSiduqhzf9c/yGG
	/9vqCECSpV5j8fFUVbnO7vJ+cEkjN07nEV7eF1gMKAeLTOpAQ39gwL91l1eMy1rct87fXeDetFnLs
	LNGqzWNP0YHzkBwRMhEURUDmP7RRvqsnpdUw1bQwiUmw8v64FHkZyf9ZwZasy6TXGIH7/sRUGNfMj
	xFzS25dw0bmxIvEgBAy8VVHhh+/6ozT/9u4qPJRa4ROIk8b8cfVu7r5s4SHRO3/MHJLAw2mlDGaqy
	Z1tu8P3Msn93psMkZSFH+Zof7mReNwgYeWLepWr0re76UTHbdAGvqPaEWan2HdXh1fVK18Ys9HyLs
	FX3F8sig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhl9j-00000005FhT-0yIH;
	Fri, 01 Aug 2025 08:30:23 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhkpo-00000005DSM-01WR
	for linux-nvme@lists.infradead.org;
	Fri, 01 Aug 2025 08:09:49 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id 5DFD14EB45; Fri,  1 Aug 2025 10:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1754035703; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=ujPxKH84tIgtRW7t/x8jQW5hx8cVCi5/Gnyyp7QkViyLyiBSS+bGgjsXyjcH7A1Pp
	 WxaP1EHDqH4rw0MzDpFRneStPVvpacnB39ncT8L2Mo69cFWfHLsi2oqjAItLMQUoWi
	 Ey/EyWjeNmzVCu/pe6pIHSRUpTgR2aGBNxkhQMPFVWTNuSjImpFXD4Hes0WQW079f/
	 sjoonicXLvEj+61w6hr5+KBEIMEXHwuFR4boJFShSgg7XsHV89uj/3Fh+BEoyGpAPj
	 doKTO5tDL0FFUS6Gw5msUEjYy+dlC44SX7ubDekpWwaB/lhNgeBOdiKoizT0keIck7
	 rAhULIVlO8muA==
Received: by mail.fintara.pl for <linux-nvme@lists.infradead.org>; Fri,  1 Aug 2025 08:06:06 GMT
Message-ID: <20250801084500-0.1.b1.31fro.0.37aszzh78y@fintara.pl>
Date: Fri,  1 Aug 2025 08:06:06 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250801_010948_313603_7B58BFE8 
X-CRM114-Status: UNSURE (   1.89  )
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

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam
Dominik Lotka

