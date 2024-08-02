Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41317C52D70
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Aug 2024 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tU7gEcO5Zgme5BifBIK2ckMTS7sI+kwhhQ7BvALV+BQ=; b=YQIhxPtIZf+a9y9uiXVsE0VbEt
	Ev3LD7T1OqxbUmQpTBHoOGT3SHhfjd+XV0nDP/GyTda4JxdDwCrVRnBeztM/OM16oBQeRr8DtfGY+
	3NOsiTFgL9dZemhXMeMV0XtRxEFSqWmQ0iev0nKZEyCIi0L+mYH2t5DkonwV0Qh9IG/xvflmGLXZh
	Ud+xWCX9SvkckhQNACA2vDL6rcHRXptjnaphubjIi9s4bPIZgMZWsoBz9mUyyVM6NxJ0azVEAOSjI
	E2Gh8vQYoIgtzEMPIk5ndekglW25grjklf6ZNabyeKtvLROuw6Ku5avDU9Y8bKtmFLPolWdAvaK7r
	lu+BmopQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZmkv-00000007xJ6-3VCX;
	Fri, 02 Aug 2024 07:31:17 +0000
Received: from mail.synergyflux.pl ([51.38.99.212])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZmkt-00000007xFs-0RLu
	for linux-nvme@lists.infradead.org;
	Fri, 02 Aug 2024 07:31:17 +0000
Received: by mail.synergyflux.pl (Postfix, from userid 1002)
	id 9CC73247AF; Fri,  2 Aug 2024 09:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synergyflux.pl;
	s=mail; t=1722583868;
	bh=n9RRp8MlabRDJBtJNro49Rmci90RtotaZYZ8+xo6WI4=;
	h=Date:From:To:Subject:From;
	b=gNUXaww7n1X0ENOj/3U+xKS8nLrGHgdmecCjpQnwAgKuXsk3QVo6I3XmtBlYSWnql
	 r4jLA3kEeM0bRZBeURWPiEvKYnWFjGGZ+IdtcmW5w8WPPUDd4Fx24LaBmxfr/r3AtM
	 El4Go/FqtbNeT9y5a03QYsR3Ko2BIGU+o+xw9TNTHOaRau7pbcOC5cezlZ2XA4irDa
	 TjACFSxvtjq5slUzd7Zq0yf1TZ51U5urCi/BiUaYXdr/pl3QxyyFS6QBw4pbcYt6hn
	 ADtqXjp96C9xqaGl/VktdRpk1iaAAPlo9AQGob7N1+zAxw4oknm3Rtg1RWJYWI4Z4i
	 sGWkN/wvZ/QnA==
Received: by mail.synergyflux.pl for <linux-nvme@lists.infradead.org>; Fri,  2 Aug 2024 07:30:58 GMT
Message-ID: <20240802084500-0.1.d4.39gk4.0.b137kfn6ne@synergyflux.pl>
Date: Fri,  2 Aug 2024 07:30:58 GMT
From: =?UTF-8?Q?"Konrad_Zieli=C5=84ski_"?= <konrad.zielinski@synergyflux.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Instalacja pv
X-Mailer: mail.synergyflux.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_003115_867852_DDA8E03E 
X-CRM114-Status: UNSURE (   1.36  )
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

