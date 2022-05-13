Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1180AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 13 May 2022 08:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9KGuIG62LgzC9aYmjKxzocuYLRCVghXg6v9Q1q2LHec=; b=yTbqiOzRnZ7F1hy/2S5ihoU6u0
	qxLhQMjxChBGTnPn4jxFj1HmVzHTLLVGG2Q2kWVKYRHxa0qj+Ic+3q9LINktosCtcmYX1I+tCwoYP
	Yup6heMltJgJelnGoONzUFZ5LSZ4lZdYO6nYwZJZuLYXXOZB9QDVLvqLeXtcgfTV4mtTUMXn5ik0Q
	tdlCryo4XZjp/1o59sZRWwg5zroj0k/CNYYQMd2eAA3mmNgxVmcKBLBb9J0u+7GxSnyEOhR5lFej3
	nVAXB8Kkm4ZuzvB7XfDfi5/0RIj9BoqsHclgQviM+1jTemtR22fot3NEqEe5Ayjfgz/BxBUz4OOaE
	ulJh2WQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npQJx-00Exsn-C3; Fri, 13 May 2022 08:06:45 +0000
Received: from mail.coredeal.pl ([51.75.73.133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npQJu-00ExrZ-8S
 for linux-nvme@lists.infradead.org; Fri, 13 May 2022 08:06:43 +0000
Received: by mail.coredeal.pl (Postfix, from userid 1002)
 id ED762A524A; Fri, 13 May 2022 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=coredeal.pl; s=mail;
 t=1652429200; bh=9KGuIG62LgzC9aYmjKxzocuYLRCVghXg6v9Q1q2LHec=;
 h=Date:From:To:Subject:From;
 b=fe6GEowUVN32yXZ5BN1Py0Dql6sVZNIT/1pqz358eKTfgDazcgKnd8F6sFtfB7kv6
 20K7yAsLi0z52Yt+xdCDuNecOrG2xGMZvjkHLXmUEY6BtEGk3rfkxvZVTJBz8ix22n
 HIsrVXebU1cWKJ5HKLVxgFoELDZQ0diDqDX4wBbkZji/ms2IqusENaRcAcFrO4RfPE
 lmPBf2j0PTuZqR8tANeLS8+UKXwl/yd7vCluMnW1ATh7sqwplzbWu/CW4dza1K0QGo
 wCACkwiEmxnxp7BBf/RxOoKQg3D4PlNv5JPbtpQyJaWIV1zxcnYN1nKfm/NvUlVD+i
 TtA28APBIif6w==
Received: by mail.coredeal.pl for <linux-nvme@lists.infradead.org>;
 Fri, 13 May 2022 08:05:55 GMT
Message-ID: <20220513064500-0.1.33.o04r.0.qpd5jpbw1m@coredeal.pl>
Date: Fri, 13 May 2022 08:05:55 GMT
From: "Krzysztof Maj" <krzysztof.maj@coredeal.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Biznesowy angielski
X-Mailer: mail.coredeal.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220513_010642_457941_81D45FD0 
X-CRM114-Status: UNSURE (   1.54  )
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

czy rozwa=C5=BCali Pa=C5=84stwo rozw=C3=B3j kwalifikacji j=C4=99zykowych =
swoich pracownik=C3=B3w?

Opracowali=C5=9Bmy kursy j=C4=99zykowe dla r=C3=B3=C5=BCnych bran=C5=BC, =
w kt=C3=B3rych koncentrujemy si=C4=99 na podniesieniu poziomu s=C5=82owni=
ctwa i jako=C5=9Bci komunikacji wykorzystuj=C4=85c autorsk=C4=85 metod=C4=
=99, stworzon=C4=85 specjalnie dla wymagaj=C4=85cego biznesu.=20

Niestandardowy kurs on-line, dopasowany do profilu firmy i obszar=C3=B3w =
=C5=9Bwiadczonych us=C5=82ug, w szybkim czasie przyniesie efekty, kt=C3=B3=
re zwi=C4=99ksz=C4=85 komfort i jako=C5=9B=C4=87 pracy, rozwijaj=C4=85c m=
o=C5=BCliwo=C5=9Bci biznesowe.=20

Zdalne szkolenie j=C4=99zykowe to m.in. zaj=C4=99cia z native speakerami,=
 kt=C3=B3re w szybkim czasie naucz=C4=85 pracownik=C3=B3w rozmawia=C4=87 =
za pomoc=C4=85 jasnego i zwi=C4=99z=C5=82ego j=C4=99zyka Business English=
=2E

Czy m=C3=B3g=C5=82bym przedstawi=C4=87 wi=C4=99cej szczeg=C3=B3=C5=82=C3=B3=
w i opowiedzie=C4=87 jak dzia=C5=82amy?=20


Pozdrawiam
Krzysztof Maj

