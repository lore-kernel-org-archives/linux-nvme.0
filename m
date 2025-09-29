Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B04CAC5B5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Sep 2025 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=H50qZk7EtdRngFLenpLqfActII
	jGyaGFhoj/QvLj7gBdYdwePts+CQItgw9Bmgf6sOq5KiCB7VYrzDcT/MydE1B0G9SL69Jx/na48vU
	27kbXu88P9nyEUNtk8ucYObkBiWxx42Yo++xOTjtTO97FiLfqa1uxjiFLkAwQLCG6hUYWzawfHdF0
	nBGPIFscquLuOkelR5MXkSse0FGxlfEynhufmbOhTo/US9eb2r+cF10Dn6Dz9DnUzAYK7NQvHYnFH
	wcks2zg/d43TkNikL2rF9QnKo+2qpL0gzNRi9BfYRgdo8zBoLluz8cRu8CBFff2P/6OUocypc25Kh
	xRnU5B1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v38rl-00000001iBm-3Ayk;
	Mon, 29 Sep 2025 08:04:13 +0000
Received: from mail.proventix.pl ([51.195.118.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v38qt-00000001iAD-06j4
	for linux-nvme@lists.infradead.org;
	Mon, 29 Sep 2025 08:03:20 +0000
Received: by mail.proventix.pl (Postfix, from userid 1002)
	id 93C3CA3CC9; Mon, 29 Sep 2025 10:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=proventix.pl; s=mail;
	t=1759132994; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=MD8GFeUF4rXvvQdPEAflEAwQuNwEB5rO3PxVrBrEuTPRZ2E/Dgpz4t0fYzMmDmzvW
	 oXG/ZidAjiHXEfjt0Gf1qQo2Q0LU9riu2PJjtBdZasjWNqwkBmJEB+si9RIwPazmKi
	 eEB1bkq3yhNLyD6JKwOqzb+i/fjwGqeAEs0PdL+QyIoG44SbvMsfQv4namoOmX0le6
	 sfUIYC91iak4C0h7CYeKB+xjOrfYjE48IMUCckHKNnEVFstvXa9lduaw34XoSMMbj6
	 +7z7n29oL7sWII0zOXx+DUEz5kXALMA0bLaPiHNY0e1cr14dxAwNAUy7hK3Hi2I7t3
	 H+yqbd3r3yrUw==
Received: by mail.proventix.pl for <linux-nvme@lists.infradead.org>; Mon, 29 Sep 2025 08:00:55 GMT
Message-ID: <20250929084500-0.1.o6.3aklw.0.d2zn2m1bgf@proventix.pl>
Date: Mon, 29 Sep 2025 08:00:55 GMT
From: "Adrian Liszka" <adrian.liszka@proventix.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.proventix.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_010319_345357_C123A438 
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

Dzie=C5=84 dobry,

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Z pozdrowieniami
Adrian Liszka

