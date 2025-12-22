Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5956D711D5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rBf3jQVFnGCeJlMPbA0E+WWQIPnf9AfAJW4UEB5U3Ig=; b=aSkAox0rp5+l9+kxEf7lQMOjKN
	WEvqdXpei1qfnAUuNOZghQvpX6F8e9/eE3AVxUwDpseMaOPXjXtFCS6YyLhWj2V0XxvUVACBBStRC
	L7CJ/y5Hc1bLoovOuRhZ1xxpaJSTCjoKYZaU1SR1st7jnIjBFoBV39ScZ4tn0HTv+hx1lWMGyc3WG
	RGQAIbV6EsQ3qK2lUZH4vzOE3VwCKpfzJkOJXQ3o90VrAeFxsVncJjNfw8kRkyQ5TzZnxIo8mxrXQ
	aMa1x1MAyX5IRg3kFKNvyKGcFfAInKpCx+oeQoBkDHVVM2EaRwUE0Lvmtgd5el1ugTgAT+4oaqoFB
	XfcXCAUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXboe-0000000DUoW-1c7v;
	Mon, 22 Dec 2025 09:02:56 +0000
Received: from mail.vexro.pl ([141.94.250.70])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXbob-0000000DUoB-1rld
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 09:02:54 +0000
Received: by mail.vexro.pl (Postfix, from userid 1002)
	id C40F5A5501; Mon, 22 Dec 2025 10:01:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexro.pl; s=mail;
	t=1766394072; bh=rBf3jQVFnGCeJlMPbA0E+WWQIPnf9AfAJW4UEB5U3Ig=;
	h=Date:From:To:Subject:From;
	b=oMaMnwdlq2WkvBlqGq0pLYeXmB/SN6PDB1qmK6Ujy36uCDpEDofukGeiRUKJuvGcF
	 d5lk0WNwiGymA9m5KjE2zFIPKZz0/2Ol9gTWCuLjQF55NCAE4/0+8KFnCrC0NdhMNt
	 njs8SB/CDR4N8nDBi5sbXYfPbn0eZ49Yw5JAOyQGBHH74rDNMhjqiv4OOTKAYsAro9
	 ZdbhmEmW0sHXmBiLgwvOpNyQyp+X5PwLEYvk/zC08XkevmeAkTbxVAm+RCZrNoRIO9
	 cG1kc5vMvkNVzsf6aE0zouhoEBP6PfYkigWRZa55Mx/gV5JnaFikXWZ2rWh5blywTs
	 UpzSSpK2eKiSA==
Received: by mail.vexro.pl for <linux-nvme@lists.infradead.org>; Mon, 22 Dec 2025 09:00:58 GMT
Message-ID: <20251222084500-0.1.pc.4sj0y.0.4hrote2bnk@vexro.pl>
Date: Mon, 22 Dec 2025 09:00:58 GMT
From: "Adam Drzewiecki" <adam.drzewiecki@vexro.pl>
To: <linux-nvme@lists.infradead.org>
Subject: W sprawie samochodu 
X-Mailer: mail.vexro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_010253_621749_36F70EBC 
X-CRM114-Status: UNSURE (   2.64  )
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

czy istnieje mo=C5=BCliwo=C5=9B=C4=87 porozmawiania z Pa=C5=84stwem o wsp=
=C3=B3=C5=82pracy?

Dostarczamy i wdra=C5=BCamy system, kt=C3=B3rego efektem jest obni=C5=BCe=
nie koszt=C3=B3w za paliwo, szybsze pokonywanie tras, skr=C3=B3cenie czas=
u dostaw oraz wi=C4=99ksze bezpiecze=C5=84stwo kierowc=C3=B3w na drodze.

Prosz=C4=99 o kontakt, je=C5=9Bli interesuje Pa=C5=84stwa poznanie mo=C5=BC=
liwo=C5=9Bci lub bezp=C5=82atny test tego typu narz=C4=99dzia.


Pozdrawiam
Adam Drzewiecki

