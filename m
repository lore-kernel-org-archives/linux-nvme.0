Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28344C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7iowqdzve/IIiUUjcEwx8j3uMrVqqiE7R9zbOCKRV9Q=; b=eNZqCecZtjC/0CebyVwyqpRUPp
	K1vWTKNlOq8YMzBqkJ4W/Nv444Xg64b1fbdQdvyX+UdX0AEoKck93PccXVQ9mvvOpuYcvBe/M9nMf
	lJNjewtVmQmmzzRt1wySxv6aYyJK3beBgfk9UydeG5JUF4U2ZlTIrXjaqxFmdFSykOKrsccy33CQX
	xDsfk1PvU/oSnDEwX/Mp0jsLVocyJ8hzi6X8BYNAoj6MLcZkv8h1wE+ygKdyfdB3boR9lAlge0ZSM
	rJWQt11sO5DNX/i9X/Jc1NzyFNiS4HBTbX7lDnulE5H8M5sZvdl2tbC7s63m9JAKGuboWoBWnep8P
	HdwjmJOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbqt-004N2y-0B;
	Mon, 11 Dec 2023 08:41:23 +0000
Received: from mail.venturelinkage.com ([80.211.143.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbqq-004N1s-26
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 08:41:21 +0000
Received: by mail.venturelinkage.com (Postfix, from userid 1002)
	id 413AA824CB; Mon, 11 Dec 2023 09:41:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturelinkage.com;
	s=mail; t=1702284079;
	bh=7iowqdzve/IIiUUjcEwx8j3uMrVqqiE7R9zbOCKRV9Q=;
	h=Date:From:To:Subject:From;
	b=NEpbdOuPjf3tjBv7E/RFc6WpNxfdUhaRUzDkU36W+ejw8iGi4/AXWNKEJ8nmtDRX9
	 8HcZRKMoAd02Nk7aWt+WM6DZ09KNiuelKLstd8N93UldleC/Dk+e7WdMbQaTv1RFvR
	 1YOgZmxitMzaaXhkSc241JWD3ozSaDTg4AakkdiiM9kMltT0xB98em5l9ax/9Enby7
	 ITdQrxqRT/Vg5hIK3RAFsKlgnVng0ajRhUFDkW0OhKnW6m+wJdSGcQoBtPEk46BZW3
	 5u6WVcWjGyTl/AlfmQvoJnpyRV2RF7JI8ouO1UlzdVzGwSEMftQyCtM393uMSqiR3W
	 KlztWBPmQ94Uw==
Received: by mail.venturelinkage.com for <linux-nvme@lists.infradead.org>; Mon, 11 Dec 2023 08:41:18 GMT
Message-ID: <20231211084500-0.1.25.5e0r.0.vel4hh5z63@venturelinkage.com>
Date: Mon, 11 Dec 2023 08:41:18 GMT
From: "Lukas Varga" <lukas.varga@venturelinkage.com>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Popt=C3=A1vka?=
X-Mailer: mail.venturelinkage.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_004120_839871_70B91BD7 
X-CRM114-Status: UNSURE (   2.23  )
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

Dobr=C3=A9 r=C3=A1no,

Dovolil jsem si V=C3=A1s kontaktovat, proto=C5=BEe m=C3=A1m z=C3=A1jem ov=
=C4=9B=C5=99it mo=C5=BEnost nav=C3=A1z=C3=A1n=C3=AD spolupr=C3=A1ce.

Podporujeme firmy p=C5=99i z=C3=ADsk=C3=A1v=C3=A1n=C3=AD nov=C3=BDch obch=
odn=C3=ADch z=C3=A1kazn=C3=ADk=C5=AF.

M=C5=AF=C5=BEeme si promluvit a poskytnout podrobnosti?

V p=C5=99=C3=ADpad=C4=9B z=C3=A1jmu V=C3=A1s bude kontaktovat n=C3=A1=C5=A1=
 anglicky mluv=C3=ADc=C3=AD z=C3=A1stupce.


Pozdravy
Lukas Varga

