Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290A3CD342A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 08:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tU7gEcO5Zgme5BifBIK2ckMTS7sI+kwhhQ7BvALV+BQ=; b=J/9YT7tbKQ+ADmQBeOEhyoqINb
	yPwF5LNAbZkP86iW0YsXP1qPvUtsl/V9KO8vCwQSatVJT02J6VnaAluHx2yotv2ZuBdDw/pG/Z8g2
	jxoxh4zd/DqBlfhYVSkx4HMkjB6kA1C2ShEMHe5KFDFMfPq9/vOq7hU0TIMrl5W2MA5uzPHLTiCCU
	M8LvalzvO4bU4MwWjJXhmpHusryX95/VhhKJl8kBLku2zThx22TCTBppqs1slvLW6H6znpQKbZ2hz
	Zz8Q9mpQb/zFbE+7Qu//+vwMnlvUf9grErLUJ0iKiwqHgxI/NrHlvD7qvrf+35vY93LQFirIndK2K
	xXbrYA1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slOT4-0000000Gnzo-0HCv;
	Tue, 03 Sep 2024 08:00:50 +0000
Received: from mail.synergyflux.pl ([51.38.99.212])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slOQt-0000000GnQl-07VP
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 07:58:36 +0000
Received: by mail.synergyflux.pl (Postfix, from userid 1002)
	id 3A1C3253D1; Tue,  3 Sep 2024 09:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synergyflux.pl;
	s=mail; t=1725350235;
	bh=n9RRp8MlabRDJBtJNro49Rmci90RtotaZYZ8+xo6WI4=;
	h=Date:From:To:Subject:From;
	b=Ga2sSgNwG12i7UAh8CkEfmWffeDve8j9u8L/Ib5MS1AxRO+BRjRal4kY9WZrYzOaL
	 hdZdJp5+sxwObS1q9hbFfL+4+2HUvAsnDJ4J6gyVLY1NlHGOM/jLQG0wkQbtjY0evw
	 MQ9tcirKoYjVaxsCCtTtGlol6mHBxNnUbi1n6a4q01jjGyAhj+2W5zXxyzeqGRpMJ/
	 cOuaiw63EtpEAnpwzPnlpAUlXQJ8KrMrelkawHF2Nd95H1if218cov9zX2DXXc9HUy
	 A4z8QmjoMlm+t0hdXZ7dsLKxEdqee0e1IOKx16IniXIV/ss64x3tSm/dK6qQbtck03
	 LU4FiagNssAHQ==
Received: by mail.synergyflux.pl for <linux-nvme@lists.infradead.org>; Tue,  3 Sep 2024 07:55:44 GMT
Message-ID: <20240903084500-0.1.dp.3gcpv.0.2285ia9jlb@synergyflux.pl>
Date: Tue,  3 Sep 2024 07:55:44 GMT
From: =?UTF-8?Q?"Konrad_Zieli=C5=84ski_"?= <konrad.zielinski@synergyflux.pl>
To: <linux-nvme@lists.infradead.org>
Subject: Instalacja pv
X-Mailer: mail.synergyflux.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_005835_237383_83841289 
X-CRM114-Status: UNSURE (   1.84  )
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

