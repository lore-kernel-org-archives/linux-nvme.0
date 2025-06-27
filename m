Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09B7C7EE31
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 08:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=; b=CrhzrunEy64m7UhcQzYgK/9yHx
	2nTW09hY5HIbNovivly29tTryMNdBUbA9S1pMVJ+vykBuYTJGA1bNKpIFo6hnIybKDj2OFCPzO9eV
	vWpoDD5AtmkR3d6iDlPgQEOgI3O/QJg7Vuu0lDSWg+Ic7cK7h4/nOs+BxDhOoJ8RlNFl6IT7JBXcE
	HEiSG+2WtAvkpuWQYw3aPBSABRnSYs+tUREEn0bey2H6VddYuTC7ItJJwYZHQb61eAIZU0tvbK5ON
	ITwqGTiu5I2sv1jieXecyy9RjwbAZhL6kcu7MUpXMs90++FuwKZC/FBl0bHoo4N5kBxm6GlN20DkS
	/uIrgnKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4Bt-0000000DvPw-0bAM;
	Fri, 27 Jun 2025 08:12:09 +0000
Received: from mail.fintara.pl ([51.68.214.200])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV4Bq-0000000DvPQ-06kA
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 08:12:07 +0000
Received: by mail.fintara.pl (Postfix, from userid 1002)
	id E89F64C71A; Fri, 27 Jun 2025 10:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fintara.pl; s=mail;
	t=1751011920; bh=0Yjr6NsrKkaYb/LNYm1mPKHuxqkR0iWhkNkzH9QSzrg=;
	h=Date:From:To:Subject:From;
	b=ySL9tBpZftkC7a9ZX30NXz/zunP7jcj6PL10ZmMnkXG+brtEYapSF2u1N1yfF42wI
	 vEjmj3ydo3g8GiooPUQUWO+aTUAwyhaMC6dvH5dkDFPyuPv5nSKxs0Afa3SKvJXBTT
	 ct696Ebpx10gOQs/aSYT3uzE+IeCGS+vepXvTatRrhEWNGAxrACr6skoPo/Ko3IFvI
	 NqaBJ+N+6CPyuapXtI9DJrbaWaVVXdS+3VI3AvGm9DCIgWy3P87PTEtkgz8q1iOzTe
	 LgYDbz1c3XIEgG5XhHz68x3nKD8HwBh+YOmMU3blKfczBKePsKTB7qbaIAG1yiLv7l
	 oy+d8YTGZi1UQ==
Received: by mail.fintara.pl for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:11:04 GMT
Message-ID: <20250627084500-0.1.ac.2ohq7.0.hhg4i8i9ht@fintara.pl>
Date: Fri, 27 Jun 2025 08:11:04 GMT
From: "Dominik Lotka" <dominik.lotka@fintara.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.fintara.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_011206_744337_6CD090CE 
X-CRM114-Status: UNSURE (   1.08  )
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

