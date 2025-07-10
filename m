Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65439C83F1F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jul 2025 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HDVkD9F9d0LNuXby99FgApyHr5MULFRdKL2PW8Qg/Vo=; b=ma95nv2gBGhBQX1a9SWzfsGMK5
	cel3RRWkuVAoBp8Bu0CwuHU27eFBu/6N18Twc4EjOIYM/g6oNDr+n/lsMK+RVyw8Gfb7dWuKH+SBr
	3Z4RCCJyMHNDsv7bVjcro5d7ZJm2iKAqHjBkCKDzHi/XXAFA3egnlhKtqZtka/SNCd03s2y+D05eP
	R6dzw4XSrMu/6dmJjmqfXOUeQbTeMZhkj6sgcrIJbpRQcBI/2Tn86myJmaZ5yxvI5LKHqx5OwJCyf
	/FdCA4lTqZMeMaLIX8y9TICfhhmFwdUFCHwEQuiYJvxZ/9faZKahHacWFH94HY2rMgukP7tVMoT8B
	l5XZbx9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZnCy-0000000BHQa-2i5y;
	Thu, 10 Jul 2025 09:04:48 +0000
Received: from mail.capitalcraft.pl ([57.129.67.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlur-0000000B31E-1noZ
	for linux-nvme@lists.infradead.org;
	Thu, 10 Jul 2025 07:42:02 +0000
Received: by mail.capitalcraft.pl (Postfix, from userid 1002)
	id E04BC23A0E; Thu, 10 Jul 2025 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=capitalcraft.pl;
	s=mail; t=1752133319;
	bh=HDVkD9F9d0LNuXby99FgApyHr5MULFRdKL2PW8Qg/Vo=;
	h=Date:From:To:Subject:From;
	b=OZtmIqVzlBEtMEhgvC2FSpzpmWmjqw8+iziNZ5L+9pcouV1n/lLDcvUIYy0luZ+8b
	 zLTr/M0k9FveuKj8sUZI71PON9dGRm9QnAY78Jf1H4ixy+Mv7QcDOTKvvUs/4Mj2AO
	 74F28sklmqZkRr4qcTCqONAJzh+tPsOlVkT4r9B+gKehzr7Vh2pwoATKQiAlFO8QBL
	 ngnV72mRm/DSrO6avIcJGalfcICe0KIjwm973uuAYwHqsRi60yS48FosI/lMr65S0J
	 VRfe1jshtMGKKxkmU3YnfJ7LC/zxnSSu5gTca3VL4pdho83E/Yb2S9Q4IuKdMpjbdE
	 spyryLW3PAkJw==
Received: by mail.capitalcraft.pl for <linux-nvme@lists.infradead.org>; Thu, 10 Jul 2025 07:40:33 GMT
Message-ID: <20250710064500-0.1.3c.g4a2.0.0d7pellf95@capitalcraft.pl>
Date: Thu, 10 Jul 2025 07:40:33 GMT
From: "Karolina Dylkiewicz" <karolina.dylkiewicz@capitalcraft.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Ochrona pracodawcy - prawo pracy
X-Mailer: mail.capitalcraft.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_004201_612594_6B632BE8 
X-CRM114-Status: UNSURE (   2.19  )
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

Drodzy Przedsi=C4=99biorcy,

w praktyce prawa pracy granica mi=C4=99dzy formalno=C5=9Bciami a ryzykiem=
 potrafi by=C4=87 cienka =E2=80=93 a jeden nieprzemy=C5=9Blany zapis mo=C5=
=BCe mie=C4=87 kosztowne konsekwencje.

=C5=9Awiadcz=C4=99 sta=C5=82=C4=85 obs=C5=82ug=C4=99 prawn=C4=85 w zakres=
ie prawa pracy =E2=80=93 tak, by=C5=9B mia=C5=82 pewno=C5=9B=C4=87, =C5=BC=
e Twoje dzia=C5=82ania jako pracodawcy s=C4=85 bezpieczne i dobrze udokum=
entowane.=20

Dzia=C5=82am sprawnie, rzeczowo i bez nadmiaru formalno=C5=9Bci =E2=80=93=
 wi=C4=99kszo=C5=9B=C4=87 spraw rozwi=C4=85zujemy zanim urosn=C4=85 do ra=
ngi problemu.

Czy mog=C4=99 przedstawi=C4=87 pe=C5=82en zakres naszego wsparcia?


Pozdrawiam
Karolina Dylkiewicz

