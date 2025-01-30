Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77A6C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 08:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vUvp0ttX3lOxjdOrvZsKvJKNpHHNusfF6naBdS8j1E8=; b=jbOvEXhJIDr8OiZqAQBBCl/vMa
	WVWPR5u7NIcdIuljWTkdtJesRujYJCfmX081Z/snY9GV8us8jfCX7YU4fSuSQc6sJefi8IPKv1F8u
	pjkJu9n5Ir/RRclOdXBmg92oLAe2oeFDRsR3Yc2Pbqxr9wHH7aDvuQbi+/LSeV9hHoR14Vt15T7z1
	yN+f+jQmv4NsNUlIAFlvZVymhY/f/FY8WcCubLMUUoyofLSYrTn6Rwe38gk2gtN95BxRXZxBS8rQx
	YrC3axWp/7D4U6q2hINYVrogYFBJuzKs093Qjs3xLU/j23z/aPFCJqhHVgSgrg3WYGmo2fKU4WMbx
	eQsIjEOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQAd-00000008RM0-1uX3;
	Thu, 30 Jan 2025 08:45:07 +0000
Received: from mail.cybercitadel.pl ([57.128.173.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdQAa-00000008RLE-1UuQ
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 08:45:06 +0000
Received: by mail.CyberCitadel.pl (Postfix, from userid 1002)
	id CD6F34F605; Thu, 30 Jan 2025 09:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=CyberCitadel.pl;
	s=mail; t=1738226462;
	bh=vUvp0ttX3lOxjdOrvZsKvJKNpHHNusfF6naBdS8j1E8=;
	h=Date:From:To:Subject:From;
	b=uvHxxDqD210E6laOwcDRVIrsalaVs6uSG/aHu/MImmUCsSNbpXO+p+0fbFLCSrkRM
	 GBrFxl2jPO6zAnSY3J4GgmjfU+QxB1wn3St4hbHt3sTpEkulJAN58Z9tWZZLB9sDfJ
	 PfOPS13jE+JOxyiDlJY8QL+7c4Ueq1AcOXUHMH+lYSFw3DJWXAQhRe138WpDwgln9G
	 WZzp3u2f8wZOmfsOj/w9KBbe9XlSndTLSdpGFemcQ1Gk3OTRazEoCbbsG7J+uzeUpd
	 8G4+cudQ6wIRK7E5k0xDrEA53nU7cu2GMedzZtctWU7AQEQUPHPMyRgnLHuTIHuZ+c
	 JY5LoN+KP7WvA==
Received: by mail.CyberCitadel.pl for <linux-nvme@lists.infradead.org>; Thu, 30 Jan 2025 08:40:22 GMT
Message-ID: <20250130084500-0.1.d8.2dabd.0.59p46bqi6q@CyberCitadel.pl>
Date: Thu, 30 Jan 2025 08:40:22 GMT
From: "Marek Kucharski" <marek.kucharski@cybercitadel.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.CyberCitadel.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_004505_077056_EACF9D09 
X-CRM114-Status: UNSURE (   2.31  )
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
Marek Kucharski

