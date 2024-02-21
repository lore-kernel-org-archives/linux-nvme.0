Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96BDC48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=; b=mdW/K7zYHYkWRGM+25ZgJt3ZQC
	m+0aS0xQx52rAY0MOSWj9fpfXffYGjEqCflXJLaou1bZ+ME2fakbGaYRy87r2hSvxqq/EnS9mqqc1
	iaxPVjC5M0LCSe8q2F0Xrh5lN1ZhVD3cAvUgnUn9kWy7EmDjZGxmnOSw1qZ8Zi3QeoPO0FOiZJ4RP
	wReszcXHgAXPqar2n/Y8BdDdWnfG/wK6fTTLb/9jnuGrLccrHsjgYUm1MT6LM6rmdHeGpes3QR5qN
	xGOypYmHwL2hoY+KXp5mOIHVN3c+2WBN+s6tDkdE0ISWKANa8AbVXUiqaZuQKeyxoT3AMxTFACk6f
	Dyq9uohQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5tB-00000004Onh-2Xvs;
	Thu, 22 Feb 2024 10:01:13 +0000
Received: from mail.thrivehub.pl ([164.132.48.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5t6-00000004Olq-1X4W
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 10:01:09 +0000
Received: by mail.thrivehub.pl (Postfix, from userid 1002)
	id 62B90256BD; Wed, 21 Feb 2024 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thrivehub.pl; s=mail;
	t=1708505158; bh=m3ZUCTPRVLoDFM+cXi7VhHW+xNF3eUdGHrj1eDbLwQI=;
	h=Date:From:To:Subject:From;
	b=YPXiSZR7nhEsaG5RiaPv/kEazylNs/7RxMgqFpdMUXtmPfzdKNhLiUC1JYCrujxNh
	 TcYHGZ3d/xjGwnJLj7cydDWeZHjdXEcrar6DkNQXX1m+WAT8YDdGkstqVnrzz7d2PS
	 ILMHSONQa/3c0kHEveYTzP4ac5xp8yGVVkfhOLhhlK48ro54o5zPub88Sy3NmWl7n1
	 y+ar6ECnl8c9ddDZe9cR3BYs++C23Jra/ApbIcL3Wmyne63+aFXO6RbLmAKCLtN22Z
	 dTaHUowdQ7KNacGlvcAK4uoL7sD6NKSW0WdgM+ktxtE9UwKgrqcRWPfehFsExTHIU3
	 rgMiw83vPXYsw==
Received: by mail.thrivehub.pl for <linux-nvme@lists.infradead.org>; Wed, 21 Feb 2024 08:45:49 GMT
Message-ID: <20240221074500-0.1.4r.233jd.0.8bbakpil9e@thrivehub.pl>
Date: Wed, 21 Feb 2024 08:45:49 GMT
From: "Szymon Jankowski" <szymon.jankowski@thrivehub.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.thrivehub.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_020108_561752_B4189111 
X-CRM114-Status: UNSURE (   2.89  )
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
Szymon Jankowski

