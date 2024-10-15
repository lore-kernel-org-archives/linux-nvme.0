Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1FFCFC273
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 08:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=; b=qpw3f0oHFQUmtzPzY+42wjau1h
	K+kxKIywocG0LNZMePQk+GrMRq00Ca1X2dyXZEBvIl+IZ4vrhVbnOGmEhTv5xDsA29JilVrLqi1Mh
	z/q0dNGyPCkYO5XQ+PtaHj+KuV5lEumrYw8fACjyi5xK9DWmQxyNIIFrrTwmJtjVZ062eaTLv4UCJ
	Nc7Fhfsngjf59wlKZSR40KRR2fVdAbToTh6E6o3dmciUz8jrNf4snfo0Hd5yP8YdQ3Tz14LV4893f
	bpN6D/lEMkeDweewDiantpJsQ2wz4+d2y+Dqqmx2ff4n4LB0pIeQZnoD7VMUYhheDMtzJHcuHp5yc
	1wlQmxXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0cdB-00000007S79-2xBb;
	Tue, 15 Oct 2024 08:10:13 +0000
Received: from mail.geniusthrive.pl ([217.61.112.199])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0cZT-00000007RDe-1dUJ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 08:06:24 +0000
Received: by mail.geniusthrive.pl (Postfix, from userid 1002)
	id 8439F84FFB; Tue, 15 Oct 2024 10:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geniusthrive.pl;
	s=mail; t=1728979296;
	bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=;
	h=Date:From:To:Subject:From;
	b=F1glZOlH+DDqdEqR6PjIoBlRyBtHhburodQ9o1qEKNR0pnHO6EX6lhIktyoGn4rOf
	 BhEC6/MeTFSb/GP2FQuVF99p179VSw9E0XmOk8njM2v1UbWYWIV0vAgMQZSEFhxH1u
	 D4AaQXJrhz84WTONC3Oxr0gCGQeLL+EpL0NdqH61TpFPwjZ6wC+kBwtOOp95eKoZr1
	 npW9ohqJ1qY9J3DAk+IsFKQzlezLPhZPGrpM19e49i5mYKLVa5tD0myNAfJn4hsyqC
	 V4V+VCokZyLYYvAGopsrOhnJ3mz6uQZHZLg/Y4Ir2jiFI4RH0XoGo1nYut3Yz6l9GG
	 8MUYxK0GFHiPA==
Received: by mail.geniusthrive.pl for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 08:00:38 GMT
Message-ID: <20241015084500-0.1.aa.1gsrc.0.mzo2amr4fo@geniusthrive.pl>
Date: Tue, 15 Oct 2024 08:00:38 GMT
From: "Patryk Wysocki" <patryk.wysocki@geniusthrive.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.geniusthrive.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_010623_574079_EF5DBE7F 
X-CRM114-Status: UNSURE (   1.48  )
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
owych informacji?


Pozdrawiam
Patryk Wysocki

