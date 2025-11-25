Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787CED0EE0D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7eKUbEQxuZZ81A2bCWYhdxQgXMpUbzIZ0U1MPP5CWqI=; b=BRJEuIqrO1iL2zQHYN9BsawtW/
	tapXCiO467l8t2ph1PtFNGkvuAlN/TkXiwJMbI0UAvRlXHVtZHYXWpm3AqQO6BHWclWWpbNXLf/vd
	8cISnhGEHlnalaDGlQ+8GFJwQ+jqh4GkhicfDqoY+JcPUJHc5HV5SOnYTLfdagG73DkD+Nv0eq3iE
	KSXG1mb3TxoyybUJ9UJ1bocUtrntJyrCKnl+bDXzVQJhvWhtjha1PZr2KIjSogPagNhrn7sKb3fzg
	ZCLkEYoC9/uSufqHjdsOlkJSdlgUPFdhNsmjXIo5daWTrTpJKSROkLHXXVA3EVEG7Ikyggpz074Xj
	bWQQIhiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNwLp-0000000Dd39-00ks;
	Tue, 25 Nov 2025 16:57:13 +0000
Received: from smtp.witbe.net ([81.88.96.48] helo=smtp-c9.witbe.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNwLm-0000000Dd1k-2XYL
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 16:57:11 +0000
Received: from riri ([81.88.96.247])
	by smtp-c9.witbe.net (8.16.1/8.16.1) with ESMTP id 5APGv5Nn025269;
	Tue, 25 Nov 2025 16:57:05 GMT
Date: Tue, 25 Nov 2025 17:57:04 +0100
From: Paul Rolland <rol@as2917.net>
To: Dragan =?UTF-8?B?TWlsaXZvamV2acSH?= <galileo@pkm-inc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
        linux-raid@vger.kernel.org
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <20251125175704.2dc57a76@riri>
In-Reply-To: <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
	<CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
Organization: AS2917.net
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-pc-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEWsjH1VRjFydFciEg3a1tJxUEM6OCB1zdsDAAACcElEQVQ4jV2Tu3LcMAxFEY7SG/KQNYlY2685Zi1rmF5kQteBNcL/f0JAacfZDUscARePK9itY3Q4Qu5vplJKIFsrvI0t7Ii/8/nmQsERtgJpHAtiGW4ggylOAwhXTxPi0xfIcxDrZIc3qhMGD/kfKdwBExZrAf6l5PeC/Al7cAGfAGD+AgvL5yckcsxegVmG+QZRPgnYXnFUMAC8DLd6QZhAxj6dRo6vT/JNkmZQmPyDtoroMkD2VlaVgHsw2QrCAf1jPM+ou2Ju1j/G8+xINfZT+zGDPDjr7H/xnKewgi6SO4D7zloYoRDafSoogmirP0t9YIOJnN2ibDEKK6zDoSEjTIFXDcYYkwizoO/AjkATm3g+JVsSXPOCZIHwj7uBo2Bi97RMOoflJ4n3b3dvS2kVXDQupjvAk7zvaMEJlu0OJDFy4SsCusRbL95jRynY0LIA/rpyxCMkJ1ie+bWoEy+MG7pzDE3k8Z2C1a5eUdxmi0adGi2mdVjyUr2uvamrW9EeuLTCY84/AUjBj40LtqYbbM23vqolA2mpj5g03gparH45DqBgmsBK2hU0x662+QQLVYJLitxTnHB7yf0es4rraS/xqKW/hF1zPg9lOijpmtIBVrWKOQ6oTSkQjh3YtnarHQc0RrtS1XjtbQnScPrLeNKM6iS+6Qz6e9mVoPvaHHPU6eP5aKu1Ifd2QQvp6EA1bLaP3VREwewXY73xgLppBR2tg4LFg9lXzegHQlusWuxwogLCaswJ+qunQ2cyfuziX6B1p0E26nQazR3Qn2jQarRXVVZT9zP3uB5FV6pNjQG+u03ugbalEsEXqo7/AjAH60VpvOMvAAAAAElFTkSuQmCC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_085710_900016_DF98C9E1 
X-CRM114-Status: UNSURE (   7.83  )
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

Hello,

On Tue, 25 Nov 2025 16:19:27 +0100
Dragan Milivojevi=C4=87 <galileo@pkm-inc.com> wrote:

> > Issue/Summary:
> > 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> > drop out of a NAS array, after power cycling the device, it rebuilds
> > successfully.
> > =20
>=20
> Seen the same, although far less frequent, with Samsung SSD 980 PRO on
> a Dell PowerEdge R7525.
> It's the nature of consumer grade drives, I guess.
>=20

Got some issue long time ago, and used :

nvme_core.default_ps_max_latency_us=3D0 pcie_aspm=3Doff pcie_port_pm=3Doff

to boot the kernel. That fixed issue with SN700 2TB.

Regards,
Paul

