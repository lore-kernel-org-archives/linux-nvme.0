Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D2CD3B7F6
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=; b=Nt49n2s42jqYCqjSs0W9sQgANT
	J8UjFM8DUkqTCyIdJ/7SxubcQNADuydG7X5h9QbEdXExVxjNAM8Ny3Mh4PhsQgXaAR3uZb7Z9EiAx
	PQyoML4yn8yEfFLm6k9iZdEW2GcqpaTCb1LrDnh4uMUWazwZ78o4FZbJqL8bnD+He4osPNuoA5xb1
	d1mNQsE0uPesT/iZPjOcCxGLs8qnUQjKIxGOhurhtiVpfqwdMaNsPhPscVTPI/cCsMMinDISQK/ws
	SkAR2UYin3BrLFU1D3JW50XuZPZ0gODrKrf+yaCGbj4RaNUfWm8AFhGbmwQDjQ96ToEJ7eRDTDB//
	tQjIq7Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVEf-00000007XEN-0FKu;
	Mon, 25 Nov 2024 09:18:25 +0000
Received: from mail.sharpwise.pl ([5.249.155.170])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFVCe-00000007Wn9-2VOJ
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 09:16:21 +0000
Received: by mail.sharpwise.pl (Postfix, from userid 1002)
	id 1BA1282EC0; Mon, 25 Nov 2024 10:11:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sharpwise.pl; s=mail;
	t=1732525971; bh=5k7KaERzV9XtiDAeG3jYJqSXCiNxYwmW5KPssYFF/k8=;
	h=Date:From:To:Subject:From;
	b=5t0u8bpqhLen1OsWsSWshpfKUefmgzNw2bbiXno4p5DqsXJT0zLj36DjtzEP4omyB
	 5OAhvejo8HBKeBFpXfPQ1XEFTKRjZVIDHTJqyQ1KwEOg+0qKtQKygpuqIBD3qhDBqL
	 F8a31QicSRnDBJuWq+QzCjpoVhDPEIDNGX37ECh/51UCEWSyT2jtz8DjhhcVKvb7kf
	 dWGJUEpRAMijdxaTGeHdOI5obCvv4SA3rwxGzU9S5YKlyJE3Qu+9qojFHB2W3Ysr+o
	 psV3ONLRozwyEMEz1agVyjk6z/Xp28OwBGKOAtAr9gjZBl41V5uJnALmT8wMQB9pLS
	 0F5QnvtGOXCkg==
Received: by mail.sharpwise.pl for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 09:10:51 GMT
Message-ID: <20241125084501-0.1.82.1alhd.0.hgaiio41g0@sharpwise.pl>
Date: Mon, 25 Nov 2024 09:10:51 GMT
From: "Patryk Wysocki" <patryk.wysocki@sharpwise.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Zapytanie ofertowe 
X-Mailer: mail.sharpwise.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_011620_780176_C4F6AA61 
X-CRM114-Status: UNSURE (   2.87  )
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

