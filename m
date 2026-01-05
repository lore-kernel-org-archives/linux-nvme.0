Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A69C2A079
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=; b=k9MQbT55QxAgpkChI6CEi/SdXZ
	emFRZpBjH1hmGTC0ELjqaV+bL4c6qY2SLH/BqZTmaQ6DA38b5cOEwr+klBypI7nep9Py1DP4dREk2
	g9od4kRnd8Rfrpf9ks/qYDXtJAeCpja4tRWR6JSRf95gd59FRzUIbAn/qsorXwtzrcoc/j/E/3KTw
	P0HTOiotNs4MmHfXUszbm9qoatgmN9D7UdeUm3uLgg8722YNN55pdyT4HQoZxaEZBStoBfmOwjtgE
	OCNkCf0mVPDqS8CHleS2ALLgXRFMzq/bG3HrynN6+TRiBe6z0HC4U8n99USUFelxVrY+EcDW4aHlS
	o8/JRFVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcgbH-0000000B2uR-3vLb;
	Mon, 05 Jan 2026 09:10:07 +0000
Received: from mail.growzi.pl ([51.75.73.133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcgbE-0000000B2tB-12Iy
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 09:10:06 +0000
Received: by mail.growzi.pl (Postfix, from userid 1002)
	id 54B6025B30; Mon,  5 Jan 2026 10:07:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growzi.pl; s=mail;
	t=1767604051; bh=LHmroAf0IX0JOjVUiIwqM4s8ghVxxktECxT6AQD+q2c=;
	h=Date:From:To:Subject:From;
	b=XRT47TR1gEcplmriMQh+fdo8Bvg3OcY6z3YY6fPpvhQdUYNoJY0ug9X8LSjmho8Eh
	 fnWLbgLNA3KyQBty8WevyCyaCyiMWHAnwkQw9vOg8alSjz7F0a/H/0dHu2vdK+ESD5
	 /2+pd+hF8VFGDUN74mZn3DIdB7YWHQxzAv4QX2/XsL5l4Btty50kFoEBGikcI0f/PO
	 gxm/lxeUr92Co9d2WJz235rTV0n09Fkhkj5FEeUNfIYF/MsQaxo09HCkJxp8m7IeGX
	 mweU9uvPbfQBW8ulAhasBnzhNBpUACEfIMPk5TXppkIy0KSoogBCu3xEnYqDeZDvJM
	 YBaovWBcoR+Og==
Received: by mail.growzi.pl for <linux-nvme@lists.infradead.org>; Mon,  5 Jan 2026 09:06:03 GMT
Message-ID: <20260105084500-0.1.fb.1hc4y.0.11p21q86mr@growzi.pl>
Date: Mon,  5 Jan 2026 09:06:03 GMT
From: "Eryk Wawrzyn" <eryk.wawrzyn@growzi.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zwrot
X-Mailer: mail.growzi.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_011004_759170_731EB140 
X-CRM114-Status: UNSURE (   2.68  )
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

kontaktuj=C4=99 si=C4=99 w imieniu kancelarii specjalizuj=C4=85cej si=C4=99=
 w zarz=C4=85dzaniu wierzytelno=C5=9Bciami.

Od lat wspieramy firmy w odzyskiwaniu nale=C5=BCno=C5=9Bci. Prowadzimy ko=
mpleksow=C4=85 obs=C5=82ug=C4=99 na etapach: przeds=C4=85dowym, s=C4=85do=
wym i egzekucyjnym, dostosowuj=C4=85c dzia=C5=82ania do bran=C5=BCy Klien=
ta.

Kiedy mo=C5=BCemy porozmawia=C4=87?


Pozdrawiam
Eryk Wawrzyn

