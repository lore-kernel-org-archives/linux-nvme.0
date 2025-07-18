Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1543C83F17
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UbKn3eq96haC/y6nyG5aIGnYr/CHw5y2gV8o2pDmMkU=; b=sy1AnS/OlTdsnNA2KmCs77v0Wv
	Ulyg8rOvE9T3Rzg3NIYp+TuPWSKmVhiXqDHR46LPlZj3FboqP42Y4IfGtFczdZtwZJkejQiCS+wFP
	3TDc2t55CHic4chv/T8k/2tk7R4iGsC+GtmLnO3xclmhlnUOmhXhnM6jrLRM07lwYbi0n/MGP10U7
	DkLDFICWyGkfqyaz4GsXOZyq1XQxTPByAHNigtWOVC7/uHBIGqGIUtTv10+m9OTnpaR4nFJ4HLqrC
	CznXjhvof0Apu2H8b0NtpAG6Skx5fYcHN4hsSel+sUHqSh1jL3UBoFV2AGtwbNikRe5fgDz6jPJ7H
	QneaP8Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uck6Q-0000000CZK2-39XO;
	Fri, 18 Jul 2025 12:22:14 +0000
Received: from mail.profitkey.pl ([141.95.53.180])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucjL8-0000000CTgL-49pF
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 11:33:25 +0000
Received: by mail.profitkey.pl (Postfix, from userid 1002)
	id C8F3A6118E; Fri, 18 Jul 2025 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=profitkey.pl; s=mail;
	t=1752826223; bh=UbKn3eq96haC/y6nyG5aIGnYr/CHw5y2gV8o2pDmMkU=;
	h=Date:From:To:Subject:From;
	b=JHrBIdtR0nOvHh3bRiWlJx9VfsdFKPdpyk6qKOq9aq2QTmgzUZ95TabL5mJnBKq7s
	 akTDW3ai0ilFRSpvXYk8N+W1LDS9vRzzNUX8yQtLeCeJyZ9+Pny6BcmIziATBQqBDv
	 WBMsuAetSUgxnEqaNYX8wk/5Bw9UG7OYty4WlC5jBN6OPQfaidfqmAV1Tk0Z5wGSLS
	 3oKuZM4H7lD/yB7DyAL8i/OgmDPv6WEFy9qEU4EGtxwKKZJ3FY1N/WyFdXC8gPQv3O
	 +3dkzvCPRwgqFLlzZcs47Cph3hZpqfw1q96BAJuxyxBu46MAs36HKz1SfMZgdIdro7
	 4aAFpWfNy6EwA==
Received: by mail.profitkey.pl for <linux-nvme@lists.infradead.org>; Fri, 18 Jul 2025 07:56:19 GMT
Message-ID: <20250718064500-0.1.3i.186yp.0.mal18ctk6d@profitkey.pl>
Date: Fri, 18 Jul 2025 07:56:19 GMT
From: "Agata Lorenc" <agata.lorenc@profitkey.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Karta lunchowa
X-Mailer: mail.profitkey.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250718_043323_726366_E24AB6AD 
X-CRM114-Status: UNSURE (   1.67  )
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
Agata Lorenc
Senior HR Manager




