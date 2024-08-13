Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338AEC52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rGguLSfwniavDEMHMy3GgVchwkMAgtGND+6W9QtIiDc=; b=oD0WnvYe7kTVyI0v/KoPT9BkPb
	wPNsbj8WTP2uYXyA+AqPZK8E228mF1VSLaAHOHMnk+xIKtCsGvuGmh9C8OL7Q9DAojYipkBUa4NSi
	iTgiiUFBG8B3VJ/8n94M9uEvtv+odV4OcflimLjUJzNo6B7992rcsnW059b0CI8IqcYdYBglsEz4e
	JTO6rboVulHipjkFcYYZkEg9WYU9j7zTBgfn07UNKgS+Iais6fGkfqTsDPHEVIso9db74B8Y2RhYO
	ZPl6MY2PMmr2uojtfVIjoxdn7hX46ikk8EAxr5mX1+WTCpwwlAaTG3hVweFoW8VcagL5CWzuHBqOQ
	I8g79b5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdncz-000000036QW-1Gzh;
	Tue, 13 Aug 2024 09:15:41 +0000
Received: from mout.web.de ([212.227.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdncv-000000036Px-26js;
	Tue, 13 Aug 2024 09:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723540507; x=1724145307; i=markus.elfring@web.de;
	bh=rGguLSfwniavDEMHMy3GgVchwkMAgtGND+6W9QtIiDc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d5dn+5kltuhJs+yuGh2lf8dfvJaXvvciQnd54XEgwRZJo8cjfX2+W9DHfMDFAnRr
	 oSpeJMNhQZ+xRSgUMaw9dtiSuGP/+3XXDgqBn20m9B7uSHvULJR8NcaMdqXjTaqpy
	 XlpwQ9WqhDkYAiz3/dHqg9i+sH/z5QPhQyB6fvHTbTlSglVuFAFgzylDODlukXD7y
	 Q/HER3TJ7bVzCl/2fsXGaIk6t5uKRT/nX5OWt2MtaxDaDhEUh1vLqn8Ni8mrtBfFm
	 0FqRC6VbxIto64aRQRSiEU7pDfAmYr7XTxqN96Jlr4sws/DIoFaUUMNODKY+7mUmj
	 wRMHI5XxapfQM8Cn2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1snSHu1zMb-00UOJc; Tue, 13
 Aug 2024 11:15:07 +0200
Message-ID: <d49cf866-2223-45e9-9ef6-c72990d87a3a@web.de>
Date: Tue, 13 Aug 2024 11:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christian Marangi <ansuelsmth@gmail.com>, linux-nvme@lists.infradead.org,
 linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Joern Engel <joern@lazybastard.org>,
 Keith Busch <kbusch@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan <saravanak@google.com>,
 =?UTF-8?Q?Thomas_Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240809172106.25892-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240809172106.25892-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5OSznLC1x5l4DccGvfE0cxn4yFFn97VuHg47N4spG6KwoK18cCa
 u7rC+LnBerN5Fj1djIeJHC6ZxqyG7ZBcxRpFbTchUIFAChFRqkBj6wpD3oqHdOEEgRtDlAC
 HtE4KPgNjcMfqicWP1nbyFIFu1giD/7GYtwnkDB7ZP5HD8l4Xm4RETt47ea7DrRFOc6jI9A
 QNidh/HFdpT2P/8HmYCtg==
UI-OutboundReport: notjunk:1;M01:P0:Np8KOEmCYsI=;z/+4c8gTK4XQuaeM7RbBj1+xKBe
 GnmhKkOHHh7e2w732IW8Ag8dTzkXWWfoFRPDNRTDGp4oBqnzRFaqT+QJbgQQzC5q6DoheDvy4
 4K6hzfjCrIfu1vC7alajleh3cyZ2aBMvJRAnti80z1OClHWKpyU+mLguk1rPeZWI3VNsnjP+a
 l8ZkQeoG0gceLGFDodqgh9p0ukXev3bK4614cWlibUmfPs6N3YNly+XAR4sUkNF6Gi0TKJsS9
 hubWrA3hNvPzUJSlFw4ISIRx6o+r7YnU7J2pKPWy6vgmUgKzcUHhwD3K8HDcPgOoRgw+403/c
 JpzEz60bFdXa0J7JUAdpZrD+577k+Vl+S2iHX3wpIzu4ahBML1W/4sCyzDEgeSd3KRI2xfVI2
 kdE/Cq3EwMociuNW+MJkQaEc6/PzjG56aiZYqnM4YgYSXcizwNvx3KM2Npxq27nG7HErsi1c2
 L8P8AY8CeYDNtgdzsLF2H4pr3q11W6YZSNZLYiCHIojtSZ7LXF4PIg1ibLyEzFaaUcj9ypMPV
 n63CvwhN4LzUcjFE7+JCcPow/boReJ0/oyROQ+Ma830y1msb9f/kF2SCdhbq+6YiH40GRzZot
 LMeWdIma1ZZs+76tDn6IQ2k4YADjqiRKCt+t4GtoaA74dEjaRzeilmv6Vv1mdtW0g1Sw/imUn
 KdGibm3XsP/wn4CYQcjGHH/dnKNnRL7GKKaU7dYu7r0Mxad+CGBoQnV3LFbdUO5gLSTnLTLlV
 PVDDFYhJTg0NhnHj75a7PtNc3iEd/KBBh6G/2B+OswXxAUGsr6JcX3NThjfdQXHro2VXnXY6J
 PLaVer5xX68HLw1Rsd5DNE6g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_021537_939709_1AACE8AA 
X-CRM114-Status: UNSURE (   4.55  )
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

=E2=80=A6
> This follow a similar implementation done for mmc =E2=80=A6

       follows?

Regards,
Markus

