Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F67BC54ED1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=oxmDnEoOh6Jn92tTDkhFBLYt/v
	2f2/MbvrCVL/PG+R2RC2mnEM7ODRGAiiej3+XGUfUlymxNaUF9dduoIRtVC7LJa5xiCcRtXG1tTbH
	eYp/h1LZHltGYjwE7ofLxXpj7B+kySW9ebggL3sOIoetHzM4G5mmhQn/VSYHexWJRJQppbMCtYJyi
	g3iIeMuMgssnwyu8ihVqc/ZmY8VTdumFYQTCRlD12O7b0kJupSZx33nUc1yKtOhzFM7CAIcr9Y7s4
	ORxT6kWfXeRtAF7AhDns2KN2UNgls8a0/2SBnPKVPh+67LqTq9+E1OqEZT7gYAmEPXtj+ACeSYGr1
	gPu8chZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJpBS-0000000ACQp-0BzG;
	Tue, 27 May 2025 07:57:14 +0000
Received: from mail.novaplan.pl ([51.195.118.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJpBK-0000000ACQP-1trA
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 07:57:08 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
	id 25BCEA4ACE; Tue, 27 May 2025 09:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
	t=1748332593; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=MKCWGKrfQVDmshyOAaOHDCyPnCWWg4+F70L48HahiIQLIq4izMchbJSx8M9kq/+t8
	 9DUEmOjdcSmoBH+JvsNJ8DSV1IaIvOWyj2rG6zIXocOH8JdL/66+Az7e+NnKN9Jcy3
	 WC7HtNC04wdfNWOXrs+12/jQv6iqZ6T+9n2cC5R4fzpitgkBHCRKQ/CF+J299FOU52
	 UrJBlPUeGfybrIYRlRhFdzEqbutDhpIg75c/itxav9RrygUuXyqJp9QKgNslNFmjVz
	 W1Dkrkcdms8ChfcANOAWR7tp5PJPEnezx6llM4wtaGtUWzSp1y9Nm8HV3zXMFnpucV
	 T+4ex5d4Ybb7A==
Received: by mail.novaplan.pl for <linux-nvme@lists.infradead.org>; Tue, 27 May 2025 07:55:50 GMT
Message-ID: <20250527084500-0.1.ls.20y9x.0.13p0zg55c5@novaplan.pl>
Date: Tue, 27 May 2025 07:55:50 GMT
From: "Adrian Liszka" <adrian.liszka@novaplan.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_005707_183505_4A2DD851 
X-CRM114-Status: UNSURE (   1.05  )
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


Z pozdrowieniami
Adrian Liszka

