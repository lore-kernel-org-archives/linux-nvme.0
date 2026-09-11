Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3342C88E45
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhPkzIwpcyRo7Ohgbz2mRN/hsyMqyZdNpG0dP+/Xjs8=; b=WihnupYDHneheFBffNysd00/Dz
	pKEDLKpeThH35BNhb4hTxiqMjMVctObZv/VvG04u+hzPB34LncpqUcFmM2zTu3vGROOTQnB1i0S5/
	oq7GOK87xQxpPQ/kZ06WVLz4LiI/fprZ2NrtAbL414ySs4YZq5xcwNEG/kDgOnKV1TrLLE6fe4gFM
	EPW+jqwrIbZPlqKrgGZKKINDWvPASEE+DRGGuR/0vlVeRaJYD9z2i1FF6mZylkWcBJ89VodtiK22k
	75JY4A88GiBcZx4yLMiG+c1Vif0w+spygtn/QYRki3n7NlRaCciXlVBIutIe8w4vQ8PdceCydMkQr
	FQbzmEUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52p4-0000000Gzzr-2473;
	Fri, 11 Sep 2026 15:05:50 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52p1-0000000Gzz7-4AXx
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 15:05:49 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1789139119; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R7lcf5afbXLOaiJSse/4TpvIY41wwWb6uc/jGaAI8x4YP1389UY+u+5GL9rnSgTXzJ
    NV5FluByMTQkAhBW1t2yvE8bPMMQvn6Stl0eMkqVln40OLgRm7MuA1upBc6iJrH0WnhK
    7IiQkUdLSgkyeI3SAU/v2VoOAU/SJ7ccdP/nLHZbVVgEiv6q7+tngGfHGpybjI7kR6az
    ORKaZHkXsIWoXB35aJCHtuUOnU0xj6tGSeptGAlwXOksUNvoJZ2YEDS/BtQsFlHWPaD5
    HytlQboPxP5UHhSkS88U1PY16TudsOJurbWAY4f1JvFXDNBJha5ecRnuAFTPcw4y9W0T
    3jCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789139119;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UhPkzIwpcyRo7Ohgbz2mRN/hsyMqyZdNpG0dP+/Xjs8=;
    b=PyDrl4AKmyF2PnWdL5BD5I4zNl4O0Gsj2SFUo4EkSgRImhskRSUEMb5YN6VLCgj2ae
    EJyLEk2xxW08FBbcv2ySKnvOSk98o4V9AJcXEtgdb674XM6a5MrbqtYNKWG9TlNEIBK3
    OtiD+yUSw9CX/VWQW2GlhAWeIhn/X+7HZ+68qTciIzNzS6lqTL/TlvtL9+iCxrkkwGRi
    pfXP5YsnR9TiifzN0PNs7WqZLjgGE5+OGLbtSoNIoVv3RcWaAINtXoEGFlVZdGFPpGx/
    sO2UwCojwrgbx6Gs0rb9qzY0YvR6ZIFC1YH8mD1MGET8x155nvqXyfbVoV9QXO0RrcJE
    Bjuw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789139119;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UhPkzIwpcyRo7Ohgbz2mRN/hsyMqyZdNpG0dP+/Xjs8=;
    b=YmNfACgE2w4HN80jUoBcVhWXlZ4ji2OxyeyV6sdy8cRmUJUSEOD3MInthxQjcQSkfQ
    MxE5NTs/6NcTHjrfXvbX++eYpSuVaY5jODbGu527/aAURW/gBqqDFOlm0UB0SdbRZjnz
    U3GJWb8l9e+pry1+Rd/xPA2i37SrZ7Nlb14z4Fr4FEtTJ979i6SgY5CUHFNnwYGm3md4
    LSrCPsKlHHgJ2pT+yNWljXQ6OEbdeZYsJHbJoQUKhnxOoy/gmWGAFskhVxa1Ul5CI7UA
    ReExzlNNQpkGqKfQDXhhBmq3pSzH98oBimfDB1CdlptURmfHxqXDv5X9DFdxakoXZfCz
    EjmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789139119;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UhPkzIwpcyRo7Ohgbz2mRN/hsyMqyZdNpG0dP+/Xjs8=;
    b=MwFCa9ZIKYTfh4A59EINXjLEP3O9OUU613PU4VnHUfCHG+CJ8U4EFcgEpAnHat+2P9
    buUKG/NrmD0TkX5K/+CQ==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSe9tgBDSDt0V0zNriHg+YfT0rGaZpI+/63exJG3nKe+1cCDsnKpsYY+u4Ll0RlE="
Received: from p200300c58729681c3f3e4b76edf8c1cb.dip0.t-ipconnect.de
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze37e128BF5JUAD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Sep 2026 17:05:19 +0200 (CEST)
Message-ID: <fbbc0c280c004dbc2c4029f1c216143a0a5d6b04.camel@iokpp.de>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for Micron
 4100AT
From: Bean Huo <beanhuo@iokpp.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 sagi@grimberg.me,  linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 bob.beckett@collabora.com,  Bean Huo <beanhuo@micron.com>, Gaurav Sinha
 <gsinha@micron.com>
Date: Fri, 11 Sep 2026 17:05:18 +0200
In-Reply-To: <aqQYMR2uaKcHosYD@kbusch-mbp>
References: <20260904105155.1402065-1-beanhuo@iokpp.de>
	 <aqQYMR2uaKcHosYD@kbusch-mbp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_080548_287245_F5485401 
X-CRM114-Status: UNSURE (   9.92  )
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

On Fri, 2026-09-11 at 09:03 -0600, Keith Busch wrote:
> On Fri, Sep 04, 2026 at 12:51:55PM +0200, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
>=20
> ...
>=20
> > Signed-off-by: Gaurav Sinha <gsinha@micron.com>
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
>=20
> I've applied the patch as-is, however usually the first "Signed-off-by"
> is who the patch is attributed to as being "from".
>=20
> Thanks, applied to nvme-7.3.

thanks!

