Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0136C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 08:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=TQ+kUwwd4x7vkgjEsVUHAtR+Qf
	bi2PG9kcNql56Qf55qoOdq3cx0yZ9yFvq+ty8u2XfFyuhJgI1tXunhqNB9BgMiiXoqzqgcd/GIA9u
	sey8GSKPcdQaCkSMoJKnxmh7Ir7O6X3Nl6ezTV0BXNQ1/k7dj9DYXrCHi+gcPH60VfbSbT5kHfiGp
	s9reqE4wSTRpDl+JpEoIyX1tgjBRn5davfkQQjH2ePPw1b45M8UfvU9pGNu0GNpRPJ3fdWH40sbPG
	edOJh5Gf3NDBuVDa9IL8t/Mkav4y+XLzo2bBtn+iLMKX3HuaKubUBi2oQvhgG0hgsZmdobTShleTv
	LQSK033Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7s5M-0000000DLqQ-09rN;
	Thu, 24 Apr 2025 08:37:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7r3f-0000000DBzU-48qo
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 07:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=lvKn+txwn9/gbfk2GieQ4e+Cro
	c7Xy5T6F6BzTaEI92TWR2Q2IAQdyTwWz1lAVTvuSJJ3PQFVP/7xqABXCnLVlg9x0oHBCNFaBNgn3K
	PM2rFszCX4+TRebcgbnZvPeW0ocy9VDdUd5sfFkXg0Xo0TvWyy4QYpRFgZjCBA38OslTb9uHNYagg
	ZfsNmFGF19PH3OP1pVV90L1YlH3FA3HSc1OduPNqNB6f6XKxJe8rSu3FypFamrVtroOWpniV0JoiF
	9tJOAasNACTmCkPj7fbBigb6/a6MTBmIQ7Is96r/8KNEUFag0xfFIsObFIvqpaIcLK5pG6FuYrR5K
	jCNaM1bg==;
Received: from mail.novaplan.pl ([51.195.118.1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7r3b-0000000BYan-27R0
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 07:31:42 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
	id DBB8AA3A98; Thu, 24 Apr 2025 09:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
	t=1745479894; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
	h=Date:From:To:Subject:From;
	b=oJ1ZrC/UbU1f0oMrvx2fFxcZXsluNhYEk294maSl5v9rdEwdc7gqUHqxld9Ga7tBr
	 xEvr2a0N8qID5fccv2eyd3enMLWvCNVKDgb+ODi/fTR0Gt0h6wHiihs3rVCVRyhv8P
	 n7ph8GBsWWl+rT89ajnSloMWoA091J/ypjR0oMfkOoduxSiD+gY4sehVsL8S8QZrSN
	 /i139uFFgx8TH8l8ei7DDmlglKbUnaVcby3du86YyrqoQQVlx6a+JHdwp2E0Oujs9Z
	 n2fMs4GVMSZUZsPk+lQiKmncouwt/jofB72QlRFJ6JYcvDK8n0IPBykpPvk+l14nhx
	 6dmsYblAHtgLg==
Received: by mail.novaplan.pl for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 07:31:09 GMT
Message-ID: <20250424084500-0.1.l7.1rj29.0.hx9guz9dt1@novaplan.pl>
Date: Thu, 24 Apr 2025 07:31:09 GMT
From: "Adrian Liszka" <adrian.liszka@novaplan.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_083140_802926_44298A8A 
X-CRM114-Status: UNSURE (   0.51  )
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

