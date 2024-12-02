Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F15D10DCF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4SsVKfavNtEL8KiAyuhM0WdCxWV7dwsn0eOpgkwr5fY=; b=mrsuldjA70nViM9UnxaYlAnPP3
	0qLUBgM3hMvbC34VWfSw1grug/oMnGytamIk8PphXvNhX6TNHA12tuO8uiNJ4CDxIWW1xVLQqXcEN
	GvwjbTdc0wKTTaREc22Eyn4jswebbt4/2zIOwC0LFC8Dwuq/KEhlPTLkFq8JEdCsuE+3rexucJNN9
	jWfz39jkhitQ9Jk/ObJidORRvyADdVbpZr9FSFN80SX4kW8fgxpukn2B1PJk+34oOCUB3NZAbmUI6
	+hlbCLv+i1MD21G9/NFJ8zyyqu6llrwVOyFHNTowd3JPljfKqQVXnpMCpschGX9g+wAYmpvGEtteJ
	ebXk9ZqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI2Fr-00000005U73-2vXI;
	Mon, 02 Dec 2024 08:58:07 +0000
Received: from mail.finteras.pl ([5.249.155.118])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI2De-00000005TlY-1Y0C
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 08:55:52 +0000
Received: by mail.finteras.pl (Postfix, from userid 1002)
	id 67C5582E58; Mon,  2 Dec 2024 09:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finteras.pl; s=mail;
	t=1733129744; bh=4SsVKfavNtEL8KiAyuhM0WdCxWV7dwsn0eOpgkwr5fY=;
	h=Date:From:To:Subject:From;
	b=RmKtYwfZwWVj3VOue+8A09xQ6UmORwh4xABeWo3jlLoymv1bMePfkdNixRCGdWrJC
	 Q37NNIqXgplwIOF73ov2WuFYXhobQjORZU6q929XLPFBWzHo+0uTG4vdfjJpYcBrm2
	 XEIUPYkaBPEtgLL7BBJY86d7UoTDYT7fpwQ5c3BQwfqUKrpyRTXJNYHIx9Q/cZwaVW
	 pWsrRPhQ6hEIcX1+CG46BcEfdkk3twdMSN0lFua6m2AToZDdQKlCZjV4SwFhfHcdMU
	 HbgCyMpEogwBXP1vKyHqpX1k6mj9IN1iVzbyyMSTnSxchZmDOY2w01Cif3+0g9oMaD
	 5kTxvppBLnuRQ==
Received: by mail.finteras.pl for <linux-nvme@lists.infradead.org>; Mon,  2 Dec 2024 08:55:23 GMT
Message-ID: <20241202084500-0.1.57.6qv5.0.0epaglclx9@finteras.pl>
Date: Mon,  2 Dec 2024 08:55:23 GMT
From: "Urszula Kurach" <urszula.kurach@finteras.pl>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Pakiety_telemedyczne_dla_pracownik=C3=B3w?=
X-Mailer: mail.finteras.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_005551_091789_65DB745F 
X-CRM114-Status: UNSURE (   2.53  )
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

chcia=C5=82abym zapyta=C4=87, czy byliby Pa=C5=84stwo zainteresowani dost=
=C4=99pem do nielimitowanej opieki telemedycznej pediatry, ortopedy, neur=
ologa oraz lekarzy wielu innych specjalizacji?

Oferujemy 3 r=C3=B3=C5=BCne pakiety, kt=C3=B3re zapewniaj=C4=85 dost=C4=99=
p do us=C5=82ug dopasowanych do potrzeb Pa=C5=84stwa firmy. Pakiet podsta=
wowy daje mo=C5=BCliwo=C5=9B=C4=87 korzystania z konsultacji internisty n=
awet w weekendy i =C5=9Bwi=C4=99ta, natomiast pakiet pe=C5=82ny obejmuje =
dost=C4=99p do lekarzy 42 specjalizacji, a tak=C5=BCe atrakcyjne rabaty n=
a badania laboratoryjne i diagnostyk=C4=99 obrazow=C4=85.

Dzi=C4=99ki takim rozwi=C4=85zaniom, Pa=C5=84stwa pracownicy zyskaj=C4=85=
 warto=C5=9Bciowy benefit pozap=C5=82acowy, a firma zyska zmotywowany zes=
p=C3=B3=C5=82, mniej absencji chorobowych i dodatkowe oszcz=C4=99dno=C5=9B=
ci.

Czy mog=C4=99 przedstawi=C4=87 wi=C4=99cej szczeg=C3=B3=C5=82=C3=B3w na t=
emat dost=C4=99pnych pakiet=C3=B3w?


Pozdrawiam
Urszula Kurach

