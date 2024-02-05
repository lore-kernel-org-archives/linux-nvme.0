Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E70C4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tU7gEcO5Zgme5BifBIK2ckMTS7sI+kwhhQ7BvALV+BQ=; b=Bh1+RBqiF8zds2C/biAkf2aCO+
	F4vmDzvQrpyEedUgnptNXdlAtqW4vQ0EDeu288AjI6mTalESv529pi3Busd8Iyr/KEI+NOPkBmNaj
	MlolcfQrAwOSzzOZD3oxTGkexYD7Yq0UIw0tmRXmBf6ojzUB5/AOvLq78EKd/UpPk8ehIXX/AzdFy
	/4hK7QFC8f9jryXpmdwtj5KpLrzZZQHFsgQiQfxLqFXo3wmpcSU8waZ7DSaEr1Xr7x/uo0p4XEsIa
	PPVALyoEElIJpf7t27/LaFZxRrEjpQBzWxfalBTIAMDvoVpsv3bqV1Wm0LQ38+9nUq/aHtVxMv3dC
	ZitVdJSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWv16-00000002Ywp-2mVw;
	Mon, 05 Feb 2024 09:11:52 +0000
Received: from mail.synergyflux.pl ([51.38.99.212])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWv14-00000002Yvg-2sJE
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 09:11:51 +0000
Received: by mail.synergyflux.pl (Postfix, from userid 1002)
	id 27C0126088; Mon,  5 Feb 2024 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synergyflux.pl;
	s=mail; t=1707124309;
	bh=n9RRp8MlabRDJBtJNro49Rmci90RtotaZYZ8+xo6WI4=;
	h=Date:From:To:Subject:From;
	b=a30GqWXIBsip1b/iHEK/cfrz0UVMbQ8UWUug8l00U9457bq0Y5cbSviRy32XLMlgW
	 2Ao6042uWwmohv3i06SsNmR0azjeJG2EMlg2PAKuL+B4ZS3RUBZpQruxFpbp5Y8xUL
	 4iHPA8Ne6h1Y8NIPZGtAIPIPF0fTXXM0G+7VhJBv/93wshj0fKU4An9BWDJ0YD9Ewf
	 M2nMVIpz4mZutVGAwb/J7VTFZ2jAK8nExb8+P+znLP8PCHu08w2l6ZOwlv75RKhVYH
	 8Brk+ks6drMpGKgCozC+xdKe1Ln9RgDqQng7J/CDkRDnuFQT6p0yfAEE+TarTBPWEc
	 3qWIZ5YbgW1XQ==
Received: by mail.synergyflux.pl for <linux-nvme@lists.infradead.org>; Mon,  5 Feb 2024 09:10:51 GMT
Message-ID: <20240205074500-0.1.9m.1w7aw.0.flv7g7prvg@synergyflux.pl>
Date: Mon,  5 Feb 2024 09:10:51 GMT
From: =?UTF-8?Q?"Konrad_Zieli=C5=84ski_"?= <konrad.zielinski@synergyflux.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Instalacja pv
X-Mailer: mail.synergyflux.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_011150_892583_2DE19530 
X-CRM114-Status: UNSURE (   2.19  )
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

czy s=C4=85 Pa=C5=84stwo otwarci na niezobowi=C4=85zuj=C4=85c=C4=85 rozmo=
w=C4=99 na temat fotowoltaiki?

Jako firma specjalizuj=C4=85ca si=C4=99 w instalacji i serwisie najlepszy=
ch jako=C5=9Bciowo paneli s=C5=82onecznych na rynku chcia=C5=82bym przeds=
tawi=C4=87 propozycj=C4=99, jak=C4=85 wsp=C3=B3lnie z zespo=C5=82em przyg=
otowali=C5=9Bmy dla Pa=C5=84stwa obiektu.

B=C4=99d=C4=99 wdzi=C4=99czny za wiadomo=C5=9B=C4=87 od Pa=C5=84stwa czy =
mo=C5=BCemy porozmawia=C4=87.


Pozdrawiam
Konrad Zieli=C5=84ski 

