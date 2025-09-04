Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D10CA1013
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Sep 2025 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YccsrTHMaKf8U2PNLRc4rk3XTmEZZeorct3+VE5wz7k=; b=P/eImOiDBOSmbest85bKjwwDbE
	BzR8YxNyQbQgMjSKLsosZlIorOko04bnxcS0T67XDvI0FddBpz+fy5cUbYY9sog1jTLWWVtf6dbAe
	eMfMKB+hhbKdKvR4YutVycCASpTS135XHkRoSqqWZH2Gf/w5EVB6Ybv5ofWF2n6t2ogq+Z4xQDCHV
	6i9Br6bkVgWrFUizrRGcDjZjGREiqNOsGxHCodD4mMkiTYG0LLTqPxrwjdF7EN90Jk+/daBJ/IA/w
	t/YFmXp/iHJNkuw5cdip6NA4VLNOs1qvhK3HpdO/yhAnrXSdPTofEI8X4VAmowkTxI1C9onvdrVNi
	qoemsFmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu5SS-0000000AH4q-3o0J;
	Thu, 04 Sep 2025 08:36:40 +0000
Received: from mail.taskario.pl ([198.244.149.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu4qn-0000000A2tW-3TkS
	for linux-nvme@lists.infradead.org;
	Thu, 04 Sep 2025 07:57:47 +0000
Received: by mail.taskario.pl (Postfix, from userid 1002)
	id 6075625F54; Thu,  4 Sep 2025 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taskario.pl; s=mail;
	t=1756972267; bh=YccsrTHMaKf8U2PNLRc4rk3XTmEZZeorct3+VE5wz7k=;
	h=Date:From:To:Subject:From;
	b=t4p7bYOj+Xhx7BM/wuaRFfa058+X6Z0xnDfX4bzrR+QYb36KnmBO8Z5J+dk4HxVCj
	 nm4X2oNCaiKc33HTcsCoItDfUbWzYeCw0cBRxj/jJMsU25B2HHPhFrHVIbjQ/VyY/H
	 IILN3PCatxSBoB5waRzXLFNXED/zWjkuvxgPjd4RYt7+WFHj6qEUeAB3tFsY2O5c5F
	 zlsz9F8+W2LJTmUDqL3EgS/aGlF+9RYoHcPDgMERRXZzlmv9e2NX/CB/mCe/p/siVE
	 jwiPpu9Nl7LBSD+Bvp8lwXYFBKKQX9//Kt/UCYkWi8zbVl8m9hi3JZsJtq/mMHhzuo
	 j7q07w5bpDZYA==
Received: by mail.taskario.pl for <linux-nvme@lists.infradead.org>; Thu,  4 Sep 2025 07:50:31 GMT
Message-ID: <20250904064500-0.1.3r.kqhi.0.632b72jfed@taskario.pl>
Date: Thu,  4 Sep 2025 07:50:31 GMT
From: "Ewelina Koprowska" <ewelina.koprowska@taskario.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Karta lunchowa
X-Mailer: mail.taskario.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_005746_144914_E7CBD87B 
X-CRM114-Status: UNSURE (   2.09  )
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

