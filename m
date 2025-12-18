Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DE4D68BF4
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g+bJVIpt0gfvrKpvvpbdhzaZrLDQ51BQvCd8rNT5zDA=; b=m4B9PSuJPgzxQLG2t868jnu+fu
	y+BKHYMGml+LKLDTIZbcu3XsqIPiwhmie8jYRTY6pPg3qjvpicEypFQ6YdQZia/KKl5Hxfy7U++Qb
	6XVgD7obrtG4A6K5Xj9n/SRCrKN0GLOKdZFW7UrI1LEfEzh50egEiktMIZP/y/8O/eEtHh95BppjU
	N/hHXfi54JHgvI4cRfORXYXjwnGC4LsMqcoHTpOlPjlBAlyBF2tHHhSUMTyMGqEaniwnDzoyKheWq
	PWan5UotzGdIANixOfEUxRRFNPM4xbMizcz8MvIG8PSQCJjciBbuRouMLHaRQ6YqvpIWnElCOzUsF
	EzUzxL3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9eZ-000000085OH-08LE;
	Thu, 18 Dec 2025 08:46:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9eS-000000085MQ-3RtQ
	for linux-nvme@bombadil.infradead.org;
	Thu, 18 Dec 2025 08:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=g+bJVIpt0gfvrKpvvpbdhzaZrLDQ51BQvCd8rNT5zDA=; b=JJZXYddQE95NiaJvrKU4NSHnVq
	9S6vThKP0h1oRfrj5SPn/9O/gUH30xCpYGgi7W7DnqnJyEl6GTEMfTh3GXeSO2Pl0iUZTJuaS2559
	IgCofLF3LlnTTjYIiL16xO03llQaJe5JirKIp4+RlpK60jbfmdrUOYHAaHykiMQ3FicmFsNpwRdnY
	n9tsxTg8UYteO5DMYsZJwErhbmtXU3JMlBJiOPs6WmBRlqSLOEhrIaC8nNSlMT68BtsV5dAUmuz/W
	1/2hsmkQFQJvVKqcb97lAiBoXlqI6Fk1g79Qz5Bizgny3yTbdbFv4jlmwFucl5W7YT5aI2SsH6V33
	AbuztqoA==;
Received: from mail.torqly.pl ([51.38.112.117])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8mv-00000008NyE-2WI7
	for linux-nvme@lists.infradead.org;
	Thu, 18 Dec 2025 07:51:07 +0000
Received: by mail.torqly.pl (Postfix, from userid 1002)
	id 2617DAABC7; Thu, 18 Dec 2025 09:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=torqly.pl; s=mail;
	t=1766047574; bh=g+bJVIpt0gfvrKpvvpbdhzaZrLDQ51BQvCd8rNT5zDA=;
	h=Date:From:To:Subject:From;
	b=hKHwyT8Q3QKTWAKNQJSuFJWCs9/KLojM30Dw2ysMhq3rlg3pa3MHcq04qCrO8ngEk
	 jshqlGf7i7YZowNAuHmYfnecGBO7cUhoaeLeEKx2Q1agEnHtPpHKcrXXchadF+gVEn
	 qEcIgSqehZfmnd9pXdwwMVG4ZYLH/0Y75zlLy95YcE/pbYty5Lol2jfwfwXhWnG3yb
	 oVsYsLrNYWyoQB4p23pzqmqAU+Fpd/+2phxeosDrulrWlDqxggDetJKqJBazINKR6s
	 MEZrNgIE1U6pzzMobSs42cKwPnaefqW9m8wPxh2VTdfJZwTfzWriaovbnjugWWMY2D
	 avMCwBr5CiRWw==
Received: by mail.torqly.pl for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 08:46:01 GMT
Message-ID: <20251218084500-0.1.tu.d9itb.0.wl9o79ts9r@torqly.pl>
Date: Thu, 18 Dec 2025 08:46:01 GMT
From: "Tomasz Jaworski" <tomasz.jaworski@torqly.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Ulga_na_sk=C5=82adki_ZUS?=
X-Mailer: mail.torqly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_075106_402821_5BE3EE43 
X-CRM114-Status: UNSURE (   1.80  )
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

Dzie=C5=84 dobry,=20

chcia=C5=82bym wskaza=C4=87 Pa=C5=84stwu mo=C5=BCliwo=C5=9B=C4=87 zarz=C4=
=85dzania benefitami w =C5=82atwy spos=C3=B3b, poprzez nasze intuicyjne n=
arz=C4=99dzie, jakim jest karta lunchowa.=20

Nasze karty oferuj=C4=85 wygod=C4=99, oszcz=C4=99dno=C5=9Bci i zdrowe wyb=
ory =C5=BCywieniowe. Dofinansowanie posi=C5=82k=C3=B3w jest korzystne dla=
 obu stron. Karty lunch to dla pracodawcy realne oszcz=C4=99dno=C5=9Bci w=
 postaci zwolnienia z ZUS do 450 z=C5=82 miesi=C4=99cznie na pracownika.=20

Kart=C4=99 mo=C5=BCna do=C5=82adowa=C4=87 dowoln=C4=85 kwot=C4=85, a niew=
ykorzystane =C5=9Brodki nie przepadaj=C4=85, lecz przechodz=C4=85 na kole=
jny miesi=C4=85c.=20

Mog=C4=99 przedstawi=C4=87 ofert=C4=99, kt=C3=B3ra pozwoli zoptymalizowa=C4=
=87 koszty i zapewni=C4=87 pracownikom po=C5=BC=C4=85dany benefit?


Pozdrawiam
Tomasz Jaworski

