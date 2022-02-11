Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3DCC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L7rZPDqncV/PGNK3vBL4eFyhOA8rMHMu3jCfxnl4mEc=; b=VjtS+c0q9zHf7yGnUoyGNlECz8
	von3BzKAs1RLClUld3tAtbJab6JURPFBZJyc1kjxK2ubZF7Ac+2qul/Z8cVKUm7z8H8vk46sWNHW9
	PlWfM9tvZfUSUiHmudHzqB3vR3XKgoVFgoLjD19Z7AiQMVve9kW7b6H40YEdlxhRPyvmWkMcnyb1t
	tVZyg7I6WE16a5R/m6iEIev6GXl5InrR6AOYvhmLXEupknTh8QnbN0a9jVeKtVMPeFKxFz6wE/J0o
	pmNx8TvwiXa/QxL92QKJDy0B4L0KoqdVj1BMAjk9fGEyzYrS9+ZGIauym/uUSLrpCsJIo19p4hFVf
	G98QdMhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIRRf-006CmQ-7R; Fri, 11 Feb 2022 08:38:23 +0000
Received: from mail.bizcall.pl ([192.71.213.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIRRa-006Clx-89
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 08:38:20 +0000
Received: by mail.bizcall.pl (Postfix, from userid 1001)
 id 98E4C40E9D; Fri, 11 Feb 2022 09:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizcall.pl; s=mail;
 t=1644568696; bh=L7rZPDqncV/PGNK3vBL4eFyhOA8rMHMu3jCfxnl4mEc=;
 h=Date:From:To:Subject:From;
 b=UHYpSW5T61LSwbQ1SHHRs9XqpIVjzFTvDqfp9c8YNxc7T9qLm+MhmJjcsHndQX8aa
 vSioqoQHoaAx+2SM7psuJeVUb9K9XNJPJ+ALeNZwMOmjh9Z+RLDlX7a4X1Zu0OnkhE
 TA4kCprFl1VmgtwDr3A8eOI+bqgAsNxpBU150R19Sak+n5Wq/lOscLH6K3hlaVx8iy
 OoAki5lO0p7Fcxse8203dtIw8msljb0Iobmjx/C5OO9hZG2/SQBsgPfoTSudY36dQ6
 ioWSkrqT6SetMZzrc9+fSLEN5aBSNzO6lJ4+31eZJgAnkK+cR2lsnT1G0Xx9wHEMoO
 3p1n8OKdX3gfA==
Received: by mail.bizcall.pl for <linux-nvme@lists.infradead.org>;
 Fri, 11 Feb 2022 08:34:29 GMT
Message-ID: <20220211084500-0.1.u.23mf.0.6mgj24dflt@bizcall.pl>
Date: Fri, 11 Feb 2022 08:34:29 GMT
From: "Marek Onufrowicz" <marek.onufrowicz@bizcall.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Prezentacja
X-Mailer: mail.bizcall.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_003818_438561_3DEB7EB1 
X-CRM114-Status: UNSURE (   2.43  )
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

Dzie=C5=84 dobry!

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re umo=C5=
=BCliwia monitoring ka=C5=BCdego auta w czasie rzeczywistym w tym jego po=
zycj=C4=99, zu=C5=BCycie paliwa i przebieg?

Dodatkowo nasze narz=C4=99dzie minimalizuje koszty utrzymania samochod=C3=
=B3w, skraca czas przejazd=C3=B3w, a tak=C5=BCe tworzenie planu tras czy =
dostaw.

Z naszej wiedzy i do=C5=9Bwiadczenia korzysta ju=C5=BC ponad 49 tys. Klie=
nt=C3=B3w. Monitorujemy 809 000 pojazd=C3=B3w na ca=C5=82ym =C5=9Bwiecie,=
 co jest nasz=C4=85 najlepsz=C4=85 wizyt=C3=B3wk=C4=85.

Bardzo prosz=C4=99 o e-maila zwrotnego, je=C5=9Bli mogliby=C5=9Bmy wsp=C3=
=B3lnie om=C3=B3wi=C4=87 potencja=C5=82 wykorzystania takiego rozwi=C4=85=
zania w Pa=C5=84stwa firmie.


Pozdrawiam,
Marek Onufrowicz

