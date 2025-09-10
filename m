Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E411CA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7Cq0DHB5k0l5CQs6BVZUFt4lPJTtmejSvjf3feeP/U8=; b=JDes9OTbXeBBcBamzDNm2eFqkj
	9jKnqV+vYFmTK7/D4lxN071LkPoM6hmWRIb9Pg00a41V4UsiL5fFOj+AkStty/nqy05AWteVOMnlo
	KVMea/I2K5gdcHaoyYYNqFKAvZ3K5Urfsf+YgJhoe51XITW1WDb6KWsmU7q11+zkkgeHbvt8b7ufg
	zCy0EaHklSMo4SFNTZPjl8J+6JrlpL/M+D6hoemmpe/WV8PXxvcXh0GQuJ5R3WaEU1465In+onKRr
	4d8E4fYwbjx7tLuxpgc40z0ve1vARFEiHshNyYXyvDi3qDacglMSYJTT2k2DHSRCHduJwO3ok1LwY
	kvs1IXFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFNv-0000000CbVL-1ucQ;
	Wed, 10 Sep 2025 07:36:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFNt-0000000CbUV-2IGq
	for linux-nvme@bombadil.infradead.org;
	Wed, 10 Sep 2025 07:36:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7Cq0DHB5k0l5CQs6BVZUFt4lPJTtmejSvjf3feeP/U8=; b=QbSqDXLG3Up+oLJQVBfQQDoXO4
	CzKHV63Ff7upBFao/o6jnqev0B4X2pOhcuspYoV5eGF8vSoYevOKf9udwFp0xnx09Bv306pUaqklC
	2couZ4CxnZ+dYMBJmCCg7cjosEImjAxPrbIce4RY9v9XmBfwkqzTrIVDYD7k8qIP+WN1N7Gmw5RVW
	hmBrTHbhVRLs0XP6ebqBbmyd1vxg593POdbh9DQs6mXNaXnFaGMQDxdUajjO11Ygxt5dAF55gJUd1
	oy6pyLllfLUYtdAmiK2ryxSXUsEy7zXPWsoEoCNFkV/YhOmba9U4RYlX/mQsxRTBf1IqZMWriRe3p
	/UyhWDag==;
Received: from mail.bizosto.pl ([151.80.59.16])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFNq-00000005ll6-3pEj
	for linux-nvme@lists.infradead.org;
	Wed, 10 Sep 2025 07:36:52 +0000
Received: by mail.bizosto.pl (Postfix, from userid 1002)
	id D8AB424827; Wed, 10 Sep 2025 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizosto.pl; s=mail;
	t=1757489780; bh=7Cq0DHB5k0l5CQs6BVZUFt4lPJTtmejSvjf3feeP/U8=;
	h=Date:From:To:Subject:From;
	b=EW3meICgq5j2RFt5WDVoj0tFbAnf/168fpjcwNkP3KhKN3azTNW+GabwZgpSC6GUl
	 BUYWAF/tjL9O0fWVVnNURA6eljLZCq5Xl/2DgcntbwkKg+ZDVtUXN4W5nKO7FeLIyZ
	 jU1BxVpbUixpJDC557XLKgHwOMDZ15mAbCo6j1KICQE9UMy65oB/9ga4yeNDmf33K+
	 9eMQiG2KrCpmbQ+zOUklht4Q7BIEihUL1+KXmK7PAkjc3tx2qip4qdVIvpbk0OvI46
	 gJpCTib2gdLFCs9RmRUOhBpGsZMkJaYkSBwhQqrPoxNf14LMUryUUdsFXvsbCqBIQn
	 SRM3kkEYGixlQ==
Received: by mail.bizosto.pl for <linux-nvme@lists.infradead.org>; Wed, 10 Sep 2025 07:35:57 GMT
Message-ID: <20250910064500-0.1.3v.1ahxu.0.f5qhrlh8mg@bizosto.pl>
Date: Wed, 10 Sep 2025 07:35:57 GMT
From: "Kamil Nakielski" <kamil.nakielski@bizosto.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zatrudnienie nowej osoby
X-Mailer: mail.bizosto.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_083651_022907_91813129 
X-CRM114-Status: UNSURE (   2.61  )
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

kontaktuj=C4=99 si=C4=99 w sprawie zatrudnienia pracownik=C3=B3w z Ukrain=
y w Pa=C5=84stwa zak=C5=82adzie.

Stale obs=C5=82ugujemy firmy produkcyjne w tym temacie. Je=C5=9Bli potrze=
bujecie Pa=C5=84stwo dodatkowego personelu do pracy, prosz=C4=99 o wiadom=
o=C5=9B=C4=87.=20


Pozdrawiam
Kamil Nakielski

