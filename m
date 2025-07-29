Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20419C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nKFyL6kHGsUkO+q8agC+zR0Go57BP4LT86ehYkplXn0=; b=zeAwwz16Mo4Nz7c2D0xFHN1w8C
	UmtULiC5U0ZOW6Zhh5dVzN+X9n7sb22zh3hxi9n9FPAydcN5HAuqNkrhUPKqDLvxkfOSk6JQ4QQFS
	2/1ZXUJB4xgvZmoJ7FZ4WDBF8o/QDOj23K9VLdePSAaV/1OErB37fAQHFeZSi6b/xTqrBF0hRThMC
	OFbE23Ptpvz6EWowwomeEF+z5ZeyhM4Onb0gdgauHnSnxP3dLhBxD2j7cQyqr5OCHr6dxitewnK5k
	vE0ZsXxgaeA8Co6SsU+OydOTJ5szCR6fnoQ5FsGyTtmuRKbXDE58bkDXFMDDiZFSsnt++hzSbpALj
	kM9o5bdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugewz-0000000G92X-0Bpu;
	Tue, 29 Jul 2025 07:40:41 +0000
Received: from mail.quantro.pl ([51.195.47.38])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugetv-0000000G8hb-2iVU
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:37:33 +0000
Received: by mail.quantro.pl (Postfix, from userid 1002)
	id 815EF24C9B; Tue, 29 Jul 2025 09:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=quantro.pl; s=mail;
	t=1753774647; bh=nKFyL6kHGsUkO+q8agC+zR0Go57BP4LT86ehYkplXn0=;
	h=Date:From:To:Subject:From;
	b=MY3Ffz7hx0Q/e2MFt88acAuANh82L2AWhfko0CJEnTTYnPN17NWod2FGvHDV/W5f/
	 40UEAQDiow287JbVqa7+rMvdxO6jSFDRbgVPzAFKydAg7JXIvBPPICp6xDx+hLNyLt
	 OY2jD7x7uUxWPtsXQjSZAMsBPvB7egBxmBAM3/1WUeIkaowVmBCol4FHbYkOUcJlPW
	 FkWQhGB32AbGWrcFEW7p/X0xAQU1s6NmtzzulCXc3CIVmjaqu81+rqPieFhnPA8VcK
	 018s35jJTFgA9omkcP9SuAJX9aVeE7VJWZ1VuxxcWAk7EgCa26zq+4SRNinHXHDqAt
	 M7XlE7UUhKH4A==
Received: by mail.quantro.pl for <linux-nvme@lists.infradead.org>; Tue, 29 Jul 2025 07:35:35 GMT
Message-ID: <20250729084501-0.1.j1.5zmr3.0.gyom0q34d0@quantro.pl>
Date: Tue, 29 Jul 2025 07:35:35 GMT
From: "Ewelina Koprowska" <ewelina.koprowska@quantro.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Karta lunchowa
X-Mailer: mail.quantro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_003731_993637_C1EB5A1C 
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

Szanowni Pa=C5=84stwo,

czy zastanawiali si=C4=99 Pa=C5=84stwo, jak zwi=C4=99kszy=C4=87 zadowolen=
ie pracownik=C3=B3w i jednocze=C5=9Bnie zaoszcz=C4=99dzi=C4=87 na kosztac=
h zatrudnienia?=20

Obecnie jest mo=C5=BCliwo=C5=9B=C4=87 zwolnienia z op=C5=82at ZUS a=C5=BC=
 do 450 z=C5=82 miesi=C4=99cznie na ka=C5=BCdego pracownika poprzez dofin=
ansowanie posi=C5=82k=C3=B3w.=20

Za pomoc=C4=85 karty lunch pracownicy mog=C4=85 p=C5=82aci=C4=87 w restau=
racjach, zamawia=C4=87 jedzenie online, korzysta=C4=87 z cateringu czy ro=
bi=C4=87 zakupy spo=C5=BCywcze. To doskona=C5=82e narz=C4=99dzie motywacy=
jne, kt=C3=B3re tak=C5=BCe wyr=C3=B3=C5=BCnia firm=C4=99 na rynku pracy.

Ch=C4=99tnie opowiem wi=C4=99cej na ten temat, czy mogliby=C5=9Bmy porozm=
awia=C4=87 w najbli=C5=BCszym czasie?


Pozdrawiam
Ewelina Koprowska
Senior HR Manager

